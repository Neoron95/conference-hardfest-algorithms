#!/usr/bin/env python3
"""Сводные таблицы по results/*.csv (Markdown в stdout).

Для каждой конфигурации берётся медиана блоков в каждой сессии; в таблицах —
медиана по сессиям и разброс между сессиями (max/min − 1).
"""
import csv
import glob
import os
import statistics as st
import sys
from collections import defaultdict

os.chdir(os.path.dirname(os.path.abspath(__file__)))
rows = []
for f in sorted(glob.glob("results/E*.csv")):
    with open(f) as fh:
        rows += list(csv.DictReader(fh))

# (exp, toolchain, variant, alg, keys, order, N, U) -> {session: median}
data = defaultdict(dict)
spread = defaultdict(dict)
for r in rows:
    k = (r["exp"], r["toolchain"], r["variant"], r["alg"], r["keys"], r["order"], int(r["N"]), int(r["U"]))
    data[k][r["session"]] = float(r["median_ns_el"])
    spread[k][r["session"]] = float(r["spread_pct"])


def get(exp, tc, alg, N=None, U=None, variant=None, keys=None, order=None):
    out = []
    for k, v in data.items():
        if k[0] != exp or k[1] != tc or k[3] != alg:
            continue
        if variant is not None and k[2] != variant:
            continue
        if keys is not None and k[4] != keys:
            continue
        if order is not None and k[5] != order:
            continue
        if N is not None and k[6] != N:
            continue
        if U is not None and k[7] != U:
            continue
        out.append((k, v))
    if not out:
        return None
    assert len(out) == 1, (exp, tc, alg, N, U, variant, [o[0] for o in out])
    return out[0][1]


def med(v):
    return st.median(v.values()) if v else float("nan")


def between(v):
    if not v or len(v) < 2:
        return "—"
    return f"{(max(v.values()) / min(v.values()) - 1) * 100:.0f}%"


def fmt(x, d=1):
    if x is None or x != x:
        return "—"
    return f"{x:.{d}f}".replace(".", ",")


def sessions(v):
    return " / ".join(fmt(v[s]) for s in sorted(v)) if v else "—"


GCC, CXX, CLS = "gcc13-libstdc++", "clang18-libc++", "clang18-libstdc++"
N20 = 1 << 20
p = print

# ------------------------------------------------------------------ E1
p("### E1. N = U = 2^20, нс/эл (медиана по сессиям; в скобках — по сессиям)\n")
p("| связка | sort+unique | unordered_set | radix+unique | flat_hash_set | uset/sort |")
p("|---|---|---|---|---|---|")
for tc in (GCC, CXX, CLS):
    vals = {a: get("E1", tc, a, N20, N20) for a in ("sort", "uset", "radix", "flat")}
    if not any(vals.values()):
        continue
    cells = [f"{fmt(med(vals[a]))} ({sessions(vals[a])})" for a in ("sort", "uset", "radix", "flat")]
    ratio = med(vals["uset"]) / med(vals["sort"])
    p(f"| {tc} | " + " | ".join(cells) + f" | {fmt(ratio, 2)} |")
p()

# ------------------------------------------------------------------ E2
p("### E2. U = N/2, нс/эл, sort+unique против unordered_set\n")
for tc in (GCC, CXX):
    ns = sorted({k[6] for k in data if k[0] == "E2" and k[1] == tc})
    if not ns:
        continue
    has_extra = get("E2", tc, "flat", ns[0], ns[0] // 2) is not None
    p(f"**{tc}**\n")
    hdr = "| N | sort | uset | T_sort/T_uset | кто быстрее | разброс сессий sort / uset |"
    if has_extra:
        hdr = "| N | sort | uset | radix | flat | T_sort/T_uset | кто быстрее | разброс сессий sort / uset |"
    p(hdr)
    p("|" + "---|" * (hdr.count("|") - 1))
    for n in ns:
        s = get("E2", tc, "sort", n, n // 2)
        u = get("E2", tc, "uset", n, n // 2)
        r = med(s) / med(u)
        who = f"хеш на {fmt((r - 1) * 100, 0)}%" if r > 1 else f"sort в {fmt(1 / r, 2)} раза"
        extra = ""
        if has_extra:
            extra = f"{fmt(med(get('E2', tc, 'radix', n, n // 2)))} | {fmt(med(get('E2', tc, 'flat', n, n // 2)))} | "
        p(f"| {n} | {fmt(med(s))} | {fmt(med(u))} | {extra}{fmt(r, 2)} | {who} | {between(s)} / {between(u)} |")
    p()

# ------------------------------------------------------------------ E3
p("### E3. N = 2^20, доля уникальных, нс/эл\n")
for tc in (GCC, CXX):
    vs = [v for v in ("all_equal", "ufrac_0.01", "ufrac_0.1", "ufrac_0.5", "ufrac_1")
          if get("E3", tc, "sort", variant=v)]
    if not vs:
        continue
    p(f"**{tc}**\n")
    p("| U/N | sort | uset | radix | flat | uset/sort |")
    p("|---|---|---|---|---|---|")
    for v in vs:
        c = {a: med(get("E3", tc, a, variant=v)) for a in ("sort", "uset", "radix", "flat")}
        p(f"| {v} | {fmt(c['sort'])} | {fmt(c['uset'])} | {fmt(c['radix'])} | {fmt(c['flat'])} | {fmt(c['uset'] / c['sort'], 2)} |")
    p()

# ------------------------------------------------------------------ E4
p("### E4. N = 2^20, U = N/2, порядок входа, нс/эл\n")
for tc in (GCC, CXX):
    if not get("E4", tc, "sort", order="random"):
        continue
    p(f"**{tc}**\n")
    p("| порядок | sort | uset | radix | flat | uset/sort |")
    p("|---|---|---|---|---|---|")
    for o in ("random", "runs", "sorted"):
        c = {a: med(get("E4", tc, a, order=o)) for a in ("sort", "uset", "radix", "flat")}
        p(f"| {o} | {fmt(c['sort'])} | {fmt(c['uset'])} | {fmt(c['radix'])} | {fmt(c['flat'])} | {fmt(c['uset'] / c['sort'], 2)} |")
    p()

# ------------------------------------------------------------------ E5
p("### E5. «Бенчмарк врал»: N = 1024, U = 512, нс/эл\n")
e5v = sorted({k[2] for k in data if k[0] == "E5"})
for tc in (GCC, CXX):
    if not get("E5", tc, "sort", variant="c_64_different"):
        continue
    p(f"**{tc}**\n")
    p("| вариант | P разных | буферов | рабочий набор | sort+unique | radix+unique | сессии sort |")
    p("|---|---|---|---|---|---|---|")
    for v in e5v:
        s = get("E5", tc, "sort", variant=v)
        rd = get("E5", tc, "radix", variant=v)
        if not s:
            continue
        k = [k for k in data if k[0] == "E5" and k[1] == tc and k[2] == v and k[3] == "sort"][0]
        r0 = [r for r in rows if r["exp"] == "E5" and r["toolchain"] == tc and r["variant"] == v][0]
        ws = int(r0["batch"]) * 1024 * 8 // 1024
        p(f"| {v} | {r0['pool']} | {r0['batch']} | {ws} КБ | {fmt(med(s))} | {fmt(med(rd))} | {sessions(s)} |")
    p()

# ------------------------------------------------------------------ E6
p("### E6. sort+unique, все ключи равны, N = 2^20, нс/эл\n")
p("| связка | нс/эл | по сессиям |")
p("|---|---|---|")
for tc in (GCC, CXX, CLS):
    s = get("E6", tc, "sort", N20, 1)
    if s:
        p(f"| {tc} | {fmt(med(s), 2)} | {sessions(s)} |")
p()

# ------------------------------------------------------------------ E7
p("### E7. Плотные id (1..U, перемешаны) против случайных 64-бит, N = 2^20, U = N/2, нс/эл\n")
for tc in (GCC, CXX):
    if not get("E7", tc, "sort", keys="dense"):
        continue
    p(f"**{tc}**\n")
    p("| ключи | sort | uset | radix | flat | uset/sort |")
    p("|---|---|---|---|---|---|")
    for kk in ("random64", "dense"):
        c = {a: med(get("E7", tc, a, keys=kk)) for a in ("sort", "uset", "radix", "flat")}
        p(f"| {kk} | {fmt(c['sort'])} | {fmt(c['uset'])} | {fmt(c['radix'])} | {fmt(c['flat'])} | {fmt(c['uset'] / c['sort'], 2)} |")
    p()

# ------------------------------------------------------------------ E8
p("### E8. Локальные 2^20 (отсортированы, уникальны) + дельта 2^16 (50% дублей), нс на элемент входа\n")
p("| связка | sort+unique всего | unordered_set | radix | flat | sort(дельта)+unique+inplace_merge+unique | sort(дельта)+unique+set_union |")
p("|---|---|---|---|---|---|---|")
for tc in (GCC, CXX):
    c = {a: med(get("E8", tc, a) or {}) for a in ("sort", "uset", "radix", "flat", "merge_inplace", "merge_union")}
    if c["sort"] == c["sort"]:
        p(f"| {tc} | " + " | ".join(fmt(c[a]) for a in ("sort", "uset", "radix", "flat", "merge_inplace", "merge_union")) + " |")
p()

# ------------------------------------------------------------------ E9
p("### E9. Прозрачные huge pages для кучи (GLIBC_TUNABLES=glibc.malloc.hugetlb=1), N = 2^20, нс/эл\n")
p("| связка | U | куча | sort | uset | radix | flat | uset/sort |")
p("|---|---|---|---|---|---|---|---|")
for tc in (GCC, CXX):
    for U in (N20, N20 // 2):
        for v in ("default_malloc", "thp_malloc"):
            c = {a: med(get("E9", tc, a, N20, U, variant=v) or {}) for a in ("sort", "uset", "radix", "flat")}
            if c["sort"] == c["sort"]:
                p(f"| {tc} | {U} | {v} | {fmt(c['sort'])} | {fmt(c['uset'])} | {fmt(c['radix'])} | {fmt(c['flat'])} | {fmt(c['uset'] / c['sort'], 2)} |")
p()

# ------------------------------------------------------------------ шум
p("### Шум\n")
allsp = [x for v in spread.values() for x in v.values()]
p(f"- Разброс блоков внутри конфигурации ((max−min)/медиана): медиана {fmt(st.median(allsp), 1)}%, "
  f"90-й перцентиль {fmt(sorted(allsp)[int(0.9 * (len(allsp) - 1))], 1)}%, конфигураций: {len(allsp)}.")
bs = []
for k, v in data.items():
    if len(v) >= 2:
        bs.append((max(v.values()) / min(v.values()) - 1) * 100)
if bs:
    bs.sort()
    p(f"- Расхождение медиан между сессиями (max/min − 1): медиана {fmt(st.median(bs), 1)}%, "
      f"90-й перцентиль {fmt(bs[int(0.9 * (len(bs) - 1))], 1)}%, максимум {fmt(bs[-1], 1)}%, конфигураций: {len(bs)}.")
