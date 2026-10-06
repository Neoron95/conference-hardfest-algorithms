"""Preserve template fonts and add click/media timing to Artifact Tool output.
This is an OpenXML package pass, not a second slide authoring engine.
"""
import ast, copy, json, os, posixpath, sys, uuid
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E
HERE=Path(__file__).resolve().parent
work=Path(os.environ.get('PPTX_WORK','/tmp/hardfest-pptx'))
manifest=json.loads((work/'artifact-manifest.json').read_text())
NS={'p':'http://schemas.openxmlformats.org/presentationml/2006/main','a':'http://schemas.openxmlformats.org/drawingml/2006/main','r':'http://schemas.openxmlformats.org/officeDocument/2006/relationships','p14':'http://schemas.microsoft.com/office/powerpoint/2010/main'}
NSDECL=' '.join(f'xmlns:{k}="{v}"' for k,v in NS.items())
RNS='http://schemas.openxmlformats.org/package/2006/relationships'
CTNS='http://schemas.openxmlformats.org/package/2006/content-types'
# Reuse the repository's existing, tested PowerPoint click/loop timing.
tree=ast.parse((HERE/'build.py').read_text())
fun=next(n for n in tree.body if isinstance(n,ast.FunctionDef) and n.name=='timing_xml')
exec(compile(ast.Module(body=[fun],type_ignores=[]),'timing_xml','exec'))
with ZipFile(work/'artifact-draft.pptx') as z: parts={n:z.read(n) for n in z.namelist()}
with ZipFile(HERE/'hardfest_template.pptx') as z: reference={n:z.read(n) for n in z.namelist()}
xml=lambda name:E.fromstring(parts[name])
write=lambda name,el:parts.__setitem__(name,E.tostring(el,xml_declaration=True,encoding='UTF-8',standalone=True))
ct=xml('[Content_Types].xml')
def ctype(ext,type_):
 if not any(n.get('Extension')==ext for n in ct):E.SubElement(ct,f'{{{CTNS}}}Default',Extension=ext,ContentType=type_)
ctype('mp4','video/mp4');ctype('fntdata','application/x-fontdata')
# The template's actual embedded font faces, with fresh relationship IDs.
pres=xml('ppt/presentation.xml');pr=xml('ppt/_rels/presentation.xml.rels')
refpres=E.fromstring(reference['ppt/presentation.xml']);refrels=E.fromstring(reference['ppt/_rels/presentation.xml.rels'])
fonts=copy.deepcopy(refpres.find('p:embeddedFontLst',NS))
for n in fonts.iter():
 rid=n.get(f'{{{NS["r"]}}}id')
 if not rid:continue
 rel=next(x for x in refrels if x.get('Id')==rid)
 target=rel.get('Target');key=posixpath.normpath(posixpath.join('ppt',target))
 parts[key]=reference[key];nr='rIdHFfont'+str(len(pr)+1)
 E.SubElement(pr,f'{{{RNS}}}Relationship',Id=nr,Type=rel.get('Type'),Target=target)
 n.set(f'{{{NS["r"]}}}id',nr)
old=pres.find('p:embeddedFontLst',NS)
if old is not None:pres.remove(old)
# schema order: embedded fonts before custom-show/photo-album/default-text/ext.
idx=next((i for i,n in enumerate(pres) if E.QName(n).localname in ['custShowLst','photoAlbum','defaultTextStyle','modifyVerifier','extLst']),len(pres))
pres.insert(idx,fonts);pres.set('embedTrueTypeFonts','1');pres.set('saveSubsetFonts','1')
video_index=0
for index,entry in enumerate(manifest['slides'],1):
 name=f'ppt/slides/slide{index}.xml';s=xml(name);s.find('p:cSld',NS).set('name',entry['id'])
 if entry['hidden']:s.set('show','0')
 # Sequential shape IDs keep animation targets portable across renderers.
 for sid,nv in enumerate(s.findall('.//p:cNvPr',NS),1):nv.set('id',str(sid))
 for stretch in s.findall('.//p:blipFill/a:stretch',NS):
  if stretch.find('a:fillRect',NS) is None:E.SubElement(stretch,f'{{{NS["a"]}}}fillRect')
 relname=f'ppt/slides/_rels/slide{index}.xml.rels';rels=xml(relname)
 builds={};videos=[]
 images=[o for o in entry['objects'] if o['type'] in ['img','video']]
 pics=s.findall('.//p:pic/p:nvPicPr/p:cNvPr',NS)
 if len(images)!=len(pics):raise ValueError('image count differs')
 for obj,nv in zip(images,pics):nv.set('name',obj['name'])
 for obj in entry['objects']:
  nodes=s.xpath('.//p:cNvPr[@name=$name or @descr=$name]',namespaces=NS,name=obj['name'])
  if len(nodes)!=1:raise ValueError(f'{entry["id"]}: object not found {obj["name"]}')
  nv=nodes[0];spid=int(nv.get('id'));nv.set('name',obj['name'])
  parent=nv.getparent().getparent();has_text=parent.find('p:txBody',NS) is not None
  if obj['build']:builds.setdefault(obj['build'],[]).append((spid,has_text))
  if obj.get('dash'):
   ln=parent.find('p:spPr/a:ln',NS)
   if ln is not None:
    for n in ln.findall('a:prstDash',NS)+ln.findall('a:custDash',NS):ln.remove(n)
    ds=E.SubElement(ln,f'{{{NS["a"]}}}custDash')
    lengths=obj['dash']['lengths'];width=max(.1,obj['dash']['width'])
    if len(lengths)%2:lengths=lengths*2
    for d,sp in zip(lengths[::2],lengths[1::2]):E.SubElement(ds,f'{{{NS["a"]}}}ds',d=str(round(d/width*100000)),sp=str(round(sp/width*100000)))
  # Exact browser line height, without changing native text editability.
  if obj.get('textMetric'):
   tx=parent.find('p:txBody',NS)
   if tx is not None:
    for ppr in tx.findall('a:p/a:pPr',NS):
     ls=ppr.find('a:lnSpc',NS)
     if ls is None:ls=E.SubElement(ppr,f'{{{NS["a"]}}}lnSpc')
     for ch in list(ls):ls.remove(ch)
     E.SubElement(ls,f'{{{NS["a"]}}}spcPts',val=str(round(obj['textMetric']['heightPx']*.375*100)))
  if obj['type']=='video':
   # Keep an ordinary picture behind media for renderers without video support.
   tree=s.find('p:cSld/p:spTree',NS)
   fallback=copy.deepcopy(parent)
   fnv=fallback.find('p:nvPicPr/p:cNvPr',NS)
   fid=max(int(n.get('id')) for n in s.findall('.//p:cNvPr',NS))+1
   fnv.set('id',str(fid));fnv.set('name',obj['name']+'-poster')
   tree.insert(tree.index(parent),fallback)
   if obj['build']:builds.setdefault(obj['build'],[]).append((fid,False))
   video_index+=1;filename=f'hf-animation-{video_index}.mp4';parts['ppt/media/'+filename]=Path(obj['src']).read_bytes()
   vr=f'rIdHFvideo{video_index}';mr=f'rIdHFmedia{video_index}'
   for rid,type_ in [(vr,'http://schemas.openxmlformats.org/officeDocument/2006/relationships/video'),(mr,'http://schemas.microsoft.com/office/2007/relationships/media')]:E.SubElement(rels,f'{{{RNS}}}Relationship',Id=rid,Type=type_,Target='../media/'+filename)
   E.SubElement(nv,f'{{{NS["a"]}}}hlinkClick',attrib={'action':'ppaction://media'})
   nvpr=parent.find('p:nvPicPr/p:nvPr',NS)
   E.SubElement(nvpr,f'{{{NS["a"]}}}videoFile',attrib={f'{{{NS["r"]}}}link':vr})
   ex=E.SubElement(nvpr,f'{{{NS["p"]}}}extLst');ext=E.SubElement(ex,f'{{{NS["p"]}}}ext',uri='{DAA4B4D4-6D71-4841-9C94-3DE7FCFB1B01}')
   E.SubElement(ext,f'{{{NS["p14"]}}}media',attrib={f'{{{NS["r"]}}}embed':mr})
   videos.append((spid,round(obj['duration']*1000),obj['loop'],obj['build']))
 if builds or videos:s.append(E.fromstring(timing_xml(builds,videos)))
 write(name,s);write(relname,rels)
# Sections follow actual order, and hidden backup slides stay accessible on demand.
extlst=pres.find('p:extLst',NS)
if extlst is None:extlst=E.SubElement(pres,f'{{{NS["p"]}}}extLst')
ext=E.SubElement(extlst,f'{{{NS["p"]}}}ext',uri='{521415D9-36F7-43E2-AB2F-B90AF26B5E84}')
sectlst=E.SubElement(ext,f'{{{NS["p14"]}}}sectionLst')
slids=pres.findall('p:sldIdLst/p:sldId',NS)
ids=[e['id'] for e in manifest['slides']]
sections=[s for s in manifest['deck']['sections'].values() if s['start'] in ids]
for j,sec in enumerate(sections):
 start=ids.index(sec['start']);end=ids.index(sections[j+1]['start']) if j+1<len(sections) else len(ids)
 se=E.SubElement(sectlst,f'{{{NS["p14"]}}}section',name=sec['description'],id='{'+str(uuid.uuid5(uuid.NAMESPACE_URL,'hardfest/'+sec['start'])).upper()+'}')
 si=E.SubElement(se,f'{{{NS["p14"]}}}sldIdLst')
 for n in slids[start:end]:E.SubElement(si,f'{{{NS["p14"]}}}sldId',id=n.get('id'))
write('ppt/presentation.xml',pres);write('ppt/_rels/presentation.xml.rels',pr);write('[Content_Types].xml',ct)
if 'docProps/core.xml' in parts:
 core=xml('docProps/core.xml')
 dc='http://purl.org/dc/elements/1.1/'
 for tag,value in [('title',manifest['deck']['title']),('creator','Никита Нагорнов'),('subject','HardFest 2026')]:
  n=core.find(f'{{{dc}}}'+tag)
  if n is None:n=E.SubElement(core,f'{{{dc}}}'+tag)
  n.text=value
 write('docProps/core.xml',core)
out=Path(sys.argv[1]) if len(sys.argv)>1 else work/'candidate.pptx'
with ZipFile(out,'w',ZIP_DEFLATED) as z:
 for n,b in parts.items():z.writestr(n,b)
print(f'{out}: {len(ids)} slides, {manifest["deck"]["mainCount"]} main, {video_index} preserved animation videos')
