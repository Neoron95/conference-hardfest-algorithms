#!/usr/bin/env python3
"""Разбор callgrind.out.* → строка CSV с метриками на элемент.

Использование: cg_parse.py <callgrind.out> <elements> [метка...]
Печатает: label,Ir/el,Bc/el,Bcm/el,Bcm/Bc%,Bi/el,Bim/el,D1mr/el,DLmr/el,Dr/el
"""
import sys

def parse(path):
    events, summary = None, None
    with open(path, encoding='utf-8', errors='replace') as f:
        for line in f:
            if line.startswith('events:'):
                events = line.split(':', 1)[1].split()
            elif line.startswith('summary:') or line.startswith('totals:'):
                summary = [int(x) for x in line.split(':', 1)[1].split()]
    if events is None or summary is None:
        raise SystemExit(f'no events/summary in {path}')
    return dict(zip(events, summary))

def main():
    path, n = sys.argv[1], float(sys.argv[2])
    label = ','.join(sys.argv[3:])
    d = parse(path)
    g = lambda k: d.get(k, 0)
    bc, bcm = g('Bc'), g('Bcm')
    print(f"{label},{g('Ir')/n:.2f},{bc/n:.3f},{bcm/n:.4f},{(100*bcm/bc if bc else 0):.1f},"
          f"{g('Bi')/n:.4f},{g('Bim')/n:.4f},{g('D1mr')/n:.4f},{g('DLmr')/n:.4f},{g('Dr')/n:.2f}")

if __name__ == '__main__':
    main()
