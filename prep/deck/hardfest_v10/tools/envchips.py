"""Три среды внизу слайда вместо текстового футера: M2 Pro · Xeon VM · iPhone 14 Pro.
Подсвечена та, на которой измерено то, что на экране; остальное — в заметках («Источники и условия»).

    python3 tools/envchips.py          # применить ENV ко всем слайдам из таблицы
"""
import re, sys
from pathlib import Path

DECK = Path(__file__).resolve().parents[1]
CHIPS = [('M2 Pro', 120), ('Xeon VM', 130), ('iPhone 14 Pro', 170)]
KEYS = ['m2', 'xeon', 'iphone']
ENV = {
    'work': {'xeon'}, 'curve': {'m2'}, 'nodes': {'xeon'}, 'memory': {'xeon', 'm2'}, 'inflight': {'xeon'},
    'window': {'xeon'}, 'alloc-split': {'xeon'}, 'flat': {'m2', 'xeon'}, 'share-q': {'m2'}, 'share': {'m2'},
    'outcontract': {'m2'}, 'inputorder': {'m2', 'xeon'}, 'learned': {'m2', 'xeon'}, 'speculation': {'xeon'},
    'sortfamily': {'xeon'}, 'x33': {'iphone'}, 'boxes': {'xeon'}, 'cores': {'m2', 'iphone'},
    'flip': {'m2', 'xeon', 'iphone'}, 'langs': {'xeon'}, 'merge': {'xeon'}, 'prod': {'iphone'},
}
FOOTER = re.compile(r'\n?<p class="abs lbl" style="left:117px;top:(?:8[6-9]\d|9\d\d)px;width:1\d{3}px;[^"]*"[^>]*>(?:(?!</p>).)*(?:M2 Pro|Xeon|iPhone)(?:(?!</p>).)*</p>', re.S)

def chips(measured):
    x, out = 117, ['<!-- env -->']
    for (label, w), key in zip(CHIPS, KEYS):
        on = key in measured
        style = 'border:2px solid #46CDAE;color:#46CDAE' if on else 'border:2px solid #3A3A3A;color:#6A6A6A'
        out.append(f'<p class="pill" style="left:{x}px;top:926px;width:{w}px;height:30px;font-size:16px;line-height:26px;letter-spacing:0.5px;{style}">{label}</p>')
        x += w + 12
    out.append('<!-- /env -->')
    return '\n'.join(out)

def apply(sid, measured):
    p = DECK / 'slides' / f'{sid}.html'
    s = p.read_text()
    s = FOOTER.sub('', s)
    s = re.sub(r'\n?<!-- env -->.*?<!-- /env -->', '', s, flags=re.S)
    s = s.replace('<!-- /body -->', chips(measured) + '\n<!-- /body -->', 1)
    p.write_text(s)

if __name__ == '__main__':
    only = sys.argv[1:]
    for sid, m in ENV.items():
        if only and sid not in only:
            continue
        apply(sid, m); print('env ->', sid, sorted(m))
