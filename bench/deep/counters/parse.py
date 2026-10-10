#!/usr/bin/env python3
"""Сводит results/raw/*.out (callgrind) и *.meta (stdout харнесса) в
results/counters.csv (все события на элемент входа) и results/phases.csv
(фазы uset_phased / flat_phased и ключевые функции по callgrind_annotate --inclusive).
Запуск: ./parse.py  (из каталога bench/deep/counters)."""
import csv, glob, os, re, sys

RAW = os.path.join(os.path.dirname(os.path.abspath(__file__)), 'results', 'raw')
OUT = os.path.join(os.path.dirname(RAW))
EV = None

def read_out(path):
    events, totals = None, None
    with open(path) as f:
        for line in f:
            if line.startswith('events:'): events = line.split(':', 1)[1].split()
            elif line.startswith('totals:'): totals = [int(x) for x in line.split(':', 1)[1].split()]
    return events, totals

def read_meta(path):
    d = {}
    with open(path) as f:
        for line in f:
            for kv in line.split():
                if '=' in kv:
                    k, v = kv.split('=', 1); d[k] = v
    return d

def parse_ann(path):
    """Строки callgrind_annotate: список (значения по событиям, имя функции с файлом)."""
    rows = []
    if not os.path.exists(path): return rows
    with open(path) as f:
        for line in f:
            if not re.match(r'^\s*[\d,]+ \(', line): continue
            nums = re.findall(r'([\d,]+|\.) *\([ \d.]+%\)|(?<= )\.(?= )', line)
            vals = [int(n[0].replace(',', '')) if n and n[0] not in ('', '.') else 0
                    for n in re.findall(r'(?:([\d,]+) *\([ \d.]+%\)|(?<=\s)(\.)(?=\s))', line)]
            name = line.rsplit('  ', 1)[-1].strip()
            rows.append((vals, name))
    return rows

rows, prow = [], []
for out in sorted(glob.glob(os.path.join(RAW, '*.out'))):
    base = out[:-4]
    name = os.path.basename(base)
    events, totals = read_out(out)
    if not totals: print('no totals:', name, file=sys.stderr); continue
    EV = events
    meta = read_meta(base + '.meta')
    el = float(meta.get('elements', 0) or 0)
    if not el: print('no elements:', name, file=sys.stderr); continue
    group, tc, cache, _ = name.split('__', 3)
    r = dict(group=group, toolchain=tc, cache=cache, alg=meta['alg'], mode=meta['mode'], N=meta['N'], U=meta['U'],
             keys=meta['keys'], order=meta['order'], calls=meta['calls'], elements=int(el))
    for e, t in zip(events, totals): r[e + '/el'] = round(t / el, 4)
    r['DLm/el'] = round((totals[events.index('DLmr')] + totals[events.index('DLmw')]) / el, 4)
    r['D1m/el'] = round((totals[events.index('D1mr')] + totals[events.index('D1mw')]) / el, 4)
    rows.append(r)
    if r['alg'].endswith('_phased') or group in ('main', 'merge'):
        for vals, fname in parse_ann(base + '.ann'):
            if len(vals) != len(events): continue
            short = None
            for key in ('phase_insert', 'phase_dump', 'phase_dtor', 'operator new', 'operator delete', '_M_rehash', 'rehash',
                        '_M_insert_unique', '__hash_table', '__emplace_unique', 'raw_hash_set', 'memcpy', 'memmove',
                        '__introsort_loop', '__sort', '__insertion_sort', 'unique', 'measured_call', 'malloc', 'free',
                        '__partition', 'inplace_merge', 'set_union', 'resize'):
                if key in fname: short = key; break
            if not short: continue
            if fname.startswith('/') and ':' in fname and not fname.split(':', 1)[0].endswith('.cpp') and 'counters.cpp' not in fname:
                pass
            p = dict(name=name, toolchain=tc, cache=cache, alg=r['alg'], N=r['N'], U=r['U'], func=short,
                     file=fname.split(':', 1)[0] if ':' in fname else '', full=fname[:160])
            for e, t in zip(events, vals): p[e + '/el'] = round(t / el, 4)
            p['DLm/el'] = round((vals[events.index('DLmr')] + vals[events.index('DLmw')]) / el, 4)
            p['D1m/el'] = round((vals[events.index('D1mr')] + vals[events.index('D1mw')]) / el, 4)
            prow.append(p)

if rows:
    keys = list(rows[0].keys())
    with open(os.path.join(OUT, 'counters.csv'), 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=keys); w.writeheader(); w.writerows(rows)
if prow:
    keys = list(prow[0].keys())
    with open(os.path.join(OUT, 'phases.csv'), 'w', newline='') as f:
        w = csv.DictWriter(f, fieldnames=keys); w.writeheader(); w.writerows(prow)
print(f'{len(rows)} runs, {len(prow)} function rows; events: {EV}')
