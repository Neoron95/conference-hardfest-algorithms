#!/usr/bin/env python3
"""Replace kicker / title / body of a v2 slide, keeping its <aside> notes.
usage: setslide.py <id> <body.html|-> [--k "kicker html"] [--t "title html"] [--attrs 'data-logo="big"']"""
import sys, re, os, argparse
ap = argparse.ArgumentParser()
ap.add_argument('id'); ap.add_argument('body')
ap.add_argument('--k'); ap.add_argument('--t'); ap.add_argument('--attrs'); ap.add_argument('--note')
a = ap.parse_args()
p = os.path.join(os.path.dirname(__file__), '..', 'slides', a.id + '.html')
s = open(p).read()
body = sys.stdin.read() if a.body == '-' else open(a.body).read()
m = re.search(r'<aside>.*</aside>', s, re.S)
aside = m.group(0)
if a.note is not None:   # text removed from the screen goes to the notes (one marker paragraph, replaced on re-run)
    aside = re.sub(r'<br>С экрана убрано: .*?(?=<br>|</aside>)', '', aside)
    if a.note:
        aside = aside.replace('</aside>', '<br>С экрана убрано: ' + a.note + '</aside>')
head = re.match(r'<section[^>]*>', s).group(0)
if a.attrs is not None:
    hid = ' hidden' if ' hidden' in head else ''
    head = f'<section id="{a.id}"{hid} {a.attrs}>'.replace(' >', '>')
k = re.search(r'<p class="k">.*?</p>\n', s, re.S)
t = re.search(r'<h2 class="t[^"]*">.*?</h2>\n', s, re.S)
kh = (f'<p class="k">{a.k}</p>\n' if a.k else '') if a.k is not None else (k.group(0) if k else '')
th = (f'<h2 class="t{" nok" if not kh else ""}">{a.t}</h2>\n' if a.t else '') if a.t is not None else (t.group(0) if t else '')
out = f'{head}\n{kh}{th}<!-- body -->\n{body.strip()}\n<!-- /body -->\n{aside}\n</section>\n'
open(p, 'w').write(out)
print('ok', a.id)
