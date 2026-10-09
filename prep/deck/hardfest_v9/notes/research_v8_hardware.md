# Аппаратная часть V8

Проверка от 07.10.2026. Новые аппаратные слайды объясняют возможности процессора и ограничения интерпретации. Учебный машинный код и отдельный pointer-chasing не представлены как трасса дедупликации.

## Инструкции `cpu-loads`

Сгенерировано на этой машине Apple clang 21.0.0 (clang-2100.3.34.2). Минимальный исходник:

```c
typedef unsigned long long u64;
typedef struct { u64 a, b; } Pair;
Pair independent(const u64 *p, const u64 *q) {
  Pair r = { *p, *q };
  return r;
}
u64 dependent(const u64 * const *p) {
  return **p;
}
```

Команды:

```sh
clang -target x86_64-unknown-linux-gnu -O3 -S -masm=intel loads.c -o loads-x86.s
clang -target aarch64-unknown-linux-gnu -O3 -S loads.c -o loads-arm.s
```

Точные инструкции загрузки, без `ret` и служебных директив:

```asm
# x86-64 independent
mov rax, qword ptr [rdi]
mov rdx, qword ptr [rsi]
# x86-64 dependent
mov rax, qword ptr [rdi]
mov rax, qword ptr [rax]

// AArch64 independent
ldr x0, [x0]
ldr x1, [x1]
// AArch64 dependent
ldr x8, [x0]
ldr x0, [x8]
```

В первом случае результаты загрузок не формируют адрес друг друга. Во втором случае вторая инструкция использует результат первой как адрес. Показанная возможность перекрытия независимых операций зависит от конкретного ядра и его текущих ресурсов.

Проверенные первичные объяснения механизма:

- [Intel Optimization Reference Manual](https://www.intel.com/content/www/us/en/developer/articles/technical/intel64-and-ia32-architectures-optimization.html).
- [Arm: Memory access ordering, introduction](https://developer.arm.com/community/arm-community-blogs/b/architectures-and-processors-blog/posts/memory-access-ordering---an-introduction), sections Out-of-order execution and Speculation. Адресная зависимость ограничивает выполнение следующей загрузки.
- [Apple WWDC25: Optimize CPU performance with Instruments](https://developer.apple.com/videos/play/wwdc2025/308/), transcript around 20–27 minutes. Apple прямо описывает выполнение вне порядка, предсказатели и кэш-иерархию.

## `xeon-cache`

Два факта из одного сохранённого окружения:

- `bench/results/env.txt`: `L3 cache: 260 MiB (1 instance)`, четыре vCPU, KVM.
- `bench/results/probe.txt`: `latency_ns,65536 KB,140.8`.

Сохранённый тест `bench/probe.cpp` строит случайную зависимую цепочку. Его задержка включает то, что происходит при данном доступе, в том числе перевод адресов. Она не разлагается на измеренные попадания L1/L2/L3/DRAM.

[lscpu manual](https://man7.org/linux/man-pages/man1/lscpu.1.html), DESCRIPTION, проверен: информация в VM описывает конфигурацию гостя, размеры в summary суммируются, физическая топология может отличаться. В сохранённом дампе для L3 указан один instance. Это всё равно не обещание личной ёмкости одному vCPU или задержки конкретной нагрузки.

Нельзя сказать по одному времени «данные точно в DRAM», «соседи забрали кэш» или «виноват NUMA». Все эти объяснения требуют дополнительного опыта. PMU недоступен, что сохранено в `bench/results/perf_probe.txt`.

## `speculation` и `learned`

[Intel Hardware Features and Behaviors Related to Speculative Execution](https://www.intel.com/content/www/us/en/developer/articles/technical/software-security-guidance/technical-documentation/hardware-behavior-related-to-speculative-execution.html), version 2.0, updated 20.01.2026, проверен. Conditional branch predictors выбирают направление до разрешения условия. Неверный прогноз заставляет отбросить спекулятивные инструкции. [Apple WWDC25](https://developer.apple.com/videos/play/wwdc2025/308/) также показывает стоимость плохо предсказываемых ветвлений на Apple Silicon.

В `learned` сопоставлены среды постоянными колонками. Это сравнение протоколов внутри каждой среды, не сравнение абсолютной скорости разных машин:

| Сценарий | M2 Pro, native macOS | Xeon VM, GCC13/libstdc++ | iPhone 14 Pro |
|---|---:|---:|---|
| Один вход | 6,8 нс/эл | 9,7 нс/эл | нет серии |
| 64 разных | 14,4 нс/эл | 46,9 нс/эл | нет серии |

N=1024 в обеих сериях. U=512 подтверждено для Xeon E5. В сохранённой нативной M2-записи U не указан, поэтому общий U на слайде не заявлен. Xeon E5: 64 одинаковые копии дают 9,6 нс/эл, 64 разных через один 8 КиБ буфер дают 46,8 нс/эл. Это поддерживает гипотезу роли рисунка ветвлений. Без PMU доля branch misses не измерена.

M2 native 6,8/14,4 взяты из сохранённой V7.6. Контроль с копиями на M2 выполнен в Linux VM и не подменяет контроль на нативной macOS. Причина её эффекта не установлена. iPhone-серии нет.

## `core-model`, `cache-path`, `cores`

- [iPhone 14 Pro specifications](https://support.apple.com/en-my/111849): A16, 2 performance и 4 efficiency CPU cores.
- [Apple: Tune CPU job scheduling for Apple silicon games](https://developer.apple.com/videos/play/tech-talks/110147/): Apple Silicon P/E, кластеры, независимые ресурсы, QoS как один из факторов размещения.
- [XNU Edge scheduler documentation](https://github.com/apple-oss-distributions/xnu/blob/main/doc/scheduler/sched_clutch_edge.md): предпочтительные кластеры рекомендует контроллер производительности, в том числе по QoS внутри thread group. `utility=E` не универсальное правило.
- [Apple WWDC25](https://developer.apple.com/videos/play/wwdc2025/308/): L1 внутри CPU, более медленный L2, высокий штраф доступа к основной памяти. Схема V8 помечена упрощённой, блок «Дальше» не подменяет специфическую топологию всех платформ.

`cores`: все `points` исходных M2 и iPhone полилиний V7.6 сохранены без изменений. В V8 M2 расположен слева, iPhone справа. Геометрическое масштабирование меняет ширину панелей, не данные. Границы кэшей Mac не нарисованы на A16. Кривая utility содержит исходные неровности.

Лестница измеряет отдельную зависимую цепочку. Разные изломы согласуются с разными доступными быстрыми уровнями памяти и служат косвенным признаком типа ядра. Это не трасса обращений измеряемого дедупа и не счётчик его промахов.
