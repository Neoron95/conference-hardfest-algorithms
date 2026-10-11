"""Плитки-гипотезы: три множителя формулы со слайда 16 в правом верхнем углу «железных» слайдов.

Состояния: 'off' (серый контур, «?»), 'on' (янтарная заливка, «?» — эту гипотезу сейчас проверяем),
'done' (тёмно-бирюзовая заливка, вписано измеренное число). Между плитками операторы формулы: × и +.
Вставляется между <!-- board --> и <!-- /board --> в тело слайда; без билда — видна сразу.

    python3 tools/board.py            # применить состояния из BOARD ко всем слайдам
    python3 tools/board.py work       # только к одному
"""
import re, sys
from pathlib import Path

DECK = Path(__file__).resolve().parents[1]
LABELS = ['инструкции', 'ожидание', 'отмена']
VALUES = ['×3', '49 нс', '9 : 1']      # что вписывается после проверки: слайды 17, 21–23, 33
OPS = ['×', '+']
# Свободная зона: x 1540–1803, y 60–135 (кикер кончается на 1517, логотип начинается на y 144).
X0, Y0, W, H, GAP = 1545, 62, 76, 66, 15

# id слайда -> состояния плиток 1..3
BOARD = {
    'work':        ['on',   'off',  'off'],
    'curve':       ['done', 'on',   'off'],
    'nodes':       ['done', 'on',   'off'],
    'memory':      ['done', 'on',   'off'],
    'inflight':    ['done', 'on',   'off'],
    'window':      ['done', 'on',   'off'],
    'alloc-split': ['done', 'on',   'off'],
    'learned':     ['done', 'done', 'on'],
    'speculation': ['done', 'done', 'on'],
    'sortfamily':  ['done', 'done', 'on'],
    'boxes':       ['done', 'on',   'done'],
    'cores':       ['done', 'on',   'done'],
}

def card(i, state):
    x = X0 + i * (W + GAP)
    if state == 'on':
        box, color, mark, size = 'background:#F2C14E;border:3px solid #F2C14E', '#000', '?', 28
    elif state == 'done':
        box, color, mark, size = 'background:#174F45;border:3px solid #46CDAE', '#46CDAE', VALUES[i], 22
    else:
        box, color, mark, size = 'background:#000;border:3px solid #555', '#8F8F8F', '?', 28
    out = [f'<div class="abs" style="left:{x}px;top:{Y0}px;width:{W}px;height:{H}px;border-radius:12px;{box}"></div>',
           f'<p class="abs" style="left:{x}px;top:{Y0 + 4}px;width:{W}px;text-align:center;font-size:{size}px;font-weight:800;line-height:32px;color:{color}">{mark}</p>',
           f'<p class="abs" style="left:{x - 6}px;top:{Y0 + 38}px;width:{W + 12}px;text-align:center;font-size:11px;font-weight:700;'
           f'letter-spacing:0.3px;text-transform:uppercase;line-height:16px;color:{color}">{LABELS[i]}</p>']
    if i < 2:
        out.append(f'<p class="abs ph" style="left:{x + W}px;top:{Y0 + 16}px;width:{GAP}px;text-align:center;font-size:18px;font-weight:700;line-height:24px">{OPS[i]}</p>')
    return '\n'.join(out)

def board_html(states):
    return '<!-- board -->\n' + '\n'.join(card(i, s) for i, s in enumerate(states)) + '\n<!-- /board -->'

def apply(slide_id, states):
    path = DECK / 'slides' / f'{slide_id}.html'
    src = path.read_text()
    html = board_html(states)
    if '<!-- board -->' in src:
        src = re.sub(r'<!-- board -->.*?<!-- /board -->', lambda m: html, src, flags=re.S)
    else:
        src = src.replace('<!-- body -->', '<!-- body -->\n' + html, 1)
    path.write_text(src)
    return path

if __name__ == '__main__':
    only = sys.argv[1:]
    for sid, states in BOARD.items():
        if only and sid not in only:
            continue
        print('board ->', apply(sid, states).name, states)
