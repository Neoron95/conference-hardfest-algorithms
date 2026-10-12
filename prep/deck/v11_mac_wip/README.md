# V11 Mac (в работе)

Вариант колоды, где главная машина — M2 Pro, контрасты — iPhone 14 Pro и CI Xeon.
Числа — bench/mac/results/{m2,m2b,iphone-20261012-1304,xeon207}, сводка — bench/mac/results/THREE_MACHINES.md.

- `project/` — файлы колоды (deck.json + slides/*.html, ссылки на картинки — ассеты исходной колоды V10).
- `slides_text.md` — текст слайдов, речь и заметки по порядку показа.

Не закрыто: команды на вставку на ARM (слайды window-v2, alloc-split-v2, why-nodes помечены «⚠ пока x86»)
и M2 в QoS utility (слайд qos, ячейка ⟨m2c⟩) — ждут `sudo ./run_phases.sh m2c && ./run_utility.sh m2c`.
Новые слайды: flip-v2 (карта победителей), reasons (четыре причины), cores-v2 (лестница на новых данных).
