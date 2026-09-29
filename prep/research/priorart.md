# «Плечи гигантов» для доклада «O(n) проиграл O(n log n)»: источники, цитаты, картинки и похожие доклады

HardFest 2026 · Никита Нагорнов · подготовлено 29.09.2026

---

## 0. Как читать отчёт

**Метки у каждого утверждения:**

- **[О]** — источник открыт и прочитан, ссылка рабочая. Почти всё открыто через GitHub (git-клоны, raw), documentation-API Apple и gist.
- **[С]** — видел только сниппет поиска, сама страница заблокирована прокси. Факт стоит перепроверить.
- **[П]** — по памяти, не проверено.
- **[А]** — мой анализ или вывод, не факт из источника.

**Что было недоступно.** Прокси этой сессии блокирует lemire.me, easyperf.net, chipsandcheese.com, youtube.com, habr.com, isocpp.org, stroustrup.com, aristeia.com, dl.acm.org, arxiv.org, abseil.io, cppconf.ru, highload.ru, mobiusconf.com, *.github.io, learn.microsoft.com и университетские сайты. Поэтому я искал первоисточники в GitHub-репозиториях: слайды CppCon лежат в `github.com/CppCon/CppCon20xx`, исходник сайта abseil.io — в `abseil/abseil.github.io`, книга Бахвалова — в `dendibakh/perf-book`, код и тексты постов Лемира — в `lemire/Code-used-on-Daniel-Lemire-s-blog`, слайды ClickHouse — в `ClickHouse/clickhouse-presentations`, PDF Дреппера и статья COZ — в `tpn/pdfs`.

**Локальные копии.** Всё скачанное и извлечённый текст лежат в `/tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/research/priorart/`. Тексты слайдов — в файлах `carruth.txt`, `acton.txt`, `alexandrescu.txt`, `txt_*.txt`, `drepper.txt`, `coz.txt`, `wwdc*.txt`.

**Смежные отчёты.** Фактчек C++ (`research/cpp.md`) и Apple (`research/apple.md`) частично пересекаются с этим отчётом. Ниже я на них ссылаюсь, а не дублирую.

---

## 1. Главное

### 1.1. Что нашлось

1. **Раунд 1 доклада почти дословно повторяет пост Лемира 2017 года** [О: код]. В посте «Counting exactly the number of distinct elements: sorted arrays vs. hash sets?» от 23.05.2017 сравниваются `std::unordered_set<uint64_t>` и `std::sort` + `std::unique` на случайных 64-битных числах. Код поста открыт: [uniquevalues.cpp](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2017/05/23/uniquevalues.cpp). Раунд 2 — это классика Карратта 2014 («unordered_map — это связные списки, хорошая таблица — открытая адресация») и Кулукундиса 2017 (SwissTable). Свежие пересечения: Jonathan Müller, CppCon 2025, «Sorted std::vector is consistently faster than std::unordered_map!» [О]; серия статей «Структуры данных на практике» на Хабре, глава 7 «Хэш-таблицы и конфликты кэша» («Миф про O(1)»), 26.03.2026 [С].
2. **У раундов 3 и 4 я прямых аналогов не нашёл.** Раунд 3 — это контракт выхода и порядок входа. Раунд 4 — переворот результата из-за QoS и E-ядра и расхождение CI с устройством. Сюда же относится «бенчмарк врал по-разному на двух процессорах». Оговорка: YouTube, Хабр и сайты конференций закрыты, поиск был неполным. Вывод [А]: новизна доклада в раундах 3 и 4, а раунды 1 и 2 стоит **честно атрибутировать и сжать**. CFP HardFest прямо отсекает «обзорные» доклады (см. `conf.md`, §2.2).
3. **Сильные первоисточники в поддержку каждого раунда** [О]:
   - Карратт: «Discontiguous data structures are the root of all (performance) evil».
   - Эктон: «If you don't understand the hardware, you can't reason about the cost of solving the problem».
   - Дреппер, 2007: тот же pointer chasing по случайному кольцу, что и на слайде `cores`.
   - Бахвалов: «replicate the target system configuration».
   - Abseil Fast TotW #39: «Benchmarks are only a tool for debugging efficiency: Production is ultimately what matters».
   - Apple: «profiling on a device instead of the simulator».
   - Apple WWDC25 «Optimize CPU performance with Instruments»: тот же O(log n) бинарный поиск ускоряется вдвое от безветвлённой версии и ещё вдвое от раскладки Эйцингера. Это пример «цены шага» от самой Apple.
4. **Свежие цифры Лемира про Apple, которые прямо касаются колоды** [О]:
   - Apple M2: одиночный pointer chase по 256 МиБ — **102,1 нс**. При 28 параллельных цепочках — 4,3 нс на обращение, «about 28 parallel paths».
   - Apple M4 «can predict perfectly 10,000 branches» (пост от 18.03.2026).
5. **Контраргументы, к которым стоит готовиться** [О]:
   - Максим Кита (ClickHouse, HighLoad++ 2021): «How NOT to Do Benchmarks: Test hash tables on random integer values».
   - Репозиторий det/random_insert: «runtime complexity and cache efficiency are orthogonal». Пример Страуструпа там назван «misleading».
   - Бергер: эффект -O3 против -O2 «indistinguishable from noise».

### 1.2. Что противоречит колоде или требует правки (с точки зрения prior art)

| # | Слайд | Проблема | Источник | Что сделать |
|---|---|---|---|---|
| P1 | `result`, `curve`, `allocs`, `flatmin`, `flat` | Раунды 1–2 известны давно, а в колоде нет ни одной ссылки | Лемир 2017 [О: код], Карратт 2014 [О], Кулукундис 2017/2019 [О], Müller 2025 [О] | Добавить одну фразу и мелкую сноску: «это классика: Lemire 2017, Carruth 2014, Kulukundis 2017; новое — дальше». Время раундов 1–2 сократить в пользу 3–4 |
| P2 | `learned` | «Предсказатель ни при чём» на M2 Pro сказано слишком категорично. Лемир [О]: Apple M4 безошибочно выучивает около 10 000 ветвлений, а сортировка 1024 элементов — это порядка 10 000 сравнений, ровно на границе. [А] Объяснение рабочим набором плохо сходится по величине. Массив в 8 КБ из L2 подгружается за единицы микросекунд, это максимум ≈3 нс на элемент, а разница — около 10 нс на элемент. Если вход восстанавливается прямо перед вызовом, массив уже лежит в L1 | Lemire 2026-03-18 [О] | Смягчить: «на M2 Pro разницу даёт не история ветвлений (копии одинаковые), а что-то, связанное с адресами; счётчики — следующий шаг». Проверить в Instruments → CPU Counters (WWDC25 308 [О]) и контрольным опытом: 8 копий × 1024 = 64 КБ, это меньше L1 |
| P3 | `memory` | «L2 ~5 нс, RAM ~100 нс» подаются как справочные. В обновлённой таблице Dean & Ghemawat (2023, ред. 2025) стоит **L2 3 нс, RAM 50 нс**, в старой (Norvig/Dean) — L2 7 нс, RAM 100 нс [О]. Если сослаться на «Latency Numbers», вас поправят | Performance Hints [О]; gist jboner [О] | Опираться на свой замер со слайда `cores` или на Лемира: M2 — 102 нс [О]. «Десятки промахов в полёте» подтверждает Лемир: около 28 на M2 [О] |
| P4 | `flatmin` | «Группа из 16 байт… одной SIMD-инструкцией» неверно для M2 и iPhone: на AArch64 Abseil использует группу из **8** (NEON) | abseil-cpp, тег 20260817.0, `hashtable_control_bytes.h`, `GroupAArch64Impl::kWidth = 8` [О, перепроверил] (так же в `cpp.md`, п. B) | «8 байт на ARM, 16 на x86». Сноска «8 слотов вместо 16» на ARM как раз верна |
| P5 | `hashtable`, заметки | «std::hash — тождество, для случайных id идеально». Миловидов [О] показал, что для узловой таблицы тождество безвредно (10,319 против 10,279 с), а для открытой адресации — катастрофа (dense_hash_map медленнее в 26 раз). Раунд 2 как раз переходит на открытую адресацию | ClickHouse, 2017 [О] | Одна фраза: «у flat_hash_set свой перемешивающий хешер (absl::Hash), поэтому тождество std::hash ему не грозит» (см. `cpp.md`: absl::Hash не тождество) |
| P6 | `case`, все серии | Вход — случайные 64-битные id, а кейс про rowid из SQLite. Кита прямо называет тестирование хеш-таблиц на случайных int антипаттерном | Кита, HighLoad++ 2021 [О]; `cpp.md`, п. H | Сказать вслух, почему id случайные, и держать ответ наготове (§9) |
| P7 | `qos`, заметки | «utility — класс, которым в реальных проектах помечают синхронизацию». Apple в Energy Efficiency Guide относит synchronizing к **Background** [О] | apple.md §1.2; Energy Efficiency Guide [О, локальная копия] | «Apple советует для синхронизации даже background — там ещё дороже; utility — компромисс, который я вижу в проектах» |
| P8 | `diff`, `outcontract` | `ids.assign(s.begin(), s.end())` на flat_hash_set даёт порядок, который меняется от запуска к запуску. Abseil делает это намеренно, против закона Хайрама. У Кулукундиса есть готовая история: сервис Dedup на unordered_set и тест `DedupTest`, завязанный на порядок обхода | Kulukundis, CppCon 2019 [О]; `raw_hash_set.h` (per-table seed) [О] | Одна фраза в заметках к `outcontract` или в backup: «порядок любой — значит любой каждый раз; тесты и снапшоты это ловят» |
| P9 | `cores` | Метод (pointer chasing по случайному циклу) выглядит самодельным | Дреппер 2007, рис. 3.10/3.15 [О]; Слотин [О]; Лемир testingmlp [О] | В сноске: «метод — Drepper 2007 / Intel MLC / Lemire testingmlp». Это снимает вопрос «а правильно ли вы мерили» |

---

## 2. Карта: слайд → источник

| Слайд | Что подкрепить | Лучший источник |
|---|---|---|
| `diff`, `twoways` | «линейно вместо n log n» — типичный аргумент | Alexandrescu 2019: меньше сравнений, но медленнее (§3.12); CppCoreGuidelines Per.6 (§4.3) |
| `vote`, `result` | интуиция экспертов ошибается | Per.6: «even experts are regularly surprised» [О]; Alexandrescu «Measuring gives you a leg up…» [С] |
| `bigo`, `sums` | Big-O не знает цены шага | Alexandrescu 2019 «Informational entropy of comparisons radically affects performance» [О]; WWDC25 308, Эйцингер [О]; Slotin «beyond just asymptotic complexity» [О]; det/random_insert как противовес [О] |
| `sortmin`, `radixmin` | radix для целых ключей | Alexandrescu 2019: «Use Radix Sort for small integers, default ordering» [О] |
| `hashtable`, `nodes` | узлы — это связные списки | Carruth 2014, слайд 50: «These buckets are… linked lists» [О]; Миловидов 2017: цепочки против открытой адресации [О]; COZ dedup: гистограмма корзин [О] |
| `memory` | лестница, строка кэша, MLP | Drepper 2007 [О]; Lemire M2/M4 MLP [О]; Dean & Ghemawat [О]; Carruth: таблица задержек [О]; Meyers [С] |
| `allocs` | миллион new и delete; второй платёж | Kita 2021: «Deinitialization of std::unordered_map took longer than benchmarks of other tables» [О]; Abseil Performance Hints «Batched storage» [О]; Lemire 2025-12-30 про переразмер аллокатора на macOS [О] |
| `cachecost` | излом на границе кэша | Drepper, рис. 3.15 и текст про LLC [О] |
| `flatmin`, `flat` | SwissTable | Abseil blog 2018 и Design Notes [О]; Kulukundis 2019 [О]; abseil-cpp 20260817.0 [О] |
| `share`, `outcontract`, `inputorder` | данные и контракт назначают победителя | Acton «If you have different data, you have a different problem» [О]; Slotin «Differing datasets» [О]; Lemire «Faster sorted array unions by reducing branches» (2021) [С + код О]; Dean & Ghemawat: контрпример, где хеш заменил отсортированное пересечение (−21,6%) [О] |
| `qos`, `cores` | QoS влияет на ядро | Apple WWDC20 10686 [О]; Apple News 2020 [О]; Tech Talk 110147 [О]; Bakhvalov 13-4 (гибридные ядра, pinning) [О] |
| `flip` | CI не то ядро | Bakhvalov 2-1, 2-6 [О]; Abseil Fast #39 [О]; Drepper: «twice as fast… thanks to the increased last level cache size» [О]; Apple «profile on that device» [О] |
| `learned` | бенчмарк выучил вход | Lemire 2019 и 2026 [О]; Abseil Fast #39/#75 [О]; Slotin (GCD и порядок) [О]; Mytkowicz/Berger [О через слайды Бергера] |
| `checklist` | методология | Berger/Stabilizer [О]; Bakhvalov «Measure one level deeper», неожиданные ускорения [О]; Slotin «A/B testing» [О]; Kita: медианы и две машины [О]; Apple «Writing and running performance tests» [О] |
| `decision`, `final` | правило вместо нотации | Knuth 97%/3% [О через Dean & Ghemawat]; Leiserson et al. 2020 «tailor it to the hardware» [О через Бахвалова] |

---

## 3. Обязательные источники по списку

### 3.1. Chandler Carruth, «Efficiency with Algorithms, Performance with Data Structures» (CppCon 2014)

- **Ссылка [О]:** [слайды PDF в CppCon/CppCon2014](https://github.com/CppCon/CppCon2014/blob/master/Presentations/Efficiency%20with%20Algorithms%2C%20Performance%20with%20Data%20Structures/Efficiency%20with%20Algorithms%2C%20Performance%20with%20Data%20Structures%20-%20Chandler%20Carruth%20-%20CppCon%202014.pdf). Извлечённый текст — `priorart/carruth.txt`.
- **Что взять (дословно со слайдов):**
  - с. 38: «DISCONTIGUOUS DATA STRUCTURES ARE THE ROOT OF ALL (PERFORMANCE) EVIL»;
  - с. 18: «C++ DOESN'T GIVE YOU PERFORMANCE, IT GIVES YOU CONTROL OVER PERFORMANCE»;
  - с. 50: «STD::UNORDERED_MAP… These buckets are… you guessed it… linked lists. You essentially always have some pointer chasing.»;
  - с. 51: «A GOOD HASH TABLE DESIGN: No buckets! Use open addressing… Table stored as contiguous range of memory… local probing… in the same cache line (usually)» — это ваш раунд 2 в одном слайде 2014 года;
  - с. 53–54: «EXCEPT THAT THIS IS ALL A LIE… Algorithms can also influence the data access pattern regardless of the data structure used»;
  - с. 11: «COMPUTE/WATT DOMINATES» — мостик к E-ядрам;
  - с. 42: таблица задержек Norvig/Dean (L1 0,5 нс; L2 7 нс; RAM 100 нс).
- **Куда:** `nodes` или `memory` (цитата с. 38), `flatmin` (с. 51 как «это известно с 2014»), `final` («control over performance»).
- **Как отличаться [А]:** Карратт говорит «никогда не unordered_map». Вы показываете, что и это зависит от данных и контракта: при 1% уникальных и порядке первого появления хеш выигрывает.

### 3.2. Matt Kulukundis, «Designing a Fast, Efficient, Cache-friendly Hash Table, Step by Step» (CppCon 2017) и продолжение 2019

- **2017:** слайдов в репозитории CppCon2017 нет, я проверил листинг [О]. Видео — [youtube.com/watch?v=ncHmEUmJZf4](https://www.youtube.com/watch?v=ncHmEUmJZf4) [С]. Аннотация по сниппету [С]: путь от `std::unordered_map` к SwissTable, «2-3x better performance with significant memory reductions».
- **Первичное подтверждение [О]:** [Abseil blog «Swiss Tables and absl::Hash»](https://github.com/abseil/abseil.github.io/blob/master/_posts/2018-09-27-swisstables.md), 27.09.2018; авторы Benzaquen, Evlogimenos, **Kulukundis**, Perepelitsa. Цитаты: «Last year at CppCon, We presented a talk on a new hashtable…»; «The "flat" Swiss tables should be your default choice. They store their value_type inside the container's main array to avoid memory indirections. Because they move data when they rehash, elements do not get pointer stability.»
- **[Swiss Tables Design Notes](https://github.com/abseil/abseil.github.io/blob/master/about/design/swisstables.md) [О]:** H1 — 57 бит (позиция), H2 — 7 бит (метаданные), «one byte of overhead for every entry»; «winnow 16 candidates down… in only a few instructions» — это про x86 SSE.
- **Kulukundis, «Abseil's Open Source Hashtable: 2 Years In», CppCon 2019 [О]:** [слайды PDF](https://github.com/CppCon/CppCon2019/blob/master/Presentations/abseils_open_source_hashtable_2_years_in/abseils_open_source_hashtable_2_years_in__matthew_kulukundis__cppcon_2019.pdf). Что там для вас:
  - схема H1/H2 и SSE-`Match` (`_mm_set1_epi8`, `_mm_cmpeq_epi8`, `_mm_movemask_epi8`) — готовая картинка для `flatmin`;
  - **закон Хайрама** (слайд 24): «With a sufficient number of users of an API, it does not matter what you promise in the contract, all observable behaviors of your system will be depended on by somebody. — Hyrum Wright»;
  - **дедупликация как пример** (слайды 26, 36–37): сервис `Dedup` на `std::unordered_set` и тест `TEST(Service, DedupTest)`, который зависел от порядка обхода. Вариант на flat_hash_set: `if (seen.insert(i).second) res.add_id(i);` — это ваш «порядок первого появления» из `outcontract`;
  - в debug-сборке порядок обхода намеренно рандомизирован: `demo()` возвращает «true — 50.3% of the time (in debug mode)».
- **Проверено в коде [О]:** в abseil-cpp на теге `20260817.0` (его указывает колода) `GroupSse2Impl::kWidth = 16`, `GroupAArch64Impl::kWidth = 8`. Выбор: `#ifdef ABSL_INTERNAL_HAVE_SSE2 … #elif …ARM_NEON… using Group = GroupAArch64Impl`. В `raw_hash_set.h` есть per-table seed, «to ensure non-determinism of iteration order». См. [hashtable_control_bytes.h@20260817.0](https://github.com/abseil/abseil-cpp/blob/20260817.0/absl/container/internal/hashtable_control_bytes.h).
- **Куда:** `flatmin` (схема, исправить 16→8 для ARM), `outcontract` (история DedupTest и закон Хайрама), backup.

### 3.3. Bjarne Stroustrup: vector против list (GoingNative 2012, кейноут «C++11 Style»)

- **Первоисточник открыть не удалось.** learn.microsoft.com, isocpp.org и stroustrup.com заблокированы.
- **Что известно по сниппетам [С]:** кейноут «C++11 Style», GoingNative 2012 ([learn.microsoft.com](https://learn.microsoft.com/en-us/shows/goingnative-2012/keynote-bjarne-stroustrup-cpp11-style)), фрагмент про списки — [youtube.com/watch?v=YQs6IC-vgmo](https://www.youtube.com/watch?v=YQs6IC-vgmo). Пост «Are lists evil?» — [isocpp.org/blog/2014/06/stroustrup-lists](https://isocpp.org/blog/2014/06/stroustrup-lists). Суть по сниппету: вставка и удаление в случайных позициях, время определяет линейный поиск позиции, и vector выигрывает за счёт компактности и кэша.
- **Постановка опыта [П]:** вставить N случайных чисел в отсортированную последовательность, затем удалять по случайным позициям; vector быстрее list на всех показанных N.
- **Первичная замена [О]:** C++ Core Guidelines (редакторы Stroustrup и Sutter), [SL.con.2](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md#rsl-vector): «Even when other containers seem more suited, such as `map` for O(log N) lookup performance or a `list` for efficient insertion in the middle, a `vector` will usually still perform better for containers up to a few KB in size.»
- **Контраргумент [О]:** [det/random_insert](https://github.com/det/random_insert). Автор называет видео «misleading» и показывает, что «runtime complexity and cache efficiency are orthogonal». Вставка 10⁶ чисел в случайные позиции: vector — 155,5 с, btree_array — 0,19 с, list не укладывается в лимит. Это прямая поддержка вашей мысли «Big-O спасает от катастроф» (`bigo`). Из этой таблицы 2×2 получается хорошая картинка (§8, К1).
- **Куда:** `bigo` — одной фразой («классика Страуструпа 2012») плюс противовес. Отдельный слайд не нужен: зал это видел.

### 3.4. Scott Meyers, «CPU Caches and Why You Care»

- **Первоисточник заблокирован** (aristeia.com). По сниппетам [С]: доклад читался на code::dive 2014, C++ and Beyond 2010 и ACCU 2011. Handouts — [codedive-CPUCachesHandouts.pdf](https://www.aristeia.com/TalkNotes/codedive-CPUCachesHandouts.pdf), видео — [youtu.be/WDIkqP4JbkE](https://youtu.be/WDIkqP4JbkE).
- **Вторичный конспект [О]:** [ardanlabs/gotraining, arrays/README.md](https://github.com/ardanlabs/gotraining/blob/master/topics/go/language/arrays/README.md) со ссылками на таймкоды Мейерса: «Small = Fast… Compact data structures that fit in cache are fastest»; «Predictable access patterns matter. Whenever it is practical, you want to employ a linear array traversal»; «Hardware likes to traverse data and instructions linearly along cache lines».
- **Куда:** `memory`, `sortmin` («читается подряд»). Цитировать Мейерса дословно стоит только после сверки с PDF.

### 3.5. Mytkowicz, Diwan, Hauswirth, Sweeney, «Producing Wrong Data Without Doing Anything Obviously Wrong!» (ASPLOS 2009)

- **PDF заблокирован.** Библиография [О] из perf-book: SIGPLAN Not. 44(3), 265–276, март 2009. Аннотация по сниппету [С]: «measurement bias is significant and commonplace»; эффект есть на Pentium 4, Core 2 и m5 O3CPU, в gcc и icc, в большинстве SPEC CPU2006; предложены causal analysis и setup randomization.
- **Как пересказывают другие [О]:**
  - Бахвалов, perf-book 2-1: «UNIX environment size… or the link order… can affect performance in unpredictable ways»;
  - слайды Бергера (CppCon 2020): «Layout biases measurement — Link Order, Environment Variable Size — Larger than the impact of -O3! (±40%)», а также «Change Username», «Run in a new directory»;
  - Слотин: «Even a program's name can affect its speed… the length of the name affects stack alignment».
- **Куда:** `learned` и `checklist`, одной строкой: «в 2009 году показали, что длина переменных окружения меняет результат сильнее, чем -O3». Атрибуция: «Mytkowicz et al., ASPLOS 2009, в пересказе Бергера».

### 3.6. Emery Berger, «Performance Matters» (Strange Loop 2019), Stabilizer и Coz

- **Доклад.** Видео — [youtube.com/watch?v=r-TLSBdHe1A](https://www.youtube.com/watch?v=r-TLSBdHe1A) [С]. Тот же доклад на CppCon 2020, [слайды PDF](https://github.com/CppCon/CppCon2020/blob/main/Presentations/performance_matters/performance_matters__emery_berger__cppcon_2020.pdf) [О]. В профиле [github.com/emeryberger](https://github.com/emeryberger/emeryberger) [О] он назван «The second most popular Strange Loop video of all time!»
- **Цитаты со слайдов [О]:**
  - «Layout is Brittle»;
  - «STABILIZER generates a new random layout every ½ second»;
  - «Analysis of Variance… p-value = 26.4%… one in four experiments will show an effect that does not exist!… The effect of -O3 over -O2 is indistinguishable from noise… did you try -O9?»
- **Stabilizer [О]:** [README](https://github.com/plasma-umass/stabilizer): «A random memory layout eliminates the effect of layout on performance, and repeated randomization leads to normally-distributed execution times.» По словам Бахвалова [О], проект «almost abandoned».
- **Coz [О]:** [README](https://github.com/plasma-umass/coz) и статья SOSP 2015 ([PDF в tpn/pdfs](https://github.com/tpn/pdfs/blob/master/COZ%20-%20Finding%20Code%20that%20Counts%20with%20Causal%20Profiling%20-%202015%20%28090-curtsinger%29.pdf)). **Кейс PARSEC `dedup` — находка для слайда `hashtable`:**
  - Coz указал на `hashtable.c:217`, обход цепочки в узловой хеш-таблице;
  - «dedup's hash function maps keys to just 2.3% of the available buckets»;
  - после замены хеш-функции средняя длина цепочки упала с 76,7 до 2,09, программа ускорилась на **8,95% ± 0,27%**, изменено три строки;
  - gprof этого не показал: hashtable_search из этапа вычисления хешей занимал 0,48% времени.
- **Куда:** `learned` и `checklist` (Stabilizer: -O2 против -O3 — шум), `hashtable` (Coz dedup: «проверьте гистограмму цепочек» — у вас это уже есть в заметках, теперь с живым примером).
- **Как отличаться [А]:** Бергер про то, что малые эффекты тонут в шуме. У вас эффекты в 2–3 раза, и вы показываете, что они **меняют знак** между средами. Скажите это: «это не те 3%, о которых спорит Бергер».

### 3.7. Daniel Lemire: ветвления в бенчмарках, хеш против сортировки, MLP на Apple

Все посты заблокированы, но код, сырые данные и (для 2025–2026 годов) тексты постов лежат в [lemire/Code-used-on-Daniel-Lemire-s-blog](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog) [О].

| Пост | Статус | Что взять | Слайд |
|---|---|---|---|
| **«Benchmarking is hard: processors learn to predict branches»**, 16.10.2019 | заголовок [С]; код и данные [О] — [2019/10/15](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/tree/master/2019/10/15) | 2000 случайных значений, ветвление «нечётное → записать», 1024 повтора на тех же данных. На Intel промахи на значение падают с 0,478 (повтор 0) до 0,020 (повтор 1023), такты — с 17,0 до 4,25. На AMD Rome — с 0,517 до 0,001 (`results.txt`, `resultsamdrome.txt`) | `learned` |
| «Mispredicted branches can multiply your running times», 15.10.2019 | [С] | предыстория того же опыта | `learned` |
| **«How many branches can your CPU predict»**, 18.03.2026 | [О] — [post.md](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2026/03/18/post.md) | «The AMD Zen 5 processor can predict perfectly 30,000 branches. The Apple M4… 10,000 branches. Intel Emerald Rapids… 5,000»; «if you test on small datasets, you can get surprising results that might not work on real data». См. P2 | `learned` |
| **«Counting exactly the number of distinct elements: sorted arrays vs. hash sets?»**, 23.05.2017 | заголовок и вывод [С]; код [О] — [uniquevalues.cpp](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2017/05/23/uniquevalues.cpp) | Тот же опыт, что в раунде 1: `unordered_set<uint64_t>` против `sort` + `unique`, N от 10 до 10⁸. Вывод по сниппету: хеш-множество платит кэш-промахами, сортировка делает больше операций, но их избегает | `result`, P1 |
| **«Memory-level parallelism: Apple M2 vs Apple M4»**, 09.07.2025 | заголовок [С]; данные [О] — [m2.txt](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2025/07/09/m2.txt), [m4.txt](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2025/07/09/m4.txt) | Массив 256 МиБ, цикл Саттоло. M2: 1 цепочка — 102,1 нс на обращение, 10 — 11,0, 28 — 4,3, «Maybe you have about 28 parallel paths?». M4: 94,3 → 3,7 нс | `memory` («десятки промахов в полёте», ~100 нс) |
| «Memory-level parallelism: Intel Skylake versus Apple A12/A12X», 13.11.2018 | [С] | «Skylake… about ten concurrent memory requests whereas Apple's A12… 40 or more» — про iPhone! | `memory` |
| «Memory-level parallelism: AMD is the king», 25.07.2026 | [О] — [post.md](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2026/07/25/post.md) | «That trip costs on the order of 100 nanoseconds»; «Memory latency has not improved in ten years… It got worse»; Zen 5 держит 58 промахов в полёте, Granite Rapids — 30, Graviton 5 — 19 | `memory` |
| «Sorting already sorted arrays is much faster?», 28.09.2016 | [С]; код [О] | отсортированный вход — к `inputorder` | `inputorder` |
| «Faster sorted array unions by reducing branches», 14.07.2021 | [С]; код [О] — [union2by2.cpp](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2021/07/14/union2by2.cpp) | безветвлённое слияние отсортированных массивов — это ваш неизмеренный кандидат `set_union` | `inputorder`, `decision` |
| «By how much does your memory allocator overallocates?», 30.12.2025 | [О] — [post.md](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2025/12/30/post.md) | на Linux `new char[4096]` даёт около 16 Б накладных; на macOS `new char[3585]` занимает 4096 («rounds up… to the nearest 512 byte boundary for moderately small allocations»). Для узлов по 24 Б действует квант 16 Б (см. `apple.md` §3) | `allocs` |
| «How fast is C++23's std::flat_map?», 17.09.2026 | [О] — [post.md](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2026/09/17/post.md) | 12 дней назад, «плоские» контейнеры на слуху. Случайная вставка в `std::flat_map`: 7149 нс на операцию при 100K, а `std::map` — 253, рост квадратичный. «Flat» не значит «всегда быстрее» | Q&A |
| «Microbenchmarking calls for idealized conditions», 16.01.2018 | [С] | противоположная позиция: микробенчмарк — в идеальных условиях. См. §9 | Q&A |

### 3.8. Ulrich Drepper, «What Every Programmer Should Know About Memory» (2007)

- **Ссылка [О]:** PDF в [tpn/pdfs](https://github.com/tpn/pdfs/blob/master/What%20Every%20Programmer%20Should%20Know%20About%20Memory%20-%20Ulrich%20Drepper%20%282007%29.pdf), версия 1.0 от 21.11.2007. Текст — `priorart/drepper.txt`. Официальные адреса akkadia.org и people.freebsd.org заблокированы.
- **Что взять:**
  - Аннотация: «the limiting factor for most programs is now, and will be for some time, memory access».
  - Методика §3.3.2 **совпадает с вашей на `cores`**: элементы `struct l { struct l *n; long int pad[NPAD]; }` связаны в кольцевой список, последовательно или в случайном порядке. Меряется время на элемент в зависимости от рабочего набора.
  - Рис. 3.10: три уровня с переходами на 2^14 и 2^20 байт, «the processor has a 16kB L1d and 1MB L2».
  - Рис. 3.15 «Sequential vs Random Read»: при случайном доступе «we reach 450 cycles and more… The curve keeps on rising».
  - Про размер LLC (к `flip`): «The second processor… can perform the work on the working set of 2^20 bytes twice as fast as the first processor. All thanks to the increased last level cache size.»
- **Куда:** `cores` (сноска «метод — Drepper 2007»), `memory`, `flip` (почему x86 с большим L3 любит хеш).

### 3.9. «Latency Numbers Every Programmer Should Know»

- **Gist [О]:** [jboner/2841832](https://gist.github.com/jboner/2841832): «Originally by Peter Norvig», «By Jeff Dean». L1 0,5 нс; branch mispredict 5 нс; L2 7 нс; mutex 25 нс; main memory 100 нс («20x L2 cache, 200x L1 cache»).
- **Обновление от самих авторов [О]:** Jeff Dean, Sanjay Ghemawat, [«Performance Hints»](https://github.com/abseil/abseil.github.io/blob/master/fast/hints.md) (abseil.io/fast/hints; «Original version: 2023/07/27, last updated: 2025/12/16»): «an updated version of a table from a 2007 talk at Stanford». L1 0,5 нс; **L2 3 нс**; branch mispredict 5 нс; mutex 15 нс; **main memory 50 нс**.
- **Интерактивная версия [О]:** Colin Scott, [interactive_latencies](https://github.com/colin-scott/interactive_latencies). В коде модели после 2000 года задержка памяти зафиксирована на 100 нс, с комментарием «Bus Latency is actually getting worse».
- **Куда:** `memory`. [А] Не ссылайтесь на таблицу как на источник «~100 нс»: у первоисточника теперь 50. Лучше свои плато с `cores` или M2 у Лемира (102 нс). Таблицу можно показать как «популярная таблица говорит одно, мой телефон в фоне — другое» (см. К5).

### 3.10. Denis Bakhvalov, «Performance Analysis and Tuning on Modern CPUs» (easyperf)

- **Ссылка [О]:** исходник книги [dendibakh/perf-book](https://github.com/dendibakh/perf-book), лицензия CC0.
- **Цитаты:**
  - **2-1 «Noise in Modern Systems»:** «when you analyze the performance of a production application, you should try to replicate the target system configuration, which you are optimizing for. Introducing any artificial tuning to the system will change results from what users of your service will see in practice.» Это эпиграф к `flip`.
  - **2-6 «Microbenchmarks»:** «when a benchmark runs on a system free from other demanding processes, it has all resources available to it, including DRAM and cache space. Such a benchmark will likely champion the faster version of the function even if it consumes more memory than the other version.» Это ровно unordered_set в CI с большим L3.
  - **2-3 «Performance Regressions»:** «the CI system should alert, not just on software performance regressions, but on unexpected performance improvements, too» — к `checklist`.
  - **2-6:** ссылка на Ousterhout, «Always measure one level deeper» (CACM 61(7), 2018) — к `checklist`, п. 8.
  - **13-4 «Task Scheduling»:** опыт на Alder Lake: P-ядра на SIMD-нагрузке «finish their jobs two times faster». «On macOS, it is not possible to pin threads to cores since the operating system does not provide an API for that» — подтверждает вашу фразу на `cores` «не имея API привязки».
  - **1-5:** «There is a famous quote by Donald Knuth… But the opposite is often true as well. Postponed performance engineering may be too late…» и цитата Leiserson et al. (Science, 2020): «During the post-Moore era, it will become ever more important to make code run fast and, in particular, to tailor it to the hardware on which it runs.»
  - **4-10:** Intel MLC меряет задержку «by doing dependent loads (also known as pointer chasing)»; для ARM готового инструмента нет, только lmbench и аналоги — к `cores`.

### 3.11. Donald Knuth: premature optimization, полная цитата

- **Источник:** D. E. Knuth, «Structured Programming with go to Statements», ACM Computing Surveys, т. 6, 1974, с. 261–301. Библиография — perf-book [О]. PDF ([pic.plover.com](https://pic.plover.com/knuth-GOTO.pdf), dl.acm.org) заблокирован.
- **Ядро цитаты [О, через Dean & Ghemawat, которые ссылаются на ACM PDF]:** «We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil. Yet we should not pass up our opportunities in that critical 3%.»
- **Полный абзац [С]:** «Programmers waste enormous amounts of time thinking about, or worrying about, the speed of noncritical parts of their programs, and these attempts at efficiency actually have a strong negative impact when debugging and maintenance are considered. We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil. Yet we should not pass up our opportunities in that critical 3%. A good programmer will not be lulled into complacency by such reasoning, he will be wise to look carefully at the critical code; but only after that code has been identified.»
- **Вторая цитата Кнута [О, через Dean & Ghemawat]:** «In established engineering disciplines a 12% improvement, easily obtained, is never considered marginal; and I believe the same viewpoint should prevail in software engineering.»
- **Куда:** `questions` или `decision`. Шестой вопрос «Какую долю всего этапа занимает эта операция?» — это и есть «critical 3%». Готовая связка: «Кнут не запрещал оптимизировать — он велел сначала найти свои 3%».

### 3.12. Andrei Alexandrescu о производительности

- **«Optimization Tips», CppCon 2014 [О]:** [PDF](https://github.com/CppCon/CppCon2014/blob/master/Presentations/Optimization%20Tips/Optimization%20Tips%20-%20Andrei%20Alexandrescu%20-%20CppCon%202014.pdf). Для вас: «App costs != benchmark estimates»; «Spills seldom occur in microbenchmarks. Issue in large applications»; «No generic allocator handles small allocs well» (к `allocs`).
- **«Speed Is Found In The Minds of People», CppCon 2019 [О]:** [PDF](https://github.com/CppCon/CppCon2019/blob/master/Presentations/speed_is_found_in_the_minds_of_people/speed_is_found_in_the_minds_of_people__andrei_alexandrescu__cppcon_2019.pdf). **Лучшая иллюстрация к `bigo`:**
  - «Looking Good»: бинарная вставка на 1M double — 22,14M сравнений против 25,33M, «15% reduction of comparisons!»;
  - «Oopsies»: 68,58 мс против 60,75 мс, «13% pessimization»;
  - «Unpleasant Realization — All research: minimize C(n)… Reality: Informational entropy of comparisons radically affects performance»;
  - выводы: «Measure everything like crazy», «Try silly things!», «Use Radix Sort for small integers, default ordering».
- **«Measuring gives you a leg up on experts who don't need to measure»** [С]: по сниппетам, из серии «Writing Fast Code» (code::dive 2015 / C++ and Beyond 2012). Точное место не проверено.
- **Куда:** `bigo` (Oopsies), `radixmin` (radix для целых), `vote` (эксперты).

### 3.13. Mike Acton, «Data-Oriented Design and C++» (CppCon 2014)

- **Ссылка [О]:** [pptx](https://github.com/CppCon/CppCon2014/blob/master/Presentations/Data-Oriented%20Design%20and%20C%2B%2B/Data-Oriented%20Design%20and%20C%2B%2B%20-%20Mike%20Acton%20-%20CppCon%202014.pptx). Текст — `priorart/acton.txt`.
- **Принципы, дословно:**
  - «The purpose of all programs, and all parts of those programs, is to transform data from one form to another.»
  - «If you don't understand the data you don't understand the problem.»
  - «**If you have different data, you have a different problem.**» → `share`
  - «If you don't understand the cost of solving the problem, you don't understand the problem.»
  - «**If you don't understand the hardware, you can't reason about the cost of solving the problem.**» → `bigo` и `final`
  - «Solving problems you probably don't have creates more problems you definitely do.»
  - «Rule of thumb: Where there is one, there are many.»
  - «**Software does not run in a magic fairy aether powered by the fevered dreams of CS PhDs.**» → `bigo`, ради смеха в зале
  - «Solve for the most common case first, Not the most generic.»
  - «Ignoring inconvenient facts is not engineering; It's dogma.»
- **«Три большие лжи»** на слайдах 47–60 — картинки, текста в pptx нет. По памяти [П]: «Software is a platform», «Code should be designed around a model of the world», «Code is more important than data».

### 3.14. Apple: WWDC и документация про QoS, энергоэффективность и Apple silicon

Основной фактчек Apple — в `apple.md`. Здесь только то, что пригодится как цитата или prior art.

- **WWDC20 10686 «Explore the new system architecture of Apple silicon Macs» [О]** (транскрипт `priorart/wwdc20_10686.txt`): «Setting QoS correctly is important on all our platforms, but it's particularly important on platforms with AMP, as QoS is a factor in determining which core a task will be run on.» → `qos`.
- **Apple Developer News, 22.06.2020, «Optimize for Apple Silicon with performance and efficiency cores» [О]:** «an app running in the background may have its threads placed on E cores to optimize battery life while the foreground app is taking advantage of P cores»; «the operating system uses the energy-efficiency information conveyed by QoS classes to influence placement of threads on P or E cores». → `qos` (у вас уже есть «influences placement»).
- **Tech Talk 110147 «Tune CPU job scheduling for Apple silicon games» [О]:** «the P and E cores use a similar microarchitecture»; «note the availability of P cores is not guaranteed»; «an iPhone XS has one cluster of two P cores, and one cluster of four E cores». → `cores`.
- **WWDC25 308 «Optimize CPU performance with Instruments» [О]** (`priorart/wwdc25_308.txt`). **Prior art от Apple к `bigo`:** бинарный поиск по `Span`; безветвлённая версия «about twice as fast»; раскладка Эйцингера «two times faster again than the branchless search». Там же: «requests that miss both caches… become 50 times slower than the fast path» и «64- or 128 byte segments called cache lines». Есть режим **CPU Counters → L1D Cache Miss Sampling** — инструмент для «счётчики — следующий шаг» (`cachecost`, `learned`).
- **Energy Efficiency Guide for iOS Apps: QoS [О, локальная копия]:** «Utility — Work that may take some time to complete and doesn't require an immediate result, such as downloading or importing data… Focuses on providing a balance between responsiveness, performance, and energy efficiency»; «Background — …such as indexing, **synchronizing**, and backups. Focuses on energy efficiency.» См. P7.
- **«Improving your app's performance» [О]** (developer.apple.com/documentation/xcode/improving-your-app-s-performance): «**You get higher-fidelity measurements by profiling on a device instead of the simulator. If the information you gather shows that your app performs poorly on a particular class or model of device, profile on that device.**» Организатор Xcode даёт метрики «by device model». → `flip`, `final`.
- **«Writing and running performance tests» [О]:** «configure the performance test plan so it replicates the conditions under which the code runs on device… Release build configuration». Базовое значение и «Max STDDEV» задаются в Xcode. Что базовые значения хранятся по моделям устройств — [П]. → `checklist`, п. 7.

### 3.15. Chips and Cheese: кэши и задержки M2 и A17

- **Сайт заблокирован** (chipsandcheese.com, old.chipsandcheese.com).
- **По сниппетам [С]:** статья «A Brief Look at Apple's M2 Pro iGPU» (Chester Lam, 31.10.2023) содержит, в том числе, задержку памяти CPU M2 Pro: «116.5 ns latency with a 1 GB test size using macOS's default 16 KB page size». Кэши M2 по сниппету: P — 128 КБ L1D, общий L2 16 МБ; E — 64 КБ L1D, L2 4 МБ. Есть страница [«Memory Latency Data»](https://old.chipsandcheese.com/memory-latency-data/) и заметка «Addendum: Clock Ramp on ADL, Zen 4, M1, and More» — к `drift` (разгон частоты при коротком запуске).
- **Отдельной статьи Chips and Cheese про CPU A17 Pro или про E-ядра Apple я не нашёл** [С]: поиск выдаёт только разборы Intel E-ядер (Crestmont, Skymont) и GPU M3/A17.
- **Инструмент [О]:** [clamchowder/Microbenchmarks](https://github.com/clamchowder/Microbenchmarks). Это код, которым сняты их графики задержка/рабочий набор; автор сам пишет, что это «playground».
- **Что делать [А]:** откройте их графики сами. Для `cores` ваш собственный график ценнее чужого: он снят на том же телефоне и в том же QoS. Chips and Cheese — только для ответа «сходится с независимыми замерами».

---

## 4. Сильные находки вне списка

### 4.1. Jeff Dean и Sanjay Ghemawat, «Performance Hints» (abseil.io/fast/hints, 2023–2025) [О]

[fast/hints.md](https://github.com/abseil/abseil.github.io/blob/master/fast/hints.md).

- Полная цитата Кнута и «a more compelling quote» про 12% (§3.11).
- Обновлённая таблица задержек (§3.9).
- **Оценка на салфетке для quicksort миллиарда чисел:** стоимость памяти ≈7,5 с, промахи предсказателя ≈75 с — «branch mispredictions are the dominant cost». Это аргумент к `learned`: у сортировки главная статья расходов — ветвления, поэтому выученный вход её сильно ускоряет.
- «Batched storage»: «Avoid data structures that allocate a separate object per stored element (e.g., `std::map`, `std::unordered_map`)… consider… `std::vector`, `absl::flat_hash_{map,set}`… less allocator overhead.» → `allocs`.
- **Честный контрпример:** «Replace sorted-list intersection (O(N log N)) with hash table lookups (O(N))» дал −21,61% на `BM_CompileLarge`. Покажите его, если спросят «так хеш всегда хуже?»: победителя назначают данные.

### 4.2. Abseil Performance Tips of the Week [О]

- **#39 «Beware microbenchmarks bearing gifts»** (Chris Kennelly, Alkis Evlogimenos; 22.01.2021, ред. 29.09.2025), [файл](https://github.com/abseil/abseil.github.io/blob/master/_posts/2023-03-02-fast-39.md):
  - «Benchmarks are only a tool for debugging efficiency: Production is ultimately what matters.»
  - «It is not uncommon for the first and last to disagree» — первый и последний из уровней «микробенчмарк → нагрузочный тест одной задачи → кластер → прод».
  - «Microbenchmarks tend to have small working sets that tend to be cache resident.»
  - Про SwissMap: «benchmarked in two ways: always triggering a cache hit and always triggering a cache miss. The latter can be achieved by having enough hashtables that their working set will not fit in cache, then picking a hashtable to lookup at random» — **это ваш приём «64 разных массива»**. Сошлитесь: «так мерили SwissTable в Google».
  - Сдвиги выравнивания дают «20% swings»; в snappy годами жили «load bearing nops».
- **#75 «How to microbenchmark»** (Kennelly, 29.09.2023): про ветвления («the processor can likely speculate on the next iteration due to successful branch prediction») и про входы («Deterministically generating a set of varied inputs and then randomly shuffling them»), а также совет прогонять размеры через кэши вплоть до «4 × caches.back().size». → `learned`, `checklist`.

### 4.3. C++ Core Guidelines (ред. Stroustrup, Sutter) [О]

[CppCoreGuidelines.md](https://github.com/isocpp/CppCoreGuidelines/blob/master/CppCoreGuidelines.md):

- **Per.6** «Don't make claims about performance without measurements»: «The field of performance is littered with myth and bogus folklore. Modern hardware and optimizers defy naive assumptions; even experts are regularly surprised.»
- **Per.16/Per.18:** «Performance is typically dominated by memory access times»; «Space is time».
- **Per.19:** «cache algorithms favor simple (usually linear) access to adjacent data».

### 4.4. Sergey Slotin, «Algorithms for Modern Hardware» (en.algorithmica.org/hpc) [О]

[algorithmica-org/algorithmica](https://github.com/algorithmica-org/algorithmica). Русскоязычный автор; в предисловии ссылается на свой профиль Codeforces [О: hpc/_index.md]. То, что он из олимпиадного сообщества, близкого вам по ICPC, — [П].

- Предисловие: «…want to learn more practical ways to speed up a program than by going from O(n log n) to O(n log log n)».
- complexity/models: «accepting the reality and optimizing for the hardware you have, beyond just asymptotic complexity».
- cpu-cache/latency: тот же pointer chasing по случайной перестановке-циклу, «This performance anti-pattern is known as *pointer chasing*».
- profiling/noise:
  - «It is not an uncommon for there to be two library algorithm implementations, each… claiming to be faster than the other… they just have different definitions of what "faster" means»;
  - «The only way to choose between hash table implementations is to try and put multiple variants into the application»;
  - «Unless you are expecting a 2x kind of improvement, treat all microbenchmarks the same way as A/B testing»;
  - «When you run a program on a laptop for under a second, a ±5% fluctuation in performance is completely normal».

### 4.5. Danila Kutenin (Google), «A long journey of changing std::sort implementation at scale» (CppCon 2023) [О]

[PDF](https://github.com/CppCon/CppCon2023/blob/main/Presentations/a_long_journey_of_changing_stdsort_implementation_at_scale.pdf).

- «LLVM libc++ did not do anything at all for a long time» (7 лет без introsort).
- «We chose a mix of BlockQuickSort and pdqsort»; «Special handling for almost sorted targets».
- «Fought the Hyrum's Law»: год ушёл на починку golden-тестов, завязанных на порядок равных элементов.
- Совет включать в debug `-D_LIBCPP_DEBUG_RANDOMIZE_UNSPECIFIED_STABILITY`.

**Куда:** `stdlib` (backup). Версии LLVM проверены в `cpp.md` (п. C): эвристика для отсортированного входа старше LLVM 17, BlockQuickSort появился в LLVM 16.

### 4.6. Свежие доклады CppCon 2025 [О]

- **Jonathan Müller (think-cell), «Cache-Friendly C++»**, 16.09.2025: [PDF](https://github.com/CppCon/CppCon2025/blob/main/Presentations/Cache_Friendly_Cpp.pdf). Мотивирующий график: «Sorted std::vector is consistently faster than std::unordered_map!» — поиск на размерах до 1024. Дальше разбор префетчинга, «Avoid pointer chasing → sequential memory access», «std::list<T> is not cache-friendly».
- **«Performance Is Not a Number: Avoiding Microbenchmarking Pitfalls»**, [PDF](https://github.com/CppCon/CppCon2025/blob/main/Presentations/Performance_Is_Not_a_Number.pdf). Автор, судя по ссылкам на github.com/qlibs, — Kris Jusiak [П]. Разделяет «Noise — external», «Bias — implicit (hardware effects)», «Optimization — explicit… can introduce bias». Рекомендует гистограммы и ECDF вместо одного числа и ссылается на Mytkowicz.

### 4.7. Swift stdlib: что ответить iOS-залу про Set [О]

[HashTable.swift](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/HashTable.swift):

- `bucketCount` — степень двойки («bucketCount must be a power of two»), `maxLoadFactor = 3/4`, пробирование к следующей корзине с переходом через конец (`bucket(wrappedAfter:)`) — это открытая адресация без узлов.
- Seed своя у каждой таблицы, «so that we avoid certain copy operations becoming quadratic». Это та же проблема, что у Миловидова (Rust) и Кулукундиса.
- Хешер — SipHash, файл [SipHash.swift](https://github.com/swiftlang/swift/blob/main/stdlib/public/core/SipHash.swift) реализует 2-4 и 1-3. Какой вариант использует `Hasher`, см. `cpp.md` (там 1-3).

[А] Итог для ответа: Swift `Set` ближе к flat_hash_set, чем к unordered_set, но с дорогим хешером; я его не мерил.

### 4.8. Android Jetpack Microbenchmark [О]

Документация «Microbenchmark overview» (developer.android.com):

- «Clocks on mobile devices dynamically change from high state, for performance, to low state, to save power or when the device gets hot. These varying clocks can make your benchmark numbers vary widely».
- Решения: lockClocks (только root), `setSustainedPerformanceMode`, автоматическая пауза при обнаружении троттлинга.
- Про big.LITTLE на этой странице ничего нет.

[А] Для Android-части зала: у Google тоже признают, что мобильные замеры по умолчанию нестабильны. Ваш `drift` — та же история на iPhone.

### 4.9. Для ответов на вопросы

- **Farach-Colton, Krapivin, Kuszmaul, «Optimal Bounds for Open Addressing Without Reordering»** (arXiv 2501.02305, январь 2025) [С]. Опровергнута гипотеза Яо о «Uniform Hashing is Optimal». Если спросят «а новая хеш-таблица Крапивина?» [А]: это теоретические границы числа проб при почти полной таблице, а не про кэш и аллокации; в стандартных библиотеках её нет.
- **AS2: Adaptive sorting algorithm selection for heterogeneous workloads and systems** (Future Generation Computer Systems, 2025) [С]. Выбор алгоритма сортировки по данным и системе, «up to 1.83×». Академический родственник вашего тезиса «победителя назначает среда».

---

## 5. Похожие доклады: что уже сказано и чем отличаться

| Доклад / текст | Что уже сказано | Пересечение с вами | Чем вы отличаетесь [А] |
|---|---|---|---|
| Lemire, 2017, sorted arrays vs hash sets [код О, текст С] | sort + unique против unordered_set на 64-битных ключах | **Раунд 1 целиком** | Кривая по N, узлы и аллокации посчитаны, flat, radix, контракт, QoS. Сошлитесь на него первым |
| Carruth, CppCon 2014 [О] | unordered_map — списки; хорошая таблица — открытая адресация; «discontiguous… evil» | раунды 1–2 | Карратт даёт правило, вы — где правило ломается (1% уникальных, порядок появления) |
| Kulukundis, CppCon 2017/2019 [С/О] | путь к SwissTable, H1/H2, SIMD, закон Хайрама, пример Dedup | раунд 2, `outcontract` | Вы показываете SwissTable на ARM (группа 8) и на телефоне в фоне |
| Stroustrup, GoingNative 2012 [С] | vector быстрее list вопреки «теории» | тезис доклада | Вы добавляете то, чего у него нет: процессор и QoS меняют ответ |
| Alexandrescu, CppCon 2019 [О] | меньше сравнений — медленнее; энтропия ветвлений | `bigo` | У вас не сортировка против сортировки, а два класса алгоритмов и среда |
| Berger, Strange Loop 2019 / CppCon 2020 [О] | раскладка памяти меняет результат, Stabilizer, Coz | `learned`, `checklist` | Ваши эффекты крупные (2–3 раза) и меняют знак между средами |
| Müller, CppCon 2025 «Cache-Friendly C++» [О] | отсортированный vector быстрее unordered_map | раунд 1 | Он про поиск на малых N, вы — про дедупликацию, контракт и устройство |
| Jusiak (?), CppCon 2025 «Performance Is Not a Number» [О] | шум, смещение, распределения вместо одного числа | `checklist` | Ваш чек-лист мобильный: QoS, заряд, нагрев, CI против устройства |
| Kutenin, CppCon 2023 [О] | эволюция std::sort в libc++, закон Хайрама | `stdlib` | Вы используете это как один из факторов, а не тему |
| Apple WWDC25 308 [О] | тот же O(log n), кэш-раскладка, Instruments | `bigo` | Сошлитесь: «даже Apple на WWDC показывает цену шага» |
| Миловидов, «Как устроены хэш-таблицы в ClickHouse», 2017 [О] | тождественный хеш, цепочки против открытой адресации, простые размеры таблиц — «нелепость» | раунд 2, `hashtable` | Зал HighLoad/CodeFest мог это видеть: сошлитесь одной фразой |
| Кита, HighLoad++ 2021 «Zero-Cost Abstractions Using Hash Tables in ClickHouse» [О] | unordered_map 44,8 с против 7,4–10 с; «How NOT to do benchmarks: random integers» | раунд 2, P6 | Готовьте ответ про случайные id |
| Хабр, 2026, «Структуры данных на практике» (гл. 1, 2, 3, 5, 7) [С] | «Миф про O(1)», иерархия памяти, бенчмаркинг, «связанные списки — убийцы кэша» | тезис доклада | Свежая серия, аудитория её могла читать. Ваш козырь — телефон, QoS и CI |
| Андрюхин (Авито), Mobius 2019, «Устройство многопоточности в iOS» [С] | GCD и QoS для iOS-разработчиков | `qos` | Вы показываете численные последствия QoS для алгоритма, а не API |

**Итог [А].** Первые 17 минут (раунды 1–2) пересекаются с известными докладами. Последние 10 минут (раунды 3–4 и «бенчмарк врал») нигде в найденном не встречаются.

**Рекомендация.** Раунды 1–2 рассказать как «быстро, это классика, вот цифры на моём железе» и сэкономить 1,5–2 минуты. Их отдать на `cores`, `flip` и `learned`. Слайд или сноска «Плечи гигантов» с 5–6 ссылками и QR закрывает вопрос «это же Лемир / Карратт» до того, как его зададут.

---

## 6. Русскоязычный контекст: что аудитория могла видеть

| Материал | Статус | Суть | Как использовать |
|---|---|---|---|
| **А. Миловидов, «Как устроены хэш-таблицы в ClickHouse»**, 22.08.2017 | [О] [слайды](https://github.com/ClickHouse/clickhouse-presentations/blob/master/2017-hash_tables/index_ru.html) | «hash(x) = x — так сделано… в libstdc++ и в libc++ для int-ов». Тождественный хеш: std::unordered_map — «разницы в производительности нет (10.319 vs 10.279 сек)», google::dense_hash_map — «в 26 раз». HashMap ClickHouse против std::unordered_map с хорошим хешем — 2,439 против 10,097 с, «производительность скрадывается зависимыми кэш-промахами». Chaining: «низкая кэш-локальность; нагрузка на аллокатор»; простое число как размер таблицы — «нелепость… std::unordered_map использует именно эту нелепость» | `hashtable` (P5), backup |
| **М. Кита, «Zero-Cost Abstractions Using Hash Tables in ClickHouse as an Example»**, 11.05.2021, HighLoad++ (по имени каталога) | [О] [слайды](https://github.com/ClickHouse/clickhouse-presentations/blob/master/2021-highload/hash_tables/index.html); хабр-версия «C++ zero-cost abstractions на примере хеш-таблиц в ClickHouse. Доклад Яндекса» (habr.com/ru/companies/yandex/articles/572588) [С] | WatchID, около 20,7M уникальных, около 600 МБ: ClickHouse HashMap 7,366 с, DenseMap 10,089, Abseil 9,011, **std::unordered_map 44,758**; «Deinitialization of std::unordered_map took longer than benchmarks of other tables»; cache-misses 1,94 млрд против 0,33 млрд. **«How NOT to Do Benchmarks: Test hash tables on random integer values»** | `allocs` (деструктор), P6 |
| **М. Кита, «ClickHouse performance optimization practices»**, C++ Russia 2022, и **«…techniques»**, C++ Russia 2023 | [О] [2022](https://github.com/ClickHouse/clickhouse-presentations/blob/master/2022-cpp-russia/clickhouse_performance_optimization_practices/index.html), [2023](https://github.com/ClickHouse/clickhouse-presentations/blob/master/2023-cpp-russia/clickhouse_performance_optimization_techniques/index.html); на cppconf.ru — «Техники оптимизации производительности» [С] | Перф-тесты на двух серверах, медианы, счётчики промахов и ветвлений; «Query should not be short, because otherwise it measures nothing»; «Replace std::unordered_map with absl::flat_hash_map if you do not need pointer stability» | `checklist` (медианы, две машины) |
| Хабр, серия «Структуры данных на практике», 2026 (гл. 1 «Разрыв в производительности», 2 «Иерархия памяти», 3 «Бенчмаркинг и профилирование», 5 «Связанные списки — убийцы кэша», 7 «Хэш-таблицы и конфликты кэша» — 26.03.2026) | [С] | тезис «O(1) делает меньше операций, но каждая дорогая» | знать; не повторять определения |
| Хабр, «Вглубь std::unordered_map: магические числа» (765760) | [С] | простые числа в bucket_count | `hashtable` |
| Хабр (VK), «Я написал самую быструю хеш-таблицу» (323242) — перевод Мальте Скарупке | [С] | открытая адресация | контекст |
| Хабр (Badoo), «Какой map быстрее, и есть ли альтернатива Judy» (328472) | [С] | dense_hash быстрее std::unordered_map | контекст |
| Хабр, «Галерея эффектов кэшей процессоров» (93263) — перевод Игоря Островского | [С] | классические ступеньки по размерам кэшей | картинка-предок для `cores` |
| А. Акиньшин, «Сложности микробенчмаркинга» (DevFest Siberia 2017) и книга «Pro .NET Benchmarking» (Apress, 2019; рус. «Профессиональный бенчмарк: искусство измерения производительности», Питер) | [С] | ветвления, «Sorted and Unsorted Data», распределения | `learned`, `checklist`. Для .NET-части зала — «то же, что у Акиньшина» |
| А. Андрюхин (Авито), «Устройство многопоточности в iOS», Mobius 2019 | [С] | GCD, QoS | iOS-часть зала знает QoS как API, но не как «другой процессор» |
| С. Слотин, «Algorithms for Modern Hardware» | [О] (§4.4) | pointer chasing, шум, A/B | олимпиадная аудитория знает автора |
| CodeFest, HardFest: прошлые доклады про алгоритмы и кэши | не найдено [С] | — | ваш доклад, вероятно, единственный такой (см. `conf.md` §4) |

---

## 7. Цитаты для доклада (8 штук, с точной атрибуцией)

Отбор [А]: короткие, проверяемые, от признанных авторов, каждая ложится на конкретный слайд. Шрифт мелкий, английский оригинал и русский перевод. Произносить по-русски.

1. **`bigo` или `nodes`.** «Discontiguous data structures are the root of all (performance) evil.» — *Chandler Carruth, «Efficiency with Algorithms, Performance with Data Structures», CppCon 2014, слайд 38.* [О] — «Разрывные структуры данных — корень всего зла производительности».
2. **`bigo` или `final`.** «If you don't understand the hardware, you can't reason about the cost of solving the problem.» — *Mike Acton, «Data-Oriented Design and C++», CppCon 2014.* [О] — «Не понимаешь железо — не можешь рассуждать о цене решения».
3. **`share`.** «If you have different data, you have a different problem.» — *Mike Acton, там же.* [О] — «Другие данные — другая задача». Ложится ровно на «доля уникальных переворачивает результат».
4. **`vote` или `result`.** «The field of performance is littered with myth and bogus folklore. Modern hardware and optimizers defy naive assumptions; even experts are regularly surprised.» — *C++ Core Guidelines, Per.6 (ред. B. Stroustrup, H. Sutter).* [О]
5. **`bigo`.** «All research: minimize C(n)… Reality: Informational entropy of comparisons radically affects performance.» — *Andrei Alexandrescu, «Speed Is Found in the Minds of People», CppCon 2019.* [О] Вместе с его «15% fewer comparisons → 13% slower».
6. **`flip`.** «…you should try to replicate the target system configuration, which you are optimizing for. Introducing any artificial tuning to the system will change results from what users of your service will see in practice.» — *Denis Bakhvalov, «Performance Analysis and Tuning on Modern CPUs», гл. 2.1.* [О] Вариант короче: «Benchmarks are only a tool for debugging efficiency: Production is ultimately what matters.» — *Chris Kennelly, Alkis Evlogimenos, Abseil Performance Tip of the Week #39.* [О]
7. **`questions` или `decision`.** «We should forget about small efficiencies, say about 97% of the time: premature optimization is the root of all evil. Yet we should not pass up our opportunities in that critical 3%.» — *Donald E. Knuth, «Structured Programming with go to Statements», ACM Computing Surveys, 1974.* [О через Dean & Ghemawat] Перевод: «…Но мы не должны упускать свои возможности в тех критических 3%».
8. **`final`.** «During the post-Moore era, it will become ever more important to make code run fast and, in particular, to tailor it to the hardware on which it runs.» — *C. Leiserson et al., «There's plenty of room at the Top», Science, 2020.* [О через perf-book 1-5] Мостик к «алгоритм не выбирал процессор».

**В запасе:**

- «You get higher-fidelity measurements by profiling on a device instead of the simulator… profile on that device.» — *Apple, «Improving your app's performance».* [О]
- «Software does not run in a magic fairy aether powered by the fevered dreams of CS PhDs.» — *Acton, 2014.* [О] Хорошо заходит смехом, но осторожно: может прозвучать как «против теории», а доклад не об этом.
- «Unless you are expecting a 2x kind of improvement, treat all microbenchmarks the same way as A/B testing.» — *Sergey Slotin, «Algorithms for Modern Hardware».* [О]
- Закон Хайрама — *Hyrum Wright, в докладе Kulukundis, CppCon 2019.* [О]
- «the limiting factor for most programs is now, and will be for some time, memory access» — *Drepper, 2007.* [О]

**Совет [А].** Не больше 3 цитат на экране за весь доклад: 1, 3 и 6 или 8. Остальные — в заметках, в устной речи и на слайде «Плечи гигантов».

---

## 8. Картинки, которые стоит перерисовать в стиле колоды

Данные для каждой проверены по первоисточнику; указано, откуда брать числа.

**К1. «Асимптотика × локальность», матрица 2×2 → `flat`, `decision` или `bigo`.**
- Идея: [det/random_insert](https://github.com/det/random_insert), таблица «linear/logarithmic × cache inefficient/efficient» [О] и Carruth, с. 51 [О].
- Ваш вариант:

  | | локальность плохая | локальность хорошая |
  |---|---|---|
  | O(1) | unordered_set (узлы) | flat_hash_set |
  | O(n log n) / O(n·8) | — | sort + unique, radix |

  Стрелка: «flat выигрывает, потому что не выбирает между клетками».
- Зачем: одна картинка объясняет раунд 2 и отвечает тем, кто скажет «так Big-O не важен?».

**К2. «Промахи в полёте»: задержка против числа независимых цепочек, Apple M2 и M4 → `memory`.**
- Данные: [m2.txt, m4.txt Лемира](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/tree/master/2025/07/09) [О]. M2: 1 цепочка — 102,1 нс, 10 — 11,0, 20 — 5,7, 28 — 4,3. M4: 94,3 → 3,7.
- Визуально: одна линия падает как 1/k и выходит на полку около 28. Подпись: «один указатель — 100 нс; двадцать восемь независимых адресов — по 4 нс. Узловая таблица — первый случай, сортировка — второй».
- Зачем: заменяет абстрактное «дорого обращение, которое ждёт предыдущего» числом с похожего чипа.

**К3. «Процессор учит ваш бенчмарк»: промахи предсказателя против числа повторов → `learned`.**
- Данные: [2019/10/15/results.txt](https://github.com/lemire/Code-used-on-Daniel-Lemire-s-blog/blob/master/2019/10/15/results.txt) (Intel: 0,478 → 0,020 за 1024 повтора; такты 17,0 → 4,25) и resultsamdrome.txt (AMD Rome: 0,517 → 0,001) [О].
- Врезка из поста 18.03.2026 [О]: безошибочно выучивает Zen 5 — 30 000 ветвлений, Apple M4 — 10 000, Emerald Rapids — 5 000. Рядом ваша сортировка 1024 элементов: около 10⁴ сравнений.
- Зачем: делает ваш слайд `learned` понятным, а P2 — честным.

**К4. «Лестница Дреппера → лестница вашего телефона» → `cores` (backup или мини-вставка).**
- Данные: Drepper, рис. 3.10/3.15, Pentium 4: 16 КБ L1d, 1 МБ L2; последовательный доступ — около 4, 9 и далее тактов на элемент; случайный — «450 cycles and more» [О]. Рядом ваш P/E-график.
- Подпись: «метод 2007 года, лестница выросла в 8–16 раз, форма та же».
- Зачем: снимает вопрос «а правильно ли мерили».

**К5. «Одинаковый O(log n) — ×2 и ещё ×2»: бинарный поиск из WWDC25 308 → `bigo` (для iOS-зала).**
- Данные [О]: безветвлённый поиск «about twice as fast», Эйцингер «two times faster again». Три столбика: branchy / branchless / Eytzinger, относительные 1 / ~2 / ~4.
- Подпись: «Apple, WWDC25: тот же алгоритм, другая цена шага».
- Абсолютные цифры в транскрипте я не нашёл: рисуйте только отношения.

**К6 (запасная). «Корзины dedup до и после» → `hashtable` или backup.**
- Данные: COZ, рис. 4 и текст [О]: «just 2.3% of the available buckets», цепочка 76,7 → 2,09, итог +8,95%.
- Гистограмма «ключей на корзину», два состояния. Иллюстрирует ваш совет про гистограмму цепочек.

**Не рисовать [А].** Таблицу «Latency Numbers» как авторитет (см. P3), график Страуструпа (оригинал не открыт, числа по памяти), графики Chips and Cheese (не открыты).

---

## 9. Возражения из зала, которые подпитывают эти источники

| Возражение | Кто так скажет | Ответ [А] |
|---|---|---|
| «Это известно с 2017 года» | читавшие Лемира и Карратта | «Да, раунд 1 — Лемир 2017, раунд 2 — Карратт и Кулукундис. Я их повторил на своём железе, чтобы дальше показать новое: контракт, порядок входа и QoS» |
| «Вы тестируете хеш-таблицы на случайных int» | ClickHouse-аудитория (Кита 2021) | «Специально: так раскладка не зависит от удачи. На плотных rowid узловой таблице везёт, а radix делает 3 прохода вместо 8 (cpp.md, §6). Меряйте на своих id — бенчмарк в репозитории» |
| «Микробенчмарк должен идти в идеальных условиях» | Lemire 2018 [С] | «Для сравнения кода — да. Для решения, что катить, нужна целевая среда. Это два разных вопроса, и в CI обычно задают первый, думая, что второй» |
| «Страуструп был нечестен, Big-O важен» | det/random_insert [О] | «Согласен: Big-O спасает от катастроф. Поэтому победитель — flat: O(1) и локальность одновременно» (К1) |
| «Ваши 15% между сессиями — шум, Бергер показал» | Berger [О] | «Поэтому я и не утверждаю про 15%: мои эффекты в 2–3 раза, и они меняют знак» |
| «На M2 предсказатель тоже учит 10 тыс. ветвлений» | Lemire 2026 [О] | см. P2: «Именно поэтому я сделал контроль с 64 одинаковыми копиями. История ветвлений у них одна, а время другое. Значит, дело в адресах. Счётчики — следующий шаг» |
| «А Swift Set?» | iOS-зал | «Открытая адресация без узлов, load factor 3/4, своя seed на таблицу, SipHash. Ближе к flat, но хешер дороже. Я не мерил» (§4.7) |
| «А новая хеш-таблица Крапивина?» | читавшие новости 2025 | «Это теоретический результат про число проб при почти полной таблице. К кэшу и аллокациям отношения не имеет, в стандартных библиотеках её нет» (§4.9, [С]) |
| «flat_map из C++23 решает?» | читавшие Лемира неделю назад | «Это отсортированный вектор. Для дедупликации это и есть sort + unique, а вставка по одному элементу квадратична» (Lemire 17.09.2026 [О]) |

---

## 10. Источники

### Открыты и прочитаны [О]

**CppCon, слайды:**
- github.com/CppCon/CppCon2014: Carruth, Acton, Alexandrescu «Optimization Tips»
- CppCon2019: Kulukundis «Abseil's Open Source Hashtable: 2 Years In», Alexandrescu «Speed Is Found in the Minds of People»
- CppCon2020: Berger «Performance Matters»
- CppCon2023: Kutenin «A long journey of changing std::sort implementation at scale»
- CppCon2025: Müller «Cache-Friendly C++», «Performance Is Not a Number»
- CppCon2015: Lelbach «Benchmarking C++ Code» (просмотрен, в отчёт не вошёл)
- CppCon2022: «Refresher on Containers, Algorithms and Performance» (просмотрен, в отчёт не вошёл)

**Abseil:**
- github.com/abseil/abseil.github.io: `fast/hints.md` (Dean & Ghemawat), `_posts/2023-03-02-fast-39.md`, `_posts/2023-11-10-fast-75.md`, `_posts/2018-09-27-swisstables.md`, `about/design/swisstables.md`
- github.com/abseil/abseil-cpp, тег 20260817.0: `hashtable_control_bytes.h`, `raw_hash_set.h`

**Книги и учебники:**
- github.com/dendibakh/perf-book: гл. 1-1, 1-5, 2-1, 2-3, 2-6, 4-10, 13-4; `biblio.bib`
- github.com/algorithmica-org/algorithmica: hpc/_index, complexity/models, cpu-cache/latency, cpu-cache/pointers, profiling/noise

**Лемир:**
- github.com/lemire/Code-used-on-Daniel-Lemire-s-blog: 2017/05/23, 2019/10/14–15, 2019/11/12, 2016/09/28, 2021/07/14, 2025/07/09 (m2.txt, m4.txt), 2025/12/30, 2026/03/18, 2026/07/25, 2026/09/17 (post.md)

**PDF в github.com/tpn/pdfs:**
- Drepper 2007
- Curtsinger & Berger, COZ, SOSP 2015

**Прочие репозитории:**
- plasma-umass/stabilizer, plasma-umass/coz (README)
- isocpp/CppCoreGuidelines (Per.2, Per.6, Per.16–19, SL.con.2)
- det/random_insert (README)
- ardanlabs/gotraining (arrays/README, конспект Мейерса)
- colin-scott/interactive_latencies
- clamchowder/Microbenchmarks (README)
- ClickHouse/clickhouse-presentations: 2017-hash_tables/index_ru.html, 2021-highload/hash_tables, 2022-cpp-russia, 2023-cpp-russia
- swiftlang/swift: HashTable.swift, SipHash.swift
- gist.github.com/jboner/2841832 (через WebFetch)
- github.com/emeryberger/emeryberger (через WebFetch)
- github.com/CppCon/CppCon2014, листинг каталога Presentations (через WebFetch)

**Apple (developer.apple.com):**
- транскрипты WWDC20 10686, Tech Talk 110147, WWDC25 308 (локальные копии из `research/apple/`)
- Apple Developer News vk3m204o
- Energy Efficiency Guide for iOS Apps: QoS
- JSON-API документации: «Improving your app's performance», «Writing and running performance tests», «Performance Tests»

**Android:**
- developer.android.com, «Microbenchmark overview» (через WebFetch)

### Только сниппеты поиска [С]

- **Блоги и сайты:** lemire.me (заголовки постов 2016–2019, 2025/07/09), mobiusconf.com, cppconf.ru, habr.com (статьи из §6), youtube.com (видео Kulukundis 2017, Berger 2019, Stroustrup), learn.microsoft.com (GoingNative 2012), isocpp.org («Are lists evil?»), aristeia.com (Meyers), chipsandcheese.com (M2 Pro 116,5 нс).
- **Статьи и книги:** dl.acm.org и researchgate (Mytkowicz, аннотация), arXiv 2501.02305 (Krapivin et al.), ScienceDirect (AS2), Pro .NET Benchmarking.

### По памяти, не проверено [П]

- «Три большие лжи» Эктона.
- Точная постановка опыта Страуструпа.
- Хранение базовых значений XCTest по моделям устройств.
- Авторство «Performance Is Not a Number» (Kris Jusiak).
