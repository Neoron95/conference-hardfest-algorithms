# Фактчек Apple-части доклада «O(n) проиграл O(n log n)»

Дата проверки: 29.09.2026. Проверял всё, что в колоде касается Apple: QoS и размещение потоков на P/E-ядрах, кэши, malloc, лимиты памяти расширений, фоновое исполнение, CI на macOS, версии инструментов и модель iPhone.

**Как читать отчёт.** Для каждого утверждения даны вердикт, источник и готовая формулировка для сцены. Источники со ссылкой я открывал сам: исходники XNU, libmalloc, libc++ и Swift на GitHub, документацию Apple через её JSON-API, транскрипты WWDC, GitHub-репозитории и issues. Пометка «по памяти, не проверено» значит, что первоисточник открыть не удалось. Пометка «по сниппету поиска» значит, что страница заблокирована egress-прокси и я видел только фрагмент в выдаче поиска.

**Что было недоступно.** Прокси блокировал eclecticlight.co (Howard Oakley), en.wikipedia.org, chipsandcheese.com, anandtech.com, notebookcheck.net, browser.geekbench.com, macrumors.com, mjtsai.com, docs.github.com и web.archive.org. Документация GitHub поэтому читалась из исходного репозитория `github/docs`. Apple Silicon CPU Optimization Guide открывается только после входа в аккаунт разработчика, так что до него я не добрался. У Никиты доступ к нему есть: там приведены размеры структур и латентности.

---

## 0. Сводка вердиктов (TL;DR)

| # | Утверждение в колоде (слайд) | Вердикт | Что делать |
|---|---|---|---|
| 1a | «В XNU (sched_amp_common.c): "utility and bg threads on E-Cores only" по умолчанию» (qos) | **Неточно, по сути устарело.** Цитата неточная: в оригинале «run utility and **by** threads on E-Cores only». Главное другое: этот код компилируется только при `!CONFIG_SCHED_EDGE`. В текущем XNU на всех асимметричных arm64-системах (iPhone и Apple Silicon Mac) включён Edge-планировщик. У Edge обратная формулировка: utility **может идти на все ядра**, и только BG/maintenance контроллер «никогда не рекомендует» на P-ядра | Заменить цитату (формулировка в §1.6) |
| 1b | «Apple в документации осторожнее — QoS "influences placement"» (qos) | **Подтверждено, почти дословно.** Apple Developer, 22.06.2020: QoS используется, «to influence placement of threads on P or E cores» | Указать источник: Apple Developer News, 2020 |
| 1c | «На Mac utility остался на P, на iPhone ушёл на E» (qos, cores) | **Согласуется с источниками, но документацией не подтверждено.** Для utility решение принимает закрытый контроллер производительности (CLPC). По исходникам ядра utility разрешено на любых ядрах. Для macOS Oakley пишет, что QoS 17–33 предпочтительно идут на P (по сниппету поиска). Про iOS у Apple публичного утверждения нет: это ваш замер | Подавать как **наблюдение на конкретном iPhone и iOS**, не как закон |
| 2a | M2 Pro: L1D P 128 КБ / E 64 КБ, L2 P 16 МБ / E 4 МБ, строка 128 Б (memory, cores, cachecost) | **Подтверждено** (sysctl-дамп M2 Pro на macOS 26.3.1). Нюанс: у 12-ядерного M2 Pro **два** P-кластера по 16 МБ, `cpusperl2=4` | Оставить; в заметках «16 МБ на кластер из 4 ядер» |
| 2b | «системный кэш — 24 МБ» (cachecost) | **Не удалось проверить.** sysctl SLC не показывает, первоисточники заблокированы | Пометить «по данным обзоров» или убрать |
| 2c | L1 ~1 нс, L2 ~5 нс, RAM ~100 нс (memory) | **Порядок правдоподобный, первоисточника нет** (по памяти). Apple на WWDC25 говорит, что промах мимо обоих кэшей «в 50 раз медленнее быстрого пути» | Подставить **свои** числа со слайда cores: замер у вас уже есть |
| 2d | График iPhone на слайде cores с пунктирами «L1 E 64К, L1 P 128К, L2 E 4М, L2 P 16М» и сноской «hw.perflevel… на M2 Pro» | **Ошибка оформления.** На графике iPhone нарисованы границы кэшей Mac | Снять sysctl на самом iPhone и нарисовать его пунктиры |
| 3 | «узел 24 Б + расходы malloc ~16 Б + ячейка 8 Б ≈ 48 Б на ключ; 512K → ~24 МБ, 1M → ~48 МБ» (cachecost) | **Опровергнуто в двух местах.** (1) У аллокаторов Apple нет заголовка перед блоком. Квант 16 Б, запрос 24 Б округляется до 32 Б, накладные расходы 8 Б, а не 16. (2) При U = N/2 узлов U, а не N. Правильно: 32·U + 8·N ≈ **12 МиБ при N=512K и 24 МиБ при N=1M**. Вывод «излом на границе L2» только усиливается | Пересчитать строку на слайде (§3.3) |
| 3b | «один new… записать заголовок» (заметки allocs) | **Неточно для Apple**: метаданные вынесены отдельно от блока. Зато free обнуляет блок (zero-on-free), так что «второй платёж» за delete у Apple ещё заметнее | Поправить заметки |
| 4 | «для виджета или share extension с лимитом в десятки МБ — jetsam» (allocs) | **Неточно.** Виджет ≈ 30 МБ, Notification Service Extension ≈ 24 МБ. Share extension ≈ 120 МБ, то есть не «десятки». Числа официально не документированы, они из отчётов разработчиков | «для Notification Service Extension (~24 МБ) или виджета (~30 МБ)» |
| 5 | «Task с qos .utility» (case) | **Терминология.** У Swift Task есть `priority`, а не qos. `Task(priority: .utility)` соответствует `QOS_CLASS_UTILITY` (0x11); это подтверждено исходниками Swift | Писать `Task(priority: .utility)` |
| 6 | «Mac · CI-раннер M2 Pro» (flip) | **Неточно.** GitHub-hosted `macos-latest` в сентябре 2026 — это VM на **M1, 3 vCPU**; xlarge — M2, 5 vCPU. Гостевая macOS видит **один** perflevel («Standard»), P/E в ней нет. QoS внутри VM на тип ядра не влияет. Ваш M2 Pro — это машина разработчика или self-hosted раннер | Переименовать колонку; это **усиливает** тезис доклада |
| 7a | «macOS 27 · Apple clang 21» (result, systems) | **Правдоподобно, подтверждено косвенно.** macOS 27.0.1 вышла 28.09.2026, Xcode 27 — 14.09.2026. `clang --version` в Xcode 26.4.1+ и в Xcode 27.0 даёт 21.0.0, в Xcode 26.2 давал 17.0.0 | Указывать **версию Xcode** рядом с Apple clang |
| 7b | «thermalState nominal» как гарантия условий (qos, cores, drift) | **Правильно сформулировано в drift** («nominal не доказывает отсутствие ограничений»). Apple про nominal пишет только «within normal limits» | Оставить; добавить Low Power Mode = off в сноски |
| 7c | «libc++ с LLVM 17 распознаёт уже отсортированный вход» (inputorder, stdlib) | **Нюанс Apple.** `std::sort` для `uint64_t` со стандартным компаратором вызывает **явно инстанцированный `__sort` из системной libc++.dylib**. Поведение зависит от **версии iOS/macOS**, а не только от Xcode | В лог и на слайд: версия ОС |
| 8 | Модель iPhone не указана | **Обязательно указать** модель (`hw.machine`), чип, версию iOS, Low Power Mode, заряд и нагрев | Шаблон сноски в §8 |
| 9 | «libc++: число ячеек не степень двойки → целочисленное деление» (hashtable) | **Для ваших замеров неверно** (попутная находка по libc++). `reserve(2^k)` даёт ровно 2^k ячеек, и номер ячейки берётся маской, без деления. Деление появляется при росте без reserve и при N не степени двойки | Поправить сноску (§9) |

---

## 1. QoS и размещение потоков на P/E-ядра

### 1.1 Что именно написано в XNU

**(а) Цитата из колоды: старый AMP-планировщик.** Файл [`osfmk/kern/sched_amp_common.c` @ xnu-12377.121.6](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/sched_amp_common.c), строки 486–491, функция `sched_amp_qos_max_parallelism()`. Точный текст с опечаткой «by» вместо «bg», которая есть в оригинале:

```c
	/*
	 * The default AMP scheduler policy is to run utility and by
	 * threads on E-Cores only.  Run-time policy adjustment unlocks
	 * ability of utility and bg to threads to be scheduled based on
	 * run-time conditions.
	 */
```

Весь этот блок (строки 62–519) обёрнут в `#if !CONFIG_SCHED_EDGE`, то есть компилируется **только без Edge-планировщика**. Там же функция `recommended_pset_type()` ([processor.c @ 12377.121.6, стр. 1929–1930](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/processor.c#L1929)) отправляет потоки с `base_pri <= BASEPRI_UTILITY` на E-кластер. Комментарий к ней прямо говорит: `/* Only used by the AMP scheduler policy */` под `#if CONFIG_THREAD_GROUPS && __AMP__ && !CONFIG_SCHED_EDGE`.

**(б) Какой планировщик включён сейчас.** Файл [`osfmk/kern/sched.h` @ xnu-12377.121.6, стр. 191–207](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/sched.h#L191-L207):

```c
/*
 * Determine whether the target platform should run the Clutch/Edge Scheduler.
 * All arm64 platforms are eligible to do so.
 */
#if defined(__arm64__) && CONFIG_CLUTCH && !CONFIG_SCHED_EDGE_OPT_OUT
/*
 * Single-cluster, symmetric (SMP) systems can run with just the Clutch policy, but
 * multi-cluster, asymmetric (AMP) systems must further enable the Edge policy
 * extension to Clutch in order to manage scheduling across the multiple CPU clusters.
 */
#define CONFIG_SCHED_CLUTCH 1
#if __AMP__
#define CONFIG_SCHED_EDGE   1
#endif /* __AMP__ */
```

Опция `config_clutch` включена в `SCHED_BASE` и для `MASTER.arm64.iPhoneOS`, и для `MASTER.arm64.MacOSX` (файлы `config/MASTER.arm64.*` того же тега). Такой блок в `sched.h` появился в xnu-11215, то есть в релизах 2024 года. В xnu-10002 (2023) его ещё нет: тогда выбор Edge или AMP делался в закрытой конфигурации конкретной платформы. Какой планировщик стоял на iPhone до 2024 года, по открытым исходникам установить нельзя.

**(в) Живые устройства.** В sysctl-дампах реальных машин видно `kern.sched: edge` (sysctl `kern.sched` объявлен в [kern_sysctl.c @ 12377.121.6, стр. 5206](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/bsd/kern/kern_sysctl.c#L5206), возможные значения — `"edge"`, `"amp"`, `"clutch"`):
- M2 Pro, macOS 26.3.1: `kern.sched=edge` ([mroth/xpe testdata](https://github.com/mroth/xpe/blob/e6e7d6f237efb274919456c5d918a0f3f3155620/testdata/m2pro-macos26_3_1.txt)).
- Устройство с Apple A18 Pro (тот же чип, что в iPhone 16 Pro) под macOS 26.3.2: `kern.sched: edge` ([dump](https://github.com/timb-machine-mirrors/dmaynor-apple-vuln-research/blob/8a2bf521cb0fcdc8340538963a663771adcc6773/artifacts/sysctl-probe/sysctl_full_dump_a18pro.txt)).
- Дампа с самого iPhone найти не удалось. **Совет:** выведите `sysctlbyname("kern.sched")` в DedupBench на своём iPhone и покажите на слайде или держите в backup. Сработает ли вызов в песочнице iOS, я не проверял.

**(г) Правило Edge-планировщика для QoS.** Файл [`osfmk/kern/sched_clutch.c` @ xnu-12377.121.6, стр. 6604–6612](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/sched_clutch.c#L6604-L6612), функция `sched_edge_qos_max_parallelism()`:

```c
	/*
	 * The Edge scheduler supports per-QoS recommendations for thread groups.
	 * This enables lower QoS buckets (such as UT) to be scheduled on all
	 * CPUs on the system.
	 *
	 * The only restriction is for BG/Maintenance QoS classes for which the
	 * performance controller would never recommend execution on the P-cores.
	 * If that policy changes in the future, this value should be changed.
	 */
```

Тот же комментарий есть в xnu-7195 (2021), 8792, 10002 и 11215. Это устойчивая позиция Apple.

В том же файле заданы рёбра миграции по умолчанию ([стр. 6357–6363](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/sched_clutch.c#L6357-L6363)). P→E — `weighted_spill`: поток, которому рекомендован P, может «перелиться» на E. E→P — `no_spill`: поток, которому контроллер рекомендовал E, по умолчанию **не мигрирует и не крадётся** на P, даже если P простаивает. Контроллер производительности может менять эти веса во время работы. Отсюда объяснение вашего наблюдения: если CLPC на iPhone рекомендовал для utility-группы E-кластер, поток там и останется.

**(д) Как Edge выбирает ядро** ([doc/scheduler/sched_clutch_edge.md](https://github.com/apple-oss-distributions/xnu/blob/main/doc/scheduler/sched_clutch_edge.md)): «The scheduler expects the performance controller to specify a cluster recommendation for each thread group… the Edge scheduler allows the performance controller to specify a preferred cluster per QoS within the thread group». Решение принимает **контроллер производительности (CLPC)**, а он закрыт. XNU только исполняет его рекомендации.

**(е) Приоритеты QoS в ядре** ([thread_policy.c @ 12377.121.6, стр. 84–90](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/thread_policy.c#L84-L90), значения из [sched.h, стр. 161–166](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/sched.h#L161-L166)): userInteractive 46, userInitiated 37, default 31, utility 20, background и maintenance 4 (`MAXPRI_THROTTLE`). Кроме того, utility получает I/O tier 1, background — tier 2, а также более слабые throughput/latency tiers.

**(ж) Новые чипы: третий тип ядер.** В xnu-12377.121.6 для T6050 выставлен `HAS_MCORE` ([board_config.h](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/pexpert/pexpert/arm64/board_config.h)). В Edge, если E-кластеров нет, «низким» узлом становятся M-ядра, и BG-потоки уходят на них («performance islands»). По дампам пользователей ([gist chockenberry](https://gist.github.com/chockenberry/1d08129bdf41bfb70e98c3a75ce74578)) у **M5 Pro/M5 Max нет E-ядер вообще**: perflevel0 = «Super», perflevel1 = «Performance» (cluster-type «M»). У базового M5 по-прежнему есть Efficiency. Для Q&A: на новейших Mac фразы «background → E-ядро» уже нет, там будет третья «лестница».

### 1.2 Официальные формулировки Apple

1. **Apple Developer News, 22.06.2020, «Optimize for Apple Silicon with performance and efficiency cores»** ([ссылка](https://developer.apple.com/news/?id=vk3m204o)). Это самая точная официальная фраза:
   - «On AMP systems, the operating system uses the energy-efficiency information conveyed by QoS classes to **influence placement of threads on P or E cores**.»
   - «The OS places threads on P or E cores based on the following criteria: Information your app provides; Observation of the app's workload; Observation of the system as whole.»
   - «…an app running in the background may have its threads placed on E cores to optimize battery life while the foreground app is taking advantage of P cores.»
   - Статья начинается словами «Recent Apple Silicon like **A13 Bionic** has both high-performance cores (P cores) and high-efficiency cores (E cores)», то есть речь и про iPhone тоже.
2. **«Tuning your code's performance for Apple silicon»** ([документация](https://developer.apple.com/documentation/apple-silicon/tuning-your-code-s-performance-for-apple-silicon)): «On Apple silicon, a task's QoS class influences whether the system runs that task. For example, the system is **more likely** to run background tasks on lower performance cores to maximize battery life.» Там же рекомендуется `pthread_set_qos_class_self_np` вместо `pthread_setschedparam`, как у вас и сделано.
3. **WWDC20 «Explore the new system architecture of Apple silicon Macs»** ([транскрипт](https://developer.apple.com/videos/play/wwdc2020/10686/)): «QoS is **a factor** in determining which core a task will be run on.»
4. **Tech Talk 110147 «Tune CPU job scheduling for Apple silicon games»** (2021, [транскрипт](https://developer.apple.com/videos/play/tech-talks/110147/)):
   - «This CPU priority also hints — among other factors — at whether a thread should run on a P or E core.»
   - «They've been designed so that developers don't need to care whether a thread runs on a P or E core. If a program is optimized to perform well on a type of core, it is expected to perform well on the other.» Это **важная контр-цитата для Q&A**: ваш доклад показывает случай, где **победитель меняется**. Отвечать так: микроархитектура похожа, но размеры кэшей и частоты разные, а нагрузка с указателями упирается именно в них.
   - «Each cluster may be independently activated or have its frequency adjusted by the kernel's scheduler — depending on the current workload, the current thermal pressure for that cluster, and other factors. Finally, note the availability of P cores is not guaranteed.»
   - «Note to be very careful with the Background class — threads using it may not run at all for a very long time.»
   - «an iPhone XS has one cluster of two P cores, and one cluster of four E cores».
5. **Energy Efficiency Guide for iOS Apps, «Prioritize Work with QoS»** ([архив](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/PrioritizeWorkWithQoS.html)). Про ядра там ничего нет: руководство написано до массового перехода на P/E.
   - «The system uses QoS information to adjust priorities such as scheduling, CPU and I/O throughput, and timer latency.»
   - Utility: «downloading or importing data… Focuses on providing a balance between responsiveness, performance, and energy efficiency».
   - Background: «such as indexing, **synchronizing**, and backups. Focuses on energy efficiency.»
   - «Optimally, run your app at a QoS level of utility or lower at least 90% of the time when user activity is not occurring.»
   - «On iPhones, discretionary and background operations, including networking, are paused when Low Power Mode is enabled.»
   - Для Mac то же самое сказано в [power_efficiency_guidelines_osx](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/power_efficiency_guidelines_osx/PrioritizeWorkAtTheTaskLevel.html).
6. **DispatchQoS** ([документация](https://developer.apple.com/documentation/dispatch/dispatchqos)): utility — «for tasks that the user does not track actively»; background — «for maintenance or cleanup tasks that you create».
7. **Привязка к ядру невозможна.** Инженер DTS на форуме Apple ([thread 703361](https://developer.apple.com/forums/thread/703361), через WebFetch): «thread affinity is not implemented / supported for Apple Silicon». В XNU [`osfmk/arm/cpu_affinity.h`](https://github.com/apple-oss-distributions/xnu/blob/main/osfmk/arm/cpu_affinity.h) функция `ml_get_max_affinity_sets()` возвращает 0. Это отвечает на ваш вопрос из заметок «не имея API привязки».

### 1.3 Howard Oakley (eclecticlight.co): только по сниппетам

Сайт заблокирован прокси. Ниже фрагменты из поисковой выдачи, сами страницы я не открывал:
- [«Tune for Performance: Core types» (17.12.2024)](https://eclecticlight.co/2024/12/17/tune-for-performance-core-types/) / [«What is Quality of Service…» (09.05.2025)](https://eclecticlight.co/2025/05/09/what-is-quality-of-service-and-how-does-it-matter/): «Threads with QoS of 9, background, are confined to E cores and are never run on P cores, even if they're all idle and the E cores are busy»; «Threads with QoS between 17 and 33 are run preferentially on P cores, but when no P cores are available, they can be run on E cores».
- [«macOS has different strategies for M1 cores» (2022)](https://eclecticlight.co/2022/03/17/macos-has-different-strategies-for-m1-cores/): при одном low-QoS потоке E-кластер M1 Pro работает около 1000 МГц, при двух — около 2000 МГц.
- [«Running tasks on E cores can use a third of the energy of P cores» (2022)](https://eclecticlight.co/2022/05/03/running-tasks-on-e-cores-can-use-a-third-of-the-energy-of-p-cores/): только заголовок.

Utility имеет QoS 17 (0x11 в [libpthread `sys/qos.h`, стр. 138](https://github.com/apple-oss-distributions/libpthread/blob/main/include/sys/qos.h)). Значит, по Oakley, **на macOS utility предпочитает P**, а это ровно ваш замер на Mac. Про iPhone Oakley не пишет.

### 1.4 Вердикт по наблюдению «Mac: utility на P; iPhone: utility на E»

- **Mac, utility на P.** Согласуется с Edge («UT… on all CPUs») и с Oakley (17–33 предпочитают P). Вердикт: **согласуется**.
- **Mac, background на E.** Согласуется с Edge («would never recommend execution on the P-cores») и с Oakley. Вердикт: **подтверждено** по исходникам и вторичному источнику.
- **iPhone, utility на E.** Не противоречит Edge: это рекомендация CLPC для группы потоков и QoS. Статья Apple 2020 допускает, что фоновое приложение уйдёт на E. **Прямого документального подтверждения для iOS нет.** Вердикт: «ваш замер, согласуется с моделью». Опирайтесь на свои данные, прежде всего на кривую «лестницы» со слайда cores.
- **iPhone, default ведёт себя как userInitiated (P).** Согласуется: в Edge ограничение есть только у BG и maintenance.

Методическая оговорка: поток с utility на iPhone у вас «на E, но на более высокой частоте». Это похоже на поведение, описанное у Oakley: частота E-кластера зависит от QoS и числа потоков. По кэшевой лестнице видно тип ядра, но не частоту. Если спросят «откуда вы знаете, что это E?», есть дополнительная проверка: Instruments → System Trace показывает, на каком CPU шёл поток, с разметкой P/E. Что Instruments подписывает P/E, я помню, но на текущей версии не проверял.

### 1.5 Фоновое приложение: потолок QoS по роли процесса

[task_policy.c @ 12377.121.6, стр. 842–877](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/osfmk/kern/task_policy.c#L842-L877) задаёт потолок QoS по роли процесса:
- `TASK_NONUI_APPLICATION /* i.e. 'off-screen' */` → `tep_qos_ceiling = THREAD_QOS_LEGACY`, то есть default;
- `TASK_DARWINBG_APPLICATION /* 'DARWIN_BG throttled background application' */` → потолок `THREAD_QOS_BACKGROUND`;
- `TASK_THROTTLE_APPLICATION` → clamp до utility.

Какую роль iOS назначает приложению в BGAppRefreshTask и BGProcessingTask, решает закрытый RunningBoard: **не проверено**. Практический вывод: код, помеченный userInitiated, в фоне **не обязан** остаться userInitiated.

### 1.6 Как сказать на сцене

**Сноска слайда qos вместо текущей:**
> XNU, Edge-планировщик (sched_clutch.c): background/maintenance «performance controller would never recommend execution on the P-cores»; utility может идти на любые ядра — решает закрытый контроллер производительности. Apple: QoS используется «to influence placement of threads on P or E cores» (Apple Developer, 2020).

**Текст в заметки (замена последних фраз к слайду qos):**
> «Механизм не магия, но и не закон. В исходниках ядра Apple прямо написано: фоновый класс контроллер производительности на P-ядра не отправляет никогда. Про utility там написано обратное: он может идти на любые ядра, а решает закрытый контроллер производительности. Apple в статье для разработчиков говорит аккуратно: QoS "влияет на размещение". Поэтому я не утверждаю, что utility всегда живёт на E. Я показываю, что на моём iPhone под iOS 27 он оказался на E, а на Mac — на P. Проверьте на своём».

**Не говорить:** «в XNU написано, что utility идёт на E-ядра». По текущим исходникам это неверно, и в зале могут оказаться люди, читавшие sched_clutch.c.

### 1.7 Вероятные вопросы и ответы

- *«Можно просто поставить userInitiated?»* — Можно, но Apple просит держать приложение в utility и ниже 90% времени, пока пользователь не взаимодействует с ним (Energy Guide). Кроме того, в фоне потолок QoS режется ролью процесса (§1.5). Правильнее выбрать алгоритм, который дёшев именно на E-ядре.
- *«Можно привязать поток к P-ядру?»* — Нет. «thread affinity is not implemented / supported for Apple Silicon» (DTS, форум Apple), а `ml_get_max_affinity_sets()` возвращает 0.
- *«Apple же говорит, что P и E архитектурно похожи?»* — Да, Tech Talk 110147 это говорит. Но у E-ядра вдвое меньше L1D, вчетверо меньше L2 кластера и ниже частота. Для pointer chasing этого достаточно (слайд cores).
- *«На M5 Pro так же?»* — На M5 Pro и Max E-ядер нет: там Super и Performance. BG-потоки идут на M-ядра (XNU `HAS_MCORE`, дампы sysctl пользователей). Лестница будет другой. Это ещё один аргумент «проверьте, какое ядро досталось».

---

## 2. Кэши, строка кэша, латентности, sysctl на iOS

### 2.1 M2 Pro: подтверждено sysctl

Дамп `m2pro-macos26_3_1.txt` ([mroth/xpe](https://github.com/mroth/xpe/blob/e6e7d6f237efb274919456c5d918a0f3f3155620/testdata/m2pro-macos26_3_1.txt)), 12-ядерный M2 Pro:

```
hw.perflevel0.physicalcpu=8   hw.perflevel0.l1dcachesize=131072  hw.perflevel0.l2cachesize=16777216  hw.perflevel0.cpusperl2=4  name=Performance
hw.perflevel1.physicalcpu=4   hw.perflevel1.l1dcachesize=65536   hw.perflevel1.l2cachesize=4194304   hw.perflevel1.cpusperl2=4  name=Efficiency
hw.cachelinesize=128   hw.nperflevels=2   kern.sched=edge
```

- L1D P = 128 КБ, E = 64 КБ; L2 P = 16 МБ на кластер из 4 ядер (при 8 P-ядрах это **два** кластера), E = 4 МБ. **Подтверждено.**
- `hw.cachelinesize = 128`. **Подтверждено.** Строка 128 Б встречается и у Apple: XNU `MAX_L2_CLINE 7` (2^7) для T6020 = M2 Pro/Max ([board_config.h](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/pexpert/pexpert/arm64/board_config.h)); Tech Talk 110147: «On Apple silicon, a cache line is 128 bytes long». Нюанс: на WWDC25 Apple говорит «These caches also group memory into **64- or 128 byte** segments called cache lines» ([308](https://developer.apple.com/videos/play/wwdc2025/308/)). Фразу «строка приносит 16 ключей» лучше привязать к sysctl, а не к L1: «hw.cachelinesize = 128».
- SLC 24 МБ у M2 Pro: **не удалось проверить**. sysctl SLC не отдаёт (`hw.l3cachesize` отсутствует), Wikipedia и обзоры заблокированы. По памяти: M2 Pro — 24 МБ, M2 Max — 48 МБ, не проверено.

### 2.2 Латентности

- Apple, WWDC25 «Optimize CPU performance with Instruments» ([308](https://developer.apple.com/videos/play/wwdc2025/308/)): «It starts with the L1 caches that are located within each CPU… A slower L2 cache sits outside of the CPUs… requests that miss both caches and need to access main memory become **50 times slower than the fast path**.»
- Цифры ~1 / ~5 / ~100 нс: по памяти, не проверено. Порядок правдоподобен: L1 около 3 тактов при ~3,5 ГГц, L2 около 16–18 тактов, DRAM около 100 нс и больше.
- **Рекомендация.** На слайде memory у вас стоит «задержки — порядок величин, не замер», а на слайде cores у вас **есть** собственный pointer-chasing. Возьмите оттуда реальные значения для userInitiated на M2 Pro: плато внутри L1, внутри L2, за L2. Тогда цифры ваши, а не справочные.
- Для заметок к cachecost («счётчики промахов — следующий шаг»): в Instruments → CPU Counters есть готовый режим **«L1D Cache Miss Sampling»** (WWDC25 308). Processor Trace работает на M4 и A18 и новее: «only available on Mac and iPad Pro with M4 or iPhone with A18».

### 2.3 Кэши iPhone-чипов

| Чип (iPhone) | P L1D | P L2 (на кластер) | E L1D | E L2 | SLC | Статус |
|---|---|---|---|---|---|---|
| A18 Pro (16 Pro / Pro Max) | 128 КБ | **16 МБ** (2 ядра) | 64 КБ | **4 МБ** (4 ядра) | ? | **Подтверждено** sysctl-дампом устройства с A18 Pro ([dump](https://github.com/timb-machine-mirrors/dmaynor-apple-vuln-research/blob/8a2bf521cb0fcdc8340538963a663771adcc6773/artifacts/sysctl-probe/sysctl_full_dump_a18pro.txt): `perflevel0.l2cachesize: 16777216`, `perflevel1.l2cachesize: 4194304`, `cachelinesize: 128`). Устройство работает под macOS, но чип тот же |
| A15 (13 / 13 Pro, 14 / 14 Plus, SE 3) | 128 КБ | 12 МБ | 64 КБ | 4 МБ | 32 МБ | по памяти, не проверено |
| A16 (14 Pro, 15 / 15 Plus) | 128 КБ | 16 МБ | 64 КБ | 4 МБ | 24 МБ | по памяти, не проверено |
| A17 Pro (15 Pro) | 128 КБ | 16 МБ | 64 КБ | 4 МБ | 24 МБ | по памяти, не проверено |
| A18 (16 / 16 Plus / 16e) | 128 КБ | ? (встречал разные цифры) | 64 КБ | 4 МБ | ? | не проверено |
| A19 / A19 Pro (17, Air, 17 Pro) | ? | ? | ? | ? | ? | не удалось проверить. У M5 того же поколения E-кластер 6 МБ по дампу из gist, для A19 не проверено |

**Главное:** не опирайтесь на эту таблицу, **снимите sysctl на своём iPhone**. Это одна строка кода (§8).

### 2.4 Доступен ли hw.perflevel на iOS из приложения

- Tech Talk 110147 (Apple): «Starting with macOS Monterey **and iOS 15**, you can query advanced details about the CPU layout with the sysctl interface… nperflevels… perflevel{N}.logicalcpu».
- XNU регистрирует узлы `hw.perflevel0/1` и `hw.nperflevels` **без условий по платформе** ([kern_mib.c @ 12377.121.6, стр. 1015–1017](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/bsd/kern/kern_mib.c#L1015-L1017)).
- Собственная libBLAS Apple (Accelerate) на iOS 26.2 (iPhone17,2) содержит строки `hw.perflevel0/1/2.l2cachesize` (результат поиска кода GitHub по [baozzz1/coreml-disassembler](https://github.com/baozzz1/coreml-disassembler)). Accelerate работает внутри процессов сторонних приложений, так что чтение из песочницы, судя по всему, разрешено.
- Страница документации [«Determining system capabilities»](https://developer.apple.com/documentation/kernel/1387446-sysctlbyname/determining_system_capabilities) описывает эти ключи. Замечание оттуда: `hw.l1dcachesize` и `hw.l2cachesize` без perflevel возвращают значения **самого медленного** типа ядер, то есть E. Метаданные страницы `sysctlbyname` указывают только macOS.
- Вердикт: **доступен с iOS 15**. Проверено по Apple Tech Talk и исходникам, на реальном iPhone из песочницы — нет. Проще всего проверить в DedupBench.

### 2.5 Ошибка на слайде cores

На правом графике «iPhone» нарисованы пунктиры M2 Pro, и в сноске написано «sysctl hw.perflevel… на M2 Pro». Если у вас A16, A17 Pro или A18 Pro, числа случайно совпадут (16 МБ / 4 МБ, 128 / 64 КБ). Если A15, P-L2 будет 12 МБ. **Исправить:** снять `hw.perflevel0/1.*` на iPhone и подписать «пунктир — sysctl этого iPhone (iPhoneXX,Y)».

---

## 3. malloc на macOS и iOS: во что превращается запрос 24 Б и 16 Б

### 3.1 Факты из исходников libmalloc

Источник — [libmalloc-812.100.31](https://github.com/apple-oss-distributions/libmalloc/tree/c49dafa25f1efe8607701ae6014a663ad2ee437f), последний тег в апреле 2026 года.

- **nanov2** ([nano_zone_common.h, стр. 27–29, 57–58](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/nano_zone_common.h#L27-L58)): `NANO_MAX_SIZE 256 /* Buckets sized {16, 32, 48, ..., 256} */`, `SHIFT_NANO_QUANTUM 4`. Округление размера — `((size + 15) >> 4) << 4`. **24 Б → 32 Б, 16 Б → 16 Б.**
- **Tiny-зона magazine malloc** ([thresholds.h, стр. 60–62](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/thresholds.h#L60-L62); [magazine_zone.h, стр. 104–128](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/magazine_zone.h#L104-L128)): `TINY_QUANTUM = 16`. Регион устроен как «metadata block followed by a heap… two bitfields… The header bit indicates that the corresponding quantum is the first quantum in a block». «Заголовок» здесь — **бит в битовой карте региона**, а не байты перед блоком.
- **xzone malloc** ([doc/xzone_malloc.md](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/doc/xzone_malloc.md); [xzone_malloc.h, стр. 76](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/xzone_malloc/xzone_malloc.h#L76); [xzone_malloc.c, стр. 51–57 и 7145–7170](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/xzone_malloc/xzone_malloc.c#L7145)):
  - `XZM_GRANULE 16`; размерные классы (bins) `16, 32, 48, 64, 80, 96, 112, 128, …`. **24 Б → 32 Б.**
  - «Externalized metadata: Almost all of xzone malloc's metadata is stored in portions of the address space that are located separately… The only case where xzone malloc uses inline metadata is for free-list linkages». То есть **внутри занятого блока нет заголовка**.
  - «Zero-on-free: …allocations below a size threshold (currently 1KB) are **zeroed on free**.» В [platform.h, стр. 239](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/platform.h#L239) общая политика по умолчанию — `MALLOC_ZERO_ON_FREE`.
  - Когда включается: `CONFIG_XZONE_MALLOC 1` для 64-битных платформ ([platform.h, стр. 242](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/platform.h#L242)). В [malloc_config.c, стр. 333–357](https://github.com/apple-oss-distributions/libmalloc/blob/c49dafa25f1efe8607701ae6014a663ad2ee437f/src/malloc_config.c#L333-L357) сказано «never enabled on Intel (including Rosetta and the embedded simulators)» и «in all other cases, we enable xzone malloc». В текущем libmalloc xzone по умолчанию включён для arm64-процессов на iOS и macOS. С какой именно версии ОС так, я не проверял.
- Во всех трёх аллокаторах Apple результат одинаковый. **Запрос 24 Б занимает 32 Б (+8 Б на округление), запрос 16 Б занимает 16 Б. Заголовка перед блоком нет.**

### 3.2 Сколько места занимает узел libc++

Узел `unordered_set<uint64_t>` в libc++ содержит `next` (8), кешированный хеш (8) и значение (8), итого 24 Б. Это подтверждается и вашими 33,6 МБ: при N = U = 2^20 и reserve(N) выходит 24·2^20 + 8·2^20 = 33 554 432 Б.

С учётом округления до 32 Б реально занято **32·2^20 + 8·2^20 ≈ 41,9 МБ** (40 МиБ). Узел libstdc++ в 16 Б остаётся 16 Б: 16·2^20 + 8·2^20 ≈ 25,2 МБ, это тоже совпадает с колодой. Но libstdc++ у вас на Linux, там свой аллокатор (glibc), и к Apple это не относится.

### 3.3 Правильная арифметика для слайда cachecost

Колода: «узел 24 Б + расходы malloc ~16 Б + ячейка 8 Б ≈ 48 Б на ключ. 512K → ~24 МБ, 1M → ~48 МБ». Здесь две ошибки:
1. Накладные расходы malloc для 24 Б — это 8 Б округления, а не 16.
2. На слайде U = N/2, то есть узлов U, а не N. Ячеек при `reserve(N)` ровно N (см. §9), по 8 Б каждая.

Рабочий набор ≈ **32·U + 8·N**:

| N (U = N/2) | узлы 32·U | ячейки 8·N | итого | против L2 P-кластера 16 МиБ |
|---|---|---|---|---|
| 512K | 8 МиБ | 4 МиБ | **12 МиБ** (12,6 МБ) | помещается |
| 1M | 16 МиБ | 8 МиБ | **24 МиБ** (25,2 МБ) | не помещается, и SLC тоже, если он 24 МБ |
| 4M | 64 МиБ | 32 МиБ | **96 МиБ** | далеко за кэшами |

**Вывод колоды выдерживает проверку и становится только чище:** на 512K всё помещается в L2, на 1M уже нет. Цифры надо исправить.

**Предлагаемый текст на слайд:**
> Арифметика рабочего набора: узел libc++ 24 Б, malloc округляет до 32 Б (квант 16 Б, без заголовка) → 32 Б × U; плюс 8 Б × N на ячейки (reserve(N)). N = 512K (U = 256K) → ~12 МиБ, помещается в 16 МиБ L2 P-кластера. N = 1M → ~24 МиБ, уже нет. Излом ложится на границу.

**В заметки (вместо «48 байт на ключ…»):**
> «Узел в libc++ — 24 байта, аллокатор Apple округляет его до 32; заголовка перед блоком нет. Плюс по 8 байт на ячейку, а ячеек после reserve(N) — N. При половине дублей на полумиллионе это около 12 мегабайт — влезает в 16 мегабайт L2. На миллионе — около 24, уже нет».

### 3.4 Поправки к заметкам слайда allocs

- «Поход к менеджеру памяти: найти свободный кусок в нужном размерном классе, **записать заголовок**, вернуть адрес» → «…найти свободный кусок в нужном размерном классе, **обновить метаданные** (у Apple они лежат отдельно от блока), вернуть адрес».
- «Второй платёж» за delete у Apple ещё весомее: блоки меньше 1 КБ **обнуляются при free** (xzone zero-on-free). Миллион delete означает миллион записей по 32 Б.
- «Адреса разбросаны по куче» — неточно. Аллокатор может раздать узлы почти подряд, потому что это слэбы одного размера. Случайность создаёт **порядок обхода**: хеш раскладывает узлы по ячейкам не в том порядке, в каком они выделялись. Формулировка: «порядок, в котором мы их обходим, никак не связан с порядком в памяти».

---

## 4. Лимиты памяти расширений (jetsam)

**Официальная позиция Apple.** Точных цифр нет. App Extension Programming Guide ([архив](https://developer.apple.com/library/archive/documentation/General/Conceptual/ExtensibilityPG/ExtensionCreation.html)): «Memory limits for running app extensions are significantly lower than the memory limits imposed on a foreground app… Some extensions may have lower memory limits than others: For example, widgets must be especially efficient». API для проверки — [`os_proc_available_memory()`](https://developer.apple.com/documentation/os/os_proc_available_memory): «Memory limits can change during the app life cycle».

**Наблюдаемые лимиты** (не документированы, могут меняться с версией iOS и устройством):

| Тип | Лимит | Источник | Надёжность |
|---|---|---|---|
| Notification Service Extension | **24 МБ** («exceeded mem limit: ActiveHard 24 MB (fatal)») | [форум Apple 740332](https://developer.apple.com/forums/thread/740332) | лог разработчика |
| Виджет WidgetKit | **30 МБ** («EXC_RESOURCE RESOURCE_TYPE_MEMORY (limit=30 MB…)») | [форум Apple 713561](https://developer.apple.com/forums/thread/713561); [FB8832751, iOS 14.1, 2020](https://github.com/feedback-assistant/reports/issues/177) | логи разработчиков |
| Share extension | **~120 МБ** | [element-ios #2341 (iPhone X, iOS 12, 2019)](https://github.com/vector-im/riot-ios/issues/2341); [hermex #682 (сентябрь 2026)](https://github.com/uzairansaruzi/hermex/issues/682): «about a 120 MB jetsam ceiling» | issues |
| Custom Keyboard | **~48 МБ** | [react-native #31910 (2021)](https://github.com/facebook/react-native/issues/31910) | issue |
| File Provider extension | **~20 МБ** | [форум Apple 804378](https://developer.apple.com/forums/thread/804378); DTS цифру не подтвердил | со слов разработчика |
| Фоновые задачи основного приложения | лимит приложения, а не расширения; зависит от устройства | не проверено | — |

**Вердикт по колоде.** «Для виджета или share extension с лимитом в десятки МБ» — **неточно**: у share extension около 120 МБ. Ваши 33,6 МБ запрошенных, а на деле около 42 МБ занятых, **не помещаются** в лимиты NSE (24) и виджета (30).

**Формулировка:**
> «33 мегабайта для приложения — ничего. Для Notification Service Extension с лимитом около 24 мегабайт или для виджета с лимитом около 30 — это jetsam».

«Процесс умирает молча» — **по сути верно**. В теме 740332 разработчик пишет, что Xcode в Device Crashes памятных падений не показывал, а увидел их только в консоли устройства. Apple: jetsam event reports «differ from crash reports… don't contain the backtraces» ([документация](https://developer.apple.com/documentation/xcode/identifying-high-memory-use-with-jetsam-event-reports)). Точнее так: «без обычного crash-лога».

---

## 5. Фоновое исполнение, BGTaskScheduler и Swift Concurrency: что будет с кодом синхронизации

### 5.1 Task priority и QoS

- Исходник Swift ([Task.swift, стр. 348–359](https://github.com/swiftlang/swift/blob/main/stdlib/public/Concurrency/Task.swift#L348-L359)): `high = 0x19`, `medium = 0x15`, `low = 0x11`, `userInitiated = high`, `utility = low`, `background = 0x09`.
- Значения QoS в [libpthread sys/qos.h, стр. 131–142](https://github.com/apple-oss-distributions/libpthread/blob/main/include/sys/qos.h): USER_INTERACTIVE 0x21, USER_INITIATED 0x19, DEFAULT 0x15, UTILITY 0x11, BACKGROUND 0x09. Числа совпадают один в один.
- Глобальный исполнитель ([DispatchGlobalExecutor.cpp, стр. 150–196, 249–254](https://github.com/swiftlang/swift/blob/main/stdlib/public/Concurrency/DispatchGlobalExecutor.cpp#L150-L196)) ставит задачу в `dispatch_get_global_queue((dispatch_qos_class_t)priority, cooperative)`. **`Task(priority: .utility)` исполняется на кооперативном потоке с QoS utility.** Подтверждено.
- Повышение приоритета ([TaskPriority](https://developer.apple.com/documentation/swift/taskpriority)): «Child tasks automatically inherit their parent task's priority… If a higher-priority task accesses the `value` property, then the priority of this task increases until the task completes». Если UI-задача ждёт `await syncTask.value`, utility-задачу поднимут. В замерах это нужно исключить или учитывать.
- **Правка к слайду case:** «Task с qos .utility» → «`Task(priority: .utility)` (QoS utility)».

### 5.2 BGTaskScheduler

- **BGAppRefreshTask** ([Choosing Background Strategies](https://developer.apple.com/documentation/backgroundtasks/choosing-background-strategies-for-your-app)): «The system decides the best time to launch your background task, and provides your app **up to 30 seconds** of background runtime».
- **BGProcessingTask** ([документация](https://developer.apple.com/documentation/backgroundtasks/bgprocessingtask)): «Processing tasks run only when the device is idle. The system terminates any background processing tasks running when the user starts using the device.»
- **BGContinuedProcessingTask** (iOS 26+, [документация](https://developer.apple.com/documentation/backgroundtasks/bgcontinuedprocessingtask)): стартует в foreground по действию пользователя, прогресс показывается в Live Activity.
- **Очередь launch handler** ([register(forTaskWithIdentifier:using:launchHandler:)](https://developer.apple.com/documentation/backgroundtasks/bgtaskscheduler/register(fortaskwithidentifier:using:launchhandler:))): «Pass nil to use a default background queue». **Какой у неё QoS, не документировано.** Проверяется `qos_class_self()` внутри handler.
- **WWDC25 «Finish tasks in the background»** ([227](https://developer.apple.com/videos/play/wwdc2025/227/)): «iOS prioritizes the foreground experience, meaning your background task **may receive a lower quality of service** compared to when your app is active»; «the system intelligently boosts the task priority when the app returns to the foreground»; «network availability, CPU load, device activity, thermal state, and battery level are all used as context».
- **Low Power Mode:** «Pausing discretionary and background activities» ([isLowPowerModeEnabled](https://developer.apple.com/documentation/foundation/processinfo/islowpowermodeenabled)). Energy Guide: «discretionary and background operations, including networking, are paused when Low Power Mode is enabled».
- **Background URLSession** (по памяти, не проверено): сама передача идёт в системном демоне. Приложение будят событием `handleEventsForBackgroundURLSession`, а обработка результата (ваша дедупликация) выполняется уже в коротком фоновом окне приложения.

### 5.3 Что реально будет с этапом синхронизации в приложении

| Сценарий | Что известно | Итог для дедупликации |
|---|---|---|
| Приложение на экране, «вернулись из метро», `Task(priority: .utility)` | Ваш замер: на iPhone это E-ядро | Цена памяти в 2–6 раз выше. Ваш главный кейс |
| Приложение в фоне (BGAppRefreshTask, ≤30 с) | Потолок QoS по роли процесса: off-screen → default, darwinbg → background (XNU §1.5); Apple: «may receive a lower quality of service» | Скорее E-ядро и ниже частота, а бюджет времени 30 с. **Не измерено**, это честно указано в колоде |
| BGProcessingTask ночью на зарядке | Устройство простаивает, задача может идти минуты | Ядро неизвестно. Узел упирается скорее в память, чем во время |
| Low Power Mode | Фоновые задачи на паузе, «Reducing CPU and GPU performance» | Замер в этом режиме — отдельный сценарий |

Лучший дополнительный опыт для backup: тот же pointer-chasing с QoS utility, запущенный **внутри BGAppRefreshTask**. Это закроет вопрос «а в реальном фоне?».

---

## 6. CI: GitHub Actions, Xcode Cloud, виртуальные машины

### 6.1 GitHub-hosted macOS-раннеры (сентябрь 2026)

- Стандартные раннеры (исходник документации [github/docs `supported-github-runners.md`](https://github.com/github/docs/blob/f4e8afc6979acd8de6b5da035066281b9a5f4025/data/reusables/actions/supported-github-runners.md), коммит от 28.09.2026): macOS arm64 — **«3 (M1)» CPU, 7 GB RAM**. Метки: `macos-latest`, `macos-14`, `macos-15`, `macos-26`, `xcode-27` (preview). Intel: 4 CPU, 14 GB (`macos-15-intel`, `macos-26-intel`).
- Larger runners ([`larger-runners-table.md`](https://github.com/github/docs/blob/f4e8afc6979acd8de6b5da035066281b9a5f4025/data/reusables/actions/larger-runners-table.md)): **XLarge — arm64 (M2), 5 CPU (+ 8 GPU)**, 14 GB; Large — Intel, 12 CPU.
- Ограничения ([`macos-runner-limitations.md`](https://github.com/github/docs/blob/f4e8afc6979acd8de6b5da035066281b9a5f4025/data/reusables/actions/macos-runner-limitations.md)): «Nested-virtualization is not supported due to the limitation of **Apple's Virtualization Framework**». Значит, раннеры — это VM на Virtualization.framework.
- `macos-latest` сейчас указывает на macOS 26 arm64 (26.6.2, Xcode 26.6 по умолчанию, [README runner-images](https://github.com/actions/runner-images/blob/main/README.md)). macOS 14 объявлен устаревшим.
- **Что видит гость** (PR 21.09.2026 [yorickdowne/get-macos-runner-hardware#1](https://github.com/yorickdowne/get-macos-runner-hardware/pull/1), через WebFetch, `macos-latest` и `xcode-27`): `machdep.cpu.brand_string: Apple M1 (Virtual)`, `hw.model: VirtualMac2,1`, **`hw.nperflevels: 1`**, `hw.perflevel0.name: Standard`, `hw.perflevel0.physicalcpu: 3`, `hw.perflevel0.l2cachesize: 12582912` (12 МБ, как у P-кластера M1), `l1dcachesize: 131072`, `hw.cachelinesize: 128`.

### 6.2 Почему в VM нет P/E: исходники XNU

- [board_config.h @ 12377.121.6, стр. 307–330](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/pexpert/pexpert/arm64/board_config.h#L307-L330): у `ARM64_BOARD_CONFIG_VMAPPLE` задано `MAX_CPU_CLUSTERS 1`, а ниже `#if MAX_CPU_CLUSTERS == 1 / #undef __ARM_AMP__`.
- [VMAPPLE.h, стр. 33](https://github.com/apple-oss-distributions/xnu/blob/xnu-12377.121.6/pexpert/pexpert/arm64/VMAPPLE.h#L33): `#define NO_ECORE 1`.
- Без `__AMP__` Edge не включается (sched.h, §1.1), и гостевое ядро работает как симметричная система на Clutch. **QoS внутри VM влияет только на очерёдность внутри гостя.** На каком физическом ядре (P или E) крутится vCPU, решает планировщик **хоста**. Это вывод из исходников, на живом раннере `kern.sched` я не проверял.
- **Следствие для доклада.** В GitHub-hosted CI эффект «utility → E-ядро» **невоспроизводим в принципе**. Это усиливает слайд flip. Но колонку «Mac · CI-раннер M2 Pro» нужно переименовать: ваш M2 Pro — не hosted-раннер.
- То же относится к backup-слайду с M2 Pro Linux VM: у гостевого Linux однородные vCPU, их размещение на P/E решает macOS-хост. Стоит добавить сноску «VM: тип ядра под vCPU не контролировался».

### 6.3 Xcode Cloud

**Не удалось проверить.** Apple не публикует ни железо, ни число ядер. Известно только, что окружения эфемерные (по сниппету поиска со страницы [Xcode Cloud Overview](https://developer.apple.com/xcode-cloud/)).

### 6.4 Симулятор iOS

По памяти, не проверено ссылкой. Приложение в Simulator — это процесс macOS на ядрах Mac. Кэши, планировщик и политика QoS там от Mac. Перф-тест в симуляторе измеряет Mac, а не iPhone. Если в зале спросят «у нас UI-тесты в симуляторе», ответ тот же, что про CI.

### 6.5 Формулировка для слайда flip

- Заголовок колонки: «Mac разработчика (M2 Pro, userInitiated)» вместо «Mac · CI-раннер M2 Pro».
- Сноска:
> «GitHub-hosted macOS-раннеры — VM на M1 (3 vCPU) или M2 (5 vCPU): гостевая macOS видит один тип ядер (hw.nperflevels = 1), QoS не может выбрать E-ядро».
- Фраза в заметки:
> «Хуже того: стандартный macOS-раннер GitHub — это виртуалка, в которой вообще нет E-ядер. Вы не увидите мой эффект в CI, даже если очень захотите».

---

## 7. Версии инструментов, thermalState, Low Power Mode, системная libc++

### 7.1 Нумерация Apple clang

По `clang --version` из отчётов actions/runner-images. Скрипт `Get-ClangLLVMVersions` берёт первую версию `x.y.z` из вывода `clang --version` Xcode по умолчанию ([SoftwareReport.Common.psm1](https://github.com/actions/runner-images/blob/main/images/macos/scripts/docs-gen/SoftwareReport.Common.psm1)).

| Xcode по умолчанию | Apple clang (`clang --version`) | Источник |
|---|---|---|
| 15.4 | 15.0.0 | [macos-14-arm64 README](https://github.com/actions/runner-images/blob/7dda6f932943bf359ccb3b9f51a1cb0215ad4d52/images/macos/macos-14-arm64-Readme.md) |
| 16.4 | 17.0.0 | [macos-15-arm64 README](https://github.com/actions/runner-images/blob/f95c0c791f690fa64eaf9788bea06643a4176db5/images/macos/macos-15-arm64-Readme.md) |
| 26.2 | 17.0.0 | [macos-26-arm64 @ 2026-05-04](https://github.com/actions/runner-images/blob/e9d8355e087eac81981227aae5d5653df8b765f6/images/macos/macos-26-arm64-Readme.md) |
| 26.4.1 | **21.0.0** | [macos-26-arm64 @ 2026-05-22](https://github.com/actions/runner-images/blob/f3b0ce0a5f1b03a37426920e123b6948fe404944/images/macos/macos-26-arm64-Readme.md) |
| 26.6 | 21.0.0 | [macos-26-arm64 @ 2026-09-11](https://github.com/actions/runner-images/blob/0af81b6d930d02b52941d584bee9214c4bc228c6/images/macos/macos-26-arm64-Readme.md) |
| 27.0 (macOS 27.0) | 21.0.0 | [xcode-27-arm64 README](https://github.com/actions/runner-images/blob/f5ec55a9dd3f638ff5850c793ecbc557dec8fa55/images/macos/xcode-27-arm64-Readme.md) |

- Xcode 16.0–16.2 → Apple clang 16.0.0: по памяти, не проверено.
- Вывод: **«Apple clang 21» правдоподобно** для Xcode 26.4+ и Xcode 27. Нумерация Apple clang **не равна** номеру Xcode и **не равна** версии upstream LLVM: с Xcode 16.3 до 26.3 была 17, потом произошёл скачок сразу на 21.
- **Правка:** везде писать «Xcode 27.0 (Apple clang 21.0.0, clang-21xx.x.x)» с точной строкой из `clang --version`.

### 7.2 macOS 27 и iOS 27

По RSS [Apple Developer Releases](https://developer.apple.com/news/releases/rss/releases.rss):
- Xcode 27 (27A266a) — 14.09.2026;
- macOS 27.0.1 (26A434) и iOS 27.0.1 (24A446) — 28.09.2026;
- runner-images `xcode-27`: macOS 27.0 (26A428).

«macOS 27» на 27.09.2026 — **подтверждено**. Версию iOS в колоде нужно добавить: вероятно, 27.0.x.

### 7.3 thermalState

- [`ProcessInfo.ThermalState.nominal`](https://developer.apple.com/documentation/foundation/processinfo/thermalstate-swift.enum/nominal): «The thermal state is within normal limits.» Больше ничего. Про `fair` сказано: «The system takes steps to reduce thermal state, like running fans and **stopping background services**».
- Tech Talk 110147: частота кластера зависит в том числе от «current thermal pressure for that cluster», а «availability of P cores is not guaranteed».
- **nominal не гарантирует максимальной частоты и одинаковых условий.** Формулировка на слайде drift («nominal не доказывает отсутствие ограничений») — **верная**.

### 7.4 Low Power Mode

- Apple ([isLowPowerModeEnabled](https://developer.apple.com/documentation/foundation/processinfo/islowpowermodeenabled); [Energy Guide](https://developer.apple.com/library/archive/documentation/Performance/Conceptual/EnergyGuide-iOS/LowPowerMode.html)): «Reducing CPU and GPU performance», «Pause discretionary and background activities, including networking».
- Как именно LPM влияет на P-ядра (частота, отключение), Apple не раскрывает: **не проверено**.
- **В чек-лист (пункт 7)** добавить «Low Power Mode: off» и логировать `isLowPowerModeEnabled`.

### 7.5 Системная libc++ и std::sort для uint64_t

- В libc++ ([sort.h, стр. 835–857 и 903–906](https://github.com/llvm/llvm-project/blob/main/libcxx/include/__algorithm/sort.h#L835-L906)) `std::sort` для арифметических типов со стандартным компаратором уходит в `std::__sort<__less<unsigned long long>&, unsigned long long*>`. Эта функция объявлена как `extern template _LIBCPP_EXPORTED_FROM_ABI`, а определена только в [src/algorithm.cpp](https://github.com/llvm/llvm-project/blob/main/libcxx/src/algorithm.cpp), то есть **внутри libc++.dylib**. Инлайнить её компилятору нечего.
- **Следствие.** На iPhone ваш `std::sort(ids)` исполняет код **системной libc++ из iOS 27**, на Mac — из macOS 27. Xcode и Apple clang 21 определяют только шаблоны в заголовках: `unordered_set` и `unique`.
- Утверждение «libc++ с LLVM 17 распознаёт отсортированный вход» на устройстве зависит **от версии ОС**. На старой iOS поведение может отличаться. Как собрана системная libc++ в iOS 27, я не проверял.
- **Правка к чек-листу, пункт 6:** «Версия компилятора, библиотеки **и ОС** в логе».

---

## 8. Какой iPhone и почему модель обязательна

### 8.1 Что можно вывести из колоды

- Кривая userInitiated на iPhone ломается около 128 КБ и около 16 МБ. Значит, P-L2 ≈ 16 МБ, что подходит к A16, A17 Pro или A18 Pro. У A15 было бы около 12 МБ (по памяти). Точный вывод невозможен: на график iPhone нанесены пунктиры M2 Pro (§2.5), и глаз мог «притянуть» излом к ним.
- Излом E-ядра на 64 КБ и примерно 3 МБ значит E-L2 ≈ 4 МБ, что подходит к A15–A18 Pro.
- Абсолютные нс/эл при userInitiated почти совпадают с M2 Pro: 19,6 против 19,6 на 512K. По ним поколение не определить: нагрузка упирается в память, а не в частоту.
- **Вывод:** скорее всего A16, A17 Pro или A18 Pro (iPhone 14 Pro … 16 Pro). Это гипотеза, её надо проверить.

### 8.2 Почему модель обязательна

1. Размеры кэшей зависят от чипа: у A15 P-L2 12 МБ, у A18 Pro 16 МБ. Именно от них зависит, где у unordered_set «ступенька».
2. Политика «utility → E» — это решение закрытого CLPC, а не закон ядра (§1.1). Она может различаться между поколениями устройств и версиями iOS.
3. У новых Mac (M5 Pro и Max) E-ядер нет вообще (§1.1ж), так что «Apple Silicon» — не одна платформа.
4. Воспроизводимость: вы зовёте зал «собрать на своём телефоне», и первое, о чём спросят, — модель.
5. Без модели и версии iOS цифры со слайдов qos, cores, flip и systems нельзя проверить. Это противоречит вашему же чек-листу (пункт 7).

### 8.3 Шаблон сноски

> iPhone 16 Pro (iPhone17,1, A18 Pro: 2P + 4E; L2 P 16 МБ / E 4 МБ по sysctl) · iOS 27.0.1 · Xcode 27.0 / Apple clang 21.0.0 · Low Power Mode off · заряд 40–80%, без кабеля · thermalState nominal

Модель и чип здесь условные: подставьте свои. Соответствие идентификаторов моделям (по памяти, не проверено): iPhone14,5 — 13; iPhone15,2 — 14 Pro; iPhone15,4 — 15; iPhone16,1 — 15 Pro; iPhone17,1 — 16 Pro; iPhone17,3 — 16; iPhone18,x — 17-я серия. Сверяйте по `hw.machine`.

### 8.4 Код «паспорта устройства» для DedupBench

```swift
import Foundation
import UIKit

func sysctlString(_ name: String) -> String {
    var size = 0
    guard sysctlbyname(name, nil, &size, nil, 0) == 0, size > 0 else { return "n/a" }
    var buf = [CChar](repeating: 0, count: size)
    guard sysctlbyname(name, &buf, &size, nil, 0) == 0 else { return "n/a" }
    return String(cString: buf)
}
func sysctlInt(_ name: String) -> Int64 {
    var v: Int64 = 0; var size = MemoryLayout<Int64>.size
    // часть ключей 32-битные: читаем в 64-битный буфер и берём фактический размер
    guard sysctlbyname(name, &v, &size, nil, 0) == 0 else { return -1 }
    return size == 4 ? Int64(Int32(truncatingIfNeeded: v)) : v
}

func devicePassport() -> String {
    var lines = [
        "hw.machine=\(sysctlString("hw.machine"))",
        "os=\(ProcessInfo.processInfo.operatingSystemVersionString) build=\(sysctlString("kern.osversion"))",
        "kern.sched=\(sysctlString("kern.sched"))",
        "hw.nperflevels=\(sysctlInt("hw.nperflevels")) hw.cachelinesize=\(sysctlInt("hw.cachelinesize"))",
    ]
    for p in 0..<Int(max(sysctlInt("hw.nperflevels"), 1)) {
        let k = "hw.perflevel\(p)"
        lines.append("\(k): name=\(sysctlString(k + ".name")) cpus=\(sysctlInt(k + ".physicalcpu")) " +
                     "l1d=\(sysctlInt(k + ".l1dcachesize")) l2=\(sysctlInt(k + ".l2cachesize")) cpusperl2=\(sysctlInt(k + ".cpusperl2"))")
    }
    UIDevice.current.isBatteryMonitoringEnabled = true
    lines.append("thermal=\(ProcessInfo.processInfo.thermalState.rawValue) lowPower=\(ProcessInfo.processInfo.isLowPowerModeEnabled) " +
                 "battery=\(UIDevice.current.batteryLevel) state=\(UIDevice.current.batteryState.rawValue) qos_self=\(qos_class_self().rawValue)")
    return lines.joined(separator: "\n")
}
```

Логировать в начале **и в конце** каждой серии. Если `kern.sched` или `hw.perflevel*` вернут n/a, это тоже результат: песочница iOS закрыла ключ.

---

## 9. Попутная находка по libc++ на Apple: деление и маска в хеш-таблице

Слайд hashtable: «libc++: число ячеек не степень двойки → номер ячейки через целочисленное деление, на ARM оно не бесплатно».

Исходники ([`__hash_table`, main](https://github.com/llvm/llvm-project/blob/main/libcxx/include/__hash_table)):
- `__constrain_hash`: `return !(__bc & (__bc - 1)) ? __h & (__bc - 1) : (__h < __bc ? __h : __h % __bc);` — при числе ячеек-степени двойки берётся **маска**.
- `unordered_set::reserve(n)` → `__reserve_unique(n)` → `__rehash_unique(ceil(n / max_load_factor()))`. Внутри `__rehash`: `if (__n == 1) __n = 2; else if (__n & (__n - 1)) __n = std::__next_prime(__n);`. **Степень двойки остаётся степенью двойки.**
- Рост без reserve: `2 * __bc + !__is_hash_power2(__bc)` → следующее простое.

**Вывод.** В ваших сериях N = 2^k и есть `reserve(N)`, поэтому ячеек ровно 2^k, и номер ячейки считается маской, **без деления**. Утверждение слайда верно для таблицы, которая растёт без reserve (диф со слайда diff), и для N, не равного степени двойки.

При тождественном `std::hash` для целых и маске по младшим битам есть и практическое последствие. Id, кратные большой степени двойки, например со «сдвинутыми» младшими битами, дадут длинные цепочки. Совет из заметок «проверьте гистограмму цепочек» становится особенно уместным.

**Формулировка:**
> «libc++ после роста без reserve держит простое число ячеек и считает номер ячейки делением — на ARM это не бесплатно; с reserve под степень двойки деление заменяется маской».

---

## 10. Сводный список правок по слайдам

1. **qos**, сноска и заметки: заменить цитату sched_amp_common.c на цитату Edge из sched_clutch.c (§1.6). «Apple: QoS "to influence placement of threads on P or E cores" (Apple Developer, 2020)». Подавать как наблюдение на конкретном iPhone.
2. **qos**, заметки: «а в Xcode вы бы этого не увидели» → «а на Mac и в CI вы бы этого не увидели». С устройства через Xcode эффект как раз виден.
3. **cores**: на график iPhone — пунктиры из sysctl **этого** iPhone; в сноску — модель, чип и iOS.
4. **memory**: «~1 / ~5 / ~100 нс» заменить своими значениями со слайда cores (userInitiated, M2 Pro) или сослаться на Apple (WWDC25: промах мимо кэшей «в 50 раз медленнее»). «128 байт — hw.cachelinesize».
5. **cachecost**: пересчитать арифметику: 32·U + 8·N → 12 МиБ / 24 МиБ (§3.3). SLC 24 МБ пометить «по обзорам» или убрать.
6. **allocs**: «виджет или share extension» → «Notification Service Extension (~24 МБ) или виджет (~30 МБ)». В заметках: «записать заголовок» → «обновить метаданные»; добавить «у Apple free ещё и обнуляет блок».
7. **case**: «Task с qos .utility» → «`Task(priority: .utility)`».
8. **flip**: «Mac · CI-раннер M2 Pro» → «Mac разработчика (M2 Pro)» + сноска о GitHub-hosted VM (M1, 3 vCPU, hw.nperflevels = 1).
9. **result / systems**: «Apple clang 21» → «Xcode 27.0 / Apple clang 21.0.0»; добавить версию iOS.
10. **hashtable**: уточнить про деление: только без reserve или при N, не равном степени двойки (§9).
11. **checklist**: пункт 6 → «версия компилятора, библиотеки **и ОС**»; пункт 7 → добавить «Low Power Mode».
12. **systems (backup) / learned**: у M2 Pro Linux VM добавить сноску «тип ядра под vCPU не контролировался».

---

## 11. Источники

**Исходники Apple (GitHub apple-oss-distributions, тег xnu-12377.121.6 и др.):**
- XNU: `osfmk/kern/sched_amp_common.c`, `sched_clutch.c`, `sched.h`, `processor.c`, `thread_policy.c`, `task_policy.c`; `bsd/kern/kern_mib.c`, `kern_sysctl.c`; `pexpert/pexpert/arm64/board_config.h`, `VMAPPLE.h`; `osfmk/arm/cpu_affinity.h`; `doc/scheduler/sched_clutch_edge.md`; `config/MASTER.arm64.*`. Для истории сравнивались теги xnu-7195.141.2, 8792.81.2, 10002.81.5, 11215.81.4 и 11417.140.69 (`sched.h`, `sched_clutch.c`, `sched_amp_common.c`).
- libmalloc-812.100.31: `src/nano_zone_common.h`, `thresholds.h`, `magazine_zone.h`, `platform.h`, `malloc_config.c`, `xzone_malloc/*`, `doc/xzone_malloc.md`.
- libpthread: `include/sys/qos.h`.

**Документация и видео Apple (developer.apple.com):**
- Tuning your code's performance for Apple silicon;
- Apple Developer News «Optimize for Apple Silicon with performance and efficiency cores» (22.06.2020);
- WWDC20 10686; Tech Talk 110147; WWDC25 227, 308;
- Energy Efficiency Guide for iOS Apps (QoS, Low Power Mode) и для Mac (QoS);
- DispatchQoS; QualityOfService; TaskPriority; ProcessInfo.ThermalState (+ nominal, fair, serious, critical); isLowPowerModeEnabled;
- Determining system capabilities (sysctl); sysctlbyname;
- BGTaskScheduler, BGAppRefreshTask, BGProcessingTask, BGContinuedProcessingTask, register(…); Choosing Background Strategies; Performing long-running tasks;
- App Extension Programming Guide; Identifying high-memory use with jetsam event reports; os_proc_available_memory;
- Apple Silicon CPU Optimization Guide: только описание, сам гайд требует входа;
- Developer Releases RSS.
- Форумы Apple: 740332, 713561, 804378, 703361 (через WebFetch).

**Прочее (GitHub):**
- swiftlang/swift: `Task.swift`, `DispatchGlobalExecutor.cpp`;
- llvm/llvm-project libcxx: `__algorithm/sort.h`, `src/algorithm.cpp`, `__hash_table`, `unordered_set`;
- actions/runner-images: README и README образов macOS, скрипт отчёта;
- github/docs: `supported-github-runners.md`, `larger-runners-table.md`, `macos-runner-limitations.md`;
- yorickdowne/get-macos-runner-hardware PR #1;
- mroth/xpe (sysctl M2 Pro); timb-machine-mirrors/dmaynor-apple-vuln-research (sysctl A18 Pro); gist chockenberry (M4 Max, M5);
- feedback-assistant/reports #177; vector-im/riot-ios #2341; uzairansaruzi/hermex #682; facebook/react-native #31910;
- результат поиска кода: baozzz1/coreml-disassembler (строки hw.perflevel в libBLAS iOS).

**Только по сниппетам поиска (страницы заблокированы):** eclecticlight.co (Howard Oakley): «Tune for Performance: Core types» (2024), «What is Quality of Service…» (2025), «macOS has different strategies for M1 cores» (2022), «Running tasks on E cores can use a third of the energy of P cores» (2022).
