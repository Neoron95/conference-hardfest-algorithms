"""Apply the user's text, element and focused illustration edits to V8.

The edited native reference is data. Keep existing objects, masters, fonts,
media and playback while applying the declared review changes.
"""
import copy
import hashlib
import json
import posixpath
import re
import sys
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E

ROOT = Path(__file__).resolve().parents[3]
P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
R = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
NS = {'p': P, 'a': A, 'r': R}
CT = 'http://schemas.openxmlformats.org/package/2006/content-types'


def read(path):
    with ZipFile(path) as z:
        return {n: z.read(n) for n in z.namelist()}


def serial(root):
    return E.tostring(root, encoding='UTF-8', xml_declaration=True, standalone=True)


def relpath(part):
    folder, name = posixpath.split(part)
    return f'{folder}/_rels/{name}.rels'


def target(part, value):
    return value.lstrip('/') if value.startswith('/') else posixpath.normpath(posixpath.join(posixpath.dirname(part), value))


def inventory(parts):
    prs = {n.get('Id'): target('ppt/presentation.xml', n.get('Target')) for n in E.fromstring(parts['ppt/_rels/presentation.xml.rels'])}
    return [prs[n.get(f'{{{R}}}id')] for n in E.fromstring(parts['ppt/presentation.xml']).find(f'{{{P}}}sldIdLst')]


def note_part(parts, slide):
    rels = E.fromstring(parts[relpath(slide)])
    return next(target(slide, n.get('Target')) for n in rels if n.get('Type').endswith('/notesSlide'))


def note_body(root):
    return root.xpath('.//p:sp[p:nvSpPr/p:nvPr/p:ph[@type="body"]]/p:txBody', namespaces=NS)[0]


def notes_text(parts, slide):
    body = note_body(E.fromstring(parts[note_part(parts, slide)]))
    lines = []
    for paragraph in body.findall(f'{{{A}}}p'):
        lines.append(''.join((n.text or '') if n.tag == f'{{{A}}}t' else '\n' if n.tag == f'{{{A}}}br' else '' for n in paragraph.iter()))
    return '\n'.join(lines).replace('\u2028', '\n').strip()


base_path = ROOT / 'prep/deck/hardfest2026_deck_v8.pptx'
ref_path = ROOT / 'prep/deck/hardfest_v9/reference/first_five.pptx'
out_path = Path(sys.argv[1]) if len(sys.argv) > 1 else ROOT / 'prep/.v9-build/v9-candidate.pptx'
base, ref = read(base_path), read(ref_path)
data = dict(base)
base_order, ref_order = inventory(base), inventory(ref)
assert len(base_order) == 96 and len(ref_order) == 5
topic_ids = json.loads((ROOT / 'prep/deck/hardfest_v9/deck.json').read_text())['order'][:5]
removed = {3: 'Что выбрать — и как проверить, что стало быстрее', 4: 'Мозг ещё читает.'}
source_notes = []
for index, (src, dst) in enumerate(zip(ref_order, base_order[:5]), 1):
    original, reference = E.fromstring(base[dst]), E.fromstring(ref[src])
    dropped = set()
    if index in removed:
        for shape in list(original.findall('p:cSld/p:spTree/p:sp', NS)):
            text = ' '.join(shape.xpath('.//a:t/text()', namespaces=NS))
            if removed[index] in text:
                dropped.add(shape.find('p:nvSpPr/p:cNvPr', NS).get('id'))
                shape.getparent().remove(shape)
        assert len(dropped) == 1, (index, dropped)
        # Remove only animation effects belonging to the deleted text object.
        for effect in list(original.xpath('.//p:timing//p:cTn[@presetClass]', namespaces=NS)):
            targets = set(effect.xpath('.//p:spTgt/@spid', namespaces=NS))
            if targets and targets <= dropped:
                effect.getparent().getparent().remove(effect.getparent())
        present = set(original.xpath('.//p:cNvPr/@id', namespaces=NS))
        assert set(original.xpath('.//p:timing//p:spTgt/@spid', namespaces=NS)) <= present
        data[dst] = serial(original)
    # This reference changes no other visible wording. Fail rather than miss edits.
    assert original.xpath('.//a:t/text()', namespaces=NS) == reference.xpath('.//a:t/text()', namespaces=NS), (index, 'visible text differs from Keynote')
    dest_note = note_part(base, dst)
    nr = E.fromstring(base[dest_note])
    dest_body = note_body(nr)
    for paragraph in list(dest_body.findall(f'{{{A}}}p')):
        dest_body.remove(paragraph)
    source_body = note_body(E.fromstring(ref[note_part(ref, src)]))
    for paragraph in source_body.findall(f'{{{A}}}p'):
        dest_body.append(copy.deepcopy(paragraph))
    data[dest_note] = serial(nr)
    assert notes_text(ref, src) == notes_text(data, dst)
    source_notes.append({'position': index, 'id': topic_ids[index - 1], 'text': reference.xpath('.//a:t/text()', namespaces=NS), 'speakerNotes': notes_text(ref, src)})

# Every source part outside the declared edit boundary remains byte-for-byte V8.
changed = {base_order[2], base_order[3], 'docProps/core.xml'} | {note_part(base, n) for n in base_order[:5]}
for part in base:
    if part not in changed:
        assert data[part] == base[part], (part, 'unrelated part changed')

# The current review replaces only the two opening-vote slides.
stage_path = ROOT / 'prep/.v9-build/review-6-7/stages.pptx'
if stage_path.exists():
    stage = read(stage_path)
    stage_order = inventory(stage)
    assert len(stage_order) == 2
    ct = E.fromstring(data['[Content_Types].xml'])
    for source, destination, number in zip(stage_order, base_order[5:7], [6, 7]):
        slide = E.fromstring(stage[source])
        for shape in slide.findall('.//p:sp', NS):
            off = shape.find('p:spPr/a:xfrm/a:off', NS)
            ts = shape.findall('.//a:t', NS)
            if off is not None and int(off.get('x')) > 8000000 and int(off.get('y')) > 4500000 and len(ts) == 1 and (ts[0].text or '').isdigit():
                ts[0].text = str(number)
        data[destination] = serial(slide)
        rels = E.fromstring(stage[relpath(source)])
        for rel in rels:
            if rel.get('TargetMode') == 'External':
                continue
            old = target(source, rel.get('Target'))
            kind = rel.get('Type').rsplit('/', 1)[-1]
            if kind == 'image':
                new = 'ppt/media/v9-' + hashlib.sha256(stage[old]).hexdigest()[:24] + Path(old).suffix
                data[new] = stage[old]
            elif kind == 'notesSlide':
                new = note_part(base, destination)
                data[new] = stage[old]
                nr = E.fromstring(stage[relpath(old)])
                for nrel in nr:
                    if nrel.get('Type').endswith('/slide'):
                        nrel.set('Target', '/' + destination)
                    elif nrel.get('Type').endswith('/notesMaster'):
                        nrel.set('Target', '/ppt/notesMasters/notesMaster1.xml')
                data[relpath(new)] = serial(nr)
            elif kind == 'slideLayout':
                base_rels = E.fromstring(base[relpath(destination)])
                new = next(target(destination, n.get('Target')) for n in base_rels if n.get('Type').endswith('/slideLayout'))
            else:
                raise ValueError(f'Unexpected stage dependency: {kind}')
            rel.set('Target', '/' + new)
        data[relpath(destination)] = serial(rels)
        changed.update({destination, relpath(destination), note_part(base, destination), relpath(note_part(base, destination))})
    data['[Content_Types].xml'] = serial(ct)
    changed.add('[Content_Types].xml')

# Replace only the Approve background and label with the authored paper picture.
# Keep its original shape ID so the existing second-click animation still applies.
button_stage = ROOT / 'prep/.v9-build/review-approve/button.pptx'
if button_stage.exists():
    authored = read(button_stage)
    source = inventory(authored)[0]
    destination = base_order[3]
    slide = E.fromstring(data[destination])
    tree = slide.find('p:cSld/p:spTree', NS)
    label = next(n for n in tree.findall('p:sp', NS) if ''.join(n.xpath('.//a:t/text()', namespaces=NS)) == 'Approve ✓')
    background = tree[tree.index(label) - 1]
    assert background.tag == f'{{{P}}}sp' and not background.xpath('.//a:t', namespaces=NS)
    background_id = background.find('p:nvSpPr/p:cNvPr', NS).get('id')
    label_id = label.find('p:nvSpPr/p:cNvPr', NS).get('id')
    picture = copy.deepcopy(E.fromstring(authored[source]).find('p:cSld/p:spTree/p:pic', NS))
    nv = picture.find('p:nvPicPr/p:cNvPr', NS)
    nv.set('id', background_id)
    nv.set('name', 'v9-paper-approve')
    nv.set('descr', 'Бумажная бирюзовая кнопка Approve ✓')
    blip = picture.find('p:blipFill/a:blip', NS)
    source_rid = blip.get(f'{{{R}}}embed')
    source_rels = E.fromstring(authored[relpath(source)])
    source_media = next(target(source, n.get('Target')) for n in source_rels if n.get('Id') == source_rid)
    media = 'ppt/media/v9-approve-' + hashlib.sha256(authored[source_media]).hexdigest()[:24] + '.png'
    data[media] = authored[source_media]
    rels = E.fromstring(data[relpath(destination)])
    rid = 'rIdV9PaperApprove'
    assert all(n.get('Id') != rid for n in rels)
    E.SubElement(rels, '{http://schemas.openxmlformats.org/package/2006/relationships}Relationship', Id=rid, Type='http://schemas.openxmlformats.org/officeDocument/2006/relationships/image', Target='/' + media)
    blip.set(f'{{{R}}}embed', rid)
    index = tree.index(background)
    tree.remove(background)
    tree.remove(label)
    tree.insert(index, picture)
    for effect in list(slide.xpath('.//p:timing//p:cTn[@presetClass]', namespaces=NS)):
        targets = set(effect.xpath('.//p:spTgt/@spid', namespaces=NS))
        if targets == {label_id}:
            effect.getparent().getparent().remove(effect.getparent())
    present = set(slide.xpath('.//p:cNvPr/@id', namespaces=NS))
    for build in list(slide.xpath('.//p:timing/p:bldLst/*', namespaces=NS)):
        if build.get('spid') not in present:
            build.getparent().remove(build)
    assert set(slide.xpath('.//p:timing//p:spTgt/@spid', namespaces=NS)) <= present
    assert background_id in slide.xpath('.//p:timing//p:spTgt/@spid', namespaces=NS)
    data[destination] = serial(slide)
    data[relpath(destination)] = serial(rels)
    changed.update({destination, relpath(destination), media})

# Any speaker edits made in the side-panel file take precedence at build time.
speaker_path = ROOT / 'prep/script/speaker_notes_v9.md'
if speaker_path.exists():
    spoken = dict(re.findall(r'^## \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^## \d+\. |\Z)', speaker_path.read_text(), re.M | re.S))
    main_ids = json.loads((ROOT / 'prep/deck/hardfest_v9/deck.json').read_text())['order'][:46]
    for name, slide in zip(main_ids, base_order[:46]):
        if name not in spoken:
            continue
        old = notes_text(data, slide)
        source_tail = re.search(r'(?:[─━]+\s*)?Источники(?: и условия)?\s*\n[\s\S]*', old)
        note = spoken[name].strip() + ('\n\n' + source_tail.group(0).strip() if source_tail else '')
        if note == old:
            continue
        part = note_part(data, slide)
        nr = E.fromstring(data[part])
        body = note_body(nr)
        for paragraph in list(body.findall(f'{{{A}}}p')):
            body.remove(paragraph)
        for line in note.split('\n'):
            paragraph = E.SubElement(body, f'{{{A}}}p')
            run = E.SubElement(paragraph, f'{{{A}}}r')
            E.SubElement(run, f'{{{A}}}t').text = line
        data[part] = serial(nr)
        changed.add(part)
    assert all(data[part] == base[part] for part in base_order[7:]), 'An unrelated slide changed'
core = E.fromstring(data['docProps/core.xml'])
core.find('{http://purl.org/dc/elements/1.1/}title').text = 'O(n) проиграл O(n log n) — HardFest 2026 · V9'
data['docProps/core.xml'] = serial(core)
out_path.parent.mkdir(parents=True, exist_ok=True)
with ZipFile(out_path, 'w', ZIP_DEFLATED) as z:
    for name, content in data.items():
        z.writestr(name, content)
manifest = json.loads((ROOT / 'prep/deck/hardfest_v8/deck_v8.json').read_text())
manifest.update({'revision': 'v9', 'baseSha256': hashlib.sha256(base_path.read_bytes()).hexdigest(), 'firstFiveSha256': hashlib.sha256(ref_path.read_bytes()).hexdigest(), 'updatedThroughSlide': 5, 'reviewedSlides': [6, 7] if stage_path.exists() else [], 'changedParts': sorted(changed)})
manifest.pop('finalSha256', None)
if button_stage.exists():
    manifest['reviewedSlides'] = sorted(set(manifest['reviewedSlides']) | {4})
out_path.with_suffix('.manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
(ROOT / 'prep/deck/hardfest_v9/reference/first_five.json').write_text(json.dumps(source_notes, ensure_ascii=False, indent=2) + '\n')
print(f'{out_path}: source text imported; review slides and editable speaker notes applied')
