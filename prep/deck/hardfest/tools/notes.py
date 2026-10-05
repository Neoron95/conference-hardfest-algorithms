#!/usr/bin/env python3
"""Rewrite speaker notes of every slide: spoken text first, then a rule, then timing, click map,
fallback lines and reference material. Reads the click map from steps.json (tools/steps.js)."""
import re, json, os, html
HERE = os.path.dirname(os.path.abspath(__file__))
steps = json.load(open('/tmp/hardfest-steps/steps.json'))
deck = json.load(open(os.path.join(HERE, '..', 'deck.json')))
RULE = '━━━━━━━━━━━━━━━━━━━━━━━━'
MARKERS = ('Если отстаю', 'Под рукой', 'Условия и источники', 'С экрана убрано')
for sid in deck['order']:
    p = os.path.join(HERE, '..', 'slides', sid + '.html')
    s = open(p).read()
    m = re.search(r'<aside>(.*)</aside>', s, re.S)
    a = m.group(1)
    if RULE in a:  # already restructured: take the spoken part and rebuild the rest from the archive
        continue
    paras = [x.strip() for x in a.split('<br>')]
    timing = None
    spoken, rest = [], []
    tail = False
    for x in paras:
        if not x: continue
        if x.startswith('План '):
            mm = re.match(r'План ([\d:]+) · к концу ([\d:]+)\.?', x)
            timing = f'Тайминг: {mm.group(1)}, к концу {mm.group(2)}.' if mm else x
            continue
        if x.startswith(MARKERS): tail = True
        (rest if tail else spoken).append(x)
    clicks = steps.get(sid, {})
    cm = '; '.join(f'{k} — ' + ', '.join(t.rstrip('.') for t in clicks[k] if t != '[фигура]') for k in sorted(clicks, key=int))
    # keep "Под рукой:" bullets together: they already come as separate paragraphs starting with •
    below = []
    if timing: below.append(timing)
    below.append('Щелчки: ' + (cm if cm else 'нет, всё на экране сразу') + '.')
    below += rest
    new = '<br>'.join(spoken) + '<br>' + RULE + '<br>' + '<br>'.join(below)
    s = s.replace(a, new)
    open(p, 'w').write(s)
    n = len(re.findall(r'\[щелчок', '<br>'.join(spoken)))
    print(f'{sid:14} clicks in speech={n} steps={len(clicks)}{"" if n==len(clicks) else "  <-- CHECK"}')
