import json
from PIL import Image, ImageDraw, ImageFont, ImageChops, ImageStat
spec=json.load(open('B/spec.json'))
FD='../fonts_embed/'
FILES={('Montserrat',False):'g3.ttf',('Montserrat',True):'g6.ttf',('Montserrat Medium',False):'g4.ttf',('Montserrat SemiBold',False):'g5.ttf',
       ('Montserrat ExtraBold',False):'g7.ttf',('JetBrains Mono',False):'g1.ttf',('JetBrains Mono',True):'g2.ttf'}
cache={}
def font(face,bold,px):
    k=(face,bold,round(px*4)/4)
    if k not in cache: cache[k]=ImageFont.truetype(FD+FILES.get((face,bold),FILES[(face,False)] if (face,False) in FILES else 'g3.ttf'),size=max(1,round(px)))
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
    im=render(s).convert('RGB'); im.save(f"B/prev-{s['n']:02d}.png")
    fin=Image.open(f"A/{s['n']:02d}-final.png").convert('RGB')
    dd=ImageChops.difference(fin,im).convert('L'); res.append((s['n'],s['id'],round(ImageStat.Stat(dd).mean[0],2)))
res.sort(key=lambda r:-r[2]); print(res[:15])
