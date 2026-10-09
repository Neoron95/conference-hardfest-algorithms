"""Check the V8 route, narration, evidence and unchanged archived media."""
import hashlib
import html
import json
import posixpath
import re
import sys
from pathlib import Path
from zipfile import ZipFile
from lxml import etree as E

ROOT = Path(__file__).resolve().parents[3]
NS = {'p': 'http://schemas.openxmlformats.org/presentationml/2006/main', 'a': 'http://schemas.openxmlformats.org/drawingml/2006/main', 'r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships'}
P, R = NS['p'], NS['r']
deck = json.loads((ROOT / 'prep/deck/hardfest_v8/deck.json').read_text())
manifest = json.loads(Path(sys.argv[1]).with_suffix('.manifest.json').read_text())
script = (ROOT / 'prep/script/full_script_v8.md').read_text()
chunks = dict(re.findall(r'^### \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^### \d+\. |\Z)', script, re.M | re.S))


def package(path):
    with ZipFile(path) as z:
        assert z.testzip() is None
        return {n: z.read(n) for n in z.namelist()}


def target(part, val):
    return val.lstrip('/') if val.startswith('/') else posixpath.normpath(posixpath.join(posixpath.dirname(part), val))


def inventory(parts):
    rels = {r.get('Id'): target('ppt/presentation.xml', r.get('Target')) for r in E.fromstring(parts['ppt/_rels/presentation.xml.rels'])}
    out = {}
    for node in E.fromstring(parts['ppt/presentation.xml']).find(f'{{{P}}}sldIdLst'):
        part = rels[node.get(f'{{{R}}}id')]
        root = E.fromstring(parts[part])
        out[root.find('p:cSld', NS).get('name')] = (part, root)
    return out


base = package(ROOT / 'prep/deck/hardfest2026_deck_v7_6.pptx')
parts = package(Path(sys.argv[1]))
slides = inventory(parts)
assert list(slides) == manifest['order']
assert manifest['mainCount'] == deck['mainCount']
assert manifest['order'][:deck['mainCount']] == deck['order'][:deck['mainCount']]
assert manifest['order'][deck['mainCount'] - 1] == 'final'
assert manifest['order'][deck['mainCount']] == 'backup'
steps = 0
for index, (name, (part, root)) in enumerate(slides.items(), 1):
    assert (root.get('show') == '0') == (index > deck['mainCount']), (name, 'hidden flag')
    if index <= deck['mainCount']:
        body = ' '.join(root.xpath('.//a:t/text()', namespaces=NS))
        assert not re.search(r'radix|поразрядн', body, re.I), (name, 'radix remains in main content')
        speech = re.search(r'\*\*Говорю\.\*\*\s*(.*?)(?=\*\*Если отстаю)', chunks[name], re.S).group(1).strip()
        source = (ROOT / 'prep/deck/hardfest_v8/slides' / f'{name}.html').read_text()
        orders = sorted(set(map(int, re.findall(r'data-build-in="\w+ (\d+)"', source.split('<aside>')[0]))))
        assert orders == list(range(1, speech.count('[щелчок]') + 1)), (name, 'click cues')
        note = html.unescape(re.search(r'<aside>(.*?)</aside>', source, re.S).group(1)).replace('<br>', '\n')
        normalized = re.sub(r'\*\*([^*]+)\*\*', r'\1', speech).replace('`', '')
        assert note.startswith(normalized), (name, 'HTML narration differs')
        relname = posixpath.dirname(part) + '/_rels/' + posixpath.basename(part) + '.rels'
        rels = E.fromstring(parts[relname])
        nr = next(r for r in rels if r.get('Type').endswith('/notesSlide'))
        notes = E.fromstring(parts[target(part, nr.get('Target'))])
        note_body = notes.xpath('.//p:sp[p:nvSpPr/p:nvPr/p:ph[@type="body"]]//a:t/text()', namespaces=NS)
        assert re.sub(r'\s+', ' ', '\n'.join(note_body)).startswith(re.sub(r'\s+', ' ', normalized)), (name, 'PPTX narration differs')
        steps += len(orders)

base_slides = inventory(base)
staged = 0
for name, (part, root) in slides.items():
    if '-stage-' in name:
        staged += 1
        old = base_slides[name][1].find('p:timing', NS)
        new = root.find('p:timing', NS)
        assert old is not None and E.tostring(old) == E.tostring(new), (name, 'video timing changed')
assert staged == 22
original_videos = [n for n in base if n.endswith('.mp4')]
assert len(original_videos) == 26
for name in original_videos:
    assert hashlib.sha256(base[name]).digest() == hashlib.sha256(parts[name]).digest(), (name, 'media changed')
print(json.dumps({'slides': len(slides), 'main': deck['mainCount'], 'hidden': len(slides) - deck['mainCount'], 'revealSteps': steps, 'retainedStages': staged, 'retainedOriginalVideos': len(original_videos), 'narration': 'matches script and HTML'}, ensure_ascii=False, indent=2))
