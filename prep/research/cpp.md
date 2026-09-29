# Фактчек C++: библиотеки и алгоритмы в докладе «O(n) проиграл O(n log n)»

HardFest 2026 · Никита Нагорнов · проверка от 2026-09-29

## 0. Как проверял

**Источники (все открыты и прочитаны, не сниппеты поиска):**

- libc++: `github.com/llvm/llvm-project`, тег `llvmorg-23.1.0` (последний релиз; файлы совпадают с `main` на 29.09.2026). Для истории — теги `llvmorg-12.0.0` … `llvmorg-23.1.0`, коммиты `7f287390d78d` и `4eddbf9f10a6`, release notes `libcxx/docs/ReleaseNotes.rst` на тегах.
- libstdc++: `github.com/gcc-mirror/gcc`, тег `releases/gcc-13.3.0`. Файлы байт-в-байт совпадают с локальными заголовками GCC 13.3, на которых я гонял тесты.
- Abseil: клон тега `20260817.0` (коммит `2065f4ded055`, 2026-08-18, «Apply LTS transformations for 20260817 LTS branch»). Для истории — ветки LTS с 20220623 по 20260526.
- Boost.Unordered: `boostorg/unordered`, ветка `develop`, файл `include/boost/unordered/detail/foa/core.hpp`.
- ankerl::unordered_dense: `martinus/unordered_dense`, ветка `main`, заголовок версии 5.2.0.
- Swift stdlib: `swiftlang/swift`, ветка `main`, `stdlib/public/core/{HashTable,NativeSet,SipHash}.swift`.
- Стандарт C++: `github.com/cplusplus/draft`, ветка `main`, `source/containers.tex` и `source/algorithms.tex`. Сайт eel.is заблокирован прокси.

**Локальные тесты.** Среда: облачная VM, `Intel Xeon @ 2.10GHz`, L3 260 МиБ. Ubuntu 24.04, GCC 13.3.0 + libstdc++ 13, Clang 18.1.3 + libc++ 18.1.3 (системная `.so`). Abseil 20260817.0 я собрал сам, опции по умолчанию. Скорее всего, это тот же тип машины, что и x86 Xeon 2,1 ГГц в колоде. Счётчики (вызовы `new`, байты, `bucket_count`, число сравнений) детерминированы, им можно доверять. Наносекунды на этой VM шумные: `unordered_set` на 2^20 случайных ключей дал 300–365 нс/эл, в колоде — 139–146. Поэтому из моих таймингов на сцену можно брать только отношения и направления, абсолютные значения — нельзя.

Исходники тестов: `/tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/research/cpp_src/tests/*.cpp`. Скачанные исходники библиотек лежат рядом, в `cpp_src/`.

---

## 1. Сводка: что противоречит колоде или требует правки

| # | Слайд | Утверждение в колоде | Вердикт | Что сказать вместо |
|---|---|---|---|---|
| A | 11 `hashtable` (сноска и заметки) | «libc++: число ячеек не степень двойки → номер ячейки через целочисленное деление, на ARM оно не бесплатно» | **Неверно для условий замера.** Если просить `reserve(2^k)`, libc++ сохраняет степень двойки и берёт маску. `reserve(2^20)` даёт `bucket_count = 1 048 576`, деления нет. Простые числа и `%` — это libstdc++, причём всегда | «libstdc++: простое число ячеек и остаток от деления. libc++: простое, но если попросить степень двойки — маска по младшим битам. В моём замере у libc++ маска, так что деление ни при чём: дорого — узлы» |
| B | 15 `flatmin` (текст и заметки) | «Группа из 16 байт метаданных проверяется одной SIMD-инструкцией» — в докладе про M2/iPhone | **Неверно для ARM.** В Abseil на AArch64 группа из 8 байт (`GroupAArch64Impl::kWidth = 8`, 64-битный NEON). 16 байт (SSE2) — только на x86 | «…окно из 8 байт метаданных на ARM (16 на x86) сравнивается одним векторным сравнением» |
| C | 21 `inputorder`, заметки к 33 `stdlib` | «libc++ начиная с LLVM 17 распознаёт отсортированный вход и проходит его один раз» | **Версия неверна, механизм описан неточно.** Эвристика есть ещё в LLVM 12–13. В LLVM 14 добавлен introsort, в LLVM 16 — идеи pdqsort и BlockQuickSort. В LLVM 17 изменений по этой части нет. На сортированном входе libc++ делает ≈2 сравнения на элемент, то есть примерно два линейных прохода | «libc++ давно проверяет, не отсортирован ли вход: если разбиение не сделало ни одного обмена, пробует досортировать вставками с лимитом 8 перестановок. На отсортированном входе это ≈2 сравнения на элемент» |
| D | 21 `inputorder` | «отсортировать дельту и слить с локальными за один проход (std::set_union)» | **Идея верная, рецепт неполный.** `set_union` не убирает повторы внутри дельты: из второго диапазона он берёт max(n − m, 0) копий. Сначала нужен `unique` по дельте | «отсортировать дельту, схлопнуть в ней повторы и слить с локальными (`set_union` или `inplace_merge` + `unique`). Ровно так устроен `std::flat_set::insert(range)` в libc++» |
| E | 14 `cachecost` | «≈48 Б на ключ… 512K → ~24 МБ, 1M → ~48 МБ» | **Арифметика завышена вдвое.** При U = N/2 узлов U, а не N. Измерено: 512K входа → 12,6 МБ, 1M → 25,2 МБ. 48 Б — это на *уникальный* ключ | «≈48 Б на уникальный ключ: узел (в malloc — блок 32 Б) + две ячейки по 8 Б, потому что reserve(N) при U = N/2. 512K → ~12 МБ, 1M → ~25 МБ; L2 в 16 МБ как раз между ними». Вывод про излом от этого только выигрывает |
| F | 13 `allocs`, 33, 34 | «33,6 МБ (libc++) · 25,2 МБ (libstdc++)», «узел 16 Б vs 24 Б» | **Верно как запрошенные байты.** Но на glibc оба узла занимают чанк 32 Б, и реальный рост кучи одинаковый: ≈42 МБ на 2^20 ключей в обеих библиотеках | Подписать «запрошено у `operator new`». Добавить, что реально из кучи уходит ≈42 МБ (на glibc — измерено) |
| G | 20 `outcontract` (заметки) | «сортировке нужны индексы и вторая сортировка» | **Неточно.** Вторая сортировка не нужна: хватает битовой маски первых вхождений. На x86 это −25–30% времени, но хеш всё равно быстрее | «сортировке нужны пары (ключ, индекс) и ещё один проход» |
| H | 3 `case` против всех замеров | Кейс: «id из SQLite по первичному ключу», а замеры сделаны на случайных 64-битных id | **Методологический разрыв.** Для узловой таблицы с `std::hash`-тождеством плотные id — лучший случай: 0 коллизий, на x86 в ≈4,7 раза быстрее случайных. Для radix — 3 прохода вместо 8. Id с шагом 2^k в libc++ при степени двойки дают катастрофу (×1500) | Явно сказать «в серии — случайные 64-битные id». Либо добавить серию на плотных id. См. §6 |
| I | 2 `diff` | Диф с `unordered_set s(ids.begin(), ids.end())` | **Не то, что мерилось:** замеры (слайд 4) идут с `reserve`. Конструктор из диапазона не резервирует: в libc++ 20 перестроений, простые числа и 51,5 МБ запрошено вместо 33,6 | Упомянуть одной фразой («в дифе ещё и без reserve — это только хуже») или мерить именно диф |
| J | 6 `result`, 33 | «Apple clang 21» | **Не проверено.** По памяти, нумерация Apple clang отличается от LLVM (Xcode 26 → Apple clang 17.x), и «21» похоже на номер LLVM | Скопировать дословно из `clang --version` на машине замера |

Подтвердилось:

- ≈1 048 577 вызовов `new`, 33,6 и 25,2 МБ запрошено.
- Узлы 24 и 16 Б; libc++ хранит хеш в узле.
- `max_load_factor` = 1.0.
- `std::hash` для целых — тождество.
- Стандарт требует, чтобы ссылки переживали rehash.
- flat_hash_set: 1 аллокация, 18,9 МБ, ×64 по памяти при 1% уникальных; тег Abseil 20260817 существует.
- H2 = 7 бит, ёмкость 2^k − 1, максимальная загрузка 7/8.
- libstdc++ сортирует introsort с медианой трёх.
- sort на одинаковых ключах: libstdc++ ≈8 нс/эл, libc++ ≈1 (воспроизвёл: 8,19 и 0,94).
- radix: пропуск проходов работает.

---

## 2. libc++ `unordered_set<uint64_t>`

### 2.1 Раскладка узла: 24 Б — подтверждено

- `__hash_node_base` содержит одно поле `__next_pointer __next_;` — [`__hash_table#L83-L90`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L83-L90).
- `__hash_node` добавляет `size_t __hash_;` и `__value_` (в union) — [`__hash_table#L133-L146`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L133-L146).

Итого 8 + 8 + 8 = **24 Б**. Хеш кэшируется в libc++ всегда, независимо от хешера. Счётчиком аллокаций подтверждено: 1 048 576 вызовов `operator new(24)` (тест `alloc.cpp`).

### 2.2 Число бакетов и `__constrain_hash` — главное расхождение с колодой

Код:
```cpp
// __hash_table:171-175
bool   __is_hash_power2(size_t __bc) { return __bc > 2 && !(__bc & (__bc - 1)); }
size_t __constrain_hash(size_t __h, size_t __bc) {
  return !(__bc & (__bc - 1)) ? __h & (__bc - 1) : (__h < __bc ? __h : __h % __bc);
}
// __hash_table:1725-1741 (__rehash)
if (__n == 1) __n = 2;
else if (__n & (__n - 1)) __n = std::__next_prime(__n);   // простое — только если НЕ степень двойки
```
Ссылки: [`#L171-L175`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L171-L175), [`#L1725-L1741`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L1725-L1741), `reserve` → [`#L908-L910`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L908-L910): `__rehash(ceil(n / max_load_factor()))`.

Логика та же уже в LLVM 13 (2021): `llvmorg-13.0.0/libcxx/include/__hash_table`, строки 113–115 и 2311–2312.

- **`reserve(N)` при N = 2^k даёт ровно N бакетов, и номер ячейки берётся маской `h & (N−1)`.** Измерено: `reserve(1048576)` → 1 048 576, `reserve(524288)` → 524 288. Значит, во всех сериях колоды с `reserve(v.size())` и N = 2^k в libc++ **нет деления**.
- `reserve(1000000)` → 1 000 003 (простое), и тогда деление есть. Но при `h < bucket_count` `%` тоже пропускается: маленькие плотные id делятся «бесплатно».
- Рост без reserve идёт так: `max(2·bc + !is_pow2(bc), ceil((size+1)/mlf))` → `__next_prime`, то есть 2 → 5 → 11 → 23 → … (простые) — [`#L813-L815`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L813-L815).
- Сама функция `__next_prime` живёт в дилибе libc++: [`src/hash.cpp#L72`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/src/hash.cpp#L72).

`max_load_factor` по умолчанию 1.0f — [`#L1083`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__hash_table#L1083). ✓

### 2.3 Байты и вызовы `new` на 2^20 уникальных — подтверждено

Тест `alloc.cpp`: `reserve(N)`, N = U = 2^20, вставки, `v.assign`, деструктор.

| | вызовов new | запрошено байт | бакетов |
|---|---|---|---|
| libc++ 18, `reserve(2^20)` | **1 048 577** | **33 554 432 (33,55 МБ)** | 1 048 576 (степень двойки) |
| libc++ 18, конструктор из диапазона (как в дифе) | 1 048 596 (20 массивов бакетов) | 51 504 392 (51,5 МБ) | 1 646 237 (простое) |
| libstdc++ 13, `reserve(2^20)` | **1 048 577** | **25 227 800 (25,2 МБ)** | 1 056 323 (простое) |
| libstdc++ 13, конструктор из диапазона | 1 048 593 | 39 590 984 (39,6 МБ) | 1 447 153 |

Конструктор из диапазона в libc++ не резервирует, а просто вызывает `insert(first,last)` → `__emplace_unique` в цикле — [`unordered_set#L1062-L1064`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/unordered_set#L1062-L1064), [`#L1147-L1150`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/unordered_set#L1147-L1150).

**Реальная память (на glibc, тест `heap.cpp`):** `malloc(16)` и `malloc(24)` дают одинаковый чанк 32 Б (usable 24). Рост кучи на 2^20 ключей: **42,0 МБ у libstdc++ и 41,95 МБ у libc++** — одинаково. Разница «16 против 24 Б» есть в запрошенных байтах, но не в реальном следе на glibc. На macOS, по памяти (не проверено), nano-malloc округляет до 16 Б, то есть 24 → 32 — картина похожая.

### 2.4 Арифметика слайда 14 (рабочий набор) — поправка

Тест `half.cpp`: U = N/2, `reserve(N)`, libc++, считал реальные чанки glibc.

| N | U | бакетов | запрошено | в чанках malloc | Б на уникальный ключ |
|---|---|---|---|---|---|
| 512K | 256K | 524 288 | 10,5 МБ | **12,6 МБ** | 48,0 |
| 1M | 512K | 1 048 576 | 21,0 МБ | **25,2 МБ** | 48,0 |
| 4M | 2M | 4 194 304 | 83,9 МБ | 100,7 МБ | 48,0 |

В колоде: «512K → ~24 МБ, 1M → ~48 МБ». Это 48 Б × N, а узлов U = N/2. Правильно: **512K → ~12,6 МБ, 1M → ~25 МБ**. Граница L2 P-кластера (16 МБ по sysctl спикера) лежит ровно между ними, так что объяснение излома с поправкой даже чище.

---

## 3. libstdc++ `unordered_set<uint64_t>`

Ссылки на GCC 13.3.0:

- **Хеш не кэшируется.** `__cache_default = __not_<__and_<__is_fast_hash<_Hash>, __is_nothrow_invocable<…>>>` — [`hashtable.h#L48-L52`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable.h#L48-L52). `__is_fast_hash` — `true_type` для всех, кроме `hash<long double>` — [`functional_hash.h#L295-L300`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/functional_hash.h#L295-L300). Для `std::hash<unsigned long>` хеш «быстрый», поэтому кэша нет.
- **Узел 16 Б.** `_Hash_node_base* _M_nxt` ([`hashtable_policy.h#L311`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable_policy.h#L311)) плюс значение. Поле `_M_hash_code` добавляется только в специализации `_Hash_node_code_cache<true>` ([`#L362`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable_policy.h#L362)). Измерено: 1 048 576 вызовов `operator new(16)`.
- **Номер ячейки — всегда `%` по простому.** `unordered_set` использует `_Mod_range_hashing` и `_Prime_rehash_policy` ([`unordered_set.h#L56`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/unordered_set.h#L50-L56)). Там `return __num % __den;` ([`hashtable_policy.h#L519-L528`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable_policy.h#L519-L528)). `_M_next_bkt` делает `lower_bound` по таблице `__prime_list` ([`hashtable_c++0x.cc#L76`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/src/c%2B%2B11/hashtable_c%2B%2B0x.cc#L76), [`hashtable-aux.cc#L28`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/src/shared/hashtable-aux.cc#L28)). Рост — `_S_growth_factor = 2` ([`#L582`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable_policy.h#L582)). `max_load_factor` = 1.0 ([`#L544`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable_policy.h#L544)).
- **Деление даже на каждом шаге по цепочке.** Раз хеш не хранится, при поиске конца бакета libstdc++ пересчитывает `_M_bucket_index(*__p->_M_next()) != __bkt` для следующего узла: тождественный хеш плюс `%` — [`hashtable.h#L1964`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/hashtable.h#L1955-L1970).
- **25,2 МБ.** Простое ≥ 2^20 в `__prime_list` — это **1 056 323**. 16·2^20 + 8·1 056 323 = 25 227 800 Б ✓ (измерено то же число).

**Вывод по пункту 2 задания:** колода приписывает деление libc++, а на деле всё наоборот. libstdc++ делит *всегда*, libc++ — только при непростой-для-маски ёмкости, а в замерах с `reserve(2^k)` у libc++ маска.

---

## 4. `std::sort`: libc++ и libstdc++

### 4.1 История libc++ (по тегам и коммитам)

| Версия | Что в `std::sort` | Доказательство |
|---|---|---|
| ≤ LLVM 12 (и раньше; дизайн Hinnant) | quicksort, медиана из 3/5; эвристика «**если разбиение не сделало ни одного обмена — пробуем досортировать вставками с лимитом 8 перемещений**»; отдельная ветка для «первый == медиана», которая линейно обрабатывает одинаковые ключи. Гарантии O(n log n) **нет** | `llvmorg-12.0.0/libcxx/include/algorithm`, стр. 4229 «If we were given a perfect partition, see if insertion sort is quick...»; [`llvmorg-13.0.0/…/sort.h#L426-L445`](https://github.com/llvm/llvm-project/blob/llvmorg-13.0.0/libcxx/include/__algorithm/sort.h#L426-L445), лимит `__limit = 8` — стр. 212 |
| **LLVM 14** | **introsort**: `__depth_limit = 2·log2(n)`, при исчерпании — heapsort через `__partial_sort` | коммит [`7f287390d78d`](https://github.com/llvm/llvm-project/commit/7f287390d78d301956e8e925a84349fd4408a11e) «[libc++] Add introsort to avoid O(n^2) behavior» (Nilay Vaish, 2021-11-16, D113413); [`llvmorg-14.0.0/…/sort.h#L311`](https://github.com/llvm/llvm-project/blob/llvmorg-14.0.0/libcxx/include/__algorithm/sort.h#L311), [`#L481`](https://github.com/llvm/llvm-project/blob/llvmorg-14.0.0/libcxx/include/__algorithm/sort.h#L481) |
| LLVM 15 | безветвлённые сети сортировки для 3–5 элементов (`__use_branchless_sort`) | `grep` по `llvmorg-15.0.0` sort.h |
| **LLVM 16** | **BlockQuickSort (bitset partitioning) для арифметических типов, ninther, `__partition_with_equals_on_left` (идея pdqsort для повторов)**; старая проверка «разбиение без обменов → вставки» сохранена | коммит [`4eddbf9f10a6`](https://github.com/llvm/llvm-project/commit/4eddbf9f10a6d1881c93d84f4363d6d881daf848) «std::sort: add BlockQuickSort partitioning algorithm for arithmetic types» (2022-12-22, D122780); [release notes 16, стр. 93](https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0/libcxx/docs/ReleaseNotes.rst#L93): «Improved the performance of std::sort» |
| LLVM 17 | рефакторинг (sort4/5 больше не возвращают число обменов, отладочные проверки). **По распознаванию отсортированного входа — ничего** | `diff` sort.h 16.0.0 и 17.0.1; в `ReleaseNotes/17.rst` про sort ничего нет |
| LLVM 18–23 | то же, что в 16; код [`llvmorg-23.1.0/…/sort.h#L709-L829`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L709-L829) | — |

Показательно, что в описании самого коммита `4eddbf9f` (LLVM 16) есть замеры «до/после»:

- `BM_Sort_uint64_Ascending_262144`: 0,98 → 1,08 нс/эл;
- `SingleElement_262144`: 0,72 → 0,98 нс/эл;
- `Random_262144`: **61,3 → 30,4** нс/эл.

То есть отсортированный вход и одинаковые ключи были линейными **до** LLVM 16, а LLVM 16 ускорил вдвое **случайные** массивы целых.

### 4.2 Механизм «распознаёт отсортированный вход» (LLVM ≥ 16)

Код: [`sort.h#L775-L822`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L775-L822).

1. Опорный элемент: ninther (медиана медиан из 9) при len > 128, иначе медиана из трёх. На сортированном входе ничего не переставляется.
2. `__bitset_partition` (или `__partition_with_equals_on_right`) ищет от краёв первый «> pivot» и последний «≤ pivot». Если указатели разошлись без единого обмена, ставит флаг `__already_partitioned` ([`#L533`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L529-L537), [`#L623`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L620-L624)).
3. При этом флаге вызывается `__insertion_sort_incomplete` на обеих половинах. Она сдаётся после 8 перемещений (`const unsigned __limit = 8;`, [`#L300-L350`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L300-L350)). Если обе половины прошли — выход.

**Измерено (тест `sortcnt.cpp`, счётчик сравнений, N = 2^20):**

| вход | libc++ LLVM 13 | libc++ LLVM 15 | libc++ 18 | libstdc++ 13 |
|---|---|---|---|---|
| случайный | 23,78 сравн./эл | 23,78 | 22,24 | 25,58 |
| **отсортированный** | **2,00** | **2,00** | **2,00** | 25,63 |
| **все равны** | **2,00** | **2,00** | **2,00** | 17,19 |
| обратный | 4,00 | 4,00 | 3,00 | 18,13 |

(Для LLVM 13 и 15 я собирал их заголовки, скачанные sparse-клоном, текущим clang 18. Компаратор со счётчиком — это путь через заголовки, без дилиба.)

**Время на этом Xeon, компаратор по умолчанию (тест `sortcmp.cpp`, нс/эл, N = 2^20):**

| вход | libstdc++ 13 | libc++ 18 |
|---|---|---|
| случайные уникальные | 80,5 | 83,3 |
| отсортированный | 11,3 | **0,92** |
| все равны | **8,19** | **0,94** |
| U = N/2, сортированный | 11,8 | 0,87 |

Цифры колоды «все равны: libstdc++ 7,8, libc++ 1,2» воспроизводятся (8,19 / 0,94). Отношение «в 8 раз» на сортированном входе (слайд 21, M2) согласуется по направлению.

### 4.3 libstdc++: introsort, медиана трёх

- `_S_threshold = 16` ([`stl_algo.h#L1848`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/stl_algo.h#L1848)).
- Разбиение Хоара, которое останавливается на равных и меняет их местами ([`#L1871-L1888`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/stl_algo.h#L1871-L1888)).
- Опорный — медиана из `first+1, mid, last−1` ([`#L1893-L1903`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/stl_algo.h#L1893-L1903)).
- Глубина `__lg(n)·2`, затем heapsort ([`#L1918-L1950`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/stl_algo.h#L1918-L1950)).
- Раннего выхода на отсортированном входе нет: ≈N log N сравнений, быстро только за счёт идеального предсказания ветвлений. На всех равных разбиение делит пополам и меняет пары: ≈17 сравнений на элемент.

### 4.4 Находка для сцены: на iPhone `std::sort` для целых выполняется из системной libc++

В libc++ `std::sort(uint64_t*, …)` с компаратором по умолчанию (итераторы `vector` разворачиваются в указатель) не инстанцируется в вашем бинарнике. Он вызывает `extern template __sort<__less<unsigned long long>&, unsigned long long*>`, а в заголовке есть только объявление `__sort`:

- [`sort.h#L831-L859`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L831-L859);
- диспетчеризация: [`#L882-L925`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/sort.h#L882-L925);
- тело — в дилибе: [`src/algorithm.cpp#L15-L45`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/src/algorithm.cpp#L15-L45).

Проверено `nm` на объектнике, собранном clang 18 с `-O3 -stdlib=libc++`: `U std::__1::__sort<std::__1::__less<unsigned long, unsigned long>&, unsigned long*>` — неразрешённый символ, он берётся из libc++.so.

На Apple libc++.1.dylib входит в ОС. Значит, какой именно алгоритм сортировки целых исполнится на телефоне пользователя, **определяет версия iOS, а не Xcode**. Это вывод из устройства апстримной libc++; Apple-форк отдельно я не проверял. `unordered_set` при этом почти целиком инлайнится из заголовков SDK, в дилибе только `__next_prime`. Это усиливает тезис доклада: «даже библиотеку для вашего `std::sort` выбирали не вы».

**Формулировка для слайда 21:** «libc++ давно, ещё до LLVM 14, проверяет, не отсортирован ли уже вход. Если разбиение не сделало ни одного обмена, она пробует досортировать половины вставками с лимитом в 8 перестановок. На отсортированном входе это около двух сравнений на элемент. libstdc++ так не делает и честно платит N log N».

**Для слайда 33 (заметки):** «идеи pdqsort пришли в libc++ в LLVM 16, а одинаковые ключи она обрабатывала за линейное время и раньше».

---

## 5. Abseil Swiss table (`absl::flat_hash_set`), LTS 20260817.0

| Факт | Вердикт | Источник |
|---|---|---|
| **Ширина группы: x86 SSE2 — 16, AArch64 NEON — 8, портативная — 8** | колода («16 байт, одна SIMD-инструкция» про M2/iPhone) **неверна для ARM** | [`hashtable_control_bytes.h#L277-L278`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/hashtable_control_bytes.h#L277-L278) (`GroupSse2Impl::kWidth = 16`); [`#L361-L373`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/hashtable_control_bytes.h#L361-L373) (`GroupAArch64Impl::kWidth = 8`, `vld1_u8`, `vceq_u8`); выбор — [`#L504-L520`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/hashtable_control_bytes.h#L504-L520). На AArch64 `Match()` идёт через NEON, а `MaskEmpty/Full` — через портативную 64-битную SWAR-реализацию («to avoid the latency of moving between data GPRs and Neon registers»). 8-байтная NEON-группа есть как минимум с LTS 20220623 (проверил тег) |
| Контрольные байты: kEmpty = −128, kDeleted = −2, kSentinel = −1, полный слот = H2 (0..127) | ✓ | [`#L185-L187`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/hashtable_control_bytes.h#L185-L187) |
| H2 = 7 старших бит хеша, H1 = хеш | ✓ | [`raw_hash_set.h#L831-L837`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L831-L837) |
| Ёмкость = 2^k − 1 | ✓ | `IsValidCapacity`, [`#L395`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L395) |
| Максимальная загрузка 7/8 (на малых ёмкостях — «оставить один пустой») | ✓ | [`#L431-L452`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L431-L452) |
| Зондирование: квадратичное (треугольное) **по группам**; окно группы начинается с любого байта (клонированные kWidth − 1 байт в конце) | в колоде «слот занят — идём к следующему в той же строке кэша» — **неточно** | [`#L1748-L1760`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L1748-L1760), `next()` [`#L1785-L1788`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L1785-L1788), `NumClonedBytes` [`#L1149`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L1149) |
| Одна аллокация: GrowthInfo, контрольные байты и слоты в одном массиве | ✓ | `RawHashSetLayout` [`#L1186-L1229`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L1186-L1229) |
| Ссылки и указатели инвалидируются при rehash и move | ✓ | [`flat_hash_set.h#L69-L70`, `#L105-L110`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/flat_hash_set.h#L60-L110) |
| `absl::Hash<uint64_t>` — **не тождество**. С опциями по умолчанию (`ABSL_OPTION_INLINE_HW_ACCEL_STRATEGY 0`) это `Mix(seed ^ v, kMul)`: 128-битное умножение, xor старшей и младшей половин. CRC32-путь включается только при ненулевой опции. Seed — адрес `kSeed` (зависит от ASLR, свой на процесс), плюс 16-битный per-table seed в H1. Порядок обхода меняется от запуска к запуску | ✓ («другой хешер») | [`hash.h#L1044`, `#L1063-L1069`, `#L1170-L1173`, `#L1465-L1470`, `#L1552-L1561`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/hash/internal/hash.h#L1044); [`options.h#L186-L210`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/base/options.h#L186-L210); PerTableSeed — [`raw_hash_set.h#L597-L613`](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/raw_hash_set.h#L597-L613) |
| Тег 20260817.0 существует | ✓ | `git ls-remote`: `20260526.0`, `20260817.0`; коммит тега от 2026-08-18 |

**Измерено (тест `absl_alloc.cpp`, x86, kWidth = 16):**

| сценарий | size | capacity | загрузка | вызовов new | запрошено |
|---|---|---|---|---|---|
| U = N = 2^20, `reserve(N)` | 1 048 576 | **2 097 151** | 0,50 | **1** | **18 874 344 Б (18,87 МБ)** ✓ |
| U = 1%, `reserve(N)` | 10 485 | 2 097 151 | 0,005 | 1 | 18,87 МБ |
| U = 1%, без reserve | 10 485 | 16 383 | 0,64 | 13 | **0,295 МБ** → ×64,0 ✓ (слайд 18) |
| U = N, без reserve | 1 048 576 | 2 097 151 | 0,50 | 20 | 37,7 МБ (сумма за все роста) |

Попутная деталь для вопросов: 2^20 — неудачная точка для Swiss table. Ёмкость 2^20 − 1 вмещает только 917 504 элемента (7/8), поэтому `reserve(2^20)` берёт 2^21 − 1 слотов, и таблица заполнена на 50%. На ARM размер отличается на единицы байт (клонов 7, а не 15).

**Формулировка для слайда 15:** «Ищем ключ: считаем хеш, берём окно метаданных — 8 байт на ARM, 16 на x86 — и одним векторным сравнением находим слоты, где совпали 7 бит хеша. Трогаем только их. Если в группе нет пустого места — прыгаем к следующей группе». Сноску «схема упрощена: 8 слотов вместо групп по 16» стоит заменить на «на ARM группа как раз 8 слотов».

---

## 6. `std::hash` для целых и последовательные id — важный методологический момент

- **Тождество в обеих библиотеках.**
  - libc++: `__hash_impl` для целых ≤ size_t → `static_cast<size_t>(__v)` — [`__functional/hash.h#L372-L377`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__functional/hash.h#L372-L377).
  - libstdc++: `_Cxx_hashtable_define_trivial_hash` → `static_cast<size_t>(__val)` — [`functional_hash.h#L115-L121`, `#L169`](https://github.com/gcc-mirror/gcc/blob/releases/gcc-13.3.0/libstdc%2B%2B-v3/include/bits/functional_hash.h#L115-L121).
- **Последствия (тест `cluster.cpp`, 65 536 ключей, `reserve(N)`):**

| ключи | libc++: заполнено бакетов / макс. цепочка / нс на вставку | libstdc++: то же |
|---|---|---|
| последовательные 1..N | 65 536 / 1 / 40 | 65 536 / 1 / 39 |
| шаг 1024 | **64 / 1024 / 2 762** | 65 536 / 1 / 41 |
| шаг 2^20 | **1 / 65 536 / 60 540** | 65 536 / 1 / 38 |
| шаг 1000 | 8 192 / 8 / 31 | 65 536 / 1 / 26 |
| случайные | 41 450 / 7 / 62 | 41 834 / 7 / 41 |

   Маска по степени двойки плюс тождественный хеш означают, что в индекс попадают только младшие биты. Id с общими младшими нулями — снежинки-подобные id с нулевым счётчиком, кратные 1000/1024 метки времени, выровненные значения — складываются в одну цепочку, и таблица деградирует до списка (×1500 на шаге 2^20). У libstdc++ простой модуль это маскирует. flat_hash_set и boost перемешивают хеш и не страдают.
- **Плотные id — лучший случай для узловой таблицы** (тест `seqrand.cpp`, 2^20, `reserve(N)`, полная операция):

| | libc++: только вставки / вся операция | libstdc++ |
|---|---|---|
| случайные 64-бит | 134 / **320** нс/эл, ключей в занятых бакетах: 385 515 (≈N/e) | 151 / 365 |
| плотные 1..N (перемешаны) | 42 / **68** нс/эл, коллизий: 0 | 38 / 69 |

   На плотных id коллизий нет, а обход и деструктор идут по памяти почти подряд. Гипотеза: в libc++ и libstdc++ все узлы связаны в один односвязный список, и при отсутствии коллизий каждый новый узел встаёт в голову списка, так что порядок списка совпадает с порядком аллокаций. Счётчиками я это не проверял.

**Вывод для доклада:** кейс на слайде 3 — «id из SQLite по первичному ключу», то есть плотные и почти последовательные. Замеры сделаны на случайных 64-битных. Для `unordered_set` это далеко не нейтральный выбор: на x86 разница ≈4,7×, и в пользу хеша. Варианта два:

- (а) честно назвать данные: «в сериях id случайные 64-битные — как у серверных/UUID-подобных; для rowid из SQLite картина другая»;
- (б) добавить одну строку «плотные id».

Иначе внимательный зал спросит. Формулировку из заметок «с реальными id проверьте гистограмму цепочек» стоит усилить: «в libc++ после `reserve(2^k)` номер ячейки — младшие биты id как есть».

---

## 7. LSD radix sort

- Схема из колоды (8 проходов по байту, гистограммы 8×256 за один проход, пропуск прохода, если все ключи в одной корзине, буфер на N) — стандартная и корректная. Проверка пропуска: `count[b][byte_b(v[0])] == N`.
- **Измерено число проходов** (тест `variants.cpp`, N = 2^20):
  - случайные 64-бит — **8**;
  - плотные 1..2^20 (как rowid SQLite) — **3**;
  - случайные < 2^32 — **4**.
  - Для rowid < 2^24 будет 3 прохода, для < 2^32 — не больше 4. Серии колоды (случайные 64-бит) — худший случай и для radix.
- Тайминги (x86, нс/эл, шумно): radix + unique 27 / 21,5 / 15 против sort + unique ≈78–85. Radix в 3–5 раз быстрее, по направлению это совпадает с M2 (6,9 против 19,9).
- **Нижняя граница для сортировки сравнениями:** ⌈log2 N!⌉. Для N = 2^20 это 19 458 756 сравнений, **18,56 на элемент** (посчитано по lgamma). Фактически libc++ делает 22,2, libstdc++ — 25,6 (случайные данные).
  - По памяти, не проверено: для самой задачи «все ли элементы различны» (element distinctness) в модели алгебраических деревьев решений тоже есть Ω(N log N) (Ben-Or, 1983). Для N элементов с U различными сортировка требует Ω(N log U) сравнений (Munro–Spira, 1976). Хеш и radix обходят эти границы, потому что работают не сравнениями.
- Формулировка из заметок «на неё не действует нижняя граница N log N» ✓.

---

## 8. «Отсортировать дельту и слить с локальными»

- **`std::set_union`, семантика по стандарту:** «если в первом диапазоне m эквивалентных элементов, а во втором n, берутся все m из первого и последние max(n − m, 0) из второго». Сложность — не больше 2·((last1 − first1) + (last2 − first2)) − 1 сравнений. Источник: [`algorithms.tex#L10445-L10452`](https://github.com/cplusplus/draft/blob/main/source/algorithms.tex#L10445-L10452), [`#L10480`](https://github.com/cplusplus/draft/blob/main/source/algorithms.tex#L10480).
  - Отсюда: если в дельте id повторяется дважды, а в локальных его нет, в выход попадут **обе копии**. Измерено: без `unique` по дельте осталось 32 966 дублей из 1,06 млн.
- **Правильный рецепт (локальные L из PK уже отсортированы и уникальны):** `sort(D)` → `D.erase(unique(D))` → `set_union(L, D, out)`. Работа — O(|D| log |D| + |L| + |D|), одна аллокация под выход.
- **Вариант на месте:** `v = L ++ D` → `sort(хвост)` → `std::inplace_merge` → `unique` + `erase`. `inplace_merge` берёт временный буфер на min(len1, len2) элементов, то есть на |D| ([libc++ `inplace_merge.h#L213-L214`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__algorithm/inplace_merge.h#L213-L214)). Если буфера нет, работает за O(N log N) (стандарт, [`algorithms.tex`, раздел inplace.merge](https://github.com/cplusplus/draft/blob/main/source/algorithms.tex#L10153)).
- **Так уже устроен `std::flat_set::insert(first, last)` в libc++:** добавить в конец, `ranges::sort` хвоста, `ranges::inplace_merge`, `ranges::unique` и `erase` — [`__flat_set/flat_set.h#L696-L712`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__flat_set/flat_set.h#L696-L712). Конструктор из диапазона — это буквально `sort` + `unique` ([`#L689-L693`](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/include/__flat_set/flat_set.h#L689-L693)). Хорошая реплика для сцены: «эту идею стандартная библиотека уже реализовала».
- **Грубый замер на x86** (L = 2^20 отсортированных, D = 64K с повторами и пересечением, нс на элемент входа):

| | libstdc++ | libc++ |
|---|---|---|
| sort + unique всего | 33,0 | 30,7 |
| sort(D) + unique(D) + set_union | **5,1** | **8,4** |
| sort(хвост) + inplace_merge + unique | 5,3 | 7,9 |
| unordered_set | 41,1 | 47,6 |

   Все результаты совпадают с эталоном. Кандидат из слайда 21 в 4–6 раз быстрее sort + unique. **Формулировку «не измерен» можно заменить на «на x86 — в 4–6 раз быстрее; на телефоне не мерил»,** или измерить на iPhone.

---

## 9. Дедуп в порядке первого появления

- **На хеше (правильно, на месте):** `size_t w = 0; for (i) if (seen.insert(v[i]).second) v[w++] = v[i]; v.resize(w);`. Индекс записи никогда не обгоняет индекс чтения, так что работа идёт на месте. Лучше брать плоскую таблицу с `reserve`.
- **На сортировке, два варианта:**
  1. пары `(key, idx)`, `sort` (лексикографически — то же, что стабильная сортировка по ключу), взять первую пару каждой группы, **отсортировать выживших по idx** (так в колоде);
  2. те же пары и `sort`, затем пометить `keep[idx]` первой пары группы в **битовой маске** (N бит) и одним проходом по исходному массиву переписать помеченные. **Вторая сортировка не нужна.**
- **Измерено (x86, U = N/2, 2^20, нс/эл, результаты идентичны):**
  - libstdc++: хеш 69,3; sort + вторая сортировка 140,1; sort + битмап 105,3.
  - libc++: хеш 88,3; sort + вторая сортировка 149,4; sort + битмап 110,0.
  - Битмап экономит 25–30%, но хеш всё равно выигрывает. Вывод колоды «хеш, в 3,4 раза» по направлению верен, а на вопрос «вы обделили сортировку» есть ответ.

---

## 10. Альтернативы для вопросов (кратко)

- **`boost::unordered_flat_set`** ([core.hpp#L158-L199](https://github.com/boostorg/unordered/blob/develop/include/boost/unordered/detail/foa/core.hpp#L158-L199)):
  - группы по **15 слотов** плюс 16-байтное слово метаданных: 15 байт «редуцированного хеша» и **байт переполнения** (8 бит по h % 8);
  - число групп — степень двойки, квадратичное зондирование по группам, `mlf = 0.875` ([#L1260](https://github.com/boostorg/unordered/blob/develop/include/boost/unordered/detail/foa/core.hpp#L1260));
  - SSE2 на x86 и **128-битный NEON (`uint8x16_t`, эмулированный movemask) на ARM** ([#L48-L66](https://github.com/boostorg/unordered/blob/develop/include/boost/unordered/detail/foa/core.hpp#L48-L66), [#L466-L475](https://github.com/boostorg/unordered/blob/develop/include/boost/unordered/detail/foa/core.hpp#L466-L475)). Это отличие от Abseil, у которого на ARM 8 байт;
  - если хеш не помечен как «лавинный» (а `boost::hash`/`std::hash` для целых — тождество), результат перемешивается через `mulx` ([#L890-L915](https://github.com/boostorg/unordered/blob/develop/include/boost/unordered/detail/foa/core.hpp#L890-L915));
  - по памяти, не проверено: появился в Boost 1.81; последний тег Boost в репозитории — 1.92.0.
- **`ankerl::unordered_dense`** (заголовок 5.2.0):
  - значения лежат в плотном `vector` без дыр ([#L1786](https://github.com/martinus/unordered_dense/blob/main/include/ankerl/unordered_dense.h#L1786)), рядом — отдельный индекс;
  - в 5.x индекс устроен как **группы по 16 однобайтных отпечатков + массив индексов значений + 8 счётчиков переполнения на группу**, без надгробий ([#L1844-L1856](https://github.com/martinus/unordered_dense/blob/main/include/ankerl/unordered_dense.h#L1844-L1856));
  - `default_max_load_factor = 0.8` ([#L1732](https://github.com/martinus/unordered_dense/blob/main/include/ankerl/unordered_dense.h#L1732));
  - по памяти: в v4 индекс был robin-hood; в текущем коде упоминается как предыдущий дизайн;
  - плюс для дедупа: выгрузка — это `std::move` плотного вектора значений.
- **`std::flat_set` (C++23):**
  - libc++ — «Complete» в **21** (`flat_map` — в 20; [Cxx23Papers.csv#L55-L57](https://github.com/llvm/llvm-project/blob/llvmorg-23.1.0/libcxx/docs/Status/Cxx23Papers.csv#L55-L57)); `__cpp_lib_flat_set 202511L` в `<version>`;
  - libstdc++ — есть в `releases/gcc-15.1.0/libstdc++-v3/include/std/flat_set`, в 14.1.0 файла нет;
  - Apple libc++ (Xcode) — не проверено: смотреть `__cpp_lib_flat_set`;
  - внутри — отсортированный вектор, так что это не хеш, а «sort + unique» в контейнере.
- **Swift `Set`:**
  - открытая адресация с **линейным** зондированием: `find` идёт `bucket(wrappedAfter:)` ([NativeSet.swift#L183-L195](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/NativeSet.swift#L183-L195));
  - число бакетов — степень двойки, индекс `hashValue & bucketMask` ([HashTable.swift#L353-L354](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/HashTable.swift#L353-L354)), занятость хранится битовой картой;
  - максимальная загрузка **3/4** ([#L74-L76](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/HashTable.swift#L74-L76));
  - хешер — **SipHash-1-3** (1 раунд сжатия, 3 финализации, [SipHash.swift#L78-L96](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/SipHash.swift#L78-L96)) с сидом процесса и сидом таблицы ([HashTable.swift#L112-L130](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/HashTable.swift#L112-L130));
  - то есть Swift `Set<UInt64>` — плоская таблица, но с дорогим по сравнению с тождеством хешем. По памяти, не проверено: на iOS это может быть отдельной серией.

---

## 11. Готовые формулировки для правок

1. **Слайд 11, сноска:** «Упрощённая схема узловых реализаций (libstdc++, libc++): max_load_factor 1.0, `std::hash` для целых — тождество. libstdc++: число ячеек простое, номер — остаток от деления. libc++: простое или степень двойки, если её попросили (`reserve(2^20)` → маска по младшим битам). Стандарт требует, чтобы ссылки на элементы переживали rehash».
   Цитата стандарта: «Rehashing invalidates iterators, changes ordering between elements, and changes which buckets elements appear in, but does not invalidate pointers or references to elements» — [`containers.tex#L4234-L4238`](https://github.com/cplusplus/draft/blob/main/source/containers.tex#L4234-L4238).
2. **Слайд 11, заметки:** вместо «на ARM оно не бесплатно» — «деление здесь ни при чём: в моём замере у libc++ маска. Дорого — узлы».
3. **Слайд 14:** «≈48 Б на уникальный ключ (узел 24 Б → блок malloc 32 Б + две ячейки по 8 Б при reserve(N), U = N/2). 512K входа → ~12 МБ, 1M → ~25 МБ. L2 P-кластера — 16 МБ».
4. **Слайд 15:** «окно из 8 (ARM) / 16 (x86) байт метаданных — одно векторное сравнение».
5. **Слайд 21:** «libc++ давно замечает, что разбиение не сделало ни одного обмена, и пробует досортировать вставками — на отсортированном входе ≈2 сравнения на элемент». И: «отсортировать дельту, убрать в ней повторы и слить (`set_union`) — так делает `std::flat_set::insert`; на x86 это в 4–6 раз быстрее».
6. **Слайд 33:** «идеи pdqsort — LLVM 16; вырожденные входы libc++ проходила линейно и раньше».
7. **Слайд 13:** подписать «запрошено у operator new», в заметках добавить «реально из кучи ≈42 МБ».
8. **Слайд 3 или сноски к сериям:** «id в сериях — случайные 64-битные».

## 12. Вероятные вопросы из зала и короткие ответы

- **«У libc++ же деление по простому модулю?»** Только если ёмкость не степень двойки. `reserve(1<<20)` даёт маску, `reserve(1'000'000)` — 1 000 003 бакета и деление. libstdc++ делит всегда.
- **«А если id — снежинки / кратны 1024?»** В libc++ после `reserve(2^k)` это катастрофа: 64 из 65 536 бакетов заняты, вставка в 70 раз медленнее, на шаге 2^20 — в 1500 раз. Решение — свой хешер-микшер или плоская таблица.
- **«А ваши id из SQLite не случайные»** — см. §6: на плотных id `unordered_set` в ≈4–5 раз быстрее, radix делает 3 прохода вместо 8. Ответ: «серии специально на случайных, чтобы убрать удачу раскладки; на плотных хеш выигрывает в среднем диапазоне — меряйте свои».
- **«pmr / пул-аллокатор для узлов?»** По памяти, не мерил: `std::pmr::unordered_set` на `monotonic_buffer_resource` убирает миллион malloc/free, но не прыжки по узлам. Кандидат на замер.
- **«Почему не `std::flat_set`?»** В libc++ ≥ 21 и GCC ≥ 15 он есть. Его вставка диапазоном и есть «отсортировать дельту + inplace_merge + unique».
- **«Почему radix не во всех местах?»** Нужен буфер N × 8 Б, выигрыш только на целых ключах, на малых N счётчики 8×256 не окупаются.

## 13. Что осталось непроверенным

- Нумерация Apple clang («21»), версия libc++ в конкретных iOS и macOS, наличие `std::flat_set` в Apple libc++.
- Округление malloc на macOS (nano, 16 Б) — по памяти.
- Задержка 64-битного `UDIV` на Apple M и Xeon — не проверял, поэтому из слайда её лучше убрать.
- Android NDK использует libc++ — по памяти, верно с NDK r18.
- Нижние границы Ben-Or и Munro–Spira — по памяти.
