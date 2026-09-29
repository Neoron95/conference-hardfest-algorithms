# За пределами C++/iOS: насколько выводы доклада «O(n) проиграл O(n log n)» обобщаются

Дата: 29.09.2026. Задача: проверить, переносятся ли выводы доклада на Android, JVM/Kotlin, Swift, Go/Rust/Java/C#/Python, гибридные x86 и облачные серверы. Дать факты со ссылками и готовые формулировки для сцены и ответов на вопросы.

**Не дублирую** уже готовое: Apple QoS/XNU Edge/CLPC (`apple.md` §1), Swift `Set` в общих чертах (`cpp.md` §10, `priorart.md` §4.7), Jetpack Microbenchmark (`priorart.md` §4.8), аудитория HardFest (`conf.md` §6, §9).

**Пометки.** [О] — источник открыт и прочитан (ссылка на файл/коммит). [С] — только сниппет поиска. [П] — по памяти, не проверено. [А] — мой анализ/вывод.

**Статус:** все разделы готовы (29.09.2026). Собственных замеров на Android/JVM/Swift нет — только исходники политик и контейнеров.

## 0. Главное (TL;DR)

1. **Android — да, фон тоже уезжает на слабые ядра, но механизм другой.** Решает **состояние процесса** (приложение не на экране → cpuset `background`), а не пометка потока. Pixel 8/9 (Tensor G3/G4): `background` = cpu0–3, только маленькие ядра, плюс `uclamp_max 130/1024`. Snapdragon 8 Gen 3: маленькие A520 + младшие A720. Snapdragon 8 Elite: маленьких нет, фон просто не пускают на prime. В AOSP по умолчанию `background` = все ядра, списки пишет вендор. JobScheduler/WorkManager поднимает процесс с `BIND_NOT_FOREGROUND` («for CPU scheduling purposes it may be left in the background»). `THREAD_PRIORITY_BACKGROUND` с Android 13 меняет только nice. Jetpack Microbenchmark меряет в top-app с nice −20, то есть на больших ядрах. (§1)
2. **JVM/Kotlin — раунд 1 доклада там острее.** `HashSet<Long>` = `HashMap.Node` + боксинг `Long` → два объекта на id (~60 Б против 8 Б в `long[]`). Kotlin `distinct()` (и `LongArray.distinct()`) = `LinkedHashSet`. Плоские аналоги: fastutil `LongOpenHashSet`, androidx `MutableLongSet` (порт Abseil). `LongArray.sorted()` боксит, `sort()` — нет. (§2)
3. **Находка для бэкенда:** `Arrays.sort(long[])` в JDK 22+ на x86-Linux — SIMD-интринсика (AVX-512/AVX2, на AMD Zen 4 AVX-512-ветка выключена), на ARM/Graviton — скалярный dual-pivot quicksort. Один код — три алгоритма в зависимости от CPU. Go подбирает порог хеша «Measured on AMD Ryzen Threadripper PRO 7995WX (Zen4)» / «Measured on Apple M1». (§2.3, §4)
4. **Swift `Set` уже плоский** (линейное пробирование, битовая карта, load 3/4), но хеш — SipHash-1-3 со случайным сидом: 5 раундов на `UInt64`. Таблица на 2^20 — 16 МБ, больше L2 E-кластера. `sort()` — стабильный Timsort-вариант с Swift 5.0 (гарантия в документации — с 5.8), одна аллокация на N/2. Бенчмарков «Set против sort» для Swift не нашёл. (§3)
5. **Одна строка по языкам:** Go 1.24+ и Rust — Swiss tables; Python и Swift — открытая адресация; C# — цепочки внутри массивов, без аллокации на элемент; Java — узлы + боксинг. (§4)
6. **x86 и облако:** Windows 11 отправляет EcoQoS всегда, а свёрнутые окна и службы — на батарее, на эффективные ядра и прямо предупреждает, что автотесты без ввода искажают результаты. Linux на Intel без HT отдаёт лёгкие задачи E-ядрам. Graviton: vCPU = физическое ядро, L2 1–2 МБ на ядро, AWS пишет, что тесты на низкой нагрузке вводят в заблуждение. (§5)
7. Готовые формулировки: мост для Android (§1.9), для JVM (§2.5), для Swift (§3.5), по языкам (§4), бэкенд-финал (§5.4), слайд «Это не только Apple» (§6.3), карточки ответов (§7).

---

---

## 1. Android: куда уезжает фоновая работа

### 1.1 Как Android решает, на каких ядрах работает процесс: три слоя

1. **cpuset (жёсткая граница, по процессу).** ActivityManager раскладывает процессы приложений по cpuset-группам `top-app`, `foreground`, `foreground_window`, `background`, `system-background`, `restricted`. В AOSP эти группы создаются **пустыми копиями всех CPU**, а реальные списки ядер пишет **вендор**. Комментарий в AOSP `init.rc` [О, [aosp-mirror/platform_system_core@a3b721a, rootdir/init.rc, стр. 310–337](https://github.com/aosp-mirror/platform_system_core/blob/a3b721a32242006b59cb12bd62c9133632af3a2d/rootdir/init.rc#L310-L337)]:
   ```
   # sets up initial cpusets for ActivityManager
   # this ensures that the cpusets are present and usable, but the device's
   # init.rc must actually set the correct cpus
   ...
   # system-background is for system tasks that should only run on
   # little cores, not on bigs
   ```
2. **cpu cgroup (`/dev/cpuctl/*`) и uclamp (мягкие подсказки).** Для «devices using utilclamp» AOSP создаёт те же группы в `cpuctl` [О, init.rc стр. 117–124]. В `task_profiles.json` есть атрибуты `UClampMin`/`UClampMax`/`UClampLatencySensitive` → файлы `cpu.uclamp.min`, `cpu.uclamp.max`, `cpu.uclamp.latency_sensitive` [О, [libprocessgroup/profiles/task_profiles.json, стр. 66–79](https://github.com/aosp-mirror/platform_system_core/blob/a3b721a32242006b59cb12bd62c9133632af3a2d/libprocessgroup/profiles/task_profiles.json#L66-L79)]. uclamp.max ограничивает «сколько производительности» задача может запросить у планировщика и cpufreq; EAS учитывает это при выборе ядра.
3. **Планировщик (EAS в mainline Linux; у Qualcomm — WALT, у Pixel — vendor_sched поверх EAS).** Внутри разрешённого cpuset выбирает ядро по энергомодели и загрузке (utilization). См. §1.4.

**Профили политик** [О, task_profiles.json, AggregateProfiles]:

| Политика (что ставит система) | Из чего состоит |
|---|---|
| `CPUSET_SP_TOP_APP` | `MaxPerformance` (cpu cgroup `top-app`) + `ProcessCapacityMax` (cpuset `top-app`) + `MaxIoPriority` |
| `CPUSET_SP_FOREGROUND` | `HighPerformance` (cpu `foreground`) + `ProcessCapacityHigh` (cpuset `foreground`) |
| `CPUSET_SP_BACKGROUND` | `HighEnergySaving` (cpu `background`) + **`ProcessCapacityLow` (cpuset `background`)** + `LowIoPriority` + `TimerSlackHigh` (40 мс) |
| `CPUSET_SP_SYSTEM` | `ServiceCapacityLow` (cpuset `system-background`) |
| `SCHED_SP_BACKGROUND` (для потока) | `HighEnergySaving` (cpu cgroup `background`) + `LowIoPriority` + `TimerSlackHigh` — **без cpuset** |

Процессная группа ставится через `Process.setProcessGroup()` → JNI `android_os_Process_setProcessGroup` → `SetProcessProfilesCached(uid, pid, {get_cpuset_policy_profile_name(grp)})` [О, [platform_frameworks_base@1cdfff5, core/jni/android_util_Process.cpp, стр. 262–312](https://github.com/aosp-mirror/platform_frameworks_base/blob/1cdfff555f4a21f71ccc978290e2e212e2f8b168/core/jni/android_util_Process.cpp#L262-L312)]. То есть **cpuset назначается процессу целиком** по его состоянию (top/fg/bg), а не потоку.

> Примечание об источниках: зеркало `aosp-mirror` на GitHub заморожено на марте 2025 (main: system_core `a3b721a`, frameworks_base `1cdfff5`). Это Android 16-эпоха; более новые изменения AOSP публикуются иначе. Для Android 16/17 детали могли сдвинуться, общая схема — нет.

### 1.2 Какие ядра получает `background` у реальных устройств [О]

| SoC (телефоны) | Кластеры (по cpufreq policy в том же скрипте) | `top-app` | `foreground` | **`background`** | Источник |
|---|---|---|---|---|---|
| Google Tensor G3, **zuma** (Pixel 8/8 Pro) | cpu0–3 little · cpu4–7 mid · cpu8 big (policy0/4/8) | 0–8 | 0–7 | **0–3 (только little)** | [LineageOS/android_device_google_zuma, lineage-23.0, conf/init.zuma.rc, стр. 672–678](https://github.com/LineageOS/android_device_google_zuma/blob/lineage-23.0/conf/init.zuma.rc#L672-L678) (секция `on property:sys.boot_completed=1`) |
| Google Tensor G4, **zumapro** (Pixel 9) | cpu0–3 little · cpu4–6 mid · cpu7 big (policy0/4/7) | 0–7 | 0–6 | **0–3 (только little)** | [LineageOS/android_device_google_zumapro, lineage-23.0, conf/init.zumapro.soc.rc, стр. 163–169](https://github.com/LineageOS/android_device_google_zumapro/blob/lineage-23.0/conf/init.zumapro.soc.rc#L163-L169) |
| Snapdragon 8 Gen 3, **pineapple** (SM8650) | cpu0–1 A520 · cpu2–4 A720 · cpu5–6 A720 · cpu7 X4 (policy0/2/5/7; вариант `2_3_2_1`) | вся (не переписывается) | вся | **0–1 и 5–6**: два маленьких A520 + пара «младших» A720; без X4 и без старших A720 | [LineageOS/android_device_oneplus_sm8650-common@54444d5, init/init.kernel.post_boot-pineapple_default_2_3_2_1.sh, стр. 215–217](https://github.com/LineageOS/android_device_oneplus_sm8650-common/blob/54444d5137d07998d058e8e89158b51209dcaa91/init/init.kernel.post_boot-pineapple_default_2_3_2_1.sh#L215-L217) |
| Snapdragon 8 Elite, **sun** (SM8750) | cpu0–5 Oryon «performance» · cpu6–7 Oryon «prime» (policy0/6; вариант `6_2`) | вся | вся | **0–5**: маленьких ядер нет вовсе, фон просто не пускают на два prime | [LineageOS/android_device_oneplus_sm8750-common@f87c339, init/init.kernel.post_boot-sun_default_6_2.sh, стр. 176–178](https://github.com/LineageOS/android_device_oneplus_sm8750-common/blob/f87c3392ecd15992bde1405e7b0ee150162734bf/init/init.kernel.post_boot-sun_default_6_2.sh#L176-L178) |

Скрипты Qualcomm — это вендорские `init.kernel.post_boot-*.sh` (копирайт Qualcomm Technologies), лежащие в дереве устройства OnePlus у LineageOS; Pixel-файлы — копии `device/google/zuma*` в LineageOS. Файлы для 8 Gen 3 те же у OnePlus 12, для 8 Elite — у OnePlus 13 [А: у других OEM (Samsung, Xiaomi) могут быть свои правки cpuset — не проверял].

**Pixel дополнительно режет фону потолок производительности** через uclamp.max [О, init.zuma.rc, стр. 681–684; то же для Pixel 9 — [init.zumapro.board.rc, стр. 412–415](https://github.com/LineageOS/android_device_google_zumapro/blob/lineage-23.0/conf/init.zumapro.board.rc#L412-L415), `auto_uclamp_max "130 130 130 130 512 512 512 670"`, `bg/uclamp_max 130`]:
```
# Set uclamp.max for some groups, which could indicate cpu importance used in scheduling
write /proc/vendor_sched/auto_uclamp_max "130 130 130 130 512 512 512 512 670"
write /proc/vendor_sched/groups/bg/uclamp_max 130
write /proc/vendor_sched/groups/sys_bg/uclamp_max 512
```
Шкала uclamp — 0…1024 («Uclamp performance request has the range of 0 to 1024 inclusive», [sched-util-clamp.rst, стр. 330](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/Documentation/scheduler/sched-util-clamp.rst#L330)) [О]; 1024 соответствует самому мощному ядру на максимальной частоте [П]. То есть на Pixel 8 и 9 фоновая группа ограничена ~13% «мощности большого ядра»: это не только маленькие ядра, но и низкие частоты на них. А для top-app/fg/sys на Pixel 9 при загрузке, наоборот, ставится `uclamp_min 190` с комментарием «Set uclamp_min to capacity of little core + 1 to avoid little core» [О, init.zumapro.soc.rc, стр. 22–27] — Google явно уводит передний план **с** маленьких ядер. Это зеркальное отражение того, что Apple делает с BG-QoS.

Qualcomm в тех же скриптах ставит свой губернатор **WALT** (`echo "walt" > .../scaling_governor`, если в ядре есть модуль WALT; иначе ветка `else` ставит `schedutil`) [О, post_boot-pineapple_default_2_3_2_1.sh, стр. 157–160 и 192–196]. То есть на телефонах Qualcomm размещение и частоты решает не «чистый» mainline EAS. Там же настраивается `core_ctl` — механизм Qualcomm, который может «парковать» ядра кластера при низкой загрузке (`/sys/devices/system/cpu/cpu2/core_ctl/busy_up_thres` и т. п., стр. 60–70) [О по файлу; семантика — П].

### 1.3 Кэши типичных Android-ядер [О — upstream DTS Linux]

Из [torvalds/linux@6f8319e, arch/arm64/boot/dts/qcom/sm8650.dtsi](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/arch/arm64/boot/dts/qcom/sm8650.dtsi) (Snapdragon 8 Gen 3):

| Ядро (cpu) | L1D | L2 | L3 (общий) | `capacity-dmips-mhz` (вес для EAS) |
|---|---|---|---|---|
| Cortex-A520 (cpu0–1) | 64 КБ | **512 КБ, общий на пару** (`l2_0`, cpu0 и cpu1 ссылаются на него) | 12 МБ | 1024 |
| Cortex-A720 (cpu2–6) | 64 КБ | 512 КБ на ядро | 12 МБ | 2909 |
| Cortex-X4 (cpu7) | 64 КБ | **2 МБ** | 12 МБ | 3591 |

Строка кэша у ядер Arm Cortex — 64 байта [П; у Apple — 128 Б, см. `apple.md` §2].

[А] Сравнение с доклада: у M2 Pro E-ядро имеет 4 МБ L2 на кластер, P — 16 МБ. У Snapdragon 8 Gen 3 **даже у самого большого ядра всего 2 МБ L2**, а дальше — общий L3 12 МБ. Для 2^20 уникальных ключей узловая таблица (33,6 МБ запрошено по счётчику аллокаций, слайд `allocs`) не влезает никуда ни на каком ядре; порог «влезло/не влезло» на Android будет **ниже**, чем на Mac, и сдвинется при переезде в `background` (там на 8 Gen 3 остаются ядра с 512 КБ L2, на Pixel — little-кластер).

Остальные SoC:

| SoC | Ядра | Кэши | Статус |
|---|---|---|---|
| Snapdragon 8 Elite (SM8750) | 2 кластера Oryon: cpu0–5 и cpu6–7, **у каждого кластера один общий L2** (`l2_0` для cpu0–5, `l2_1` для cpu6–7) | L2 12 МБ на кластер; L1D 96 КБ, L1I 192 КБ | топология [О, [linux sm8750.dtsi](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/arch/arm64/boot/dts/qcom/sm8750.dtsi), размеры в DTS не указаны]; размеры [С: HotHardware, Android Authority deep dive] |
| Tensor G3 (Pixel 8) | 1× Cortex-X3 2,91 ГГц + 4× A715 2,37 + 4× A510 1,70 | точные размеры L2/L3 не нашёл; у X3 L2 по спецификации Arm 256 КБ–1 МБ, у A715 128–512 КБ | [С: Android Authority, Wikipedia] |
| Tensor G4 (Pixel 9) | 1× Cortex-X4 3,1 ГГц + 3× A720 2,6 + 4× A520 1,92 | не нашёл | [С: Android Central] |

[А] Важное отличие 8 Elite: маленьких ядер нет, но фон всё равно не пускают на prime-кластер, а L2 у обоих кластеров одинаковый (12 МБ). Значит, на 8 Elite **переезд в background почти не меняет «лестницу памяти»**, меняет только частоту/uclamp. На Pixel и 8 Gen 3 — меняет сильно. Для доклада это аргумент «проверьте, какое ядро досталось»: даже внутри Android ответ зависит от SoC.

На Android размеры кэшей часто можно прочитать без root: `/sys/devices/system/cpu/cpuN/cache/indexK/size` (заполняется из DT/ACPI, на части вендорских ядер пусто) [П — проверить на устройстве], а ёмкости ядер для EAS — `/sys/devices/system/cpu/cpuN/cpu_capacity` [П].

### 1.4 EAS и uclamp: что говорит документация ядра [О]

- [Documentation/scheduler/sched-energy.rst](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/Documentation/scheduler/sched-energy.rst): «EAS operates only on heterogeneous CPU topologies (such as Arm big.LITTLE)»; «Big CPUs are generally more power hungry than the little ones and are thus used mainly when a task doesn't fit the littles». Решение принимает `find_energy_efficient_cpu()` по энергомодели и PELT-загрузке задачи.
- [Documentation/scheduler/sched-util-clamp.rst, стр. 56–76](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/Documentation/scheduler/sched-util-clamp.rst#L56-L76) — прямо про Android:
  > «Another example is in Android where tasks are classified as background, foreground, top-app, etc. Util clamp can be used to constrain how much resources background tasks are consuming by capping the performance point they can run at… the constraint will help bias the background tasks to stay on the little cores».
  Шкала uclamp — 0…1024 («Uclamp performance request has the range of 0 to 1024 inclusive», стр. 330).

[А] Отсюда следствие для коротких задач: EAS решает по **накопленной загрузке** задачи (PELT, «разгоняется» за десятки мс). Короткий CPU-bound всплеск (наша дедупликация — десятки мс) может целиком отработать на том ядре, где проснулся поток, и не успеть «вырасти» до большого. Pixel явно задаёт скорость этого «разгона» (`write /proc/sys/kernel/sched_pelt_multiplier 1` в `on early-init` init.zuma.rc [О]; 1 — это, насколько помню, штатный полупериод 32 мс, 2 и 4 — ускорение [П]). Для CPU-bound задачи длиной в десятки мс место старта может решить исход — ещё одна причина мерить в целевом режиме.

### 1.5 `Process.THREAD_PRIORITY_BACKGROUND`: что он делает сейчас и что делал раньше [О]

- Константа: `THREAD_PRIORITY_BACKGROUND = 10`, javadoc: «Standard priority background threads. This gives your thread a slightly lower than normal priority, so that it will have less chance of impacting the responsiveness of the user interface» [О, [Process.java, стр. 410–417](https://github.com/aosp-mirror/platform_frameworks_base/blob/1cdfff555f4a21f71ccc978290e2e212e2f8b168/core/java/android/os/Process.java#L410-L417)].
- **Android 10:** `androidSetThreadPriority()` при `pri >= ANDROID_PRIORITY_BACKGROUND` вызывал `set_sched_policy(tid, SP_BACKGROUND)` → профили `HighEnergySaving` + `TimerSlackHigh`, то есть поток переезжал в **cpu cgroup `background`** (schedtune/uclamp-группа), но **не в cpuset** [О, [android-10.0.0_r1 libutils/Threads.cpp, стр. 299–321](https://github.com/aosp-mirror/platform_system_core/blob/android-10.0.0_r1/libutils/Threads.cpp#L299-L321); [libprocessgroup/sched_policy.cpp, стр. 134–148](https://github.com/aosp-mirror/platform_system_core/blob/android-10.0.0_r1/libprocessgroup/sched_policy.cpp#L134-L148)].
- **Android 11–12:** то же через `SetTaskProfiles(tid, {"SCHED_SP_BACKGROUND"})` [О, android-11.0.0_r1 и android-12.0.0_r1, Threads.cpp стр. 305–317].
- **Android 13 и новее:** `androidSetThreadPriority()` делает **только `setpriority()`** (nice), без смены групп [О, android-13.0.0_r1, 14.0.0_r1, 15.0.0_r1, main@a3b721a: [Threads.cpp, стр. 313–324](https://github.com/aosp-mirror/platform_system_core/blob/a3b721a32242006b59cb12bd62c9133632af3a2d/libutils/Threads.cpp#L313-L324)].

[А] **Вывод: на современном Android приоритет потока — это не QoS в смысле Apple.** `THREAD_PRIORITY_BACKGROUND` меняет долю CPU при конкуренции (вес CFS), но сам по себе поток на маленькие ядра не отправляет. На маленькие ядра отправляет **состояние процесса** (приложение не на экране → cpuset `background`) плюс uclamp-группа и EAS.

### 1.6 WorkManager и JobScheduler: куда попадает работа [О]

- **WorkManager** (androidx main @ [f268793](https://github.com/androidx/androidx/tree/f268793871aa2dd32ba792e587a5b4ff0f703eb1/work/work-runtime/src/main/java/androidx/work)) на всех поддерживаемых API планирует через `SystemJobScheduler` → `SystemJobService` (JobScheduler) (`Schedulers.createBestAvailableBackgroundScheduler`, [impl/Schedulers.java, стр. 283–295](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/work/work-runtime/src/main/java/androidx/work/impl/Schedulers.java#L283-L295)). Исполнитель по умолчанию — `Dispatchers.Default.limitedParallelism(max(1, min(nCPU − 1, 4)))`, `CoroutineWorker` — на `Dispatchers.Default` ([Configuration.kt, стр. 220–242, 764–770](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/work/work-runtime/src/main/java/androidx/work/Configuration.kt#L220-L242)). **Приоритет потока WorkManager не понижает** — поток обычный, куда он попадёт, решает группа процесса.
- **JobScheduler** привязывается к `JobService` приложения с флагами [О, [JobServiceContext.java, стр. 425–446](https://github.com/aosp-mirror/platform_frameworks_base/blob/1cdfff555f4a21f71ccc978290e2e212e2f8b168/apex/jobscheduler/service/java/com/android/server/job/JobServiceContext.java#L425-L446)]:
  - обычная задача: `BIND_NOT_FOREGROUND | BIND_NOT_PERCEPTIBLE`;
  - expedited: `BIND_NOT_FOREGROUND | BIND_ALMOST_PERCEPTIBLE`;
  - user-initiated (Android 14+), если пользователь не ограничил фон: `BIND_ALMOST_PERCEPTIBLE` без `BIND_NOT_FOREGROUND`.
- Смысл `BIND_NOT_FOREGROUND` из javadoc [О, [Context.java, стр. 419–429](https://github.com/aosp-mirror/platform_frameworks_base/blob/1cdfff555f4a21f71ccc978290e2e212e2f8b168/core/java/android/content/Context.java#L419-L429)]: «don't allow this binding to raise the target service's process to the foreground scheduling priority… **for CPU scheduling purposes it may be left in the background**». В `OomAdjuster` группа планирования клиента передаётся сервису только если `BIND_NOT_FOREGROUND` не стоит [О, [OomAdjuster.java, стр. 2967–2978](https://github.com/aosp-mirror/platform_frameworks_base/blob/1cdfff555f4a21f71ccc978290e2e212e2f8b168/services/core/java/com/android/server/am/OomAdjuster.java#L2967-L2978)].

[А] Итого: **периодическая или отложенная синхронизация через WorkManager при закрытом приложении** работает в процессе с `SCHED_GROUP_BACKGROUND` → `CPUSET_SP_BACKGROUND` → на Pixel 8/9 только cpu0–3 (little) с uclamp.max 130/1024, на 8 Gen 3 — A520 + младшие A720, на 8 Elite — без prime-кластера. Та же синхронизация, запущенная **при открытом приложении** (top-app), получает все ядра, даже если поток «фоновый» — потому что cpuset на Android назначается процессу, а не потоку. Исключения: foreground service / long-running worker через `setForeground()` и user-initiated jobs — они поднимают процесс выше background [П: точная группа зависит от версии Android].

### 1.7 Jetpack Microbenchmark измеряет «лучший случай» [О]

- `ThreadPriority.bumpCurrentThreadPriority()` ставит потоку бенчмарка nice **−20** (`HIGH_PRIORITY = -20`, `BENCH_THREAD_PRIORITY = HIGH_PRIORITY`) [О, [androidx benchmark-common ThreadPriority.kt, стр. 26–40](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/benchmark/benchmark-common/src/main/java/androidx/benchmark/ThreadPriority.kt#L26-L40)].
- Бенчмарк запускается поверх `IsolationActivity`, среди причин прямо названо: «running in background (**some cores may be foreground-app only**)» [О, [IsolationActivity.kt, стр. 34–43](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/benchmark/benchmark-common/src/main/java/androidx/benchmark/IsolationActivity.kt#L34-L43)].

[А] Это точный аналог слайда `flip`: стандартный инструмент Google для Android-микробенчмарков **сознательно** меряет в top-app с максимальным приоритетом, то есть на больших ядрах. Работа из WorkManager при закрытом приложении так никогда не живёт. Правильно для стабильности замера, но это не то ядро, которое достанется вашему коду в фоне.

### 1.8 NDK = libc++ [О]

- **Подтверждает строку backup-слайда `stdlib`** («macOS, iOS и Android NDK используют libc++»; `cpp.md` §13 держал это как «по памяти»).
- NDK r18: «GCC has been removed», «gnustl, gabi++, and stlport have been removed» [О, [android/ndk.wiki@fbb3b72, Changelogs/Changelog-r18.md, стр. 14–21](https://github.com/android/ndk/wiki/Changelog-r18)] → единственная STL в NDK — libc++.
- NDK r26: «The NDK's libc++ now comes directly from our LLVM toolchain, so every future LLVM update is also a libc++ update» [О, Changelog-r26.md, стр. 18–20]. r30 — clang-r574158c [О, Changelog-r30.md, стр. 19].
- [А + П] Отличие от iOS (`cpp.md` §4.4: на iOS `std::sort<uint64_t>` берётся из **системной** libc++.dylib): на Android libc++ поставляется **внутри APK** (`libc++_shared.so`) или линкуется статически, поэтому поведение `std::sort`/`unordered_set` определяется **версией NDK**, а не версией Android. `unordered_set` в NDK — тот же узловой libc++-вариант (узел 24 Б, `cpp.md` §2), что и на iPhone.

### 1.9 Можно ли сказать «на Android фоновая работа тоже уедет на маленькие ядра»?

**Да, с тремя оговорками** [А на основе §1.1–1.6]:
1. **Решает состояние процесса, а не пометка потока.** Фон = приложение не на экране (WorkManager/JobScheduler при закрытом приложении, cpuset `background`). Фоновый поток в открытом приложении живёт в top-app и может попасть на любые ядра. На iOS наоборот: QoS помечает сам поток.
2. **Что такое «маленькие» — решает вендор.** Pixel 8/9: только little (cpu0–3) + uclamp.max 130. Snapdragon 8 Gen 3: little + младшие A720. Snapdragon 8 Elite: маленьких нет, фон просто без prime. В AOSP по умолчанию cpuset `background` = все ядра.
3. **Это политика, а не гарантия, и её меняют OEM и версии Android.** В Android 10–12 `THREAD_PRIORITY_BACKGROUND` двигал поток в cpu-группу background, с Android 13 — только nice.

**Формулировка для сцены (15 секунд):**
> «На Android механизм другой, эффект похожий. Там решает не пометка потока, а состояние процесса: когда приложение не на экране, его процесс целиком переезжает в cpuset background. На Pixel 8 и 9 это только четыре маленьких ядра, на Snapdragon 8 Gen 3 — маленькие плюс младшие средние. Синк через WorkManager при закрытом приложении живёт именно там. А Jetpack Microbenchmark меряет на переднем плане с максимальным приоритетом — то есть на больших ядрах».

**Ответ на вопрос «А на Android?» (30 секунд):**
> «Сам не мерил, поэтому цифр не назову. Но механизм проверил по исходникам. В AOSP есть cpuset `background`, и вендоры кладут в него слабые ядра: у Pixel 8 и 9 это cpu 0–3, маленькие, плюс ограничение производительности uclamp до 13 процентов. У Snapdragon 8 Gen 3 — маленькие и младшие средние. JobScheduler поднимает процесс для задачи с флагом BIND_NOT_FOREGROUND — "для планирования CPU может остаться в фоне". Так что WorkManager-синк при закрытом приложении — прямой аналог моего `.utility` на iPhone. Отличие одно: на Android это свойство процесса, а не потока. И кэши там меньше — у Cortex-X4 в 8 Gen 3 всего 2 МБ L2, так что ступенька будет раньше».

---
## 2. JVM и Kotlin: тот же выбор, только узлы ещё дороже

Источники: OpenJDK master @ [fec788e](https://github.com/openjdk/jdk/tree/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b) (29.09.2026), Kotlin stdlib master @ [1d1310c](https://github.com/JetBrains/kotlin/tree/1d1310c2d8f32424f47f79a821203255aecffb6f/libraries/stdlib), fastutil @ [cbf3c2e](https://github.com/vigna/fastutil/tree/cbf3c2ec706d16c56e6896b13ef0b5361be981c8), androidx main @ f268793.

### 2.1 `HashSet<Long>` — это `unordered_set` плюс боксинг [О]

- `HashSet` внутри — `HashMap<E,Object>` с фиктивным значением `PRESENT`; `add(e)` = `map.put(e, PRESENT)==null` [О, [HashSet.java, стр. 97–107, 230](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/java.base/share/classes/java/util/HashSet.java#L97-L107)].
- `HashMap` — корзины с цепочками узлов: `static class Node<K,V> { final int hash; final K key; V value; Node<K,V> next; }` [О, [HashMap.java, стр. 281–285](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/java.base/share/classes/java/util/HashMap.java#L281-L285)]; load factor 0,75 (стр. 250); цепочка длиной ≥ 8 превращается в красно-чёрное дерево `TreeNode` (`TREEIFY_THRESHOLD = 8`, стр. 260). То есть это **ровно узловая схема со слайда `hashtable`**, один объект-узел на ключ.
- Ключ `long` в `HashSet<Long>` ещё и **боксится**: `Long.valueOf(l)` кэширует только −128…127, иначе `return new Long(l)` [О, [Long.java, стр. 993–999](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/java.base/share/classes/java/lang/Long.java#L993-L999)]. 64-битные id почти никогда не попадают в кэш → **два объекта на уникальный ключ**: `Long` и `HashMap.Node`, и оба — отдельные аллокации, разбросанные по куче (в TLAB подряд, но после GC-перемещения порядок уже не гарантирован [П]).
- Хеш: `Long.hashCode(v) = (int)(v ^ (v >>> 32))` (стр. 1232–1234), в `HashMap.hash()` ещё `h ^ (h >>> 16)` (стр. 336–338), индекс — маска по степени двойки. Дешёвый хешер, как `std::hash` в libstdc++/libc++ — та же оговорка про последовательные id (`cpp.md` §6).

**Байты на ключ** [А, расчёт по стандартной раскладке HotSpot 64-бит со сжатыми указателями, заголовок 12 Б, выравнивание 8 Б; проверять JOL]:

| Структура | На уникальный ключ |
|---|---|
| `long[]` (для sort) | 8 Б |
| `HashSet<Long>`: `Long` 24 Б + `HashMap.Node` 32 Б + слот таблицы 4 Б (таблица — степень двойки ≥ N/0,75) | **≈ 61–64 Б и 2 аллокации** |
| `LinkedHashSet<Long>`: `Long` 24 Б + `LinkedHashMap.Entry` 40 Б (+`before`, `after`) + слот | **≈ 69 Б и 2 аллокации** |
| fastutil `LongOpenHashSet`: `long` в `long[]`, ёмкость — степень двойки ≥ N/0,75 | ≈ 11–16 Б (для 2^20 ключей — 2^21 слотов = 16 Б), 0 аллокаций на ключ |

С компактными заголовками (JEP 450/519, JDK 24+/25, флаг `-XX:+UseCompactObjectHeaders`) объекты станут на 4–8 Б меньше [П], но **число объектов и прыжков по указателям не меняется**. На Android (ART) заголовок объекта 8 Б [П], арифметика близкая.

[А] Для сравнения: у libc++ `unordered_set<uint64_t>` в докладе ~32–40 Б и одна аллокация на ключ (`apple.md` §3.3). **JVM-вариант той же строчки хуже по обоим параметрам**, и к этому добавляется работа GC: миллион короткоживущих объектов попадает в young generation; при `-Xmx` впритык или на Android это ещё и паузы/давление на память.

### 2.2 Kotlin `distinct()` — это `LinkedHashSet` [О]

- `Iterable<T>.distinct() = this.toMutableSet().toList()`, где `toMutableSet()` = `LinkedHashSet(this)` [О, [_Collections.kt, стр. 1841–1843, 1910–1915](https://github.com/JetBrains/kotlin/blob/1d1310c2d8f32424f47f79a821203255aecffb6f/libraries/stdlib/common/src/generated/_Collections.kt#L1841-L1843)].
- **`LongArray.distinct()` — тоже**: `toCollection(LinkedHashSet<Long>(mapCapacity(size)))` → боксинг каждого элемента, `LinkedHashMap.Entry` на каждый уникальный, а на выходе `List<Long>` (снова объекты) [О, [_Arrays.kt, стр. 13414–13416, 13955–13957](https://github.com/JetBrains/kotlin/blob/1d1310c2d8f32424f47f79a821203255aecffb6f/libraries/stdlib/common/src/generated/_Arrays.kt#L13414-L13416)].
- Плюс: `distinct()` по контракту сохраняет **порядок первого появления** (javadoc: «The elements in the resulting list are in the same order as they were in the source collection»). То есть Kotlin по умолчанию выбирает строку 3 из слайда `outcontract` — самый дорогой для сортировки контракт, где хеш и должен выигрывать.
- `LongArray.sort()` на JVM → `java.util.Arrays.sort(this)` — примитивная сортировка на месте [О, [_ArraysJvm.kt, стр. 1979–1981](https://github.com/JetBrains/kotlin/blob/1d1310c2d8f32424f47f79a821203255aecffb6f/libraries/stdlib/jvm/src/generated/_ArraysJvm.kt#L1979-L1981)]. **Ловушка:** `LongArray.sorted()` = `toTypedArray().apply { sort() }.asList()` — боксит всё в `Array<Long>` и сортирует объекты [О, _Arrays.kt, стр. 7535–7537]. `ids.sorted().distinct()` на `LongArray` — это два раунда боксинга.

**Идиома «как sort + unique» на Kotlin:** `ids.sort()` (на месте), затем один проход с записью уникальных в тот же `LongArray` и `copyOf(n)`. Ни одного объекта.

### 2.3 `Arrays.sort(long[])` — DualPivotQuicksort, и на x86 он может быть SIMD [О]

- `java.util.DualPivotQuicksort` (Ярославский, Бентли, Блох; `@version 2018.08.18`): двухопорный quicksort + insertion sort на малых кусках (< 44/65), **распознавание и слияние уже упорядоченных серий** (`tryMergeRuns`), heapsort при деградации, параллельная версия от 4096 элементов (`MIN_PARALLEL_SORT_SIZE = 4 << 10`) [О, [DualPivotQuicksort.java, стр. 34–50, 64–74, 1032–1095](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/java.base/share/classes/java/util/DualPivotQuicksort.java#L1032-L1095)]. Как и libc++ (`cpp.md` §4.2), Java отлично обрабатывает почти отсортированный вход — к слайду `inputorder`.
- Методы сортировки и разбиения помечены `@IntrinsicCandidate` (стр. 154, 192). На **x86-64 Linux** HotSpot подгружает `libsimdsort` (порт Intel x86-simd-sort) и подменяет их на `avx512_sort`/`avx2_sort` [О, [stubGenerator_x86_64.cpp, стр. 5172–5191](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/hotspot/cpu/x86/stubGenerator_x86_64.cpp#L5172-L5191)]. Исходники библиотеки лежат в `src/java.base/linux/native/libsimdsort/` — только Linux [О, путь существует; «только Linux» — вывод по пути, П].
- История [О, по тегам]: в `jdk-21-ga` интринсика нет; в `jdk-22-ga` — только `is_intel() && supports_avx512dq()`; с `jdk-23-ga` — также AVX2.
- **AVX-512-версия выключена на AMD Zen 4** [О, [vm_version_x86.hpp, стр. 934–943](https://github.com/openjdk/jdk/blob/fec788eccb23b2b48d4aa5be050e322f9a2c0c1b/src/hotspot/cpu/x86/vm_version_x86.hpp#L934-L943)]:
  ```cpp
  static bool supports_avx512_simd_sort() {
    if (supports_avx512dq()) {
      // Disable AVX512 version of SIMD Sort on AMD Zen4 Processors.
      if (is_amd() && cpu_family() == CPU_FAMILY_AMD_19H) {
        return false;
      }
  ```
- В `stubGenerator_aarch64.cpp` `array_sort` не упоминается [О: grep = 0] → на **Graviton/Ampere/Apple Silicon** `Arrays.sort(long[])` — чистый Java DPQS.

[А] **Это лучший пример «алгоритм не выбирал процессор» для бэкенд-зала.** Одна строчка `Arrays.sort(ids)` в Java 23+ исполняет **три разных алгоритма**: AVX-512 SIMD-сортировку на Intel Xeon, AVX2-вариант на AMD Zen 4 (AVX-512-ветку JDK там сознательно выключил) и скалярный dual-pivot quicksort на Graviton. Код не менялся, JDK один. Если CI на Intel, а прод на Graviton — сравнение «sort против HashSet» в CI и в проде может дать разные ответы по построению. Замеров SIMD-sort против DPQS я не делал; JEP/тикеты обещали многократное ускорение [П: JDK-8309130 и сопутствующие, цифры не проверял].

### 2.4 «Плоские» альтернативы на JVM и Android [О]

- **fastutil `LongOpenHashSet`**: ключи в `long[] key`, открытая адресация с **линейным пробированием** `pos = (pos + 1) & mask`, хеш `HashCommon.mix(long)` = умножение на `0x9E3779B97F4A7C15` (золотое сечение) + сдвиги, load factor 0,75 [О, [drv/OpenHashSet.drv, стр. 152, 811–816](https://github.com/vigna/fastutil/blob/cbf3c2ec706d16c56e6896b13ef0b5361be981c8/drv/OpenHashSet.drv#L811-L816); [HashCommon.java, стр. 30, 104–108](https://github.com/vigna/fastutil/blob/cbf3c2ec706d16c56e6896b13ef0b5361be981c8/src/it/unimi/dsi/fastutil/HashCommon.java#L104-L108); Hash.java `DEFAULT_LOAD_FACTOR = .75f`]. `LongLinkedOpenHashSet` хранит порядок вставки **параллельным `long[] link`**, а не узлами (javadoc: «The order is kept by means of a doubly linked list, represented via an array of longs parallel to the table») — плоская замена `LinkedHashSet` для контракта «порядок первого появления».
- **androidx.collection `MutableLongSet`** (Jetpack, Kotlin Multiplatform): комментарий в [ScatterMap.kt, стр. 33–34](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/collection/collection/src/commonMain/kotlin/androidx/collection/ScatterMap.kt#L33-L34) — «A "flat" hash map based on abseil's flat_hash_map»; метаданные — байты, упакованные по 8 в `Long`, группа из **8 слотов** сравнивается одной 64-битной операцией (SWAR, без SIMD), квадратичное пробирование; элементы — `LongArray elements` [О, [LongSet.kt, стр. 150–157](https://github.com/androidx/androidx/blob/f268793871aa2dd32ba792e587a5b4ff0f703eb1/collection/collection/src/commonMain/kotlin/androidx/collection/LongSet.kt#L150-L157)]; хеш — `hashCode` + перемешивание константой MurmurHash (стр. 883–891). **Это прямой аналог `absl::flat_hash_set` для Android-разработчика**, уже в зависимостях у многих (Compose использует androidx.collection [П]).

### 2.5 Одна фраза-мост на JVM

> «На JVM та же развилка, только резче. `HashSet<Long>` — это узловая таблица, где на каждый id два объекта: сам `Long` и узел `HashMap`. Котлиновский `distinct()` — это `LinkedHashSet`, там ещё два указателя на узел. А плоские аналоги есть: fastutil `LongOpenHashSet` на сервере и `MutableLongSet` из androidx.collection на Android — это Swiss table, портированная с Abseil».

Вариант на 10 секунд: **«`HashSet<Long>` на JVM — это `unordered_set` плюс боксинг: два объекта на каждый id. Плоский вариант — fastutil или `MutableLongSet` из androidx».**

---
## 3. Swift: `Set` уже плоский, но с дорогим хешем

Источник: swiftlang/swift main @ [a9c20b8](https://github.com/swiftlang/swift/tree/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core) (29.09.2026) и теги релизов. Общие факты про `Set` уже есть в `cpp.md` §10 и `priorart.md` §4.7 — здесь только то, что добавляет смысла для iOS-части зала.

### 3.1 Что внутри `Set<UInt64>` [О]

- **Открытая адресация, линейное пробирование**: `find` идёт `bucket(wrappedAfter:)`, пока слот занят [О, [NativeSet.swift, стр. 183–196](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/NativeSet.swift#L183-L196)]. Занятость — **битовая карта** `words`, число бакетов — степень двойки, индекс по маске `bucketMask` [О, [HashTable.swift, стр. 27–46](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/HashTable.swift#L27-L46)]. Максимальная загрузка 3/4 (стр. 74–81).
- **Сид на каждую таблицу**, новый при каждом росте: «so that we avoid certain copy operations becoming quadratic» (стр. 108–116). Плюс общий сид процесса `_executionSeed`, инициализируемый при старте [О, [Hasher.swift, стр. 336–350](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/Hasher.swift#L336-L350)].
- **Хешер — SipHash-1-3**: `compress` = 1 раунд на 8-байтное слово, `finalize` = ещё один `compress` + 3 раунда [О, [SipHash.swift, стр. 12, 80–94](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/SipHash.swift#L80-L94)]. Для `UInt64` есть «одноразовый» путь `_rawHashValue(seed:)` → `Hasher._hash(seed:, UInt64)`: **5 SipRound на каждый ключ** [О, [Hasher.swift, стр. 435–440](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/Hasher.swift#L435-L440); IntegerTypes.swift.gyb, стр. 634–636].
- **Для тестов** есть детерминированный режим: «If this is true, the hash seed is not random, and hash tables do not apply per-instance perturbation» (Hasher.swift, стр. 322–327); включается переменной окружения `SWIFT_DETERMINISTIC_HASHING` [П: имя переменной по памяти, в этом файле его нет].

[А] **Что это значит для доклада.** У Swift-разработчика «узловой» проблемы нет: `Set<UInt64>` — одна аллокация под ключи плюс битовая карта, ключи лежат в массиве. Это ближе к `flat_hash_set`, чем к `unordered_set`. Но цена шага переезжает из памяти в хеш: вместо тождественного `std::hash` каждый ключ проходит 5 раундов SipHash, и это последовательная цепочка ARX-операций. На E-ядре с низкой частотой такая арифметика тоже дорожает. Оценка рабочего набора [А]: 2^20 уникальных → 2^21 бакетов × 8 Б = 16 МБ ключей + 256 КБ битовой карты. Это в 1,5–2 раза меньше узловой libc++-таблицы, но всё равно **больше L2 E-кластера (4 МБ) и примерно равно L2 P-кластера M2 Pro (16 МБ)**. Ступенька на кривой, скорее всего, будет и у Swift, только позже и ниже. **Не измерено.**

### 3.2 `sort()` в Swift [О]

- С **Swift 5.0** — адаптивная сортировка слиянием «Timsort, modified to perform a straight merge of the elements using a temporary buffer»; буфер на `count / 2` элементов, серии (`_findNextRun`) + insertion sort для коротких серий [О, [Sort.swift, стр. 655–700](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/Sort.swift#L655-L700)]. В **Swift 4.2** был introsort (`_introSort` в `Sort.swift.gyb`, тег swift-4.2-RELEASE) [О].
- **Стабильность:** реализация стабильна с 5.0, но в документации 5.0–5.7 рядом стояло «not guaranteed to be stable»; начиная с **swift-5.8-RELEASE** в doc-комментариях только «The sorting algorithm is guaranteed to be stable» [О, grep по тегам 5.0/5.5/5.8/5.9/5.10].
- `sort()`/`sorted()` — `@inlinable` → специализируются под `UInt64` **в бинарнике приложения** [О: `@inlinable public func sorted()`, Sort.swift стр. 46–49]. [А] Отличие от C++ на iOS, где `std::sort<uint64_t>` берётся из системной `libc++.dylib` (`cpp.md` §4.4): у Swift поведение сортировки определяет версия Swift-компилятора, с которой собрано приложение, а не версия iOS.
- [А] Отличие от `std::sort`: **одна аллокация** временного буфера на N/2 (у sort + unique в C++ — ноль). Зато Timsort ещё сильнее выигрывает на уже отсортированном входе: весь массив — одна серия, O(n) сравнений (к слайду `inputorder`, для Swift не измерено).

### 3.3 `Array(Set(ids))` как идиома [О]

- `Set.init(_ sequence:)` в **релизах до swift-6.4.0-RELEASE включительно**: `self.init(minimumCapacity: sequence.underestimatedCount)` + `insert` в цикле [О, [swift-6.3-RELEASE Set.swift, стр. 681–693](https://github.com/swiftlang/swift/blob/swift-6.3-RELEASE/stdlib/public/core/Set.swift#L681-L693)]. Для `Array` `underestimatedCount == count`, то есть **таблица резервируется под N** — ровно ситуация со слайда `reserve` (при 1% уникальных таблица в 64 раза больше нужного).
- В `main` уже есть быстрый путь через `withContiguousStorageIfAvailable` → `_NativeSet(buffer)` с `capacity: buffer.count` (снова под N) [О, [main Set.swift, стр. 696–718](https://github.com/swiftlang/swift/blob/a9c20b834abffb4b894b2e55e00273da2664b419/stdlib/public/core/Set.swift#L696-L718); NativeSet.swift стр. 49–58]. В релизы до 6.4.0 не попал (grep = 0).
- Порядок `Array(Set(x))` **случайный и меняется между запусками** (сид процесса + сид таблицы). [А] Это ловушка для снапшот-тестов и для «детерминированного» бенчмарка.
- «Порядок первого появления»: `swift-algorithms` `uniqued()` = `Set` `seen` + `insert(...).inserted` [О, [apple/swift-algorithms@5b7143f, Unique.swift, стр. 39–53](https://github.com/apple/swift-algorithms/blob/5b7143f8e291dee0e14c118fd0212487f0b37af5/Sources/Algorithms/Unique.swift#L39-L53)]; `swift-collections` `OrderedSet` = массив элементов + отдельная хеш-таблица индексов [О, [OrderedSet.swift, стр. 198–209](https://github.com/apple/swift-collections/blob/98ef3c98609a1e31b7e157b5b619579001a789d6/Sources/OrderedCollections/OrderedSet/OrderedSet.swift#L198-L209)] — тоже плоский.

### 3.4 Бенчмарки Swift `Set` против `sort` — не нашёл

Поиск (WebSearch «Swift remove duplicates Array(Set()) vs sorted unique performance benchmark») дал только статьи про идиомы (SwiftLee, Donny Wals, Sarunw) без замеров «Set против sort» [С]. В `swiftlang/swift/benchmark` есть отдельные тесты `Set*` и `Sort*`, но сравнения для дедупликации нет [П]. **Честный ответ: «для Swift не мерил и чужих замеров не нашёл».** Это хороший кандидат для 10-минутного эксперимента (§6).

### 3.5 Что сказать iOS-разработчикам на Swift

> «Если вы пишете на Swift, первая половина доклада про узлы к вам относится меньше: `Set` в Swift — плоская таблица, одна аллокация. Но хеш там SipHash со случайным сидом, пять раундов на каждый `UInt64` — это защита от атак, а не скорость. И таблица на миллион ключей — это 16 мегабайт, больше L2 маленького ядра. Так что четвёртый раунд, про ядро, относится к вам полностью: `Task(priority: .utility)` на iPhone может оказаться на E-ядре. Сравните `Array(Set(ids))` с `ids.sort()` и проходом по соседям на своём телефоне, это десять строк».

Короткий ответ на вопрос «А в Swift?»: **«Swift `Set` — плоский, как Abseil, но с SipHash вместо тождественного хеша. Я его не мерил. Ставлю на то, что он окажется между `flat_hash_set` и `unordered_set`, но это ставка, а не результат».**

---
## 4. Одна строка на каждый язык: узловая или плоская, какой хешер

| Язык / контейнер | Устройство | Хешер для 64-битного целого | Источник |
|---|---|---|---|
| **C++ `std::unordered_set`** (для сравнения) | **узловая**, цепочки, аллокация на ключ | тождество | `cpp.md` §2–3 |
| **Go `map[uint64]struct{}`** (с Go 1.24) | **плоская Swiss table**: группы по 8 слотов + 8-байтное контрольное слово (7 бит H2 на слот), сравнение 8 байт разом без SIMD («With SIMD instructions, this could be extended to 16 slots»); карта — каталог таблиц до 1024 слотов, растёт по таблице | случайный сид **на каждую карту** (`m.seed = uintptr(rand())`); AES-хеш или скалярный — выбирается **по CPU** (см. ниже) | [О, go1.24.md стр. 158–168](https://github.com/golang/website/blob/f2661d967b28530da480f0a1da9a4279026d34ca/_content/doc/go1.24.md#L158-L168): «a new builtin `map` implementation based on Swiss Tables», отключается `GOEXPERIMENT=noswissmap`; [О, internal/runtime/maps/map.go стр. 18–66, 220–221](https://github.com/golang/go/blob/446fdc9760b1b624bc28c40a05c11b0fc30fb300/src/internal/runtime/maps/map.go#L18-L66); group.go `maxAvgGroupLoad = 7`; table.go `maxTableCapacity = 1024` |
| **Rust `std::collections::HashSet`** | **плоская**: hashbrown, «a Rust port of Google's SwissTable», «quadratic probing and SIMD lookup»; группа 16 слотов на x86 (SSE2), **8** на aarch64 (NEON `uint8x8_t`) | **SipHash-1-3** со случайным сидом (`RandomState`) — ради защиты от HashDoS; сам крейт `hashbrown` по умолчанию — **foldhash** («much faster than SipHash») | [О, library/std/src/collections/hash/map.rs стр. 15–31, 59–65](https://github.com/rust-lang/rust/blob/ea6bb45b74c24a026dab4187b1550e97b6985c8a/library/std/src/collections/hash/map.rs#L15-L31); [hash/random.rs стр. 10–41](https://github.com/rust-lang/rust/blob/ea6bb45b74c24a026dab4187b1550e97b6985c8a/library/std/src/hash/random.rs#L10-L41); [hashbrown README стр. 8–32](https://github.com/rust-lang/hashbrown/blob/7109e3a6388b0a6a0e843befc8876864e1d44d2e/README.md); [control/group/mod.rs стр. 8–35](https://github.com/rust-lang/hashbrown/blob/7109e3a6388b0a6a0e843befc8876864e1d44d2e/src/control/group/mod.rs#L8-L35) |
| **Java 21 `HashSet<Long>`** (и новее) | **узловая**: `HashMap.Node` на ключ + **боксинг** `Long`; цепочка ≥ 8 → дерево | `(int)(v ^ v>>>32)`, затем `h ^ h>>>16`; без сида | [О, jdk-21-ga HashMap.java стр. 260, 281](https://github.com/openjdk/jdk/blob/jdk-21-ga/src/java.base/share/classes/java/util/HashMap.java#L281); HashSet.java стр. 97; подробно — §2 |
| **C# `HashSet<long>`** | **гибрид: цепочки, но в массивах** — `int[] _buckets` + `Entry[] _entries`, где `Entry { int HashCode; int Next; T Value; }` (16 Б для `long`), «next» — индекс, а не указатель; **нет аллокации на элемент, нет боксинга** (дженерики по значимым типам специализируются); число бакетов — простое, на 64 бит вместо деления `FastMod` (умножение) | `(int)v ^ (int)(v >> 32)`; без сида | [О, dotnet/runtime HashSet.cs стр. 40–43, 270–280, 1829–1839](https://github.com/dotnet/runtime/blob/72036cabdb35d7201cfe6aac1c63fd5c6d999d48/src/libraries/System.Private.CoreLib/src/System/Collections/Generic/HashSet.cs#L1829-L1839); [Int64.cs стр. 106–109](https://github.com/dotnet/runtime/blob/72036cabdb35d7201cfe6aac1c63fd5c6d999d48/src/libraries/System.Private.CoreLib/src/System/Int64.cs#L106-L109) |
| **Python `set`** | **плоская таблица** `setentry { PyObject *key; Py_hash_t hash; }` (16 Б), открытая адресация: 9 линейных проб (`LINEAR_PROBES 9`, «consecutive memory accesses tend to be much cheaper than scattered probes»), затем псевдослучайные; **но каждый int — объект в куче** (кэш малых чисел только −5…1024 в `main`; в выпущенных версиях, насколько помню, −5…256 [П]) | `hash(int)` = значение по модулю 2^61−1 [П]; без сида для чисел | [О, cpython Objects/setobject.c стр. 10–22, 212–245](https://github.com/python/cpython/blob/a4ad141c55326e5a45a5674adb5a034f5d03c120/Objects/setobject.c#L10-L22); [Include/cpython/setobject.h стр. 20–23](https://github.com/python/cpython/blob/a4ad141c55326e5a45a5674adb5a034f5d03c120/Include/cpython/setobject.h#L20-L23); pycore_runtime_structs.h стр. 97–98 |
| **Swift `Set<UInt64>`** | **плоская**, линейное пробирование, битовая карта занятости | **SipHash-1-3**, сид процесса + сид таблицы | §3 |
| **Kotlin/JVM `distinct()`** | `LinkedHashSet` — узловая + двусвязный список + боксинг | как Java | §2.2 |
| **Android `androidx.collection.MutableLongSet`** | **плоская Swiss table** (порт Abseil), группы по 8, `LongArray` | hashCode + перемешивание MurmurHash-константой | §2.4 |

**Сортировка «рядом» (одна строка):** Java `Arrays.sort(long[])` — dual-pivot quicksort, на x86 Linux JDK 22+ — SIMD-интринсика (§2.3); Swift — Timsort-вариант (§3.2); Python `list.sort` — Timsort со стратегией слияния powersort [О, listobject.c стр. 1745: «node "level" for powersort merge strategy»]; Go `slices.Sort` — pdqsort [П]; Rust `sort_unstable` — ipnsort (потомок pdqsort) с Rust 1.81 [П]; .NET `Array.Sort` — introsort [П].

**Две находки для раздела «алгоритм не выбирал процессор» за пределами C++:**

1. **Go выбирает хеш-функцию по процессору** [О, [internal/runtime/maps/runtime_alg.go](https://github.com/golang/go/blob/446fdc9760b1b624bc28c40a05c11b0fc30fb300/src/internal/runtime/maps/runtime_alg.go), main на 29.09.2026, в релизах код может отличаться]:
   ```go
   // Install AES hash algorithms if the instructions needed are present.
   if (goarch.GOARCH == "386" || goarch.GOARCH == "amd64") &&
       cpu.X86.HasAES && cpu.X86.HasSSSE3 && cpu.X86.HasSSE41 { ... initAlgAES() }
   else if goarch.GOARCH == "arm64" && cpu.ARM64.HasAES { initAlgAES() }
   ...
   func initAlgAES() {
       // TODO(mcy): investigate cutoffs on a per-uarch basis.
       case goarch.AMD64:
           // Measured on AMD Ryzen Threadripper PRO 7995WX (Zen4).
           MinAeshashSize = 9
       case goarch.ARM64:
           // Measured on Apple M1.
           // Latency crossover is at 192.
           MinAeshashSize = 16
   ```
   Порог между скалярным и векторным хешем подобран на одном конкретном процессоре (Zen 4 для x86, M1 для ARM), и в коде стоит TODO «investigate cutoffs on a per-uarch basis». Это та же мысль, что в докладе, только от команды Go: «точка перехода — свойство процессора, на котором её мерили». Для `uint64`-ключей (8 байт < 9 и < 16) используется скалярный хеш на обеих архитектурах.

2. **hashbrown сознательно не использует NEON-ускорение так же, как SSE2**: «I attempted an implementation on ARM using NEON instructions, but it turns out that most NEON instructions have multi-cycle latency, which in the end outweighs any gains over the generic implementation» (комментарий в [control/group/mod.rs, стр. 9–15](https://github.com/rust-lang/hashbrown/blob/7109e3a6388b0a6a0e843befc8876864e1d44d2e/src/control/group/mod.rs#L9-L15); ниже при этом подключается модуль `neon` для aarch64, но с группой `uint8x8_t` — **8 слотов вместо 16** [О, [control/group/neon.rs, стр. 15–20](https://github.com/rust-lang/hashbrown/blob/7109e3a6388b0a6a0e843befc8876864e1d44d2e/src/control/group/neon.rs#L15-L20)]). Та же Swiss table на x86 и на ARM — **разная ширина группы и разный код поиска**. (У Abseil на ARM тоже 8 байт, у Boost — 16, см. `cpp.md` §10.)

**Формулировка для сцены (слайд или реплика после раунда 2, 20 секунд):**
> «Если вы не пишете на C++, вот где вы. Go с версии 1.24 и Rust — плоские Swiss tables, как Abseil. Python и Swift — тоже открытая адресация, но у Python каждый int — объект, а у Swift дорогой SipHash. C# — цепочки, но внутри массивов, без аллокации на элемент. А Java `HashSet<Long>` и котлиновский `distinct()` — узловые, да ещё с боксингом: два объекта на каждый id. Так что раунд первый — про Java и Kotlin больше, чем про C++».

---
## 5. x86 и серверы: «алгоритм не выбирал процессор» на бэкенде

### 5.1 Гибридные x86 (Alder Lake и новее): Windows [О]

Документация Microsoft «Quality of Service» ([MicrosoftDocs/win32@e103fa4, desktop-src/ProcThread/quality-of-service.md](https://github.com/MicrosoftDocs/win32/blob/e103fa4e8810bd8d42c4777e17081e24dbe62dbd/desktop-src/ProcThread/quality-of-service.md), ms.date 14.07.2025):
- «While scheduling priority remains the main metric by which the system determines which thread to schedule next, QoS can influence core selection and processor power management. **On platforms with heterogeneous processors, the QoS of a thread may restrict scheduling to a subset of processors**, or indicate a preference for a particular class of processor» (стр. 10).
- Таблица уровней (стр. 20–26):
  - **Low** — «Windowed applications that are not visible or audible» → «On battery, selects most efficient CPU frequency and **schedules to efficient core**»;
  - **Utility** — «Background services» → то же на батарее (Windows 11 22H2);
  - **Eco** — явная пометка через `SetProcessInformation`/`SetThreadInformation` (`PROCESS_POWER_THROTTLING_EXECUTION_SPEED`) → «**Always** selects most efficient CPU frequency and schedules to efficient cores».
- Классификация (стр. 47–55): окно в фокусе → High, видимое → Medium, свёрнутое/перекрытое → **Low**; неклассифицированные потоки — эвристики, «threads running with reduced thread priority can imply a lower QoS level».
- **Прямо про бенчмарки** (стр. 28–31): «This feature should be disabled when testing on battery (for example, running performance benchmarks). **Automated tests lacking user input may trigger this feature, lowering QoS and skewing results.**» — Windows понижает QoS приложения на переднем плане до Medium после периода без ввода (реестр `DisableUserPresenceQos`).

[А] Это почти дословно механизм iOS из доклада: «не на экране / фоновая служба / Eco» → эффективные ядра. На ноутбуке разработчика с Core Ultra свёрнутый бенчмарк на батарее — это E-ядро.

### 5.2 Гибридные x86: Linux [О]

[Documentation/admin-guide/pm/intel_pstate.rst, раздел «Support for Hybrid Processors»](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/Documentation/admin-guide/pm/intel_pstate.rst#L339-L435):
- Гибридные процессоры — ядра, «differing by the maximum turbo P-state, performance vs power characteristics, **cache sizes**, and possibly other properties».
- **С SMT** (Alder/Raptor Lake с HT на P-ядрах): `intel_pstate` раздаёт приоритеты по производительности (ITMT/asym packing) — «causes the CPU scheduler to generally prefer more performant CPUs, so the less performant CPUs are used when the other ones are fully loaded».
- **Без SMT** (Lunar Lake, Arrow Lake — у них нет HT [П]): включается capacity-aware scheduling, а при `schedutil` в пассивном режиме — EAS с искусственной энергомоделью, где «running a task on a less performant (small) CPU appears to be **always cheaper**». Итог: «low-utilization tasks tend to be placed on the CPUs that look less expensive» — то есть на E-ядра.
- Intel HFI (аппаратная основа Thread Director) в mainline только передаёт данные в пространство пользователя: «This file provides functionality to process HFI updates and relay these updates to userspace» [О, [drivers/thermal/intel/intel_hfi.c, стр. 11–19](https://github.com/torvalds/linux/blob/6f8319e3e9a44dd537d17f41565a8453c560a581/drivers/thermal/intel/intel_hfi.c#L11-L19)]. Планировщик Linux классы Thread Director напрямую не использует [П: патчи IPC classes не видел в mainline].

[А] Для зала: **один и тот же Linux на двух ноутбуках Intel ведёт себя по-разному** — с HT он тянет задачи на P-ядра, без HT (новые поколения) отдаёт лёгкие задачи на E-ядра. Короткий бенчмарк с низкой загрузкой на ноутбуке с Lunar/Arrow Lake может целиком пройти на E-ядре.

### 5.3 Серверы: vCPU, SMT, общий L3, поколения CPU

**AWS Graviton** [О, [aws/aws-graviton-getting-started@9b5277a, README.md, таблица «Building for Graviton», стр. 52–76](https://github.com/aws/aws-graviton-getting-started/blob/9b5277add54a8c79b08be5bb8584faf4571567a1/README.md)]:

| | Graviton2 | Graviton3 | Graviton4 | Graviton5 |
|---|---|---|---|---|
| Ядро | Neoverse N1 | V1 | V2 | V3 |
| Частота, турбо | 2,5 ГГц, нет | 2,6, нет | 2,8, нет | 3,3, нет |
| L1D на ядро | 64 КБ | 64 КБ | 64 КБ | 64 КБ |
| **L2 на ядро** | 1 МБ | 1 МБ | **2 МБ** | 2 МБ |
| LLC общий | 32 МБ | 32 МБ | 36 МБ | 48–96 МБ на NUMA |

- **vCPU = физическое ядро, без SMT**: «Be sure to run Graviton instances "hotter": **vCPUs are mapped to physical cores instead of Hyperthreads** and performance often flatlines at a much higher CPU utilization than with x86 based instances. **Testing at low levels of load can lead to misleading results**» [О, [java.md, стр. 36](https://github.com/aws/aws-graviton-getting-started/blob/9b5277add54a8c79b08be5bb8584faf4571567a1/java.md#L36)]. В перф-ранбуке: урезать vCPU на x86 — `configure_vcpus.sh <n> threads`, на Graviton — `cores` [О, perfrunbook/debug_hw_perf.md, стр. 52–55].
- На x86-инстансах EC2 vCPU — это гиперпоток [П, общеизвестно; в этом репозитории — косвенно через фразу выше]. Два vCPU могут быть SMT-соседями на одном физическом ядре и делить его L1/L2; L3 делится с другими арендаторами хоста.

**GitHub-hosted раннеры** [О, [github/docs@394068d, data/reusables/actions/supported-github-runners.md](https://github.com/github/docs/blob/394068dacf2ea33d383fee605dc87aa48441305e/data/reusables/actions/supported-github-runners.md)]: `ubuntu-latest` — 4 CPU, 16 ГБ, **x64**; есть и `ubuntu-24.04-arm` (arm64). Linux/Windows-раннеры — ВМ в Azure (content/actions/concepts/runners/github-hosted-runners.md, стр. 100). **Модель процессора в документации не указана**; в логах раннеров встречаются разные AMD EPYC и Intel Xeon [П]. То есть у «CI-раннера» даже нет фиксированного процессора.

**Пулы с разными поколениями** [А + П]: в Kubernetes с автоскейлером по нескольким типам инстансов (Karpenter, mixed instance policies) один и тот же под сегодня на Graviton3 (L2 1 МБ), завтра на Graviton4 (L2 2 МБ), послезавтра на x86 со SMT-соседом. У облаков вида «general purpose» тип инстанса иногда допускает несколько поколений CPU [П: GCP N2 — Cascade Lake или Ice Lake].

### 5.4 Пример «CI на x86, прод на Graviton»: что меняется при том же коде

[А, собрано из фактов выше; сам не мерил]

| Что | CI: x86 (Xeon/EPYC), SMT | Прод: Graviton4 | Эффект для «sort против hash» |
|---|---|---|---|
| C++ стандартная библиотека | libstdc++ (GCC) | та же libstdc++ | **одинаково** — кажется, что всё честно |
| L2 на ядро | 1–2 МБ, делится с SMT-соседом [П] | 2 МБ, своя | ступенька узловой таблицы в другом месте |
| L3 / LLC | делится с соседями по хосту | 36 МБ на 96 ядер | порог «влезло в LLC» другой |
| SMT | vCPU = гиперпоток | vCPU = ядро | другая конкуренция за кэш и порты |
| Предсказатель ветвлений, prefetcher | свои | свои | ошибка бенчмарка может проявиться по-разному (слайд `learned`: на x86 — предсказатель, на M2 — рабочий набор) |
| Java `Arrays.sort(long[])` | **SIMD-интринсика** (AVX2/AVX-512, JDK 22+) | **скалярный DPQS** | другой алгоритм сортировки при том же коде (§2.3) |
| Go `map` хеш | AES/скалярный по порогу, подобранному на Zen 4 | порог, подобранный на Apple M1 | §4 |
| Rust `HashSet` | группа 16 (SSE2) | группа 8 (NEON) | §4 |

**Формулировка для сцены (бэкенд-версия финала, 20 секунд):**
> «Если вы бэкендер и думаете, что это про телефоны, — вот ваша версия. CI на x86 с гипертредингом, прод на Graviton, где vCPU — целое ядро. Стандартная библиотека та же, код тот же, а кэши, соседи и даже реализация сортировки в JDK — другие: на Intel `Arrays.sort` для `long[]` — это SIMD-интринсика, на ARM — обычный quicksort. AWS в своём гайде прямо пишет: тесты на низкой нагрузке на Graviton вводят в заблуждение. Ваш алгоритм не выбирал процессор и в облаке тоже».

**Ответ на вопрос «У нас бэкенд, при чём тут E-ядра?» (20 секунд):**
> «E-ядер у вас нет, но смена ядра есть: SMT-сосед, который делит с вами L2, другой тип инстанса в пуле, ARM вместо x86. Механизм тот же — меняется цена шага, а не число шагов. И у разработчиков на ноутбуках с Core Ultra свёрнутый бенчмарк на батарее Windows отправляет на эффективные ядра — Microsoft пишет об этом в документации про QoS и прямо предупреждает, что автотесты без ввода пользователя понижают QoS и искажают результаты».

---
## 6. Для зрителя: эксперимент на 10 минут и слайд «Это не только Apple»

### 6.1 iOS, Swift, без C++ [А — код не запускал, swiftc в контейнере нет]

Идея: тот же вопрос, что в раунде 4, но на Swift и на своём телефоне. Одно приложение, одна кнопка, три приоритета.

```swift
import Foundation

func median(_ xs: [Double]) -> Double { let s = xs.sorted(); return s[s.count / 2] }

func runDedup(_ label: String, _ prio: TaskPriority) async {
    await Task.detached(priority: prio) {
        let n = 1 << 20
        // ~половина повторов; умножение на константу убирает «последовательные id»
        let base = (0..<n).map { _ in UInt64.random(in: 0..<UInt64(n / 2)) &* 0x9E3779B97F4A7C15 }
        var tSet: [Double] = [], tSort: [Double] = []
        for _ in 0..<7 {
            var t0 = DispatchTime.now().uptimeNanoseconds
            let u1 = Array(Set(base)).count
            tSet.append(Double(DispatchTime.now().uptimeNanoseconds - t0) / Double(n))

            var a = base                        // копия вне таймера
            t0 = DispatchTime.now().uptimeNanoseconds
            a.sort()
            var w = 0
            for i in 0..<a.count where w == 0 || a[i] != a[w - 1] { a[w] = a[i]; w += 1 }
            a.removeLast(a.count - w)
            tSort.append(Double(DispatchTime.now().uptimeNanoseconds - t0) / Double(n))
            precondition(u1 == w)               // правило доклада: сравниваем одинаковый результат
        }
        let pi = ProcessInfo.processInfo
        print(label, "Set:", median(tSet), "sort:", median(tSort), "нс/эл",
              "thermal:", pi.thermalState.rawValue, "LPM:", pi.isLowPowerModeEnabled)
    }.value
}
// по кнопке: await runDedup("userInitiated", .userInitiated); await runDedup("utility", .utility); await runDedup("background", .background)
```

Условия: **Release-сборка** (в Debug Swift медленнее в разы), приложение на экране, не на зарядке, Low Power Mode выключен, записать модель (`hw.machine`, см. `apple.md` §8.4) и версию iOS. Ожидание [А, не проверено]: при `.userInitiated` `Set` и сортировка близко; при `.background` (а на iPhone, по замеру доклада, и при `.utility`) обе медленнее, и соотношение может сдвинуться. Если сдвинулось — зритель повторил раунд 4 сам.

Вариант «ещё короче»: собрать DedupBench из репозитория доклада (заметки к слайду `final`: «соберите на своём телефоне, это десять минут»).

### 6.2 Android, Kotlin, без NDK [А — код не запускал]

Идея: одна и та же функция дважды — в открытом приложении и в WorkManager при закрытом приложении. Процесс переезжает из cpuset `top-app` в `background` (§1.6), и это видно по номеру CPU.

```kotlin
// build.gradle: implementation("androidx.collection:collection:<последняя>")
import androidx.collection.MutableLongSet
import java.io.File

fun cpuNow(): Int =  // поле 39 «processor» из /proc/thread-self/stat
    File("/proc/thread-self/stat").readText().substringAfterLast(')').trim().split(' ')[36].toInt()

fun dedupSort(a: LongArray): Int { a.sort(); var w = 0
    for (i in a.indices) if (w == 0 || a[i] != a[w - 1]) a[w++] = a[i]; return w }
fun dedupHashSet(a: LongArray): Int { val s = HashSet<Long>(a.size * 2); for (x in a) s.add(x); return s.size } // боксинг
fun dedupDistinct(a: LongArray): Int = a.distinct().size                                                    // LinkedHashSet
fun dedupFlat(a: LongArray): Int { val s = MutableLongSet(a.size); for (x in a) s.add(x); return s.size }   // Swiss table

fun runBench(tag: String) {
    val n = 1 shl 20
    val base = LongArray(n) { (it.toLong() % (n / 2)) * -7046029254386353131L }.apply { shuffle() }
    val algs = listOf("sort" to ::dedupSort, "HashSet" to ::dedupHashSet,
                      "distinct" to ::dedupDistinct, "MutableLongSet" to ::dedupFlat)
    repeat(3) { algs.forEach { (_, f) -> f(base.copyOf()) } }          // прогрев JIT
    for ((name, f) in algs) {
        val ts = (1..7).map { val a = base.copyOf(); val t0 = System.nanoTime(); f(a)
                              (System.nanoTime() - t0).toDouble() / n }.sorted()
        android.util.Log.i("dedup", "$tag $name ${"%.1f".format(ts[3])} нс/эл cpu=${cpuNow()} " +
            File("/proc/self/cgroup").readText().lines().firstOrNull { "cpuset" in it })
    }
}
// 1) в Activity:   lifecycleScope.launch(Dispatchers.Default) { runBench("top-app") }
// 2) в CoroutineWorker.doWork(): runBench("worker"); поставить OneTimeWorkRequest с setInitialDelay(30 s)
//    и сразу нажать Home — задача выполнится, когда приложение уже не на экране.
```

Что сравнить в Logcat [А]: номера CPU (на Pixel 8/9 у фона ожидаются 0–3, §1.2), строку cgroup (`…/top-app` против `…/background` [П: формат строки зависит от версии Android и cgroup v1/v2]) и нс/эл четырёх вариантов. Проверить разметку ядер: `adb shell cat /sys/devices/system/cpu/cpu*/cpufreq/cpuinfo_max_freq` и `adb shell cat /dev/cpuset/background/cpus` [П: читаемость без root зависит от прошивки]. **Не использовать Jetpack Microbenchmark для второго замера** — он сам держит top-app и nice −20 (§1.7).

Дополнительный урок, который зритель получит бесплатно [А]: `distinct()` против `MutableLongSet` — это раунд 2 доклада на Kotlin (узловая с боксингом против плоской).

### 6.3 Слайд «Это не только Apple» (5 строк)

**Заголовок:** «Это не только Apple: ядро выбирает система, а не ваш код»

1. **Android** — приложение не на экране → cpuset `background`. Pixel 8/9: только маленькие ядра 0–3, потолок uclamp 13%. Синк в WorkManager живёт там.
2. **Windows 11** — EcoQoS всегда, свёрнутое окно или служба на батарее → «schedules to efficient cores». Автотест без ввода понижает QoS.
3. **Linux на Intel без HT** — лёгкие задачи EAS отдаёт E-ядрам: «small CPU appears to be always cheaper».
4. **Облако** — CI на x86 со SMT, прод на Graviton: vCPU = целое ядро, другие кэши, и даже `Arrays.sort(long[])` там другой (на x86 — SIMD).
5. **Контейнер по умолчанию:** Java `HashSet<Long>` и Kotlin `distinct()` — узлы и боксинг; Go, Rust, Swift, Python — открытая адресация.

**Сноска мелким шрифтом:** «AOSP init.rc, device/google/zuma · Microsoft Docs "Quality of Service" · Linux intel_pstate.rst · AWS Graviton Getting Started · OpenJDK stubGenerator_x86_64.cpp».

**Заметки к слайду (25 секунд):**
> «Если вы думаете, что это история про iPhone, — вот тот же механизм в других местах. Android решает по состоянию процесса: закрыли приложение — ваш синк на маленьких ядрах. Windows на батарее отправляет свёрнутые окна, а EcoQoS — всегда, на эффективные ядра и прямо пишет, что автотесты это искажают. Linux на новых Intel без гипертрединга делает то же самое. А на сервере ядро меняется вместе с типом инстанса — и вместе с ним иногда меняется даже реализация сортировки в JDK. Ваш алгоритм не выбирал процессор нигде».

[А] Где ставить: после `flip` (перед `learned`) или как backup. Если слот тесный, достаточно одной реплики в заметках к `flip` плюс строки 4 на слайде `final` (бэкенд-версия «действия на понедельник», см. `conf.md` §9 п. 2).

---

## 7. Готовые ответы на вопросы (карточки)

| Вопрос | Ответ (≤ 30 с) | Опора |
|---|---|---|
| «А на Android?» | «Не мерил, цифр не назову. Механизм проверил по исходникам: закрытое приложение уезжает в cpuset background; у Pixel 8/9 это маленькие ядра 0–3 с потолком uclamp, у Snapdragon 8 Gen 3 — маленькие плюс младшие средние. WorkManager при закрытом приложении работает именно там. Отличие от iOS: решает состояние процесса, а не пометка потока». | §1 |
| «`THREAD_PRIORITY_BACKGROUND` — это аналог `.background`?» | «Нет. С Android 13 он меняет только nice. На маленькие ядра поток отправляет состояние процесса, а не приоритет потока. В Android 10–12 он ещё двигал поток в cpu-группу background». | §1.5 |
| «А на Snapdragon 8 Elite?» | «Там маленьких ядер нет. Фон просто не пускают на два prime-ядра, а L2 у обоих кластеров по 12 МБ. Эффект будет слабее — ещё один довод проверять на своём устройстве». | §1.2–1.3 |
| «А в Java / Kotlin?» | «`HashSet<Long>` — узловая таблица, плюс каждый id — объект `Long`: два объекта на ключ. `distinct()` в Kotlin — `LinkedHashSet`. Плоские аналоги — fastutil `LongOpenHashSet` и `MutableLongSet` из androidx.collection. А `LongArray.sort()` сортирует примитивы на месте, `sorted()` — боксит». | §2 |
| «А в Go / Rust?» | «Оба плоские: Go с 1.24 — Swiss tables, Rust — hashbrown, порт той же Swiss table. У Rust по умолчанию SipHash, он дороже тождественного хеша. Я их не мерил». | §4 |
| «А в Swift?» | «`Set` плоский, линейное пробирование, но хеш — SipHash-1-3 со случайным сидом: пять раундов на `UInt64`. Узловой проблемы нет, ядерная — есть: таблица на миллион — 16 МБ, больше L2 E-кластера. Не мерил». | §3 |
| «А в C#?» | «Цепочки, но в массивах: `Entry[]` с индексом следующего, без аллокации на элемент и без боксинга `long`. Ближе к плоской по памяти». | §4 |
| «А в Python?» | «Таблица плоская, открытая адресация, 9 линейных проб. Но каждый int — отдельный объект в куче, так что прыжки по указателям возвращаются через ключи». | §4 |
| «У нас бэкенд, E-ядер нет» | «Есть SMT-сосед, другой тип инстанса в пуле, ARM вместо x86. У Graviton vCPU — целое ядро, у x86 — гиперпоток. Даже `Arrays.sort(long[])` на Intel в JDK 22+ — SIMD-интринсика, а на ARM — обычный quicksort». | §5 |
| «На ноутбуке с Intel тоже?» | «Windows 11 отправляет EcoQoS-процессы на эффективные ядра всегда, а свёрнутые окна — на батарее, а Microsoft прямо предупреждает, что автотесты без ввода понижают QoS. Linux на Intel без HT отдаёт лёгкие задачи E-ядрам через EAS». | §5.1–5.2 |
| «Можно просто замерить Jetpack Microbenchmark?» | «Можно, но он специально держит top-app и nice −20, то есть большие ядра. Для фона — отдельный замер в WorkManager при закрытом приложении». | §1.7 |

---

## 8. Что не проверено и где риск

- **Android: ни одного собственного замера.** Всё про Android — по исходникам политики, не по измерениям. На сцене говорить «механизм», а не «эффект».
- Файлы Pixel взяты из LineageOS (`lineage-23.0`), а не из AOSP напрямую: зеркала `device/google/zuma*` на GitHub нет. Стоковая прошивка может отличаться; в `lineage-22.2` значения cpuset те же [О].
- Qualcomm-скрипты — из дерева OnePlus у LineageOS; у Samsung/Xiaomi на тех же SoC cpuset может быть другим.
- AOSP-зеркало на GitHub заморожено на марте 2025; Android 16/17 могли что-то поменять в `task_profiles.json`/`OomAdjuster`.
- Размеры кэшей Tensor G3/G4 не найдены; 8 Elite — только по сниппетам.
- Байты объектов JVM — расчёт, а не JOL-замер.
- Go: код выбора хеша — из `main` (сентябрь 2026), в выпущенных релизах мог быть другим.
- Java SIMD-sort: «только Linux» — вывод по пути `src/java.base/linux/native/libsimdsort`; величину ускорения не проверял.
- Код экспериментов §6 не запускался (нет Swift/Android-тулчейна в контейнере).

## 9. Источники (открыты)

**Android / Linux:** aosp-mirror/platform_system_core@a3b721a (rootdir/init.rc, libprocessgroup/profiles/task_profiles.json, libutils/Threads.cpp) и теги android-10/11/12/13/14/15.0.0_r1 (Threads.cpp, sched_policy.cpp); aosp-mirror/platform_frameworks_base@1cdfff5 (Process.java, android_util_Process.cpp, JobServiceContext.java, Context.java, OomAdjuster.java, ProcessList.java); LineageOS/android_device_google_zuma и _zumapro (lineage-23.0, lineage-22.2); LineageOS/android_device_oneplus_sm8650-common@54444d5; LineageOS/android_device_oneplus_sm8750-common@f87c339; torvalds/linux@6f8319e (sm8650.dtsi, sm8750.dtsi, Documentation/scheduler/sched-energy.rst, sched-util-clamp.rst, admin-guide/pm/intel_pstate.rst, drivers/thermal/intel/intel_hfi.c); androidx/androidx@f268793 (work-runtime Configuration.kt, Schedulers.java; benchmark-common ThreadPriority.kt, IsolationActivity.kt; collection ScatterMap.kt, LongSet.kt); android/ndk.wiki@fbb3b72 (Changelog-r18, r26, r30).

**JVM / Kotlin:** openjdk/jdk@fec788e (HashSet, HashMap, LinkedHashMap, Long, DualPivotQuicksort, stubGenerator_x86_64.cpp, vm_version_x86.hpp, stubGenerator_aarch64.cpp) и теги jdk-21/22/23/24/25-ga; JetBrains/kotlin@1d1310c (_Collections.kt, _Arrays.kt, _ArraysJvm.kt); vigna/fastutil@cbf3c2e (drv/OpenHashSet.drv, HashCommon.java, Hash.java, gencsource.sh).

**Swift:** swiftlang/swift@a9c20b8 (Sort.swift, Hasher.swift, SipHash.swift, HashTable.swift, NativeSet.swift, Set.swift, IntegerTypes.swift.gyb) и теги swift-4.2/5.0/5.5/5.8/5.9/5.10/6.1/6.2/6.3/6.4.0-RELEASE; apple/swift-algorithms@5b7143f (Unique.swift); apple/swift-collections@98ef3c9 (OrderedSet.swift).

**Другие языки:** golang/go@446fdc9 (internal/runtime/maps/map.go, group.go, table.go, runtime_alg.go, memhash_aes.go, memhash_noaes.go; runtime/alg.go); golang/website@f2661d9 (_content/doc/go1.24.md); rust-lang/rust@ea6bb45 (library/std/src/collections/hash/map.rs, hash/random.rs); rust-lang/hashbrown@7109e3a (README.md, src/control/group/mod.rs, neon.rs); dotnet/runtime@72036ca (HashSet.cs, Int64.cs); python/cpython@a4ad141 (Objects/setobject.c, Include/cpython/setobject.h, Objects/listobject.c, pycore_runtime_structs.h).

**x86 / облака / CI:** MicrosoftDocs/win32@e103fa4 (desktop-src/ProcThread/quality-of-service.md); aws/aws-graviton-getting-started@9b5277a (README.md, java.md, perfrunbook/debug_hw_perf.md); github/docs@394068d (data/reusables/actions/supported-github-runners.md, content/actions/concepts/runners/github-hosted-runners.md).

**Только сниппеты поиска [С]:** ядра Tensor G3 (Android Authority), Tensor G4 (Android Central), кэши Snapdragon 8 Elite (HotHardware, Android Authority); поиск бенчмарков Swift `Set` против sort (SwiftLee, Donny Wals, Sarunw — замеров нет). androidauthority.com заблокирован прокси.
