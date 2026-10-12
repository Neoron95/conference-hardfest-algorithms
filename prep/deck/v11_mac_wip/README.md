# V11 Mac — главная машина M2 Pro

Опубликовано: https://claude.ai/artifact/4z4yL1HoVWWN3sGk2hPyYG (версия 1791799428-18dc).
Вариант колоды, где все основные замеры — M2 Pro (macOS, Apple clang 21 + libc++), контрасты — iPhone 14 Pro и CI Xeon.
Числа — bench/mac/results/{m2,m2b,iphone-20261012-1304,xeon207}, сводка — bench/mac/results/THREE_MACHINES.md.
Проверено тремя независимыми проверками (каждое число против CSV, связки слайдов); найденное исправлено.

- `project/` — файлы колоды ровно как в артефакте (ссылки /_blob/ — ассеты нового артефакта).
- `blobmap_from_v10.txt` — соответствие ассетов V10 → V11.
- `slides_text.md` — текст слайдов, речь и заметки; `order_visible.txt` — порядок показа.

Сокращение 12.10: why-nodes, when-which, langs — в запасные; memory-v2 + inflight-v2 → inflight-v3; merge-short + merge → merge-v2; window-v3 и alloc-split-v3 — упрощённые (старые версии скрыты в конце колоды). Основная часть — 47 слайдов, ≈38 минут речи при 145 словах в минуту.

Новые слайды: flat-e (на E-ядре sort обгоняет flat; переход там, где таблица flat больше L2), flip-v2 (карта победителей CI / Mac / iPhone P / iPhone E), reasons (четыре причины — в каждом опыте меняем ровно одно), cores-v2 (лестница на новых данных).

Не закрыто (ждёт `cd bench/mac && sudo ./run_phases.sh m2c && ./run_utility.sh m2c`):
- window-v3 — команды на вставку (90 / 319 / 208) пока x86, на слайде пометка «⚠»; alloc-split-v3 и запасной why-nodes — команды и промахи под фазами в заметках, тоже x86;
- qos — ячейка «M2 Pro · utility» = ⟨m2c⟩.
