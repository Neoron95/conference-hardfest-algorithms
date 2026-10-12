# Замеры на Mac (M2 Pro) — вариант доклада «главная машина — Mac»

Тот же харнесс, что на Xeon (`../dedup_bench.cpp`, серии E1–E8 и фазы), плюс маленькие программы
для слайдов второго акта. Всё, кроме счётчиков процессора, работает без sudo.

## Что нужно

- macOS на Apple Silicon (M2 Pro), Xcode Command Line Tools: `xcode-select --install`
- cmake: `brew install cmake`
- ≈40 минут, когда Mac не нужен: от сети, крышка открыта, остальные программы закрыты.

## Как запустить

```bash
git fetch origin claude/conference-talk-prep-fkipal
git checkout claude/conference-talk-prep-fkipal
cd bench/mac
./build.sh                       # 2–4 минуты: Abseil + 6 программ, в конце selftest: OK
./run.sh m2                      # ≈30–40 минут, results/m2/*.csv
sudo ./run_counters.sh m2        # ≈3–5 минут, results/m2/counters_*.csv
```

Отправить результаты: `git add results/m2 && git commit -m "M2 results" && git push`
(или заархивировать папку `results/m2` и прислать).

Если какая-то программа не собралась (`build.sh` скажет «НЕ СОБРАЛСЯ»), остальные всё равно
запускаются; пришлите `build/<имя>.log`.

## Что каким слайдам

| Файл | Что внутри | Слайды |
|---|---|---|
| `env.txt` | модель, кэши (`hw.perflevel*.l2cachesize`), версия clang, питание | все — подписи |
| `E1.csv` | N = U = 2^20: sort, uset, radix, flat; P-ядро (ui) и E-ядро (background) | 13 первый замер, 16, 29 flat |
| `E2.csv` | U = N/2, от 16 до 4M — та же сессия для всей кривой | 18 кривая, flip |
| `E11_phases.csv` | вставки / выгрузка / деструктор, uset и flat | 23 alloc-split |
| `alloc.csv` | стандартный аллокатор против pmr-буфера против flat | 23 alloc-split |
| `probe.csv` | частота ядра и лестница задержек 16 КБ … 1 ГБ, P и E | 17 такты, 20 лестница, cores |
| `mlp.csv` | цепочки K = 1…64 (сколько чтений в полёте), окно с nop, модель вставки | 21 inflight, 22 window |
| `sortfam.csv` | std::sort, pdqsort с ветвлениями и без, radix | 26 sortfamily |
| `E3.csv`, `E4.csv` | доля разных, порядок входа | 32–33 share, 35 inputorder |
| `E5.csv` | «бенчмарк врал»: один вход против разных | 36 learned |
| `E8.csv` | локальные отсортированные + дельта: sort, хеш, слияние | merge, финальный рецепт |
| `counters_*.csv` | на элемент: такты, команды, ветвления, ошибки предсказателя, промахи L1D и TLB | 16 work, 17 pace, 25 speculation, 26 |

## Чего на Mac не посчитать

- **Промахи L2.** В базе событий Apple такого счётчика нет. Для «сколько промахов» остаётся симулятор
  кэша с размерами M2 (16 и 4 МиБ) — он уже на слайдах curve и boxes.
- **Команды на iPhone.** kperf из песочницы iOS недоступен; на iPhone — только время.

## Как устроено

- `../dedup_bench.cpp` — общий харнесс; на macOS добавлен флаг `--qos ui|utility|background`
  (P-ядра — ui, E-ядра — background).
- `probe.cpp` — частота цепочкой зависимых `add` (1 такт) и лестница по строкам 128 Б.
- `mlp.cpp` — порт `../deep/mlp/mlp_ladder.cpp` и `rob_window.cpp` под строку 128 Б, без THP.
- `sortfam.cpp` — сортировки отдельно от unique; pdqsort из `../deep/sort/pdqsort.h`.
- `alloc.cpp` — `std::pmr::monotonic_buffer_resource` вместо malloc на узел.
- `counters.cpp` + `kperf.h` — счётчики через приватные kperf/kperfdata (как ibireme/kpc_demo и
  `apple_arm_events.h` Лемира); события по именам: FIXED_CYCLES, FIXED_INSTRUCTIONS, INST_BRANCH,
  BRANCH_MISPRED_NONSPEC, BRANCH_COND_MISPRED_NONSPEC, L1D_CACHE_MISS_LD_NONSPEC, L1D_TLB_MISS.
  Недоступное событие пишется как −1.

Проверено сборкой и прогоном на Linux (x86); на macOS ещё не запускалось — первый прогон может
потребовать мелкой правки.
