#!/usr/bin/env python3
# Разрезает .s на функции (по меткам вида name: после .type name,@function) и
# печатает по запросу: python3 split_asm.py file.s [name-substring]
import re, sys
src = open(sys.argv[1]).read().split('\n')
funcs = {}; cur = None
for line in src:
    m = re.match(r'^([A-Za-z_.$][\w.$]*):', line)
    if m and not line.startswith('.L') and not line.startswith('.Ltmp'):
        cur = m.group(1); funcs[cur] = []
    if cur: funcs[cur].append(line)
if len(sys.argv) == 2:
    for k, v in funcs.items():
        n = sum(1 for l in v if l.strip() and not l.strip().startswith(('.', '#')) and not l.rstrip().endswith(':'))
        if n: print(f'{n:6d}  {k}')
else:
    for k, v in funcs.items():
        if sys.argv[2] in k:
            print('\n'.join(v))
