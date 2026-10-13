"""Step 3B. prims.json -> spec.json: PowerPoint text boxes with forced line breaks, shapes, pictures.
Layout model: 1 px = 1/144 in = 0.5 pt; first baseline = box top + 0.8 * line spacing (PowerPoint, exact spacing)."""
import json, re
from urllib.parse import unquote
from pathlib import Path
from PIL import Image
B=Path(__file__).resolve().parent/'build'
D=json.load(open(B/'B/prims.json'))
PX=1/144  # inch per px
PT=0.5    # pt per px
MET={'Montserrat':(0.968,0.251),'JetBrains Mono':(1.020,0.300),'IBM Plex Mono':(1.025,0.275)}
def rgba(s):
    m=re.match(r'rgba?\(([\d.]+),\s*([\d.]+),\s*([\d.]+)(?:,\s*([\d.]+))?\)',s or '')
    if not m: return None
    r,g,b=(int(float(m.group(i))) for i in (1,2,3)); a=float(m.group(4)) if m.group(4) else 1.0
    return '%02X%02X%02X'%(r,g,b), a
def face(ff,fw):
    fam=ff.split(',')[0].strip('"\' '); w=int(fw)
    if fam=='Montserrat':
        if w<=450: return 'Montserrat',False
        if w<550: return 'Montserrat Medium',False
        if w<650: return 'Montserrat SemiBold',False
        if w<750: return 'Montserrat',True
        return 'Montserrat ExtraBold',False
    if fam=='JetBrains Mono': return 'JetBrains Mono', w>=600
    if fam=='IBM Plex Mono':
        if w<=450: return 'IBM Plex Mono',False
        if w<650: return 'IBM Plex Mono Medium',False
        return 'IBM Plex Mono',True
    return fam, w>=600
def tt(s,t):
    return s.upper() if t=='uppercase' else s.lower() if t=='lowercase' else s
spec=[]; stats={'lines':0,'boxes':0}
for s in D:
    shapes=[]
    for p in s['prims']:
        g=p['group']
        if p['type']=='box':
            r=p['rect']; br=p['borders']; fill=rgba(p['bg']) if p['bg'] else None
            vis=[b for b in br if b['w']>0 and b['s']!='none' and (rgba(b['c']) or ('',0))[1]>0]
            allsame=len(vis)==4 and len({(b['w'],b['c']) for b in vis})==1
            if fill or allsame:
                bw=vis[0]['w'] if allsame else 0
                x,y,w,h=r['x']+bw/2,r['y']+bw/2,r['w']-bw,r['h']-bw
                sh={'t':'rect','x':x*PX,'y':y*PX,'w':max(w,1)*PX,'h':max(h,1)*PX,'g':g}
                if fill: sh['fill']=fill[0]; sh['fillT']=round((1-fill[1])*100)
                if allsame:
                    c=rgba(vis[0]['c']); sh['line']=c[0]; sh['lineW']=bw*0.75*PT/0.75 if False else bw*PT; sh['lineT']=round((1-c[1])*100)
                    if vis[0]['s'] in ('dashed','dotted'): sh['dash']='dash' if vis[0]['s']=='dashed' else 'sysDot'
                rad=min(p['radius'],min(r['w'],r['h'])/2)
                if rad>0.5: sh['t']='round'; sh['rad']=rad*PX
                shapes.append(sh); stats['boxes']+=1
            if not allsame:
                for side,b in zip(('top','right','bottom','left'),br):
                    if not (b['w']>0 and b['s']!='none'): continue
                    c=rgba(b['c'])
                    if not c or c[1]==0: continue
                    x,y,w,h=r['x'],r['y'],r['w'],r['h']; bw=b['w']
                    if side=='top': seg=(x,y+bw/2,w,0)
                    elif side=='bottom': seg=(x,y+h-bw/2,w,0)
                    elif side=='left': seg=(x+bw/2,y,0,h)
                    else: seg=(x+w-bw/2,y,0,h)
                    sh={'t':'line','x':seg[0]*PX,'y':seg[1]*PX,'w':seg[2]*PX,'h':seg[3]*PX,'line':c[0],'lineW':bw*PT,'lineT':round((1-c[1])*100),'g':g}
                    if b['s'] in ('dashed','dotted'): sh['dash']='dash' if b['s']=='dashed' else 'sysDot'
                    shapes.append(sh)
        elif p['type']=='text' and all(c['ch'] in '\u2713\u2717' or c['ch'].isspace() for c in p['chars']):
            r=p['rect']; box=(int(r['x'])-2,int(r['y'])-2,int(r['x']+r['w'])+2,int(r['y']+r['h'])+2)
            f=str(B/f"B/{s['n']:02d}-glyph{len(shapes)}.png"); Image.open(B/f"A/{s['n']:02d}-final.png").crop(box).save(f)
            shapes.append({'t':'img','alt':''.join(c['ch'] for c in p['chars']).strip() or 'Значок','path':f,'x':box[0]*PX,'y':box[1]*PX,'w':(box[2]-box[0])*PX,'h':(box[3]-box[1])*PX,'g':g})
        elif p['type']=='text':
            chars=p['chars']; fs=p['fs']
            L=float(p['lh'][:-2]) if p['lh'].endswith('px') else 1.22*fs
            lines=[]; cur=None
            for c in chars:
                if cur is None or c['t']>cur['t']+0.5*c['st']['fs']:
                    cur={'t':c['t'],'chars':[]}; lines.append(cur)
                cur['chars'].append(c)
            out_lines=[]
            for ln in lines:
                cs=ln['chars']
                while cs and cs[-1]['ch'].isspace(): cs=cs[:-1]
                while cs and cs[0]['ch'].isspace(): cs=cs[1:]
                if not cs: continue
                runs=[]
                for c in cs:
                    st=c['st']; key=(st['ff'],st['fw'],st['fs'],st['fst'],st['c'],st['ls'],st['tt'],st['dec'])
                    ch=c['ch'].replace(' ',' ')
                    if runs and runs[-1]['key']==key: runs[-1]['text']+=ch
                    else: runs.append({'key':key,'text':ch,'st':st})
                fam=cs[0]['st']['ff'].split(',')[0].strip('"\' '); asc,desc=MET.get(fam,(0.968,0.251))
                c0=max(cs,key=lambda c:c['st']['fs'])
                base=c0['t']+c0['h']*asc/(asc+desc)
                out_lines.append({'base':base,'x0':min(c['x'] for c in cs),'x1':max(c['r'] for c in cs),'runs':runs})
            if not out_lines: continue
            con=p['content']; al={'start':'left','left':'left','center':'center','right':'right','end':'right','justify':'left'}[p['align']]
            x,w=con['x'],con['w']
            mx0=min(l['x0'] for l in out_lines); mx1=max(l['x1'] for l in out_lines)
            if mx0<x-1: w+=x-mx0; x=mx0
            if mx1>x+w+1: w=mx1-x
            y=out_lines[0]['base']-0.8*L; h=L*len(out_lines)
            # gaps between lines may differ from L (e.g. separate blocks); use measured spacing when uniform
            pts=[]
            for li,ln in enumerate(out_lines):
                for ri,rn in enumerate(ln['runs']):
                    st=rn['st']; fc,bold=face(st['ff'],st['fw']); col=rgba(st['c'])
                    ls=st['ls']; cs_=float(ls[:-2])*PT if ls.endswith('px') else 0
                    o={'fontFace':fc,'fontSize':round(st['fs']*PT,2),'bold':bold,'color':col[0],'lang':'ru-RU'}
                    if col[1]<1: o['transparency']=round((1-col[1])*100)
                    if cs_: o['charSpacing']=round(cs_,2)
                    if st['fst']=='italic': o['italic']=True
                    if 'underline' in st['dec']: o['underline']={'style':'sng'}
                    if ri==len(ln['runs'])-1 and li<len(out_lines)-1: o['breakLine']=True
                    pts.append({'text':tt(rn['text'],st['tt']),'options':o})
            # line spacing: measured median gap if multiple lines else L
            gaps=[out_lines[i+1]['base']-out_lines[i]['base'] for i in range(len(out_lines)-1)]
            Lm=sorted(gaps)[len(gaps)//2] if gaps else L
            if gaps and abs(Lm-L)>1: y=out_lines[0]['base']-0.8*Lm; h=Lm*len(out_lines)
            shapes.append({'t':'text','x':x*PX,'y':y*PX,'w':w*PX,'h':h*PX,'align':al,'ls':round(Lm*PT,2),'runs':pts,'g':g,
                           'lines':[[r['text'] for r in l['runs']] for l in out_lines],'meas':[l['x1']-l['x0'] for l in out_lines],
                           'st':[[ (r['st']['ff'],r['st']['fw'],r['st']['fs'],r['st']['ls'],r['st']['tt']) for r in l['runs']] for l in out_lines]})
            stats['lines']+=len(out_lines)
        elif p['type']=='raster':
            c=p['clip']; shapes.append({'t':'img','alt':p.get('alt') or 'Иллюстрация','path':p['file'],'x':c['x']*PX,'y':c['y']*PX,'w':c['width']*PX,'h':c['height']*PX,'g':g})
        elif p['type']=='video':
            r=p['rect']; a=p['nw']/p['nh']; w,h=r['w'],r['h']
            if w/h>a: w=h*a
            else: h=w/a
            shapes.append({'t':'video','path':p['video'],'poster':unquote(p['poster'].replace('file://','')),'x':(r['x']+(r['w']-w)/2)*PX,'y':(r['y']+(r['h']-h)/2)*PX,'w':w*PX,'h':h*PX,'g':g})
    bg=rgba(s['bg'])
    spec.append({'n':s['n'],'id':s['id'],'bg':bg[0] if bg else '000000','notes':s['notes'],'shapes':shapes})
json.dump(spec,open(B/'B/spec.json','w'),ensure_ascii=False)
print(stats, sum(len(s['shapes']) for s in spec))
