#!/usr/bin/env python3
"""dedup.py — «одна строчка» дедупликации в Python: что реально делает CPython.

Вход: N = 2^20 64-битных id (splitmix64, seed 17), как в bench/dedup_bench.cpp.
Сценарии: U = N случайный порядок; U = N отсортированный; U = 1 % случайный.
Варианты (в таймере — вся операция, включая создание результата):
  sorted_unique   sorted(x) + проход по соседям (чистый Python-цикл)
  sort_inplace    x.sort() на копии + проход
  set             set(x)             — только таблица, без выгрузки
  list_set        list(set(x))       — таблица + выгрузка
  sorted_set      sorted(set(x))     — таблица + сортировка уникальных
  dict_fromkeys   list(dict.fromkeys(x)) — порядок первого появления (идиома)
  np_unique       np.unique(arr)     — NumPy ≥ 2.3: хеш + sort уникальных
  np_sort_mask    arr.sort(); arr[np.concatenate(([True], arr[1:] != arr[:-1]))]
  np_set          set(arr.tolist()) — для сравнения: цена боксинга из ndarray
Вывод: CSV scenario,variant,ms_median,ns_per_elem,ms_min,ms_max
"""
import sys, time, statistics, gc
import numpy as np

N = int(sys.argv[1]) if len(sys.argv) > 1 else 1 << 20
REPS = int(sys.argv[2]) if len(sys.argv) > 2 else 5
MASK = (1 << 64) - 1

def splitmix(seed, n):
    # векторно в NumPy, биекция mix64 => первые n выходов различны
    s = (seed + np.arange(1, n + 1, dtype=np.uint64) * np.uint64(0x9E3779B97F4A7C15)) & np.uint64(MASK)
    z = s
    z = (z ^ (z >> np.uint64(30))) * np.uint64(0xBF58476D1CE4E5B9)
    z = (z ^ (z >> np.uint64(27))) * np.uint64(0x94D049BB133111EB)
    return z ^ (z >> np.uint64(31))

def make(n, u, order):
    rng = np.random.default_rng(17)
    keys = splitmix(17, u)
    if u == n:
        arr = keys.copy()
    else:
        arr = np.concatenate([keys, keys[rng.integers(0, u, n - u)]])
    if order == "sorted":
        arr.sort()
    else:
        rng.shuffle(arr)
    return arr

def unique_sorted_pass(s):
    out = []
    prev = None
    for v in s:
        if v != prev:
            out.append(v); prev = v
    return out

def bench(name, fn, n, scen):
    ts = []
    for _ in range(REPS):
        gc.collect()
        t0 = time.perf_counter(); r = fn(); t1 = time.perf_counter()
        ts.append((t1 - t0) * 1e3)
        del r
    med = statistics.median(ts)
    print(f"{scen},{name},{med:.2f},{med*1e6/n:.1f},{min(ts):.2f},{max(ts):.2f}", flush=True)

print("scenario,variant,ms_median,ns_per_elem,ms_min,ms_max")
for scen, u, order in (("U=N random", N, "random"), ("U=N sorted", N, "sorted"), ("U=1% random", max(1, N // 100), "random")):
    arr = make(N, u, order)
    x = arr.tolist()  # список PyLong-объектов — «обычные» данные Python-кода
    expected = len(np.unique(arr))
    assert len(set(x)) == expected
    bench("sorted_unique", lambda: unique_sorted_pass(sorted(x)), N, scen)
    def sort_inplace():
        y = list(x); y.sort(); return unique_sorted_pass(y)
    bench("sort_inplace", sort_inplace, N, scen)
    bench("set", lambda: set(x), N, scen)
    bench("list_set", lambda: list(set(x)), N, scen)
    bench("sorted_set", lambda: sorted(set(x)), N, scen)
    bench("dict_fromkeys", lambda: list(dict.fromkeys(x)), N, scen)
    bench("np_unique", lambda: np.unique(arr), N, scen)
    def np_sort_mask():
        a = arr.copy(); a.sort()
        return a[np.concatenate(([True], a[1:] != a[:-1]))]
    bench("np_sort_mask", np_sort_mask, N, scen)
    bench("np_set", lambda: set(arr.tolist()), N, scen)
    # сколько весит результат
    if scen == "U=N random":
        s = set(x)
        print(f"# sizeof(set of {len(s)}) = {sys.getsizeof(s)} B = {sys.getsizeof(s)/len(s):.1f} B/key (без самих int-объектов)", flush=True)
        print(f"# sizeof(int 64-bit) = {sys.getsizeof(x[0])} B, sizeof(list) = {sys.getsizeof(x)} B = {sys.getsizeof(x)/len(x):.1f} B/elem", flush=True)
        print(f"# numpy {np.__version__}, python {sys.version.split()[0]}", flush=True)
