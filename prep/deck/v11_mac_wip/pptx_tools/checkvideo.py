"""Step 8. Video check of built PPTX files against the deck (../project):
every shape id on a slide is unique (animations target shapes by id); each video is embedded with its poster and decodes
without errors (if imageio-ffmpeg is installed); it appears and starts on the same click as in the deck (no data-build-in =
plays right after the slide opens); it is set to loop until stopped. Exits with 1 on any problem.
Usage: python3 checkvideo.py out/*.pptx"""
import sys, re, json, zipfile, collections, subprocess, tempfile
from pathlib import Path
from lxml import etree
NS = {'p': 'http://schemas.openxmlformats.org/presentationml/2006/main', 'a': 'http://schemas.openxmlformats.org/drawingml/2006/main',
      'r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships', 'p14': 'http://schemas.microsoft.com/office/powerpoint/2010/main'}
R = '{%s}' % NS['r']
PROJ = Path(__file__).resolve().parent.parent / 'project'
try:
    import imageio_ffmpeg; FF = imageio_ffmpeg.get_ffmpeg_exe()
except ImportError:
    FF = None

order = json.load(open(PROJ / 'deck.json'))['order']
visible = [s for s in order if not re.search(r'<section[^>]*\shidden', (PROJ / 'slides' / f'{s}.html').read_text())]

def deck_clicks(sid):
    """(click on which each video of the slide appears and starts, total clicks on the slide)."""
    h = re.sub(r'<aside>.*?</aside>', '', (PROJ / 'slides' / f'{sid}.html').read_text(), flags=re.S)
    els = re.findall(r'<(?:img|p|div|svg|h1|h2|h3)\b[^>]*>', h)
    def step(e, attr):
        m = re.search(attr + r'="([^"]*)"', e)
        if not m: return 0, False
        n = re.search(r'\d+', m.group(1)); return (int(n.group()) if n else 1), 'auto' in m.group(1)
    steps = collections.defaultdict(list)
    for e in els:
        for attr in ('data-build-in', 'data-build-out'):
            k, auto = step(e, attr)
            if k: steps[k].append(auto)
    clicks = {k: sum(1 for j in steps if j <= k and not all(steps[j])) for k in steps}
    return [clicks[step(e, 'data-build-in')[0]] if step(e, 'data-build-in')[0] else 0 for e in els if 'data-video=' in e], \
           sum(1 for j in steps if not all(steps[j]))

def check(path):
    z = zipfile.ZipFile(path); names = set(z.namelist()); problems = []; nvid = 0
    slides = sorted((n for n in names if re.match(r'ppt/slides/slide\d+\.xml$', n)), key=lambda n: int(re.findall(r'\d+', n)[0]))
    for n in slides:
        sn = int(re.findall(r'\d+', n)[0]); x = etree.fromstring(z.read(n))
        dup = [i for i, c in collections.Counter(e.get('id') for e in x.iter('{%s}cNvPr' % NS['p'])).items() if c > 1]
        if dup: problems.append(f'slide {sn}: duplicate shape ids {dup}')
        pics = [p for p in x.iter('{%s}pic' % NS['p']) if p.find('.//a:videoFile', NS) is not None]
        if not pics: continue
        rels = {r.get('Id'): r.get('Target') for r in etree.fromstring(z.read(n.replace('slides/', 'slides/_rels/') + '.rels'))}
        want, nclicks = deck_clicks(visible[sn - 1])
        main = x.find('.//p:cTn[@nodeType="mainSeq"]', NS); blocks = []; k = 0
        for blk in (main.find('p:childTnLst', NS) if main is not None else []):
            conds = blk.findall('p:cTn/p:stCondLst/p:cond', NS)
            if any(c.get('delay') == 'indefinite' for c in conds) and not any(c.get('evt') == 'onBegin' for c in conds): k += 1
            blocks.append((k, blk))
        if k != nclicks: problems.append(f'slide {sn}: {k} clicks, the deck has {nclicks}')
        for vi, pic in enumerate(pics):
            nvid += 1; sid = pic.find('.//p:cNvPr', NS).get('id'); tag = f'slide {sn} ({visible[sn - 1]}) video {vi + 1}'
            parts = [pic.find('.//a:videoFile', NS).get(R + 'link'), pic.find('.//p14:media', NS).get(R + 'embed'), pic.find('.//a:blip', NS).get(R + 'embed')]
            files = ['ppt/' + (rels.get(p) or '?').replace('../', '') for p in parts]
            if not all(f in names for f in files): problems.append(f'{tag}: missing media/poster part'); continue
            if FF:
                with tempfile.NamedTemporaryFile(suffix='.mp4') as t:
                    t.write(z.read(files[1])); t.flush()
                    err = subprocess.run([FF, '-v', 'error', '-i', t.name, '-f', 'null', '-'], capture_output=True, text=True).stderr.strip()
                if err: problems.append(f'{tag}: does not decode: {err[:120]}')
            plays, entr = [], []
            for kk, blk in blocks:
                for e in blk.iter('{%s}cTn' % NS['p']):
                    pc = e.get('presetClass'); tg = e.find('.//p:spTgt', NS)
                    if not pc or tg is None or tg.get('spid') != sid: continue
                    cmd = e.find('.//p:cmd', NS)
                    if pc == 'mediacall' and cmd is not None and cmd.get('cmd').startswith('playFrom'): plays.append(kk)
                    if pc == 'entr': entr.append(kk)
            w = want[vi]
            if plays != [w]: problems.append(f'{tag}: starts on clicks {plays}, the deck: {w}')
            if entr != ([w] if w else []): problems.append(f'{tag}: appears on clicks {entr}, the deck: {w or "with the slide"}')
            node = [m for m in x.iter('{%s}cMediaNode' % NS['p']) if m.find('.//p:spTgt', NS).get('spid') == sid]
            if not node or node[0].find('p:cTn', NS).get('repeatCount') != 'indefinite': problems.append(f'{tag}: not set to loop')
    return nvid, problems

if __name__ == '__main__':
    bad = False
    for p in sys.argv[1:]:
        nvid, problems = check(p); bad |= bool(problems)
        print(f'{Path(p).name}: {nvid} videos' + ('' if FF else ' (decode check skipped: pip install imageio-ffmpeg)'), 'OK' if not problems else '')
        for pr in problems: print('  ', pr)
    sys.exit(1 if bad else 0)
