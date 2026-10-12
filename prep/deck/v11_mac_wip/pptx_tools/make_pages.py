"""Step 1. Slide HTML from ../project -> build/pages/*.html (local assets and fonts), build/pages.json, build/durs.json.
Usage: python3 make_pages.py"""
import json, re, html, os, struct
from pathlib import Path
ROOT = Path(__file__).resolve().parent
PROJ = ROOT.parent / 'project'
ASSETS = ROOT / 'assets'
B = ROOT / 'build'

def asset(i):
    for p in ASSETS.glob(i + '.*'):
        return p
    raise SystemExit(f'asset {i} not found in {ASSETS} — download it from the deck (Artifact asset) and save as assets/{i}.<ext>')

def mp4_duration_ms(path):
    data = open(path, 'rb').read(); i = data.find(b'mvhd')
    if i < 0: return 5000
    if data[i + 4] == 1: ts, dur = struct.unpack('>IQ', data[i + 24:i + 36])
    else: ts, dur = struct.unpack('>II', data[i + 16:i + 24])
    return int(dur * 1000 / ts) if ts else 5000

def main():
    (B / 'pages').mkdir(parents=True, exist_ok=True)
    css = (ROOT / 'fonts/web/local.css').read_text()
    css = re.sub(r'url\(([^)/]+\.woff2)\)', lambda m: 'url(' + (ROOT / 'fonts/web' / m.group(1)).as_uri() + ')', css)
    order = json.load(open(PROJ / 'deck.json'))['order']
    pages, durs = [], {}
    for n, s in enumerate(order, 1):
        h = (PROJ / 'slides' / f'{s}.html').read_text()
        if re.search(r'<section[^>]*\bhidden', h):
            continue  # hidden slides are not exported
        asd = h[h.index('<aside>') + 7:h.index('</aside>')] if '<aside>' in h else ''
        body = re.sub(r'<aside>.*?</aside>', '', h, flags=re.S)
        def vid(m):
            p = asset(m.group(2)); durs[str(p)] = mp4_duration_ms(p); return m.group(1) + str(p)
        body = re.sub(r'(data-video=")/_blob/([0-9a-f]{32})', vid, body)
        body = re.sub(r'/_blob/([0-9a-f]{32})', lambda m: asset(m.group(1)).as_uri(), body)
        body = re.sub(r'(<section[^>]*?)style="', r'\1style="position:relative;width:1920px;height:1080px;overflow:hidden;', body, count=1)
        f = B / 'pages' / f'{len(pages) + 1:02d}-{s}.html'
        f.write_text('<html><head><meta charset="utf-8"><style>' + css +
                     ' body{margin:0;background:#000} p,h1,h2,h3{margin:0}</style></head><body>' + body + '</body></html>')
        t = re.sub(r'<[^>]+>', '', asd.replace('<br>', '\n'))
        pages.append({'n': len(pages) + 1, 'id': s, 'page': str(f), 'notes': html.unescape(t).strip()})
    json.dump(pages, open(B / 'pages.json', 'w'), ensure_ascii=False, indent=1)
    json.dump(durs, open(B / 'durs.json', 'w'), indent=1)
    print('pages', len(pages), 'videos', len(durs))

if __name__ == '__main__':
    main()
