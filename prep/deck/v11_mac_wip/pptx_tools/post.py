"""Step 5. Post-process a pptxgenjs deck: click-sequenced fade-ins and fade-outs, video autoplay, embedded fonts (EOT .fntdata).
Usage: python3 post.py raw.pptx plan.json out.pptx fonts/embed [--kern]
  --kern  turn kerning on for every text run (editable variants)."""
import json, re, struct, sys, zipfile, io, itertools, os
from fontTools.ttLib import TTFont

def mp4_duration_ms(path):
    data=open(path,'rb').read()
    i=data.find(b'mvhd')
    if i<0: return 5000
    ver=data[i+4]
    if ver==1: ts,dur=struct.unpack('>IQ',data[i+4+4+16:i+4+4+16+12])
    else: ts,dur=struct.unpack('>II',data[i+4+4+8:i+4+4+8+8])
    return int(dur*1000/ts) if ts else 5000

def fade(ids,spid,nt):
    a,b,c=next(ids),next(ids),next(ids)
    return (f'<p:par><p:cTn id="{a}" presetID="10" presetClass="entr" presetSubtype="0" fill="hold" grpId="0" nodeType="{nt}">'
            f'<p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>'
            f'<p:set><p:cBhvr><p:cTn id="{b}" dur="1" fill="hold"><p:stCondLst><p:cond delay="0"/></p:stCondLst></p:cTn>'
            f'<p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl><p:attrNameLst><p:attrName>style.visibility</p:attrName></p:attrNameLst></p:cBhvr>'
            f'<p:to><p:strVal val="visible"/></p:to></p:set>'
            f'<p:animEffect transition="in" filter="fade"><p:cBhvr><p:cTn id="{c}" dur="500"/><p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cBhvr></p:animEffect>'
            f'</p:childTnLst></p:cTn></p:par>')

def fadeout(ids,spid,nt,grp):
    a,b,c=next(ids),next(ids),next(ids)
    return (f'<p:par><p:cTn id="{a}" presetID="10" presetClass="exit" presetSubtype="0" fill="hold" grpId="{grp}" nodeType="{nt}">'
            f'<p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>'
            f'<p:animEffect transition="out" filter="fade"><p:cBhvr><p:cTn id="{b}" dur="500"/><p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cBhvr></p:animEffect>'
            f'<p:set><p:cBhvr><p:cTn id="{c}" dur="1" fill="hold"><p:stCondLst><p:cond delay="499"/></p:stCondLst></p:cTn>'
            f'<p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl><p:attrNameLst><p:attrName>style.visibility</p:attrName></p:attrNameLst></p:cBhvr>'
            f'<p:to><p:strVal val="hidden"/></p:to></p:set>'
            f'</p:childTnLst></p:cTn></p:par>')

def play(ids,spid,dur,nt):
    a,b=next(ids),next(ids)
    return (f'<p:par><p:cTn id="{a}" presetID="1" presetClass="mediacall" presetSubtype="0" fill="hold" nodeType="{nt}">'
            f'<p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>'
            f'<p:cmd type="call" cmd="playFrom(0.0)"><p:cBhvr><p:cTn id="{b}" dur="{dur}" fill="hold"/>'
            f'<p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cBhvr></p:cmd></p:childTnLst></p:cTn></p:par>')

def build_timing(blocks, videos):
    """blocks: list of {'auto':bool,'steps':[[('fade'|'out'|'play', spid, dur), ...], ...]} — a block = one click (or auto start);
       steps inside a block run one after another (auto chain). videos: [(spid,dur)] for cMediaNode."""
    if not blocks and not videos: return ''
    ids=itertools.count(3)
    # a shape with both an entrance and an exit: the exit is build group 1
    entr={e[1] for blk in blocks for step in blk['steps'] for e in step if e[0]=='fade'}
    out=[]
    for bi,blk in enumerate(blocks):
        cid=next(ids)
        if blk['auto']:
            cond='<p:cond delay="indefinite"/><p:cond evt="onBegin" delay="0"><p:tn val="2"/></p:cond>' if bi==0 else '<p:cond delay="0"/>'
        else: cond='<p:cond delay="indefinite"/>'
        inner=[]; t=0
        for si,step in enumerate(blk['steps']):
            sid=next(ids); effs=[]
            for k,(kind,spid,dur) in enumerate(step):
                if k==0: nt='afterEffect' if (blk['auto'] or si>0) else 'clickEffect'
                else: nt='withEffect'
                effs.append(fade(ids,spid,nt) if kind=='fade' else fadeout(ids,spid,nt,1 if spid in entr else 0) if kind=='out' else play(ids,spid,dur,nt))
            inner.append(f'<p:par><p:cTn id="{sid}" fill="hold"><p:stCondLst><p:cond delay="{t}"/></p:stCondLst><p:childTnLst>{"".join(effs)}</p:childTnLst></p:cTn></p:par>')
            t+=500
        out.append(f'<p:par><p:cTn id="{cid}" fill="hold"><p:stCondLst>{cond}</p:stCondLst><p:childTnLst>{"".join(inner)}</p:childTnLst></p:cTn></p:par>')
    seq=(f'<p:seq concurrent="1" nextAc="seek"><p:cTn id="2" dur="indefinite" nodeType="mainSeq"><p:childTnLst>{"".join(out)}</p:childTnLst></p:cTn>'
         f'<p:prevCondLst><p:cond evt="onPrev" delay="0"><p:tgtEl><p:sldTgt/></p:tgtEl></p:cond></p:prevCondLst>'
         f'<p:nextCondLst><p:cond evt="onNext" delay="0"><p:tgtEl><p:sldTgt/></p:tgtEl></p:cond></p:nextCondLst></p:seq>') if out else ''
    vn=''.join(f'<p:video><p:cMediaNode vol="80000" mute="1"><p:cTn id="{next(ids)}" repeatCount="indefinite" fill="hold" display="0">'
               f'<p:stCondLst><p:cond delay="indefinite"/></p:stCondLst></p:cTn><p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cMediaNode></p:video>'
               for spid,dur in videos)
    return f'<p:timing><p:tnLst><p:par><p:cTn id="1" dur="indefinite" restart="never" nodeType="tmRoot"><p:childTnLst>{seq}{vn}</p:childTnLst></p:cTn></p:par></p:tnLst>{{BLD}}</p:timing>'

def eot(ttf_path):
    f=TTFont(ttf_path); raw=open(ttf_path,'rb').read(); os2=f['OS/2']; n=f['name']
    def nm(i):
        s=n.getDebugName(i) or ''; return s.encode('utf-16-le')
    panose=bytes([os2.panose.bFamilyType,os2.panose.bSerifStyle,os2.panose.bWeight,os2.panose.bProportion,os2.panose.bContrast,
                  os2.panose.bStrokeVariation,os2.panose.bArmStyle,os2.panose.bLetterForm,os2.panose.bMidline,os2.panose.bXHeight])
    italic=1 if (os2.fsSelection & 1) else 0
    hdr=struct.pack('<II',0x00020001,0)+panose+struct.pack('<BBIHH',1,italic,os2.usWeightClass,os2.fsType,0x504C)
    hdr+=struct.pack('<IIII',os2.ulUnicodeRange1,os2.ulUnicodeRange2,os2.ulUnicodeRange3,os2.ulUnicodeRange4)
    hdr+=struct.pack('<II',getattr(os2,'ulCodePageRange1',0),getattr(os2,'ulCodePageRange2',0))
    hdr+=struct.pack('<I',f['head'].checkSumAdjustment)+struct.pack('<IIII',0,0,0,0)
    for i,nid in enumerate((1,2,5,4)):
        s=nm(nid); hdr+=struct.pack('<H',0)+struct.pack('<H',len(s))+s
    hdr+=struct.pack('<H',0)+struct.pack('<H',0)   # Padding5 + RootStringSize=0
    body=hdr+raw
    total=8+len(body)
    return struct.pack('<II',total,len(raw))+body

# typeface name in slides -> embedded files (PowerPoint keeps regular/bold slots per typeface)
FONTS=[('Montserrat',{'regular':'Montserrat-Regular.ttf','bold':'Montserrat-Bold.ttf'}),('Montserrat Medium',{'regular':'Montserrat-Medium.ttf'}),
       ('Montserrat SemiBold',{'regular':'Montserrat-SemiBold.ttf'}),('Montserrat ExtraBold',{'regular':'Montserrat-ExtraBold.ttf'}),
       ('JetBrains Mono',{'regular':'JetBrainsMono-Regular.ttf','bold':'JetBrainsMono-Bold.ttf'})]

def process(src, plan_path, dst, fontdir, kern=False):
    plan=json.load(open(plan_path))
    zin=zipfile.ZipFile(src); out=io.BytesIO(); zout=zipfile.ZipFile(out,'w',zipfile.ZIP_DEFLATED)
    files={n:zin.read(n) for n in zin.namelist()}
    # --- timing per slide
    for sp in plan:
        name=f'ppt/slides/slide{sp["n"]}.xml'; x=files[name].decode('utf-8')
        tree=x[x.index('<p:spTree>'):x.index('</p:spTree>')]
        ids=[int(i) for i in re.findall(r'<p:cNvPr id="(\d+)"',tree)][1:]
        assert len(ids)==len(sp['shapes']),(sp['n'],len(ids),len(sp['shapes']))
        spid=lambda k: ids[k]
        blocks=[]
        for blk in sp['blocks']:
            blocks.append({'auto':blk['auto'],'steps':[[(e[0],spid(e[1]),e[2]) for e in step] for step in blk['steps']]})
        vids=[(spid(k),d) for k,d in sp['videos']]
        t=build_timing(blocks,vids)
        if t:
            bld=''.join(f'<p:bldP spid="{spid(k)}" grpId="0" animBg="1"/>' for k in sp.get('bld',[]))
            # exits of PowerPoint shapes (text, boxes) need their own build entry; group 1 if the shape also has an entrance
            entr={e[1] for blk in sp['blocks'] for step in blk['steps'] for e in step if e[0]=='fade'}
            bld+=''.join(f'<p:bldP spid="{spid(e[1])}" grpId="{1 if e[1] in entr else 0}" animBg="1"/>'
                         for blk in sp['blocks'] for step in blk['steps'] for e in step if e[0]=='out' and sp['shapes'][e[1]]=='sp')
            t=t.replace('{BLD}',f'<p:bldLst>{bld}</p:bldLst>' if bld else '')
            assert '<p:timing>' not in x
            x=x.replace('</p:clrMapOvr>','</p:clrMapOvr>'+t,1)
        if kern: x=re.sub(r'<a:rPr (?![^>]*\bkern=)','<a:rPr kern="100" ',x)
        files[name]=x.encode('utf-8')
    # --- fonts
    pres=files['ppt/presentation.xml'].decode(); rels=files['ppt/_rels/presentation.xml.rels'].decode()
    ct=files['[Content_Types].xml'].decode()
    if 'Extension="fntdata"' not in ct:
        ct=ct.replace('<Default Extension="xml"','<Default Extension="fntdata" ContentType="application/x-fontdata"/><Default Extension="xml"',1)
    lst=[]; k=0
    for face,styles in FONTS:
        parts=[]
        for st,fn in styles.items():
            k+=1; rid=f'rIdFont{k}'
            files[f'ppt/fonts/font{k}.fntdata']=eot(os.path.join(fontdir,fn))
            rels=rels.replace('</Relationships>',f'<Relationship Id="{rid}" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/font" Target="fonts/font{k}.fntdata"/></Relationships>')
            parts.append(f'<p:{st} r:id="{rid}"/>')
        lst.append(f'<p:embeddedFont><p:font typeface="{face}"/>{"".join(parts)}</p:embeddedFont>')
    m=re.search(r'<p:notesSz[^>]*/>',pres); assert m
    pres=pres[:m.end()]+'<p:embeddedFontLst>'+''.join(lst)+'</p:embeddedFontLst>'+pres[m.end():]
    pres=re.sub(r'<p:presentation\b',lambda mm:mm.group(0)+' embedTrueTypeFonts="1"',pres,count=1)
    files['ppt/presentation.xml']=pres.encode(); files['ppt/_rels/presentation.xml.rels']=rels.encode(); files['[Content_Types].xml']=ct.encode()
    order=['[Content_Types].xml']+[n for n in files if n!='[Content_Types].xml']
    for n in order: zout.writestr(n,files[n])
    zout.close(); open(dst,'wb').write(out.getvalue())

if __name__=='__main__':
    a=[x for x in sys.argv[1:] if not x.startswith('--')]
    process(*a[:4], kern='--kern' in sys.argv)
    print('wrote',a[2])
