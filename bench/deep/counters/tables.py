#!/usr/bin/env python3
"""Сводные таблицы (markdown) из results/counters.csv и results/phases.csv → results/tables.md"""
import csv, os, collections
D = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results')
rows = list(csv.DictReader(open(os.path.join(D, 'counters.csv'))))
ph = list(csv.DictReader(open(os.path.join(D, 'phases.csv')))) if os.path.exists(os.path.join(D, 'phases.csv')) else []
f = lambda r, k, d=2: f"{float(r[k]):.{d}f}"
out = []
def sel(**kw):
    return [r for r in rows if all(r[k] == str(v) for k, v in kw.items())]
TC = {'gcc': 'gcc13-libstdc++', 'libcxx': 'clang18-libc++'}
CACHE = {'X': 'LL 2 МиБ/64 Б (Xeon L2)', 'E': 'LL 4 МиБ/128 Б (E-кластер)', 'P': 'LL 16 МиБ/128 Б (P-кластер)'}
ALG = ['sort', 'uset', 'flat', 'radix']

out.append('## T1. Главная таблица: на один элемент входа, N = 2^20, случайный порядок\n')
out.append('Ir — инструкций, Dr/Dw — чтений/записей, D1m — промахов L1d (чт+зап), LLm — промахов LL (чт+зап), Bc — условных ветвлений, Bcm — промахов предсказания (симулятор), Bi — косвенных переходов.\n')
for u_label, ufrac in (('U = N', 1), ('U = N/2', 2)):
    for tc in ('gcc', 'libcxx'):
        out.append(f'\n### {u_label}, {TC[tc]}\n')
        out.append('| алгоритм | кэш | Ir | Dr | Dw | D1m | LLm | LLm чт | LLm зап | Bc | Bcm | Bi |')
        out.append('|---|---|---|---|---|---|---|---|---|---|---|---|')
        for a in ALG:
            for c in ('X', 'E', 'P'):
                for r in sel(group='main', toolchain=tc, alg=a, cache=c, U=1048576 // ufrac):
                    out.append(f"| {a} | {c} | {f(r,'Ir/el',1)} | {f(r,'Dr/el',1)} | {f(r,'Dw/el',1)} | {f(r,'D1m/el')} | {f(r,'DLm/el')} | {f(r,'DLmr/el')} | {f(r,'DLmw/el')} | {f(r,'Bc/el',1)} | {f(r,'Bcm/el')} | {f(r,'Bi/el')} |")

out.append('\n## T2. Кривая по N (U = N/2): промахи LL на элемент — где ступенька\n')
for tc in ('gcc', 'libcxx'):
    for c in ('E', 'P', 'X'):
        out.append(f'\n### {TC[tc]}, {CACHE[c]}\n')
        out.append('| N | sort LLm | uset LLm | flat LLm | sort D1m | uset D1m | flat D1m | uset Ir | sort Ir |')
        out.append('|---|---|---|---|---|---|---|---|---|')
        for n in (65536, 131072, 262144, 524288, 1048576, 2097152):
            g = {a: sel(group='curve', toolchain=tc, alg=a, cache=c, N=n) for a in ('sort', 'uset', 'flat')}
            if not all(g.values()): continue
            s, u, fl = g['sort'][0], g['uset'][0], g['flat'][0]
            out.append(f"| {n//1024}K | {f(s,'DLm/el')} | {f(u,'DLm/el')} | {f(fl,'DLm/el')} | {f(s,'D1m/el')} | {f(u,'D1m/el')} | {f(fl,'D1m/el')} | {f(u,'Ir/el',0)} | {f(s,'Ir/el',0)} |")

out.append('\n## T3. Фазы unordered_set / flat_hash_set (callgrind_annotate --inclusive), N = 2^20, на элемент\n')
for tc in ('gcc', 'libcxx'):
    for u in (1048576, 524288):
        for c in ('X', 'E', 'P'):
            sub = [p for p in ph if p['toolchain'] == tc and p['cache'] == c and p['U'] == str(u) and p['N'] == '1048576'
                   and p['alg'] in ('uset_phased', 'flat_phased') and p['func'] in ('phase_insert', 'phase_dump', 'phase_dtor', 'operator new', 'operator delete', '_M_rehash', 'rehash', 'measured_call')]
            if not sub: continue
            out.append(f'\n### {TC[tc]}, U = {u}, {CACHE[c]}\n')
            out.append('| алгоритм | фаза/функция | Ir | Dr | D1m | LLm | Bc | Bcm |')
            out.append('|---|---|---|---|---|---|---|---|')
            seen = set()
            for p in sub:
                key = (p['alg'], p['func'])
                if key in seen: continue  # первая строка — самая дорогая (annotate сортирует по Ir)
                seen.add(key)
                out.append(f"| {p['alg']} | {p['func']} | {f(p,'Ir/el',1)} | {f(p,'Dr/el',1)} | {f(p,'D1m/el')} | {f(p,'DLm/el')} | {f(p,'Bc/el',1)} | {f(p,'Bcm/el')} |")

out.append('\n## T4. Порядок входа, N = 2^20, U = N/2, кэш X\n')
out.append('| связка | алгоритм | порядок | Ir | Dr | Dw | D1m | LLm | Bc | Bcm | Bcm/Bc |')
out.append('|---|---|---|---|---|---|---|---|---|---|---|')
for tc in ('gcc', 'libcxx'):
    for a in ('sort', 'uset'):
        for o in ('random', 'runs', 'sorted'):
            for r in sel(group='order', toolchain=tc, alg=a, order=o):
                out.append(f"| {TC[tc]} | {a} | {o} | {f(r,'Ir/el',1)} | {f(r,'Dr/el',1)} | {f(r,'Dw/el',1)} | {f(r,'D1m/el')} | {f(r,'DLm/el')} | {f(r,'Bc/el',1)} | {f(r,'Bcm/el',2)} | {100*float(r['Bcm/el'])/max(float(r['Bc/el']),1e-9):.1f}% |")
cp = os.path.join(D, 'compares.txt')
if os.path.exists(cp):
    out.append('\nСравнения std::sort на элемент (счётчик в компараторе, без valgrind):\n')
    out.append('```'); out.append(open(cp).read().strip()); out.append('```')

out.append('\n## T5. learned: N = 1024, U = 512, 64 вызова, кэш X (D1 48 КБ)\n')
out.append('| связка | алгоритм | вариант | Ir | D1m | LLm | Bc | Bcm | Bcm/Bc |')
out.append('|---|---|---|---|---|---|---|---|---|')
LM = {'learned_a': 'a: один буфер, вход восстанавливается', 'learned_b': 'b: 64 одинаковые копии', 'learned_c': 'c: 64 разных'}
for tc in ('gcc', 'libcxx'):
    for a in ('sort', 'radix'):
        for m in ('learned_a', 'learned_b', 'learned_c'):
            for r in sel(group='learned', toolchain=tc, alg=a, mode=m):
                out.append(f"| {TC[tc]} | {a} | {LM[m]} | {f(r,'Ir/el',1)} | {f(r,'D1m/el',3)} | {f(r,'DLm/el',3)} | {f(r,'Bc/el',1)} | {f(r,'Bcm/el',3)} | {100*float(r['Bcm/el'])/max(float(r['Bc/el']),1e-9):.1f}% |")

out.append('\n## T6. Слияние (E8): локальные 2^20 отсортированы + дельта 2^16, на элемент входа\n')
out.append('| связка | кэш | алгоритм | Ir | Dr | Dw | D1m | LLm | Bc | Bcm |')
out.append('|---|---|---|---|---|---|---|---|---|---|')
for tc in ('gcc', 'libcxx'):
    for c in ('X', 'P'):
        for a in ('sort', 'uset', 'flat', 'radix', 'merge_inplace', 'merge_union'):
            for r in sel(group='merge', toolchain=tc, alg=a, cache=c):
                out.append(f"| {TC[tc]} | {c} | {a} | {f(r,'Ir/el',1)} | {f(r,'Dr/el',1)} | {f(r,'Dw/el',1)} | {f(r,'D1m/el')} | {f(r,'DLm/el')} | {f(r,'Bc/el',1)} | {f(r,'Bcm/el')} |")

out.append('\n## T7. Плотные ключи (E7) против случайных, N = 2^20, U = N/2, кэш X\n')
out.append('| связка | алгоритм | ключи | Ir | D1m | LLm | Bc | Bcm |')
out.append('|---|---|---|---|---|---|---|---|')
for tc in ('gcc', 'libcxx'):
    for a in ('sort', 'uset'):
        for r in sel(group='dense', toolchain=tc, alg=a) + sel(group='main', toolchain=tc, alg=a, cache='X', U=524288):
            out.append(f"| {TC[tc]} | {a} | {r['keys']} | {f(r,'Ir/el',1)} | {f(r,'D1m/el')} | {f(r,'DLm/el')} | {f(r,'Bc/el',1)} | {f(r,'Bcm/el')} |")
open(os.path.join(D, 'tables.md'), 'w').write('\n'.join(out) + '\n')
print('\n'.join(out))
