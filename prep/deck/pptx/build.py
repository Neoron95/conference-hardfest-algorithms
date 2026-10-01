#!/usr/bin/env python3
"""HTML-deck (extracted JSON) -> PPTX in the HardFest 2026 template style."""
import json, re, html, math, uuid, sys, copy, os, zipfile, subprocess
from pptx import Presentation
from pptx.util import Emu
from lxml import etree
from PIL import ImageFont

HERE = os.path.dirname(os.path.abspath(__file__))
W = os.environ.get('PPTX_WORK', '/tmp/hardfest-pptx')
TEMPLATE = os.path.join(HERE, 'hardfest_template.pptx')
# usage: build.py [--deck project|hardfest] [out.pptx] [slide ids...]
_args = sys.argv[1:]
DECKNAME = 'hardfest'
if '--deck' in _args:
    k = _args.index('--deck'); DECKNAME = _args[k + 1]; del _args[k:k + 2]
EXT = W + '/extract' + ('' if DECKNAME == 'project' else '-' + DECKNAME)
DECK = os.path.join(HERE, '..', DECKNAME, 'deck.json')
OUTFILE = _args[0] if _args else os.path.join(HERE, '..', 'hardfest2026_deck.pptx' if DECKNAME == 'hardfest' else f'hardfest2026_{DECKNAME}.pptx')
ONLY = _args[1:] or None

NS = {'a': 'http://schemas.openxmlformats.org/drawingml/2006/main',
      'p': 'http://schemas.openxmlformats.org/presentationml/2006/main',
      'r': 'http://schemas.openxmlformats.org/officeDocument/2006/relationships',
      'p14': 'http://schemas.microsoft.com/office/powerpoint/2010/main'}
NSDECL = ' '.join(f'xmlns:{k}="{v}"' for k, v in NS.items())
PX = 9144000 / 1920.0          # EMU per px (slide is 10" wide = 1920 px)
PT = 0.375                     # pt per px

def E(v): return int(round(v * PX))
def esc(t): return html.escape(t, quote=False)

# ---------------------------------------------------------------- palette
BLACK, WHITE = '000000', 'FFFFFF'
TURQ, TURQ_M, TURQ_D, PINK = '46CDAE', '23A285', '128178', 'E2489B'
TEXT2, LABEL, RULE, CARDLINE = 'C8C8C8', '8F8F8F', '333333', 'FFFFFF'
FLAT, RADIX = 'FFFFFF', '9B87F5'
PLACEHOLDER = 'F2C14E'
PALE = {'sort': '174F45', 'hash': '5E1C42', 'flat': '4A4A4A', 'radix': '3A3270'}
HILITE = '0B2B26'   # amber pale row/card highlight -> dark teal

AMBER_TEXT = {'8A5F00', 'E3A21A'}
AMBER_LINE = {'B07800', 'E3A21A'}
AMBER_PALE = {'FBEFD2', '3A2E12'}

TEXT_MAP = {
    # ink / neutrals
    '1B1F27': WHITE, 'F5F4EF': WHITE, 'FFFFFF': WHITE,
    '4A5360': TEXT2, 'C9CED8': TEXT2,
    '6A7280': LABEL, '9AA3B2': LABEL, '8A8F99': LABEL,
    # algorithms
    '2F6FDB': TURQ, 'D9622B': PINK, 'B9501F': PINK, '13806C': FLAT, '7B5CC4': RADIX, '6A4BB3': RADIX,
    # accent
    '8A5F00': TURQ, 'E3A21A': TURQ, 'B07800': TURQ,
    # diff
    'F08A7A': 'F08A7A', '7BD88F': '7BD88F',
}
FILL_MAP = {
    'FFFFFF': BLACK, 'F5F4EF': BLACK, '0F1219': BLACK, '151922': BLACK,   # cards -> black, outlined
    '1B1F27': '141414',
    '2F6FDB': TURQ, 'D9622B': PINK, '13806C': FLAT, '7B5CC4': RADIX,
    'D6E3FA': PALE['sort'], 'FBE3D6': PALE['hash'], 'D3EDE7': PALE['flat'], 'E6DEF6': PALE['radix'],
    'FBEFD2': HILITE, '3A2E12': HILITE, 'B3CAF4': '23806D', '8DB0EE': TURQ,
    '979DA8': '6E6E6E', '3A414D': 'BFBFBF', 'B9501F': PINK,
    'DAD7CE': RULE, '2A3040': RULE, 'C9C5BA': '4A4A4A', '8A8F99': '7A7A7A', '6A7280': LABEL,
    'E3A21A': TURQ, 'B07800': TURQ, '4A5360': '8F8F8F',
}
LINE_MAP = {
    'DAD7CE': RULE, '2A3040': RULE, 'C9C5BA': '4A4A4A', 'FFFFFF': RULE,
    '8A8F99': '8F8F8F', '6A7280': '8F8F8F', '9AA3B2': '8F8F8F', '4A5360': 'BFBFBF', 'C9CED8': 'BFBFBF',
    '1B1F27': WHITE, 'F5F4EF': BLACK, '151922': BLACK,
    '2F6FDB': TURQ, 'D9622B': PINK, 'B9501F': PINK, '13806C': FLAT, '7B5CC4': RADIX, '6A4BB3': RADIX,
    'B07800': TURQ, 'E3A21A': TURQ, '8A5F00': TURQ, '808080': None,
}
BRIGHT_FILLS = {TURQ, PINK, WHITE, 'F2C14E'}

def lum(hex_):
    r, g, b = (int(hex_[i:i + 2], 16) / 255 for i in (0, 2, 4))
    return 0.2126 * r + 0.7152 * g + 0.0722 * b

NATIVE = False   # set in main() for decks written directly in the template palette

def map_text(c, placeholder=False, on_bright=False):
    if c is None: return WHITE
    h = c['hex']
    if NATIVE: return h
    if on_bright:
        return BLACK if h not in ('4A5360', 'C9CED8', '6A7280', '9AA3B2') else '1E1E1E'
    if placeholder and h in AMBER_TEXT: return PLACEHOLDER
    if h in TEXT_MAP: return TEXT_MAP[h]
    if c['a'] < 1 and h == 'FFFFFF': return LABEL
    return h if lum(h) > 0.35 else WHITE

def map_fill(c):
    if c is None: return None
    h = c['hex']
    if NATIVE: return h
    if h in FILL_MAP: return FILL_MAP[h]
    if h == 'FFFFFF' and c['a'] < 1: return None
    return h

def map_line(c):
    if c is None: return None
    h = c['hex']
    if NATIVE: return h
    if h == 'FFFFFF' and c['a'] < 1: return RULE
    return LINE_MAP.get(h, h)

# ---------------------------------------------------------------- fonts
_fcache = {}
def _font_file(weight):
    style = {400: 'Regular', 500: 'Medium', 600: 'SemiBold', 700: 'Bold', 800: 'ExtraBold', 900: 'Black'}[weight]
    out = subprocess.run(['fc-match', '-f', '%{file}', f'Montserrat:style={style}'], capture_output=True, text=True).stdout
    if 'ontserrat' not in out:
        raise SystemExit('Montserrat is not installed (fc-match cannot find it) - see README.md')
    return out

def pil_font(weight, size):
    key = (weight, round(size, 2))
    if key not in _fcache:
        w = weight if weight in (400, 500, 600, 700, 800, 900) else 400
        _fcache[key] = ImageFont.truetype(_font_file(w), max(1, int(round(size))))
    return _fcache[key]

def text_len(t, weight, size):
    return pil_font(weight, size).getlength(t) * (size / max(1, int(round(size))))

def wrap_lines(text, weight, size, width):
    words = text.split(' ')
    lines, cur = [], ''
    for w_ in words:
        t = (cur + ' ' + w_) if cur else w_
        if text_len(t, weight, size) <= width or not cur:
            cur = t
        else:
            lines.append(cur); cur = w_
    if cur: lines.append(cur)
    return lines

def run_font(r):
    fam = r.get('family') or ''
    if 'Mono' in fam or 'Courier' in fam:
        return 'JetBrains Mono', r['weight'] >= 600
    wt = r['weight']
    if wt >= 800: return 'Montserrat ExtraBold', True
    if wt >= 700: return 'Montserrat', True
    if wt >= 600: return 'Montserrat SemiBold', False
    return 'Montserrat', False

def is_mono(item):
    fams = [r.get('family', '') for r in item['runs'] if not r.get('br')]
    return bool(fams) and all(('Mono' in f or 'Courier' in f) for f in fams)

# ---------------------------------------------------------------- xml helpers
class Ctx:
    def __init__(self):
        self.next_id = 100
        self.builds = {}   # order -> [spid]
    def nid(self):
        self.next_id += 1
        return self.next_id

def solid(h, alpha=None):
    if h is None: return '<a:noFill/>'
    a = f'<a:alpha val="{int(alpha * 100000)}"/>' if alpha is not None and alpha < 1 else ''
    return f'<a:solidFill><a:srgbClr val="{h}">{a}</a:srgbClr></a:solidFill>'

def ln_xml(color, w_px, dash=None, cap=None, round_join=False, tail=None, head=None):
    if color is None or w_px <= 0: return '<a:ln><a:noFill/></a:ln>'
    capattr = f' cap="{cap}"' if cap else ''
    d = ''
    if dash:
        if isinstance(dash, str): d = f'<a:prstDash val="{dash}"/>'
        else:
            ww = max(w_px, 0.5)
            segs = ''.join(f'<a:ds d="{int(dash[i] / ww * 100000)}" sp="{int(dash[i + 1] / ww * 100000)}"/>' for i in range(0, len(dash) - 1, 2))
            d = f'<a:custDash>{segs}</a:custDash>'
    j = '<a:round/>' if round_join else ''
    he = f'<a:headEnd type="{head}" w="med" len="med"/>' if head else ''
    te = f'<a:tailEnd type="{tail}" w="med" len="med"/>' if tail else ''
    return f'<a:ln w="{max(1, E(w_px))}"{capattr}>{solid(color)}{d}{j}{he}{te}</a:ln>'

def sp_xml(ctx, name, x, y, w, h, geom='rect', adj=None, fill=None, fill_alpha=None, line='<a:ln><a:noFill/></a:ln>', txbody=None, txbox=False, custgeom=None):
    sid = ctx.nid()
    if custgeom is not None:
        g = custgeom
    else:
        av = f'<a:gd name="adj" fmla="val {int(adj)}"/>' if adj is not None else ''
        g = f'<a:prstGeom prst="{geom}"><a:avLst>{av}</a:avLst></a:prstGeom>'
    tb = txbody if txbody is not None else ''
    txb = ' txBox="1"' if txbox else ''
    fillx = solid(fill, fill_alpha) if fill is not None else '<a:noFill/>'
    return sid, (f'<p:sp {NSDECL}><p:nvSpPr><p:cNvPr id="{sid}" name="{esc(name)} {sid}"/><p:cNvSpPr{txb}/><p:nvPr/></p:nvSpPr>'
                 f'<p:spPr><a:xfrm><a:off x="{E(x)}" y="{E(y)}"/><a:ext cx="{max(1, E(w))}" cy="{max(1, E(h))}"/></a:xfrm>{g}'
                 f'{fillx}{line}</p:spPr>{tb}</p:sp>')

def rpr_xml(size_px, color, font, bold, italic=False, cap=False, spc_px=0, baseline=None):
    attrs = f'lang="ru-RU" sz="{max(100, int(round(size_px * PT * 100)))}" b="{1 if bold else 0}" i="{1 if italic else 0}"'
    if cap: attrs += ' cap="all"'
    if spc_px: attrs += f' spc="{int(round(spc_px * PT * 100))}"'
    if baseline: attrs += f' baseline="{baseline}"'
    return (f'<a:rPr {attrs} dirty="0">{solid(color)}<a:latin typeface="{font}"/><a:ea typeface="{font}"/>'
            f'<a:cs typeface="{font}"/><a:sym typeface="{font}"/></a:rPr>')

def txbody_xml(paras, anchor='t', wrap=True, ins=(0, 0, 0, 0)):
    """paras: list of dict(align, lh_px, runs=[(text|None for br, rpr)])"""
    ps = []
    for p in paras:
        algn = {'left': 'l', 'start': 'l', 'center': 'ctr', 'right': 'r', 'end': 'r', 'justify': 'just'}.get(p.get('align', 'left'), 'l')
        ln = f'<a:lnSpc><a:spcPts val="{int(round(p["lh"] * PT * 100))}"/></a:lnSpc>' if p.get('lh') else ''
        sb = f'<a:spcBef><a:spcPts val="{int(round(p.get("before", 0) * PT * 100))}"/></a:spcBef>'
        body = ''
        last_rpr = None
        for t, rpr in p['runs']:
            if t is None:
                body += f'<a:br>{rpr}</a:br>'
            else:
                body += f'<a:r>{rpr}<a:t>{esc(t)}</a:t></a:r>'
            last_rpr = rpr
        end = last_rpr.replace('<a:rPr', '<a:endParaRPr').replace('</a:rPr>', '</a:endParaRPr>') if last_rpr else ''
        if p.get('bullet'):
            ch, ind, bcol = p['bullet']
            if ch.endswith('.'):
                bu = f'<a:buClr><a:srgbClr val="{bcol}"/></a:buClr><a:buFont typeface="+mj-lt"/><a:buAutoNum type="arabicPeriod" startAt="{ch[:-1]}"/>'
            else:
                bu = f'<a:buClr><a:srgbClr val="{bcol}"/></a:buClr><a:buFont typeface="Arial"/><a:buChar char="{ch}"/>'
            ps.append(f'<a:p><a:pPr marL="{E(ind)}" indent="{-E(ind)}" algn="{algn}">{ln}{sb}{bu}</a:pPr>{body}{end}</a:p>')
        else:
            ps.append(f'<a:p><a:pPr marL="0" indent="0" algn="{algn}">{ln}{sb}<a:buNone/></a:pPr>{body}{end}</a:p>')
    l, t, r, b = ins
    return (f'<p:txBody><a:bodyPr wrap="{"square" if wrap else "none"}" lIns="{E(l)}" tIns="{E(t)}" rIns="{E(r)}" bIns="{E(b)}" '
            f'anchor="{anchor}" rtlCol="0"><a:noAutofit/></a:bodyPr><a:lstStyle/>{"".join(ps)}</p:txBody>')

# ---------------------------------------------------------------- geometry transform
class T:
    def __init__(self, dx=0, dy=0, s=1.0, ox=0, oy=0):
        self.dx, self.dy, self.s, self.ox, self.oy = dx, dy, s, ox, oy
    def x(self, v): return self.ox + (v - self.ox) * self.s + self.dx
    def y(self, v): return self.oy + (v - self.oy) * self.s + self.dy
    def l(self, v): return v * self.s

# ---------------------------------------------------------------- title rules
LATIN = re.compile(r'[A-Za-z]')
KEEP_UP = {'id', 'ids', 'approve', 'backup'}
def caps_token(tok):
    core = re.sub(r'[^\wА-Яа-яЁё]', '', tok)
    if LATIN.search(tok):
        return tok.upper() if core.lower() in KEEP_UP else tok
    if re.search(r'[а-яё][А-ЯЁ]', tok):  # МиБ, КиБ
        return tok
    return tok.upper()

def caps_text(t):
    parts = re.split(r'( | )', t)
    return ''.join(p if p in (' ', ' ') else caps_token(p) for p in parts)

# ---------------------------------------------------------------- builders
def radius_adj(radius_css, w, h):
    if not radius_css or radius_css in ('0px', '0'): return None, 'rect'
    if radius_css.endswith('%'):
        return None, 'ellipse' if float(radius_css[:-1]) >= 50 else 'rect'
    r = float(radius_css.replace('px', '').split()[0])
    m = min(w, h)
    if m <= 0: return None, 'rect'
    if r >= m / 2 - 0.5 and abs(w - h) < 1: return None, 'ellipse'
    return min(50000, r / m * 100000), 'roundRect'

def deco_shapes(ctx, it, tr, bright_fill_out):
    """Background/border of a box element. Returns list of (spid, xml)."""
    d = it.get('deco')
    if not d: return []
    x, y, w, h = tr.x(it['x']), tr.y(it['y']), tr.l(it['w']), tr.l(it['h'])
    fill = map_fill(d['bg']) if d['bg'] else None
    alpha = d['bg']['a'] if d['bg'] else None
    sides = [sd if (sd and not (sd['c']['hex'] == '808080' and sd['style'] in ('inset', 'outset'))) else None for sd in d['sides']]
    if fill is None and not any(sides): return []
    uniform = all(s is not None for s in sides) and len({(round(s['w'], 1), s['c']['hex'], s['style']) for s in sides}) == 1
    out = []
    adj, geom = radius_adj(d['radius'], it['w'], it['h'])
    if not NATIVE and geom == 'ellipse' and d['bg'] and d['bg']['hex'] in AMBER_PALE: fill = TURQ
    if fill in BRIGHT_FILLS: bright_fill_out.append((x, y, w, h))
    if uniform:
        s = sides[0]
        col = map_line(s['c'])
        is_card = (not NATIVE) and (d['bg'] is None or (d['bg']['hex'] in ('FFFFFF', '0F1219'))) and s['c']['hex'] in ('DAD7CE', '2A3040')
        if is_card: col = CARDLINE
        lw = tr.l(s['w'])
        if is_card: lw = max(lw, 1.5)
        dash = 'dash' if s['style'] == 'dashed' else ('sysDot' if s['style'] == 'dotted' else None)
        line = ln_xml(col, lw, dash=dash)
        # stroke is centred on the geometry in PPTX; CSS border is inside the box
        inset = lw / 2
        out.append(sp_xml(ctx, 'Box', x + inset, y + inset, w - 2 * inset, h - 2 * inset, geom=geom, adj=adj, fill=fill, fill_alpha=alpha, line=line))
    else:
        if fill is not None:
            out.append(sp_xml(ctx, 'Fill', x, y, w, h, geom=geom, adj=adj, fill=fill, fill_alpha=alpha))
        for i, s in enumerate(sides):
            if s is None: continue
            col = map_line(s['c']); lw = tr.l(s['w'])
            if i == 0: seg = (x, y + lw / 2, x + w, y + lw / 2)
            elif i == 1: seg = (x + w - lw / 2, y, x + w - lw / 2, y + h)
            elif i == 2: seg = (x, y + h - lw / 2, x + w, y + h - lw / 2)
            else: seg = (x + lw / 2, y, x + lw / 2, y + h)
            dash = 'dash' if s['style'] == 'dashed' else None
            out.append(line_shape(ctx, [(seg[0], seg[1]), (seg[2], seg[3])], col, lw, dash=dash))
    return out

def path_geom(pts_list, bx, by, bw, bh, closed_list):
    W_, H_ = max(1, E(bw)), max(1, E(bh))
    paths = ''
    for pts, closed in zip(pts_list, closed_list):
        cmds = ''
        for i, (px, py) in enumerate(pts):
            X, Y = E(px - bx), E(py - by)
            cmds += (f'<a:moveTo><a:pt x="{X}" y="{Y}"/></a:moveTo>' if i == 0 else f'<a:lnTo><a:pt x="{X}" y="{Y}"/></a:lnTo>')
        if closed: cmds += '<a:close/>'
        paths += cmds
    fillmode = '' if any(closed_list) else ' fill="none"'
    return (f'<a:custGeom><a:avLst/><a:gdLst/><a:ahLst/><a:cxnLst/><a:rect l="0" t="0" r="r" b="b"/>'
            f'<a:pathLst><a:path w="{W_}" h="{H_}"{fillmode}>{paths}</a:path></a:pathLst></a:custGeom>')

def line_shape(ctx, pts, color, lw, dash=None, cap=None, round_join=False, tail=None, closed=False, fill=None, subpaths=None):
    allp = [p for sp in (subpaths or [pts]) for p in sp]
    xs = [p[0] for p in allp]; ys = [p[1] for p in allp]
    bx, by = min(xs), min(ys); bw, bh = max(xs) - bx, max(ys) - by
    geom = path_geom(subpaths or [pts], bx, by, bw, bh, [closed] * len(subpaths or [pts]))
    return sp_xml(ctx, 'Line', bx, by, max(bw, 0.01), max(bh, 0.01), custgeom=geom, fill=fill,
                  line=ln_xml(color, lw, dash=dash, cap=cap, round_join=round_join, tail=tail))

def text_shapes(ctx, it, tr, brights, force=None):
    """Text leaf -> [deco shapes..., textbox]."""
    out = []
    out += deco_shapes(ctx, it, tr, brights)
    runs = it['runs']
    if not runs or not it.get('tr'): return out
    size = it['size']
    mono = is_mono(it)
    asc, desc = (1.02, 0.27) if mono else (0.968, 0.225)
    lh = it['lh']
    # content box (css)
    cx = it['x'] + it['bw'][3] + it['pad'][3]
    cw = it['w'] - it['bw'][1] - it['bw'][3] - it['pad'][1] - it['pad'][3]
    # first baseline from the browser, then place the pptx box so LibreOffice/PowerPoint puts the baseline there
    first_sizes = []
    for r in runs:
        if r.get('br'): break
        first_sizes.append(r['size'])
    fs0 = max(first_sizes) if first_sizes else size
    baseline = it['tr']['top'] + asc * fs0
    box_top = baseline - (lh - desc * fs0)
    nlines = max(1, it['lines'])
    box_h = nlines * lh + 4
    align = it['align']
    # on bright fill?
    mx, my = it['x'] + it['w'] / 2, it['y'] + it['h'] / 2
    on_bright = False
    X, Y = tr.x(mx), tr.y(my)
    for (bx, by, bw, bh) in brights:
        if bx <= X <= bx + bw and by <= Y <= by + bh: on_bright = True
    slack = 0.03 * cw + 6
    if it['nowrap']: slack = 0.10 * cw + 10
    # keep the text inside the card it sits in
    cap = None
    for (rx, ry, rw, rh, rpad) in it.get('_containers', []):
        room = (rx + rw - rpad) - (cx + cw)
        cap = room if cap is None else min(cap, room)
    if it.get('deco'):
        room = it['pad'][1] + it['bw'][1] - 2
        cap = room if cap is None else min(cap, room)
    if it.get('_right') is not None:
        room = it['_right'] - 6 - (cx + cw)
        cap = room if cap is None else min(cap, room)
    if cap is not None and not it['nowrap']:
        slack = max(2, min(slack, cap if align not in ('center',) else 2 * cap))
    bx = cx
    if align in ('center',): bx = cx - slack / 2
    elif align in ('right', 'end'): bx = cx - slack
    bw = cw + slack
    # paragraph runs
    prs_ = []
    ph_open = False
    for r in runs:
        if r.get('br'):
            last = prs_[-1][1] if prs_ else rpr_xml(tr.l(size), WHITE, 'Montserrat', False)
            prs_.append((None, last)); continue
        t = r['t']
        is_ph = ('[' in t) or ph_open
        if '[' in t: ph_open = ']' not in t.split('[')[-1]
        elif ']' in t: ph_open = False
        col = map_text(r['color'], placeholder=is_ph and r['color'] and r['color']['hex'] in AMBER_TEXT, on_bright=on_bright)
        if force and 'color' in force: col = force['color']
        font, bold = run_font(r)
        prs_.append((t, rpr_xml(tr.l(r['size']), col, font, bold, r['italic'], r['upper'], tr.l(r['ls']),
                                {'super': '30000', 'sub': '-25000'}.get(r.get('va')))))
    para = {'align': align, 'lh': tr.l(lh), 'runs': prs_}
    if it.get('list'):
        ind = 0.95 * size
        para['bullet'] = ('•' if it['list'] == 'ul' else f"{it['liIndex']}."), tr.l(ind), map_text(runs[0].get('color') if runs else None)
        bx -= ind; bw += ind
    body = txbody_xml([para], anchor='t', wrap=not it['nowrap'])
    sid, xml = sp_xml(ctx, 'Text', tr.x(bx), tr.y(box_top), tr.l(bw), tr.l(box_h), txbody=body, txbox=True)
    out.append((sid, xml))
    return out

# ---------------------------------------------------------------- svg
def parse_len(v, default=0.0):
    try: return float(str(v).replace('px', ''))
    except Exception: return default

def svg_color(v):
    if v is None or v == 'none': return None
    v = v.strip()
    if v.startswith('#'):
        h = v[1:].upper()
        if len(h) == 3: h = ''.join(c * 2 for c in h)
        return {'hex': h, 'a': 1}
    if v in ('white',): return {'hex': 'FFFFFF', 'a': 1}
    if v in ('black',): return {'hex': '000000', 'a': 1}
    m = re.match(r'rgba?\(([^)]+)\)', v)
    if m:
        p = [float(s) for s in m.group(1).split(',')]
        return {'hex': ''.join(f'{int(c):02X}' for c in p[:3]), 'a': p[3] if len(p) > 3 else 1}
    return None

def parse_path(d):
    toks = re.findall(r'[MLHVZmlhvzCcQqAa]|-?\d*\.?\d+(?:e-?\d+)?', d)
    subs, cur, closed = [], [], []
    x = y = 0.0; i = 0; cmd = None
    while i < len(toks):
        t = toks[i]
        if re.match(r'[A-Za-z]', t): cmd = t; i += 1
        if cmd in 'Mm':
            nx, ny = float(toks[i]), float(toks[i + 1]); i += 2
            if cmd == 'm': nx += x; ny += y
            if cur: subs.append(cur); closed.append(False)
            cur = [(nx, ny)]; x, y = nx, ny
            cmd = 'L' if cmd == 'M' else 'l'
        elif cmd in 'Ll':
            nx, ny = float(toks[i]), float(toks[i + 1]); i += 2
            if cmd == 'l': nx += x; ny += y
            cur.append((nx, ny)); x, y = nx, ny
        elif cmd in 'Hh':
            nx = float(toks[i]); i += 1
            if cmd == 'h': nx += x
            cur.append((nx, y)); x = nx
        elif cmd in 'Vv':
            ny = float(toks[i]); i += 1
            if cmd == 'v': ny += y
            cur.append((x, ny)); y = ny
        elif cmd in 'Zz':
            if cur:
                subs.append(cur); closed.append(True)
                x, y = cur[0]; cur = []
            cmd = None
        else:
            i += 1
    if cur: subs.append(cur); closed.append(False)
    return subs, closed

def svg_shapes(ctx, it, tr):
    root = etree.fromstring(it['markup'].encode(), etree.XMLParser(recover=True))
    vb = [float(v) for v in (it['viewBox'] or f"0 0 {it['w']} {it['h']}").replace(',', ' ').split()]
    sx, sy = it['w'] / vb[2], it['h'] / vb[3]
    X = lambda v: tr.x(it['x'] + (v - vb[0]) * sx)
    Y = lambda v: tr.y(it['y'] + (v - vb[1]) * sy)
    L = lambda v: tr.l(v * sx)
    out = []
    for el in root.iter():
        tag = etree.QName(el).localname if isinstance(el.tag, str) else ''
        if tag in ('svg', 'defs', 'marker', 'g', ''): continue
        if any(etree.QName(a).localname == 'marker' for a in el.iterancestors() if isinstance(a.tag, str)): continue
        g = el.get
        stroke = svg_color(g('stroke')); fill = svg_color(g('fill'))
        sw = parse_len(g('stroke-width'), 1.0)
        dash = None
        if g('stroke-dasharray'):
            dash = [L(float(v)) for v in re.split(r'[ ,]+', g('stroke-dasharray').strip())]
            if len(dash) % 2: dash = dash * 2
        cap = 'rnd' if g('stroke-linecap') == 'round' else None
        rj = g('stroke-linejoin') == 'round'
        tail = 'arrow' if g('marker-end') else None
        lc = map_line(stroke) if stroke else None
        fc = map_fill(fill) if fill else None
        if not NATIVE and fill and fill['hex'] in ('F5F4EF', 'FFFFFF') and tag in ('circle',): fc = BLACK
        if tag == 'line':
            pts = [(X(parse_len(g('x1'))), Y(parse_len(g('y1')))), (X(parse_len(g('x2'))), Y(parse_len(g('y2'))))]
            out.append(line_shape(ctx, pts, lc, L(sw), dash=dash, cap=cap, tail=tail))
        elif tag in ('polyline', 'polygon'):
            nums = [float(v) for v in re.split(r'[ ,]+', g('points').strip())]
            pts = [(X(nums[i]), Y(nums[i + 1])) for i in range(0, len(nums) - 1, 2)]
            out.append(line_shape(ctx, pts, lc, L(sw), dash=dash, cap=cap, round_join=rj, tail=tail,
                                  closed=(tag == 'polygon'), fill=fc if tag == 'polygon' else None))
        elif tag == 'path':
            subs, closed = parse_path(g('d'))
            subs = [[(X(a), Y(b)) for a, b in s] for s in subs]
            if not subs: continue
            allp = [p for s in subs for p in s]
            xs = [p[0] for p in allp]; ys = [p[1] for p in allp]
            bx, by = min(xs), min(ys)
            geom = path_geom(subs, bx, by, max(xs) - bx, max(ys) - by, closed)
            out.append(sp_xml(ctx, 'Path', bx, by, max(xs) - bx, max(ys) - by, custgeom=geom,
                              fill=fc if any(closed) else None,
                              line=ln_xml(lc, L(sw), dash=dash, cap=cap, round_join=rj, tail=tail) if stroke else '<a:ln><a:noFill/></a:ln>'))
        elif tag == 'rect':
            x0, y0 = parse_len(g('x')), parse_len(g('y'))
            w0, h0 = parse_len(g('width')), parse_len(g('height'))
            rx = parse_len(g('rx'))
            adj = min(50000, rx / min(w0, h0) * 100000) if rx and min(w0, h0) > 0 else None
            line = ln_xml(lc, L(sw), dash=dash) if stroke else '<a:ln><a:noFill/></a:ln>'
            out.append(sp_xml(ctx, 'Rect', X(x0), Y(y0), L(w0), tr.l(h0 * sy), geom='roundRect' if adj else 'rect', adj=adj, fill=fc, line=line))
        elif tag == 'circle':
            cx, cy, r = parse_len(g('cx')), parse_len(g('cy')), parse_len(g('r'))
            line = ln_xml(lc, L(sw)) if stroke else '<a:ln><a:noFill/></a:ln>'
            out.append(sp_xml(ctx, 'Dot', X(cx - r), Y(cy - r), L(2 * r), L(2 * r), geom='ellipse', fill=fc, line=line))
    return out

def group_xml(ctx, members, name='Group'):
    """members: list of (sid, xml). Returns (gid, xml)."""
    if len(members) == 1: return members[0]
    gid = ctx.nid()
    minx = miny = 10 ** 12; maxx = maxy = -10 ** 12
    for _, x in members:
        m = re.search(r'<a:off x="(-?\d+)" y="(-?\d+)"/><a:ext cx="(\d+)" cy="(\d+)"/>', x)
        ox, oy, cx, cy = map(int, m.groups())
        minx, miny = min(minx, ox), min(miny, oy); maxx, maxy = max(maxx, ox + cx), max(maxy, oy + cy)
    inner = ''.join(re.sub(r'^<p:sp [^>]*>', '<p:sp>', x) for _, x in members)
    xfrm = f'<a:xfrm><a:off x="{minx}" y="{miny}"/><a:ext cx="{maxx - minx}" cy="{maxy - miny}"/><a:chOff x="{minx}" y="{miny}"/><a:chExt cx="{maxx - minx}" cy="{maxy - miny}"/></a:xfrm>'
    return gid, (f'<p:grpSp {NSDECL}><p:nvGrpSpPr><p:cNvPr id="{gid}" name="{name} {gid}"/><p:cNvGrpSpPr/><p:nvPr/></p:nvGrpSpPr>'
                 f'<p:grpSpPr>{xfrm}</p:grpSpPr>{inner}</p:grpSp>')

def conn_shapes(ctx, it, tr):
    x1, y1, x2, y2 = it['x1'], it['y1'], it['x2'], it['y2']
    if it['route'] == 'elbow':
        xm = (x1 + x2) / 2
        pts = [(x1, y1), (xm, y1), (xm, y2), (x2, y2)]
    else:
        pts = [(x1, y1), (x2, y2)]
    pts = [(tr.x(a), tr.y(b)) for a, b in pts]
    col = map_line(it['color']) or '8F8F8F'
    return [line_shape(ctx, pts, col, tr.l(it['w']), round_join=True, tail='triangle')]

# ---------------------------------------------------------------- slide assembly
LOGO = W + '/logo.png'   # extracted from the template in main()
TITLE_X, TITLE_TOP, KICK_TOP = 117, 128, 78
TITLE_W = 1400
LOGO_SMALL = (1586, 144, 230, 79)       # template: 8.26", 0.75", 1.20" x 0.41"
LOGO_BIG = (1436, 127, 380, 131)        # template: 7.48", 0.66", 1.98" x 0.68"
BODY_BOTTOM = 918

def notes_text(h):
    h = re.sub(r'<br\b[^>]*>', '\n', h)
    h = re.sub(r'<[^>]+>', '', h)
    return html.unescape(h).strip()

def title_plan(text, sizes=(58.67, 53.33), width=TITLE_W, max_lines=2):
    for fs in sizes:
        lines = wrap_lines(text, 800, fs, width)
        if len(lines) <= max_lines: return fs, lines
    fs = sizes[-1]
    return fs, wrap_lines(text, 800, fs, width)

SLDNUM = ('<p:sp {ns}><p:nvSpPr><p:cNvPr id="{id}" name="Slide Number {id}"/><p:cNvSpPr txBox="1"/><p:nvPr><p:ph idx="12" type="sldNum"/></p:nvPr></p:nvSpPr>'
          '<p:spPr><a:xfrm><a:off x="8384301" y="4448489"/><a:ext cx="510000" cy="393600"/></a:xfrm><a:prstGeom prst="rect"><a:avLst/></a:prstGeom><a:noFill/><a:ln><a:noFill/></a:ln></p:spPr>'
          '<p:txBody><a:bodyPr anchorCtr="0" anchor="ctr" bIns="91425" lIns="91425" spcFirstLastPara="1" rIns="91425" wrap="square" tIns="91425"><a:normAutofit/></a:bodyPr><a:lstStyle/>'
          '<a:p><a:pPr indent="0" lvl="0" marL="0" rtl="0" algn="r"><a:lnSpc><a:spcPct val="100000"/></a:lnSpc><a:spcBef><a:spcPts val="0"/></a:spcBef><a:spcAft><a:spcPts val="0"/></a:spcAft><a:buSzPts val="1000"/><a:buNone/></a:pPr>'
          '<a:fld id="{{00000000-1234-1234-1234-123412341234}}" type="slidenum"><a:rPr lang="ru"><a:solidFill><a:srgbClr val="EFEFEF"/></a:solidFill><a:latin typeface="Montserrat"/><a:ea typeface="Montserrat"/><a:cs typeface="Montserrat"/><a:sym typeface="Montserrat"/></a:rPr><a:t>‹#›</a:t></a:fld>'
          '<a:endParaRPr><a:solidFill><a:srgbClr val="EFEFEF"/></a:solidFill><a:latin typeface="Montserrat"/><a:ea typeface="Montserrat"/><a:cs typeface="Montserrat"/><a:sym typeface="Montserrat"/></a:endParaRPr></a:p></p:txBody></p:sp>')

def timing_xml(builds, videos=()):
    """builds: {order: [(spid, has_text)]}, videos: [(spid, dur_ms, loop, order)] -> <p:timing>.
    Videos without a build order start with the slide; others start on their click. All loop silently."""
    cid = [2]
    def nid():
        cid[0] += 1; return cid[0]
    def play(spid, dur, node):
        a, b = nid(), nid()
        return (f'<p:par><p:cTn id="{a}" presetID="1" presetClass="mediacall" presetSubtype="0" fill="hold" nodeType="{node}">'
                f'<p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>'
                f'<p:cmd type="call" cmd="playFrom(0.0)"><p:cBhvr><p:cTn id="{b}" dur="{dur}" fill="hold"/>'
                f'<p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cBhvr></p:cmd></p:childTnLst></p:cTn></p:par>')
    clicks = ''
    bld = ''
    auto = [v for v in videos if not v[3]]
    if auto:
        o1, o2 = nid(), nid()
        effs = ''.join(play(v[0], v[1], 'afterEffect' if k == 0 else 'withEffect') for k, v in enumerate(auto))
        clicks += (f'<p:par><p:cTn id="{o1}" fill="hold"><p:stCondLst><p:cond delay="indefinite"/>'
                   f'<p:cond evt="onBegin" delay="0"><p:tn val="2"/></p:cond></p:stCondLst><p:childTnLst>'
                   f'<p:par><p:cTn id="{o2}" fill="hold"><p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>{effs}</p:childTnLst></p:cTn></p:par>'
                   f'</p:childTnLst></p:cTn></p:par>')
    for order in sorted(builds):
        effs = ''
        for k, (spid, has_text) in enumerate(builds[order]):
            a, b, c = nid(), nid(), nid()
            node = 'clickEffect' if k == 0 else 'withEffect'
            effs += (f'<p:par><p:cTn id="{a}" presetID="10" presetClass="entr" presetSubtype="0" fill="hold" grpId="0" nodeType="{node}">'
                     f'<p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>'
                     f'<p:set><p:cBhvr><p:cTn id="{b}" dur="1" fill="hold"><p:stCondLst><p:cond delay="0"/></p:stCondLst></p:cTn>'
                     f'<p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl><p:attrNameLst><p:attrName>style.visibility</p:attrName></p:attrNameLst></p:cBhvr>'
                     f'<p:to><p:strVal val="visible"/></p:to></p:set>'
                     f'<p:animEffect transition="in" filter="fade"><p:cBhvr><p:cTn id="{c}" dur="400"/><p:tgtEl><p:spTgt spid="{spid}"/></p:tgtEl></p:cBhvr></p:animEffect>'
                     f'</p:childTnLst></p:cTn></p:par>')
            if has_text: bld += f'<p:bldP spid="{spid}" grpId="0" animBg="1"/>'
        effs += ''.join(play(v[0], v[1], 'withEffect') for v in videos if v[3] == order)
        o1, o2 = nid(), nid()
        clicks += (f'<p:par><p:cTn id="{o1}" fill="hold"><p:stCondLst><p:cond delay="indefinite"/></p:stCondLst><p:childTnLst>'
                   f'<p:par><p:cTn id="{o2}" fill="hold"><p:stCondLst><p:cond delay="0"/></p:stCondLst><p:childTnLst>{effs}</p:childTnLst></p:cTn></p:par>'
                   f'</p:childTnLst></p:cTn></p:par>')
    media = ''
    for v in videos:
        c = nid()
        rep = ' repeatCount="indefinite"' if v[2] else ''
        media += (f'<p:video><p:cMediaNode vol="0" mute="1"><p:cTn id="{c}"{rep} fill="hold" display="0">'
                  f'<p:stCondLst><p:cond delay="indefinite"/></p:stCondLst></p:cTn>'
                  f'<p:tgtEl><p:spTgt spid="{v[0]}"/></p:tgtEl></p:cMediaNode></p:video>')
    return (f'<p:timing {NSDECL}><p:tnLst><p:par><p:cTn id="1" dur="indefinite" restart="never" nodeType="tmRoot"><p:childTnLst>'
            f'<p:seq concurrent="1" nextAc="seek"><p:cTn id="2" dur="indefinite" nodeType="mainSeq"><p:childTnLst>{clicks}</p:childTnLst></p:cTn>'
            f'<p:prevCondLst><p:cond evt="onPrev" delay="0"><p:tgtEl><p:sldTgt/></p:tgtEl></p:cond></p:prevCondLst>'
            f'<p:nextCondLst><p:cond evt="onNext" delay="0"><p:tgtEl><p:sldTgt/></p:tgtEl></p:cond></p:nextCondLst></p:seq>'
            f'{media}</p:childTnLst></p:cTn></p:par></p:tnLst>{"<p:bldLst>" + bld + "</p:bldLst>" if bld else ""}</p:timing>')

import overrides as OV

def build_slide(prs, layout, sid_name, data, report):
    slide = prs.slides.add_slide(layout)
    sp_tree = slide.shapes._spTree
    for ph in list(slide.placeholders):
        sp_tree.remove(ph._element)
    # background
    cSld = slide._element.find('p:cSld', NS)
    bg = etree.fromstring(f'<p:bg {NSDECL}><p:bgPr><a:solidFill><a:srgbClr val="000000"/></a:solidFill><a:effectLst/></p:bgPr></p:bg>')
    cSld.insert(0, bg)
    ctx = Ctx()
    ov = None if NATIVE else OV.get(sid_name)
    DX = 0 if NATIVE else -11
    items = data['items']
    items = ov.pre(items, data) if ov and hasattr(ov, 'pre') else items

    kicker = next((i for i in items if i.get('role') == 'kicker'), None)
    title = next((i for i in items if i.get('role') == 'title'), None)
    special = getattr(ov, 'special', None) if ov else None

    shapes = []  # (order, spid, xml, has_text) -- appended to the tree immediately, so pictures keep DOM z-order
    videos = []  # (spid, dur_ms, loop, order)
    def add(lst, build, has_text=False):
        for sid, xml in lst:
            shapes.append((build['order'] if build else 0, sid, xml, has_text))
            sp_tree.append(etree.fromstring(xml))

    # ------------------------------------------------ title block
    title_bottom = 0
    use_title = title if title else (kicker if (kicker and not special) else None)
    use_kicker = kicker if (title and kicker) else None
    if not title and kicker and not special:
        full = ''.join(r.get('t', '') for r in kicker['runs'])
        if ' · ' in full:
            k_txt, t_txt = full.split(' · ', 1)
            base = next(r for r in kicker['runs'] if not r.get('br'))
            use_kicker = dict(kicker, runs=[dict(base, t=k_txt)])
            use_title = dict(kicker, runs=[dict(base, t=t_txt)])
    if special != 'cover':
        if use_kicker:
            kr = []
            for r in use_kicker['runs']:
                if r.get('br'): continue
                col = r['color']['hex'] if NATIVE else (LABEL if r['color']['hex'] in ('6A7280', '9AA3B2') else TURQ)
                kr.append((r['t'].upper(), rpr_xml(29.3, col, 'Montserrat SemiBold', False, spc_px=2.5)))
            body = txbody_xml([{'align': 'left', 'lh': 36, 'runs': kr}], wrap=True)
            add([sp_xml(ctx, 'Kicker', TITLE_X, KICK_TOP - 2, TITLE_W, 40, txbody=body, txbox=True)], use_kicker.get('build'), True)
        if use_title:
            for r in use_title['runs']:
                if r.get('br'): continue
                if not NATIVE: r['t'] = r['t'].replace('\u00a0', ' ')     # native decks place their nbsp on purpose
                r['t'] = r['t'].replace(' —', '\u00a0—')
            sizes = getattr(ov, 'title_sizes', (58.67, 53.33)) if ov else (58.67, 53.33)
            tw0 = getattr(ov, 'title_w', TITLE_W) if ov else TITLE_W
            if NATIVE:   # explicit <br> = line break
                segs = caps_text(''.join('\n' if r.get('br') else r['t'] for r in use_title['runs'])).split('\n')
                for fs in sizes:
                    lines = [l for sg in segs for l in wrap_lines(sg.strip(), 800, fs, tw0)]
                    if len(lines) <= 2: break
            else:
                ttext = ''.join(' ' if r.get('br') else r['t'] for r in use_title['runs'])
                fs, lines = title_plan(caps_text(ttext).replace('\n', ' '), sizes=sizes, width=tw0)
            lh = fs * 1.12
            tr_runs = []
            for r in use_title['runs']:
                if r.get('br'):
                    if NATIVE: tr_runs.append((None, rpr_xml(fs, WHITE, 'Montserrat ExtraBold', True)))
                    else: tr_runs.append((' ', rpr_xml(fs, WHITE, 'Montserrat ExtraBold', True)))
                    continue
                col = WHITE
                h = r['color']['hex']
                if NATIVE: col = h
                elif h in AMBER_TEXT: col = PLACEHOLDER if '[' in r['t'] else TURQ
                elif h in TEXT_MAP and TEXT_MAP[h] not in (WHITE, TEXT2, LABEL): col = TEXT_MAP[h]
                tr_runs.append((caps_text(r['t']), rpr_xml(fs, col, 'Montserrat ExtraBold', True)))
            tw = getattr(ov, 'title_w', TITLE_W) if ov else TITLE_W
            body = txbody_xml([{'align': 'left', 'lh': lh, 'runs': tr_runs}], wrap=True)
            top = TITLE_TOP if use_kicker else TITLE_TOP - 12
            box_top = top + 0.7 * fs - lh + 0.225 * fs  # cap-top at `top`
            add([sp_xml(ctx, 'Title', TITLE_X, box_top, tw + 24, len(lines) * lh + 6, txbody=body, txbox=True)], use_title.get('build'), True)
            title_bottom = top + 0.7 * fs + (len(lines) - 1) * lh + 0.25 * fs
            report.append(f'{sid_name}: title {fs * PT:.0f}pt x{len(lines)} bottom={title_bottom:.0f}')
        else:
            title_bottom = 0

    # ------------------------------------------------ body transform
    skip = {id(use_title), id(use_kicker)} if special != 'cover' else set()
    if kicker and not title and special != 'cover': skip.add(id(kicker))
    body_items = [i for i in items if id(i) not in skip and not (i.get('role') in ('title', 'kicker') and special != 'cover')]
    def is_footer(i):
        return i['type'] == 'text' and i['y'] + i['h'] >= 1000 and i['y'] > 900
    footers = [i for i in body_items if is_footer(i)]
    main = [i for i in body_items if not is_footer(i)]
    def top_of(i):
        if i['type'] == 'conn': return min(i['y1'], i['y2'])
        if i['type'] == 'text' and i.get('tr') and not i.get('deco'): return i['tr']['top']
        return i['y']
    def bottom_of(i):
        if i['type'] == 'conn': return max(i['y1'], i['y2'])
        if i['type'] == 'text' and i.get('tr') and not i.get('deco'): return i['tr']['bottom']
        return i['y'] + i['h']
    tr = T(dx=DX)
    if main and special != 'cover':
        btop = min(top_of(i) for i in main)
        bbot = max(bottom_of(i) for i in main)
        limit = BODY_BOTTOM if footers else 960
        if footers:
            ftop = min(f['tr']['top'] if f.get('tr') else f['y'] for f in footers)
            limit = min(limit, ftop - 14)
        need = (title_bottom + 34) if title_bottom else 0
        right = [top_of(i) for i in main if (i['x'] + i.get('w', 0) if i['type'] != 'conn' else max(i['x1'], i['x2'])) > 1560]
        if right and min(right) < 240:
            need = max(need, btop + 240 - min(right))
        if ov and hasattr(ov, 'need'): need = ov.need(need)
        if need and btop < need:
            shift = need - btop
            room = max(0, limit - bbot)
            if shift <= room:
                tr = T(dx=DX, dy=shift)
            else:
                s = (limit - need) / (bbot - btop)
                s = min(1.0, s)
                # uniform scale around left edge of content, top aligned to `need`
                tr = T(dx=DX, s=s, ox=128, oy=btop, dy=need - btop)
            report.append(f'   body {btop:.0f}-{bbot:.0f} -> need {need:.0f}: dy={tr.dy:.0f} s={tr.s:.3f}')
    if ov and hasattr(ov, 'transform'): tr = ov.transform(tr)

    brights = []
    ftr = T(dx=DX)
    boxes = [(r['x'], r['y'], r['w'], r['h']) for r in items if r.get('deco') and (r['type'] == 'rect') and r['w'] > 60 and r['h'] > 30]
    for i in items:
        if i['type'] != 'text': continue
        cx_, cy_ = i['x'] + i['w'] / 2, i['y'] + i['h'] / 2
        i['_containers'] = [(x, y, w, h, 10) for (x, y, w, h) in boxes
                            if x <= i['x'] + 1 and i['x'] + i['w'] <= x + w + 1 and y <= cy_ <= y + h]
        rx = [(o['tr']['left'] if (o['type'] == 'text' and o.get('tr')) else o['x'])
              for o in items if o is not i and o['type'] in ('text', 'rect', 'svg') and o['x'] >= i['x'] + i['w'] - 1
              and o['y'] < i['y'] + i['h'] and o['y'] + o['h'] > i['y']]
        i['_right'] = min(rx) if rx else None
    for i in (main if special != 'cover' else body_items):
        b = i.get('build')
        if ov and hasattr(ov, 'item'):
            r = ov.item(i, ctx, tr, brights)
            if r is not None:
                add(r, b, True); continue
        if i['type'] == 'text': add(text_shapes(ctx, i, tr, brights), b, True)
        elif i['type'] == 'rect': add(deco_shapes(ctx, i, tr, brights), b)
        elif i['type'] == 'svg':
            if i['label'].startswith('QR'):
                continue
            members = svg_shapes(ctx, i, tr)
            if members: add([group_xml(ctx, members, 'Chart')], b)
        elif i['type'] == 'conn': add(conn_shapes(ctx, i, tr), b)
        elif i['type'] in ('img', 'video'):
            X, Y, Wd, Ht = Emu(E(tr.x(i['x']))), Emu(E(tr.y(i['y']))), Emu(E(tr.l(i['w']))), Emu(E(tr.l(i['h'])))
            if i['type'] == 'img':
                pic = slide.shapes.add_picture(i['src'], X, Y, Wd, Ht)
                if i.get('fit') == 'cover' and i.get('nw') and i.get('nh'):
                    ar_i, ar_b = i['nw'] / i['nh'], i['w'] / i['h']
                    if ar_i > ar_b + 1e-3:
                        c = (1 - ar_b / ar_i) / 2; pic.crop_left = c; pic.crop_right = c
                    elif ar_b > ar_i + 1e-3:
                        c = (1 - ar_i / ar_b) / 2; pic.crop_top = c; pic.crop_bottom = c
            elif not os.path.exists(i['src']):
                print(f'WARNING {sid_name}: video {i["src"]} is missing, placeholder used')
                add([sp_xml(ctx, 'Missing video', tr.x(i['x']), tr.y(i['y']), tr.l(i['w']), tr.l(i['h']), geom='roundRect', adj=8000,
                            fill='1E1E1E', line=ln_xml('F2C14E', 3, dash='dash'))], b)
                continue
            else:
                pic = slide.shapes.add_movie(i['src'], X, Y, Wd, Ht, poster_frame_image=i.get('poster') or None, mime_type='video/mp4')
                videos.append((pic.shape_id, int(i.get('dur', 6) * 1000), i.get('loop', True), b['order'] if b else 0))
            ctx.next_id = max(ctx.next_id, pic.shape_id)
            adj, geom = radius_adj(i.get('radius'), i['w'], i['h'])
            if geom == 'roundRect':
                pg = pic._element.find('.//a:prstGeom', NS)
                pg.set('prst', 'roundRect'); pg.append(etree.fromstring(f'<a:avLst {NSDECL}><a:gd name="adj" fmla="val {int(adj)}"/></a:avLst>')) if pg.find('a:avLst', NS) is None else pg.find('a:avLst', NS).append(etree.fromstring(f'<a:gd {NSDECL} name="adj" fmla="val {int(adj)}"/>'))
            shapes.append((b['order'] if b else 0, pic.shape_id, None, False))
    for f in (footers if special != 'cover' else []):
        f2 = dict(f)
        f2['w'] = min(f['w'], 1740 - f['x'])
        for m in main:
            if m['type'] in ('text', 'rect') and m['x'] > f['x'] + 200 and m['y'] < f['y'] + f['h'] and m['y'] + m['h'] > f['y']:
                f2['w'] = min(f2['w'], m['x'] - 24 - f['x'])
        add(text_shapes(ctx, f2, ftr, brights), f.get('build'), True)

    if ov and hasattr(ov, 'extra'):
        for order, lst in ov.extra(ctx, tr, data):
            for sid, xml in lst:
                shapes.append((order, sid, xml, True)); sp_tree.append(etree.fromstring(xml))

    # QR images
    for i in body_items:
        if i['type'] == 'svg' and i['label'].startswith('QR') and data.get('qr'):
            par = next((p for p in items if p['type'] == 'rect' and p['x'] <= i['x'] and p['y'] <= i['y'] and p['x'] + p['w'] >= i['x'] + i['w']), None)
            x, y, w, h = (par['x'], par['y'], par['w'], par['h']) if par else (i['x'], i['y'], i['w'], i['h'])
            pic = slide.shapes.add_picture(data['qr'], Emu(E(tr.x(x))), Emu(E(tr.y(y))), Emu(E(tr.l(w))), Emu(E(tr.l(h))))
            if i.get('build'): shapes.append((i['build']['order'], pic.shape_id, None, False))

    # logo + slide number
    big = special in ('cover',) or data.get('logo') == 'big'
    lx, ly, lw, lh_ = LOGO_BIG if big else LOGO_SMALL
    if data.get('logo') != 'none':
        slide.shapes.add_picture(LOGO, Emu(E(lx)), Emu(E(ly)), Emu(E(lw)), Emu(E(lh_)))
    if special != 'cover' and not data.get('nonum'):
        sp_tree.append(etree.fromstring(SLDNUM.format(ns=NSDECL, id=ctx.nid())))

    # builds
    builds = {}
    for order, sid, xml, has_text in shapes:
        if order: builds.setdefault(order, []).append((sid, has_text and xml is not None and '<p:txBody>' in xml))
    for t in slide._element.findall('p:timing', NS):      # python-pptx adds click-to-play timing for movies
        slide._element.remove(t)
    if builds or videos:
        slide._element.append(etree.fromstring(timing_xml(builds, videos)))
    # notes
    nt = notes_text(data['notes'])
    if nt:
        slide.notes_slide.notes_text_frame.text = nt
    if data.get('hidden') and not os.environ.get('SHOWALL'):
        slide._element.set('show', '0')
    return slide

def add_sections(prs, deck, id_by_name):
    pres = prs.part._element
    ext_lst = pres.find('p:extLst', NS)
    if ext_lst is None:
        ext_lst = etree.SubElement(pres, f'{{{NS["p"]}}}extLst')
    order = deck['order']
    starts = sorted(((order.index(v['start']), v['description']) for v in deck['sections'].values()))
    secs = ''
    for k, (st, name) in enumerate(starts):
        en = starts[k + 1][0] if k + 1 < len(starts) else len(order)
        ids = ''.join(f'<p14:sldId id="{id_by_name[n]}"/>' for n in order[st:en])
        secs += f'<p14:section name="{html.escape(name)}" id="{{{str(uuid.uuid4()).upper()}}}"><p14:sldIdLst>{ids}</p14:sldIdLst></p14:section>'
    ext = etree.fromstring(f'<p:ext {NSDECL} uri="{{521415D9-36F7-43E2-AB2F-B90AF26B5E84}}"><p14:sectionLst>{secs}</p14:sectionLst></p:ext>')
    ext_lst.append(ext)

def main():
    global NATIVE
    deck = json.load(open(DECK))
    NATIVE = bool(deck.get('native'))
    os.makedirs(W, exist_ok=True)
    with zipfile.ZipFile(TEMPLATE) as z, open(LOGO, 'wb') as f:
        f.write(z.read('ppt/media/image1.png'))   # HARDfest logo
    prs = Presentation(TEMPLATE)
    lst = prs.slides._sldIdLst
    for s in list(lst):
        prs.part.drop_rel(s.rId); lst.remove(s)
    layout = next(l for l in prs.slide_layouts if l.name == 'TITLE')
    report = []
    only = ONLY
    for name in deck['order']:
        if only and name not in only: continue
        data = json.load(open(f'{EXT}/{name}.json'))
        build_slide(prs, layout, name, data, report)
    id_by_name = {}
    names = [n for n in deck['order'] if not only or n in only]
    for n, s in zip(names, prs.slides._sldIdLst):
        id_by_name[n] = s.get('id')
    if not only: add_sections(prs, deck, id_by_name)
    prs.core_properties.title = deck['title']
    prs.core_properties.author = 'Никита Нагорнов'
    prs.save(OUTFILE)
    open(W + '/build_report.txt', 'w').write('\n'.join(report))
    print(f'{len(prs.slides._sldIdLst)} slides -> {os.path.abspath(OUTFILE)}')

if __name__ == '__main__':
    main()
