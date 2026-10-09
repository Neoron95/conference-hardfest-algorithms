"""Combine Artifact Tool's V8 slides with the unchanged V7.6 video archive.

Usage: python3 merge_v8.py BASE_V7_6 AUTHORED_V8 OUTPUT
New/edited slides are authored by build_artifact.mjs, then finish_package.py.
This package pass retains the original archive media and PowerPoint timing.
"""
import copy
import hashlib
import json
import posixpath
import sys
import uuid
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E

P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
R = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
PK = 'http://schemas.openxmlformats.org/package/2006/relationships'
CT = 'http://schemas.openxmlformats.org/package/2006/content-types'
P14 = 'http://schemas.microsoft.com/office/powerpoint/2010/main'
NS = {'p': P, 'a': A, 'r': R}
DEMO = {'sort-walk', 'hash-walk', 'radix-walk', 'merge-walk'}
ROOT = Path(__file__).resolve().parents[1]


def xml(b):
    return E.fromstring(b)


def serial(r):
    return E.tostring(r, encoding='UTF-8', xml_declaration=True, standalone=True)


def relpath(part):
    folder, name = posixpath.split(part)
    return f'{folder}/_rels/{name}.rels'


def target(part, value):
    return value.lstrip('/') if value.startswith('/') else posixpath.normpath(posixpath.join(posixpath.dirname(part), value))


def read_package(path):
    with ZipFile(path) as z:
        return {n: z.read(n) for n in z.namelist()}


def inventory(parts):
    rels = {r.get('Id'): target('ppt/presentation.xml', r.get('Target')) for r in xml(parts['ppt/_rels/presentation.xml.rels'])}
    entries = {}
    for node in xml(parts['ppt/presentation.xml']).find(f'{{{P}}}sldIdLst'):
        part = rels[node.get(f'{{{R}}}id')]
        name = xml(parts[part]).find(f'{{{P}}}cSld').get('name')
        assert name and name not in entries, name
        entries[name] = (part, node)
    return entries


def related(parts, part, kind):
    return next(target(part, x.get('Target')) for x in xml(parts[relpath(part)]) if x.get('Type').endswith('/' + kind))


base_path, authored_path, output_path = map(Path, sys.argv[1:])
data, authored = read_package(base_path), read_package(authored_path)
original_media_hashes = {n: hashlib.sha256(b).digest() for n, b in data.items() if n.endswith('.mp4')}
media_by_digest = {(hashlib.sha256(b).digest(), Path(n).suffix): n for n, b in data.items() if n.startswith('ppt/media/')}
base, source = inventory(data), inventory(authored)
deck = json.loads((ROOT / 'hardfest_v8/deck.json').read_text())
assert list(source) == deck['order'], 'Authored slides differ from the V8 source order'
assert len(base) == 87, 'Expected the confirmed V7.6 package'
ct = xml(data['[Content_Types].xml'])
source_ct = xml(authored['[Content_Types].xml'])
original_parts = set(data)


def content_type(part, kind):
    path = '/' + part
    if not any(n.get('PartName') == path for n in ct):
        E.SubElement(ct, f'{{{CT}}}Override', PartName=path, ContentType=kind)


for item in source_ct:
    if item.get('Extension') and not any(n.get('Extension') == item.get('Extension') for n in ct):
        ct.append(copy.deepcopy(item))


def import_slide(name, dest):
    src = source[name][0]
    data[dest] = authored[src]
    rels = xml(authored[relpath(src)])
    for rel in rels:
        if rel.get('TargetMode') == 'External':
            continue
        old = target(src, rel.get('Target'))
        kind = rel.get('Type').rsplit('/', 1)[-1]
        if kind in ('image', 'video', 'media'):
            digest = hashlib.sha256(authored[old]).digest()
            key = (digest, Path(old).suffix)
            new = media_by_digest.get(key)
            if new is None:
                new = 'ppt/media/v8-' + digest.hex()[:24] + Path(old).suffix
                data[new] = authored[old]
                media_by_digest[key] = new
        elif kind == 'notesSlide':
            new = related(data, dest, 'notesSlide') if dest in original_parts else 'ppt/notesSlides/v8-' + Path(dest).name
            data[new] = authored[old]
            nr = xml(authored[relpath(old)])
            for nrel in nr:
                if nrel.get('Type').endswith('/slide'):
                    nrel.set('Target', '/' + dest)
                elif nrel.get('Type').endswith('/notesMaster'):
                    nrel.set('Target', '/ppt/notesMasters/notesMaster1.xml')
                else:
                    raise ValueError(f'Unexpected notes dependency: {nrel.get("Type")}')
            data[relpath(new)] = serial(nr)
            content_type(new, 'application/vnd.openxmlformats-officedocument.presentationml.notesSlide+xml')
        elif kind == 'slideLayout':
            new = related(data, dest, 'slideLayout') if dest in original_parts else 'ppt/slideLayouts/slideLayout1.xml'
            assert new in data
        else:
            raise ValueError(f'Unexpected dependency in {name}: {kind}')
        rel.set('Target', '/' + new)
    data[relpath(dest)] = serial(rels)


pres = xml(data['ppt/presentation.xml'])
pres_rels = xml(data['ppt/_rels/presentation.xml.rels'])
next_part = max(int(Path(part).stem.removeprefix('slide')) for part, _ in base.values()) + 1
next_id = max(int(node.get('id')) for _, node in base.values()) + 1
for name in deck['order']:
    if name in DEMO:
        continue  # Keep each full walkthrough's original introduction and videos.
    if name not in base:
        part = f'ppt/slides/slide{next_part}.xml'
        rid = f'rIdV8Slide{next_part}'
        node = E.Element(f'{{{P}}}sldId', id=str(next_id))
        node.set(f'{{{R}}}id', rid)
        E.SubElement(pres_rels, f'{{{PK}}}Relationship', Id=rid, Type=R + '/slide', Target='/' + part)
        content_type(part, 'application/vnd.openxmlformats-officedocument.presentationml.slide+xml')
        base[name] = (part, node)
        next_part += 1
        next_id += 1
    import_slide(name, base[name][0])

order = []
for name in deck['order']:
    order.append(name)
    if name in DEMO:
        order.extend(n for n in base if n.startswith(name + '-stage-'))
assert len(order) == len(set(order)) == len(base)
main_count = deck['mainCount']
assert all(n not in DEMO and '-stage-' not in n for n in order[:main_count])
pres.find(f'{{{P}}}sldIdLst')[:] = [copy.deepcopy(base[n][1]) for n in order]


def add_navigation(root, rels, label, destination, x=117, y=960, width=450):
    """Native text link, outside the source's evidence and animation objects."""
    sid = max(int(n.get('id')) for n in root.findall('.//p:cNvPr', NS)) + 1
    rid = f'rIdV8Nav{sid}'
    E.SubElement(rels, f'{{{PK}}}Relationship', Id=rid, Type=R + '/slide', Target='/' + base[destination][0])
    shape = E.SubElement(root.find('p:cSld/p:spTree', NS), f'{{{P}}}sp')
    nv = E.SubElement(shape, f'{{{P}}}nvSpPr')
    E.SubElement(nv, f'{{{P}}}cNvPr', id=str(sid), name='v8-navigation-' + destination)
    E.SubElement(nv, f'{{{P}}}cNvSpPr', txBox='1')
    E.SubElement(nv, f'{{{P}}}nvPr')
    sppr = E.SubElement(shape, f'{{{P}}}spPr')
    xfrm = E.SubElement(sppr, f'{{{A}}}xfrm')
    E.SubElement(xfrm, f'{{{A}}}off', x=str(round(x * 4762.5)), y=str(round(y * 4762.5)))
    E.SubElement(xfrm, f'{{{A}}}ext', cx=str(round(width * 4762.5)), cy=str(round(40 * 4762.5)))
    geom = E.SubElement(sppr, f'{{{A}}}prstGeom', prst='rect')
    E.SubElement(geom, f'{{{A}}}avLst')
    E.SubElement(sppr, f'{{{A}}}noFill')
    E.SubElement(E.SubElement(sppr, f'{{{A}}}ln'), f'{{{A}}}noFill')
    text = E.SubElement(shape, f'{{{P}}}txBody')
    E.SubElement(text, f'{{{A}}}bodyPr', wrap='none', lIns='0', rIns='0', tIns='0', bIns='0')
    E.SubElement(text, f'{{{A}}}lstStyle')
    paragraph = E.SubElement(text, f'{{{A}}}p')
    run = E.SubElement(paragraph, f'{{{A}}}r')
    props = E.SubElement(run, f'{{{A}}}rPr', lang='ru-RU', sz='1100')
    E.SubElement(E.SubElement(props, f'{{{A}}}solidFill'), f'{{{A}}}srgbClr', val='46CDAE')
    E.SubElement(props, f'{{{A}}}latin', typeface='Montserrat')
    E.SubElement(props, f'{{{A}}}hlinkClick', attrib={f'{{{R}}}id': rid, 'action': 'ppaction://hlinksldjump'})
    E.SubElement(run, f'{{{A}}}t').text = label


for index, name in enumerate(order, 1):
    part = base[name][0]
    root = xml(data[part])
    if index > main_count:
        root.set('show', '0')
    else:
        root.attrib.pop('show', None)
    for shape in root.findall('.//p:sp', NS):
        off = shape.find('p:spPr/a:xfrm/a:off', NS)
        ts = shape.findall('.//a:t', NS)
        if off is not None and int(off.get('x')) > 8000000 and int(off.get('y')) > 4500000 and len(ts) == 1 and (ts[0].text or '').isdigit():
            ts[0].text = str(index)
    rels = xml(data[relpath(part)])
    if index > main_count:
        add_navigation(root, rels, 'К финалу с QR', 'final', y=1020)
    elif name == 'final':
        add_navigation(root, rels, 'Архив для вопросов', 'backup')
    if name == 'backup':
        for label, destination, x, y in [('Методика', 'nb-where', 860, 944), ('Языки', 'nb-lang', 1120, 944), ('Контроли', 'learned-table', 1380, 944), ('Sort', 'sort-walk', 860, 833), ('Hash', 'hash-walk', 1080, 833), ('Radix', 'radix-walk', 1300, 833), ('Merge', 'merge-walk', 1520, 833)]:
            add_navigation(root, rels, label, destination, x, y, 220)
    data[part] = serial(root)
    data[relpath(part)] = serial(rels)

# Sections use physical positions, including every retained hidden video stage.
extlst = pres.find(f'{{{P}}}extLst')
if extlst is None:
    extlst = E.SubElement(pres, f'{{{P}}}extLst')
for ext in list(extlst):
    if ext.find(f'{{{P14}}}sectionLst') is not None:
        extlst.remove(ext)
ext = E.SubElement(extlst, f'{{{P}}}ext', uri='{521415D9-36F7-43E2-AB2F-B90AF26B5E84}')
section_list = E.SubElement(ext, f'{{{P14}}}sectionLst')
sections = list(deck['sections'].values()) + [{'description': 'Полные учебные видео, скрытый архив', 'start': 'sort-walk'}]
for j, section in enumerate(sections):
    begin = order.index(section['start'])
    end = order.index(sections[j + 1]['start']) if j + 1 < len(sections) else len(order)
    el = E.SubElement(section_list, f'{{{P14}}}section', name=section['description'], id='{' + str(uuid.uuid5(uuid.NAMESPACE_URL, 'hardfest/v8/' + section['start'])).upper() + '}')
    ids = E.SubElement(el, f'{{{P14}}}sldIdLst')
    for n in order[begin:end]:
        E.SubElement(ids, f'{{{P14}}}sldId', id=base[n][1].get('id'))

data['ppt/presentation.xml'] = serial(pres)
data['ppt/_rels/presentation.xml.rels'] = serial(pres_rels)
data['[Content_Types].xml'] = serial(ct)
app = xml(data['docProps/app.xml'])
for tag, number in [('Slides', len(order)), ('Notes', len(order)), ('HiddenSlides', len(order) - main_count)]:
    node = app.find('{http://schemas.openxmlformats.org/officeDocument/2006/extended-properties}' + tag)
    if node is not None:
        node.text = str(number)
data['docProps/app.xml'] = serial(app)
if 'docProps/core.xml' in authored:
    data['docProps/core.xml'] = authored['docProps/core.xml']

# Every original MP4 remains byte-for-byte unchanged.
for name, digest in original_media_hashes.items():
    assert hashlib.sha256(data[name]).digest() == digest
output_path.parent.mkdir(parents=True, exist_ok=True)
with ZipFile(output_path, 'w', ZIP_DEFLATED) as z:
    for name, content in data.items():
        z.writestr(name, content)
manifest = {'revision': 'v8', 'baseSha256': hashlib.sha256(base_path.read_bytes()).hexdigest(), 'authoredSha256': hashlib.sha256(authored_path.read_bytes()).hexdigest(), 'mainCount': main_count, 'topicCount': main_count, 'hiddenCount': len(order) - main_count, 'order': order}
output_path.with_suffix('.manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
print(f'{output_path}: {len(order)} slides, {main_count} main, {len(order) - main_count} hidden; original video archive retained')
