"""Доска подозреваемых: три мини-карточки в правом верхнем углу слайда (над логотипом, правее кикера).

Состояния карточки: 'off' (серый контур), 'on' (янтарная заливка, чёрный текст), 'done' (тёмно-бирюзовая
заливка, галочка). Вставляется между <!-- board --> и <!-- /board --> в тело слайда; без билда — видна сразу.

    python3 tools/board.py            # применить состояния из BOARD ко всем слайдам
    python3 tools/board.py suspects   # только к одному
"""
import re, sys
from pathlib import Path

DECK = Path(__file__).resolve().parents[1]
LABELS = ['Работа', 'Ожидание', 'Отмена']
# Свободная зона: x 1540–1803, y 60–135 (кикер кончается на 1517, логотип начинается на y 144).
X0, Y0, W, H, GAP = 1545, 62, 80, 66, 7

# id слайда -> состояния карточек 1..3
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
        box = f'background:#F2C14E;border:3px solid #F2C14E;color:#000'
    elif state == 'done':
        box = f'background:#174F45;border:3px solid #46CDAE;color:#46CDAE'
    else:
        box = f'background:#000;border:3px solid #555;color:#8F8F8F'
    mark = '✓' if state == 'done' else str(i + 1)
    return (f'<div class="abs" style="left:{x}px;top:{Y0}px;width:{W}px;height:{H}px;border-radius:12px;{box}"></div>\n'
            f'<p class="abs" style="left:{x}px;top:{Y0 + 4}px;width:{W}px;text-align:center;font-size:28px;font-weight:800;line-height:32px;'
            f'{"color:#000" if state == "on" else ("color:#46CDAE" if state == "done" else "color:#8F8F8F")}">{mark}</p>\n'
            f'<p class="abs" style="left:{x - 6}px;top:{Y0 + 38}px;width:{W + 12}px;text-align:center;font-size:13px;font-weight:700;'
            f'letter-spacing:0.3px;text-transform:uppercase;line-height:16px;'
            f'{"color:#000" if state == "on" else ("color:#46CDAE" if state == "done" else "color:#8F8F8F")}">{LABELS[i]}</p>')

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
