#!/usr/bin/env python3
"""Apply slide documents saved by the web editor (ArtifactData JSON files) to slides/<id>.html.
usage: apply_db.py <dir with slides/<id>.json>   -- only docs with "edited": true are applied."""
import sys, os, json, glob
HERE = os.path.dirname(os.path.abspath(__file__))
src = sys.argv[1]
n = 0
for f in sorted(glob.glob(os.path.join(src, 'slides', '*.json'))):
    d = json.load(open(f))
    if not d.get('edited'): continue
    sid = d['id']
    attrs = (d.get('attrs') or '').strip()
    hid = ' hidden' if d.get('hidden') else ''
    head = f'<section id="{sid}"{hid}{(" " + attrs) if attrs else ""}>'
    kh = f'<p class="k">{d["kicker"]}</p>\n' if d.get('kicker') else ''
    th = f'<h2 class="t{"" if kh else " nok"}">{d["title"]}</h2>\n' if d.get('title') else ''
    out = f'{head}\n{kh}{th}<!-- body -->\n{d.get("body", "").strip()}\n<!-- /body -->\n<aside>{d.get("notes", "")}</aside>\n</section>\n'
    open(os.path.join(HERE, '..', 'slides', sid + '.html'), 'w').write(out)
    print('applied', sid, d.get('updatedAt', ''))
    n += 1
print(n, 'slides applied')
