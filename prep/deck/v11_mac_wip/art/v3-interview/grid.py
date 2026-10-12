# usage: python3 grid.py out.png cols label1=img1 ...
import sys
from PIL import Image, ImageDraw, ImageFont
out, cols = sys.argv[1], int(sys.argv[2]); items=[a.rsplit('=',1) for a in sys.argv[3:]]
W,H=546,373
f=ImageFont.truetype('/tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/fonts/f1.ttf',22) if False else ImageFont.load_default()
rows=(len(items)+cols-1)//cols
sheet=Image.new('RGB',(cols*W+(cols+1)*8, rows*(H+30)+8),(24,24,24))
d=ImageDraw.Draw(sheet)
for i,(lab,p) in enumerate(items):
    im=Image.open(p).convert('RGB').resize((W,H),Image.LANCZOS)
    x=8+(i%cols)*(W+8); y=8+(i//cols)*(H+30)
    sheet.paste(im,(x,y+22)); d.text((x+4,y+4),lab,fill=(240,240,240),font=f)
sheet.save(out)
