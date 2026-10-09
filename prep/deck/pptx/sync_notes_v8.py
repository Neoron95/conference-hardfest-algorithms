"""Sync V8 narration and check the exact reveal sequence before authoring."""
import html
import json
import re
from pathlib import Path

ROOT = Path(__file__).resolve().parents[3]
DECK = ROOT / 'prep/deck/hardfest_v8'
deck = json.loads((DECK / 'deck.json').read_text())
script = (ROOT / 'prep/script/full_script_v8.md').read_text()
chunks = dict(re.findall(r'^### \d+\. `([^`]+)`[^\n]*\n(.*?)(?=^### \d+\. |\Z)', script, re.M | re.S))
count = 0
for id in deck['order'][:deck['mainCount']]:
    assert id in chunks, f'Script missing {id}'
    chunk = chunks[id]
    speech = re.search(r'\*\*Говорю\.\*\*\s*(.*?)(?=\*\*Если отстаю)', chunk, re.S).group(1).strip()
    path = DECK / 'slides' / f'{id}.html'
    source = path.read_text()
    orders = sorted(set(map(int, re.findall(r'data-build-in="\w+ (\d+)"', source.split('<aside>')[0]))))
    clicks = speech.count('[щелчок]')
    assert orders == list(range(1, clicks + 1)), (id, orders, clicks)
    assert '[щелчок: следующий этап]' not in speech, f'{id} still refers to an archived stage'
    old_note = html.unescape(re.search(r'<aside>(.*?)</aside>', source, re.S).group(1)).replace('<br>', '\n')
    tail = re.split(r'Источники(?: и условия)?\s*\n', old_note, maxsplit=1)
    if len(tail) == 2:
        reference = tail[1].strip()
    else:
        reference = chunk.split('**Под рукой.**', 1)[1].strip() if '**Под рукой.**' in chunk else ''
    note = speech + '\n\n──────────\nИсточники и условия\n' + reference
    note = re.sub(r'\*\*([^*]+)\*\*', r'\1', note).replace('`', '')
    encoded = html.escape(note, quote=False).replace('\n', '<br>')
    path.write_text(re.sub(r'<aside>.*?</aside>', '<aside>' + encoded + '</aside>', source, flags=re.S))
    count += clicks
print(f'Synced {deck["mainCount"]} V8 slides, {count} reveal steps')
