"""Per-slide adjustments for the HardFest conversion."""
import build as B

REG = {}
def reg(name):
    def deco(cls):
        REG[name] = cls(); return cls
    return deco

def get(name):
    return REG.get(name)

def tb(ctx, x, y, w, h, paras, anchor='t', wrap=True, name='Text'):
    body = B.txbody_xml(paras, anchor=anchor, wrap=wrap)
    return B.sp_xml(ctx, name, x, y, w, h, txbody=body, txbox=True)

def R(t, size, color, font='Montserrat', bold=False, cap=False, spc=0, italic=False):
    return (t, B.rpr_xml(size, color, font, bold, italic, cap, spc))


@reg('cover')
class Cover:
    special = 'cover'
    def pre(self, items, data):
        return []
    def extra(self, ctx, tr, data):
        X = 117
        s = []
        s.append(tb(ctx, X, 70, 1100, 50, [{'lh': 44, 'runs': [R('HardFest 2026 · трек «Разработка»', 37.3, B.WHITE, 'Montserrat SemiBold')]}]))
        s.append(tb(ctx, X, 318, 1250, 270, [{'lh': 120, 'runs': [
            R('O(n) ', 106.7, B.WHITE, 'Montserrat ExtraBold', True), R('ПРОИГРАЛ', 106.7, B.WHITE, 'Montserrat ExtraBold', True),
            (None, B.rpr_xml(106.7, B.WHITE, 'Montserrat ExtraBold', True)),
            R('O(n log n)', 106.7, B.TURQ, 'Montserrat ExtraBold', True)]}]))
        s.append(tb(ctx, X, 600, 1180, 160, [{'lh': 72, 'runs': [R('Ваш алгоритм не выбирал процессор, на котором работает', 58.7, 'EFEFEF')]}]))
        s.append(tb(ctx, X, 846, 1500, 56, [{'lh': 52, 'runs': [
            R('Никита Нагорнов', 42.7, B.TURQ, 'Montserrat', True), R(' · iOS, компания «Исходный код»', 42.7, B.WHITE)]}]))
        s.append(tb(ctx, X, 912, 1500, 44, [{'lh': 40, 'runs': [
            R('github.com/Neoron95/conference-hardfest-algorithms', 30, B.LABEL, 'JetBrains Mono')]}]))
        return [(0, s)]


def inside(it, x0, y0, x1, y1):
    cx = it.get('x', 0) + it.get('w', 0) / 2; cy = it.get('y', 0) + it.get('h', 0) / 2
    return x0 <= cx <= x1 and y0 <= cy <= y1

def hero(items, needle):
    """Dark 'result' box containing `needle` -> template turquoise card."""
    texts = [i for i in items if i['type'] == 'text']
    for r in items:
        d = r.get('deco')
        if r['type'] == 'rect' and d and d['bg'] and d['bg']['hex'] == '1B1F27':
            inner = [t for t in texts if inside(t, r['x'], r['y'], r['x'] + r['w'], r['y'] + r['h'])]
            if any(needle in ''.join(x.get('t', '') for x in t['runs']) for t in inner):
                d['bg'] = {'hex': '46CDAE', 'a': 1}
    return items


@reg('case')
class Case:
    def pre(self, items, data): return hero(items, 'Уникальные id')


@reg('merge')
class Merge:
    def pre(self, items, data): return hero(items, 'Уникальные id')


@reg('x33')
class X33:
    def pre(self, items, data):
        for i in items:
            if i['x'] >= 1400 and i['y'] >= 150 and i['y'] < 900:
                if i['type'] == 'rect' or (i.get('deco') and i['h'] > 400):
                    i['y'] += 80; i['h'] -= 80
                else:
                    i['y'] += 40
                    if i.get('tr'): i['tr']['top'] += 40; i['tr']['bottom'] += 40
        return items


@reg('final')
class Final:
    def need(self, n): return max(n, 250)
