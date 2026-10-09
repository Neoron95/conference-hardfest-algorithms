"""Apply the user's first-five text and element edits to V8 without restyling.

The edited native reference is data. Existing V8 objects, masters, fonts,
media and playback remain intact; only deleted labels and notes are changed.
"""
import copy
import hashlib
import json
import posixpath
import sys
from pathlib import Path
from zipfile import ZipFile, ZIP_DEFLATED
from lxml import etree as E

ROOT = Path(__file__).resolve().parents[3]
P = 'http://schemas.openxmlformats.org/presentationml/2006/main'
A = 'http://schemas.openxmlformats.org/drawingml/2006/main'
R = 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'
NS = {'p': P, 'a': A, 'r': R}


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
core = E.fromstring(data['docProps/core.xml'])
core.find('{http://purl.org/dc/elements/1.1/}title').text = 'O(n) проиграл O(n log n) — HardFest 2026 · V9'
data['docProps/core.xml'] = serial(core)
out_path.parent.mkdir(parents=True, exist_ok=True)
with ZipFile(out_path, 'w', ZIP_DEFLATED) as z:
    for name, content in data.items():
        z.writestr(name, content)
manifest = json.loads((ROOT / 'prep/deck/hardfest_v8/deck_v8.json').read_text())
manifest.update({'revision': 'v9', 'baseSha256': hashlib.sha256(base_path.read_bytes()).hexdigest(), 'firstFiveSha256': hashlib.sha256(ref_path.read_bytes()).hexdigest(), 'updatedThroughSlide': 5, 'changedParts': sorted(changed)})
manifest.pop('finalSha256', None)
out_path.with_suffix('.manifest.json').write_text(json.dumps(manifest, ensure_ascii=False, indent=2) + '\n')
(ROOT / 'prep/deck/hardfest_v9/reference/first_five.json').write_text(json.dumps(source_notes, ensure_ascii=False, indent=2) + '\n')
print(f'{out_path}: five notes and two removed labels updated; remaining V8 parts unchanged')
