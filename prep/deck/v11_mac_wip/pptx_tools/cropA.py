"""Step 3A. Crop click layers to content, then check: base + layers + video posters + overlays == final render."""
import json
from pathlib import Path
from PIL import Image, ImageChops, ImageStat
A = Path(__file__).resolve().parent / 'build' / 'A'
L = json.load(open(A / 'layers.json'))
bad = []
for s in L:
    comp = None
    for ly in s['layers']:
        im = Image.open(ly['file']).convert('RGBA')
        if ly['kind'] == 'base':
            comp = im.copy(); ly.update(x=0, y=0, w=1920, h=1080); continue
        bb = im.getchannel('A').getbbox()
        if not bb: ly['empty'] = True; continue
        f = ly['file'].replace('.png', 'c.png'); im.crop(bb).save(f)
        ly.update(cfile=f, x=bb[0], y=bb[1], w=bb[2] - bb[0], h=bb[3] - bb[1])
    def put(f, x, y, size=None):
        im = Image.open(f).convert('RGBA')
        if size: im = im.resize(size)
        comp.alpha_composite(im, (round(x), round(y)))
    for ly in s['layers']:
        if ly['kind'] == 'layer' and not ly.get('empty'): put(ly['cfile'], ly['x'], ly['y'])
    for v in s['videos']:
        f = v['fit']; put(v['poster'], f['x'], f['y'], (round(f['w']), round(f['h'])))
    for ly in s['layers']:
        if ly['kind'] == 'over' and not ly.get('empty'): put(ly['cfile'], ly['x'], ly['y'])
    d = ImageChops.difference(Image.open(s['final']).convert('RGB'), comp.convert('RGB')).convert('L')
    mean = ImageStat.Stat(d).mean[0]
    if mean > 0.6: bad.append((s['n'], s['id'], round(mean, 2)))
json.dump(L, open(A / 'layers.json', 'w'), indent=1)
print('layer check: slides differing from the reference render:', bad or 'none')
