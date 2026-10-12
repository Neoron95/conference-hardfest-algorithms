# usage: python3 grid.py out.png cols scale img1 img2 ...  (labels = file stem)
import sys
from PIL import Image, ImageDraw
out, cols, sc = sys.argv[1], int(sys.argv[2]), float(sys.argv[3])
ims = [Image.open(p).convert('RGB') for p in sys.argv[4:]]
w, h = int(ims[0].width*sc), int(ims[0].height*sc)
rows = (len(ims)+cols-1)//cols
G = Image.new('RGB', (cols*w + (cols+1)*8, rows*h + (rows+1)*8), (60,60,60))
d = ImageDraw.Draw(G)
for i, (im, p) in enumerate(zip(ims, sys.argv[4:])):
    x = 8 + (i % cols)*(w+8); y = 8 + (i//cols)*(h+8)
    G.paste(im.resize((w, h), Image.LANCZOS), (x, y))
    d.text((x+6, y+4), p.split('/')[-1], fill=(255,255,0))
G.save(out)
