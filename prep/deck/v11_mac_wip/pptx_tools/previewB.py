"""QA for the editable variant: draws every slide from spec.json with the embedded fonts by the PowerPoint layout model
(build/B/prev-NN.png) and compares it with the browser render (build/A/NN-final.png); writes build/B/compare-K.png sheets."""
import json
from pathlib import Path
from PIL import Image, ImageDraw, ImageFont, ImageChops, ImageStat
ROOT=Path(__file__).resolve().parent; B=ROOT/'build'
spec=json.load(open(B/'B/spec.json'))
FD=str(ROOT/'fonts/embed')+'/'
FILES={('Montserrat',False):'Montserrat-Regular.ttf',('Montserrat',True):'Montserrat-Bold.ttf',('Montserrat Medium',False):'Montserrat-Medium.ttf',('Montserrat SemiBold',False):'Montserrat-SemiBold.ttf',
       ('Montserrat ExtraBold',False):'Montserrat-ExtraBold.ttf',('JetBrains Mono',False):'JetBrainsMono-Regular.ttf',('JetBrains Mono',True):'JetBrainsMono-Bold.ttf'}
cache={}
def font(face,bold,px):
    k=(face,bold,round(px*4)/4)
    if k not in cache: cache[k]=ImageFont.truetype(FD+FILES.get((face,bold),FILES.get((face,False),'Montserrat-Regular.ttf')),size=max(1,round(px)))
    return cache[k]
S=144  # px per inch at 1920 width
def hexc(h,t=0): return tuple(int(h[i:i+2],16) for i in (0,2,4))+(round(255*(1-t/100)),)
widths=[]
def render(s):
    im=Image.new('RGBA',(1920,1080),hexc(s['bg']))
    for sh in s['shapes']:
        x,y,w,h=sh['x']*S,sh['y']*S,sh['w']*S,sh['h']*S
        if sh['t'] in('rect','round'):
            lay=Image.new('RGBA',im.size,(0,0,0,0)); d=ImageDraw.Draw(lay)
            fill=hexc(sh['fill'],sh.get('fillT',0)) if 'fill' in sh else None
            out=hexc(sh['line'],sh.get('lineT',0)) if 'line' in sh else None
            lw=round(sh.get('lineW',0)*2) if out else 0
            if sh['t']=='round': d.rounded_rectangle([x,y,x+w,y+h],radius=sh['rad']*S,fill=fill,outline=out,width=lw)
            else: d.rectangle([x,y,x+w,y+h],fill=fill,outline=out,width=lw)
            im.alpha_composite(lay)
        elif sh['t']=='line':
            lay=Image.new('RGBA',im.size,(0,0,0,0)); d=ImageDraw.Draw(lay)
            d.line([x,y,x+w,y+h],fill=hexc(sh['line'],sh.get('lineT',0)),width=max(1,round(sh['lineW']*2))); im.alpha_composite(lay)
        elif sh['t'] in ('img','video'):
            p=Image.open(sh['path'] if sh['t']=='img' else sh['poster']).convert('RGBA').resize((max(1,round(w)),max(1,round(h))))
            im.alpha_composite(p,(round(x),round(y)))
        elif sh['t']=='text':
            L=sh['ls']*2; d=ImageDraw.Draw(im)
            # split runs into lines
            lines=[[]]
            for r in sh['runs']:
                lines[-1].append(r)
                if r['options'].get('breakLine'): lines.append([])
            for li,ln in enumerate(lines):
                base=y+0.8*L+li*L
                # measure
                segs=[];tw=0
                for r in ln:
                    o=r['options']; f=font(o['fontFace'],o.get('bold',False),o['fontSize']*2); sp=o.get('charSpacing',0)*2
                    for ch in r['text']:
                        a=f.getlength(ch)+sp; segs.append((ch,f,a,o)); tw+=a
                widths.append((s['n'],tw))
                al=sh['align']; cx=x if al=='left' else x+(w-tw)/2 if al=='center' else x+w-tw
                for ch,f,a,o in segs:
                    col=hexc(o['color'],o.get('transparency',0))
                    d.text((cx,base),ch,font=f,fill=col,anchor='ls'); cx+=a
    return im
res=[]
for s in spec:
    im=render(s).convert('RGB'); im.save(B/f"B/prev-{s['n']:02d}.png")
    fin=Image.open(B/f"A/{s['n']:02d}-final.png").convert('RGB')
    dd=ImageChops.difference(fin,im).convert('L'); res.append((s['n'],s['id'],round(ImageStat.Stat(dd).mean[0],2)))
res.sort(key=lambda r:-r[2]); print('mean pixel diff, worst first:',res[:8])
ns=[s['n'] for s in spec]
for k in range(0,len(ns),13):
    part=ns[k:k+13]; W=Image.new('RGB',(1300,325*len(part)),(60,60,60))
    for i,n in enumerate(part):
        W.paste(Image.open(B/f'A/{n:02d}-final.png').convert('RGB').resize((576,324)),(60,325*i))
        W.paste(Image.open(B/f'B/prev-{n:02d}.png').convert('RGB').resize((576,324)),(700,325*i))
    W.save(B/f'B/compare-{k//13}.png')
print('compare sheets: build/B/compare-*.png (left: deck, right: PowerPoint model)')
