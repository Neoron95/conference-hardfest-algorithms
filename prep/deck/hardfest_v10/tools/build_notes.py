"""Заметки V10 из сценария: prep/script/full_script_v10_13-48.md -> notes/v10.json -> <aside> слайдов.

Речь правится в сценарии (markdown), не в JSON и не в HTML: этот скрипт переносит её в обе стороны
одним движением и проверяет, что число [щелчок] в речи совпадает с числом билдов в HTML.

    python3 tools/build_notes.py          # собрать JSON и синхронизировать <aside>
    python3 tools/build_notes.py --check  # только проверить щелчки и билды, ничего не писать
"""
import html, json, re, sys
from pathlib import Path

DECK = Path(__file__).resolve().parents[1]
ROOT = DECK.parents[2]
SCRIPT = ROOT / 'prep/script/full_script_v10_13-48.md'
deck = json.loads((DECK / 'deck.json').read_text())
main = deck['order'][:deck['mainCount']]
text = SCRIPT.read_text()

def field(block, start, end=None):
    if start not in block:
        return ''
    out = block.split(start, 1)[1]
    if end and end in out:
        out = out.split(end, 1)[0]
    return out.strip()

notes = {}
for m in re.finditer(r'^### (\d+)\. `([^`]+)` — (.*?)\n(.*?)(?=^### \d+\. |^## |\Z)', text, re.M | re.S):
    num, sid, title, block = m.groups()
    t = re.search(r'^\*(\d+):(\d+)', block, re.M)
    seconds = int(t[1]) * 60 + int(t[2]) if t else 0
    short = field(block, '**Если отстаю.**', '**Под рукой.**')
    notes[sid] = {
        'number': int(num),
        'title': title.strip(),
        'screen': field(block, '**На экране.**', '**Говорю.**'),
        'speech': field(block, '**Говорю.**', '**Если отстаю.**'),
        'short': short,
        'reference': field(block, '**Под рукой.**'),
        'durationSeconds': seconds,
    }

check_only = '--check' in sys.argv
problems = []
clicks_total = 0
for sid in main[12:]:
    if sid not in notes:
        problems.append(f'{sid}: нет в сценарии')
        continue
    path = DECK / 'slides' / f'{sid}.html'
    if not path.exists():
        problems.append(f'{sid}: нет slides/{sid}.html')
        continue
    src = path.read_text()
    body = src.split('<aside>')[0]
    orders = sorted(set(int(n) for n in re.findall(r'data-build-in="\w+ (\d+)"', body)))
    speech = notes[sid]['speech']
    clicks = speech.count('[щелчок]')
    if orders != list(range(1, clicks + 1)):
        problems.append(f'{sid}: билды {orders} против щелчков {clicks}')
    clicks_total += clicks
    if check_only:
        continue
    note = speech + '\n\n──────────\nИсточники и условия\n' + notes[sid]['reference']
    note = re.sub(r'\*\*([^*]+)\*\*', r'\1', note).replace('`', '')
    encoded = html.escape(note, quote=False).replace('\n', '<br>')
    if '<aside>' in src:
        src = re.sub(r'<aside>.*?</aside>', lambda _: '<aside>' + encoded + '</aside>', src, flags=re.S)
    else:
        src = src.replace('</section>', '<aside>' + encoded + '</aside>\n</section>')
    path.write_text(src)

if not check_only:
    (DECK / 'notes' / 'v10.json').write_text(json.dumps(notes, ensure_ascii=False, indent=1) + '\n')
    print(f'notes/v10.json: {len(notes)} тем; <aside> синхронизирован для {len(main) - 12} слайдов; щелчков {clicks_total}')
for p in problems:
    print('ПРОБЛЕМА', p)
sys.exit(1 if problems else 0)
