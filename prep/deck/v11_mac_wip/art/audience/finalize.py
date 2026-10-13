# usage: python3 finalize.py srcdir dstdir names... -> horizontally centre each figure by its alpha bbox (keeps scale and floor line)
import sys
from PIL import Image
src, dst, *names = sys.argv[1:]
for n in names:
    im = Image.open(f'{src}/{n}.png').convert('RGBA')
    a = im.getchannel('A').point(lambda v: 255 if v > 10 else 0)
    x0, y0, x1, y1 = a.getbbox()
    dx = round(im.width / 2 - (x0 + x1) / 2)
    out = Image.new('RGBA', im.size, (0, 0, 0, 0))
    out.paste(im, (dx, 0))
    out.save(f'{dst}/{n}.png')
    print(n, 'bbox', (x0, y0, x1, y1), 'shift', dx, '-> x', x0 + dx, x1 + dx, 'margins top/bottom', y0, im.height - y1)
