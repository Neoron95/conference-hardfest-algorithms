"""Combine the confirmed V6.5 test video package with Artifact Tool's V7 slides.

Usage: python3 merge_v7_6.py BASE_V6_5_TEST V7 OUTPUT
The base owns every existing slide, video, timing tree, master and embedded font.
Only diff and the eight meme transitions come from V7; ordinary speaker notes
also come from V7. The four staged demonstrations retain all base notes.
"""
import copy
import hashlib
import json
import posixpath
import sys
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E

P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
R = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
PK = 'http://schemas.openxmlformats.org/package/2006/relationships'
CT = 'http://schemas.openxmlformats.org/package/2006/content-types'
NS = {'p': P, 'a': A, 'r': R}
DEMO = {'sort-walk', 'hash-walk', 'radix-walk', 'merge-walk'}

def xml(b):
    return E.fromstring(b)

def serial(r):
    return E.tostring(r, encoding='UTF-8', xml_declaration=True, standalone=True)

def relpath(part):
    folder, name = posixpath.split(part)
    return f'{folder}/_rels/{name}.rels'

def target(part, value):
    return value.lstrip('/') if value.startswith('/') else posixpath.normpath(posixpath.join(posixpath.dirname(part), value))

def inventory(data):
    rels = {r.get('Id'): target('ppt/presentation.xml', r.get('Target')) for r in xml(data['ppt/_rels/presentation.xml.rels'])}
    out = {}
    for node in xml(data['ppt/presentation.xml']).find(f'{{{P}}}sldIdLst'):
        part = rels[node.get(f'{{{R}}}id')]
        root = xml(data[part])
        name = root.find(f'{{{P}}}cSld').get('name')
        out[name] = (part, node)
    return out

def related(data, part, kind):
    return next(target(part, x.get('Target')) for x in xml(data[relpath(part)]) if x.get('Type').endswith('/' + kind))

base_path, v7_path, output_path = map(Path, sys.argv[1:])
with ZipFile(base_path) as z:
    data = {n: z.read(n) for n in z.namelist()}
with ZipFile(v7_path) as z:
    v7 = {n: z.read(n) for n in z.namelist()}
base = inventory(data)
source = inventory(v7)
assert len(base) == 79 and len(source) == 65
ct = xml(data['[Content_Types].xml'])

def content_type(part, kind):
    E.SubElement(ct, f'{{{CT}}}Override', PartName='/' + part, ContentType=kind)

def import_slide(name, dest):
    src = source[name][0]
    data[dest] = v7[src]
    rels = xml(v7[relpath(src)])
    for rel in rels:
        old = target(src, rel.get('Target'))
        kind = rel.get('Type').rsplit('/', 1)[-1]
        if kind == 'image':
            new = 'ppt/media/v7-' + hashlib.sha256(v7[old]).hexdigest()[:20] + Path(old).suffix
            data[new] = v7[old]
        elif kind == 'notesSlide':
            new = dest.replace('/slides/', '/notesSlides/').replace('/slide', '/notesSlide')
            data[new] = v7[old]
            nr = xml(v7[relpath(old)])
            for nrel in nr:
                if nrel.get('Type').endswith('/slide'):
                    nrel.set('Target', '/' + dest)
                elif nrel.get('Type').endswith('/notesMaster'):
                    nrel.set('Target', '/ppt/notesMasters/notesMaster1.xml')
            data[relpath(new)] = serial(nr)
            if new not in original_parts:
                content_type(new, 'application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml')
        elif kind == 'slideLayout':
            new = old
            assert new in data
        else:
            raise ValueError(f'Unexpected dependency in imported slide: {kind}')
        rel.set('Target', '/' + new)
    data[relpath(dest)] = serial(rels)

original_parts = set(data)
import_slide('diff', base['diff'][0])
pres = xml(data['ppt/presentation.xml'])
pres_rels = xml(data['ppt/_rels/presentation.xml.rels'])
order = []
for name in source:
    order.append(name)
    order.extend(n for n in base if n.startswith(name + '-stage-'))
assert len(order) == 87 and len(set(order)) == 87
new_index = 80
for name in order:
    if name in base:
        continue
    part = f'ppt/slides/slide{new_index}.xml'
    import_slide(name, part)
    rid = f'rIdV76Slide{new_index}'
    node = E.Element(f'{{{P}}}sldId', id=str(256 + new_index - 1))
    node.set(f'{{{R}}}id', rid)
    E.SubElement(pres_rels, f'{{{PK}}}Relationship', Id=rid, Type=R + '/slide', Target='/' + part)
    content_type(part, 'application/vnd.openxmlformats-officedocument.presentationml.slide+xml')
    base[name] = (part, node)
    new_index += 1
lst = pres.find(f'{{{P}}}sldIdLst')
lst[:] = [copy.deepcopy(base[n][1]) for n in order]

# V7 owns ordinary narration, while stage entry and stage narration stay intact.
for name in source:
    if name in DEMO or name.startswith('meme-') or name == 'diff':
        continue
    dest_note = related(data, base[name][0], 'notesSlide')
    src_note = related(v7, source[name][0], 'notesSlide')
    data[dest_note] = v7[src_note]

# Visible numbers count topics. Each video stage repeats its topic number.
topic_numbers = {name: i + 1 for i, name in enumerate(source)}
for name in order:
    if name == 'diff' or name.startswith('meme-'):
        continue
    part = base[name][0]
    root = xml(data[part])
    topic = name.split('-stage-')[0]
    for shape in root.findall('.//p:sp', NS):
        off = shape.find('p:spPr/a:xfrm/a:off', NS)
        ts = shape.findall('.//a:t', NS)
        if off is not None and int(off.get('x')) > 8000000 and int(off.get('y')) > 4500000 and len(ts) == 1 and (ts[0].text or '').isdigit():
            ts[0].text = str(topic_numbers[topic])
    data[part] = serial(root)

# Rebuild section membership using existing section boundaries and stable IDs.
sections = pres.findall('.//{http://schemas.microsoft.com/office/powerpoint/2010/main}section')
if sections:
    id_to_name = {node.get('id'): name for name, (_, node) in base.items()}
    starts = [id_to_name[s.find('{http://schemas.microsoft.com/office/powerpoint/2010/main}sldIdLst')[0].get('id')] for s in sections]
    for i, section in enumerate(sections):
        begin = order.index(starts[i])
        end = order.index(starts[i + 1]) if i + 1 < len(starts) else len(order)
        ids = section.find('{http://schemas.microsoft.com/office/powerpoint/2010/main}sldIdLst')
        ids[:] = [E.Element('{http://schemas.microsoft.com/office/powerpoint/2010/main}sldId', id=base[n][1].get('id')) for n in order[begin:end]]
data['ppt/presentation.xml'] = serial(pres)
data['ppt/_rels/presentation.xml.rels'] = serial(pres_rels)
data['[Content_Types].xml'] = serial(ct)
app = xml(data['docProps/app.xml'])
for tag, number in [('Slides', 87), ('Notes', 87), ('HiddenSlides', 24)]:
    app.find('{http://schemas.openxmlformats.org/officeDocument/2006/extended-properties}' + tag).text = str(number)
data['docProps/app.xml'] = serial(app)
output_path.parent.mkdir(parents=True, exist_ok=True)
with ZipFile(output_path, 'w', ZIP_DEFLATED) as z:
    for n, b in data.items():
        z.writestr(n, b)
manifest = {'revision': 'v7.6', 'baseSha256': hashlib.sha256(base_path.read_bytes()).hexdigest(), 'v7Sha256': hashlib.sha256(v7_path.read_bytes()).hexdigest(), 'mainCount': 63, 'topicCount': 41, 'hiddenCount': 24, 'order': order}
output_path.with_suffix('.manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
print(f'{output_path}: 87 slides, 63 main, 24 hidden; base videos and timing retained')
