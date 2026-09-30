#!/usr/bin/env python3
"""Static lint for Slides-type slide files (no rendering).

Usage: python3 lint.py <slide.html> [...]   (or a directory)
Checks the rules from artifact-type/reference/format.md that are cheap to check
statically, plus deck conventions from DESIGN.md.
"""
import os
import re
import sys
from html.parser import HTMLParser

ALLOWED_TAGS = {
    'section', 'h1', 'h2', 'h3', 'p', 'ul', 'ol', 'li', 'br', 'b', 'i', 'u', 'a', 'span',
    'div', 'img', 'table', 'tr', 'th', 'td', 'svg', 'hr', 'x-shape', 'x-icon', 'x-connector',
    'x-embed', 'aside', 'tbody', 'thead',
}
TEXT_TAGS = {'h1', 'h2', 'h3', 'p', 'li', 'ul', 'ol', 'td', 'th', 'table'}
ALLOWED_PROPS = {
    'position', 'left', 'top', 'right', 'bottom', 'width', 'height', 'min-width', 'min-height',
    'max-width', 'max-height', 'display', 'flex-direction', 'flex-wrap', 'gap', 'align-items',
    'justify-content', 'justify-items', 'align-self', 'justify-self', 'flex', 'flex-grow',
    'flex-shrink', 'flex-basis', 'grid-template-columns', 'grid-template-rows', 'grid-column',
    'grid-row', 'aspect-ratio', 'padding', 'overflow', 'font-family', 'font-size', 'font-weight',
    'font-style', 'font', 'line-height', 'letter-spacing', 'text-align', 'text-transform',
    'white-space', 'text-decoration', 'font-variant-numeric', '-webkit-text-stroke', 'color',
    'background', 'background-clip', '-webkit-text-fill-color', 'border', 'border-top',
    'border-right', 'border-bottom', 'border-left', 'border-radius', 'box-shadow', 'text-shadow',
    'opacity', 'transform', 'filter', 'backdrop-filter', 'mix-blend-mode', 'object-fit',
    'margin', 'box-sizing', 'grid-template', 'border-width', 'border-style',
}
BUILD_RE = re.compile(r'^(fade|rise|drop|left|right|scale|pop)(\s+\d+)?(\s+auto)?$')


def parse_style(s):
    out = {}
    for part in (s or '').split(';'):
        if ':' in part:
            k, v = part.split(':', 1)
            out[k.strip().lower()] = v.strip()
    return out


def px(v):
    m = re.match(r'^(-?\d+(?:\.\d+)?)(px)?$', (v or '').strip())
    return float(m.group(1)) if m else None


class Linter(HTMLParser):
    def __init__(self):
        super().__init__(convert_charrefs=True)
        self.errors, self.warns = [], []
        self.stack = []          # (tag, style, attrs)
        self.in_svg = 0
        self.svg_start = None
        self.count = 0
        self.sections = []
        self.aside_text = None
        self.in_aside = False
        self.after_aside_tags = 0
        self.builds = []
        self.div_depth = 0
        self.max_div_depth = 0
        self.pos_children = []   # per open div: count of absolute children
        self.top_level_after_section = False

    def handle_starttag(self, tag, attrs):
        a = dict(attrs)
        if self.in_svg:
            if tag == 'svg':
                self.in_svg += 1
            if tag == 'text':
                self.errors.append('svg <text> is not allowed (labels must be <p> over the svg)')
            if tag in ('script', 'foreignobject', 'image'):
                self.errors.append(f'svg <{tag}> not allowed')
            return
        if tag not in ALLOWED_TAGS:
            self.errors.append(f'tag <{tag}> not in subset')
        if self.in_aside:
            if tag != 'br':
                self.warns.append(f'<{tag}> inside <aside> (notes are plain text; <br> only)')
            return
        if self.aside_text is not None and not self.in_aside and tag != 'aside':
            self.after_aside_tags += 1
        self.count += 1
        style = parse_style(a.get('style'))
        if tag == 'section':
            self.sections.append(a.get('id'))
            if 'background' not in style:
                self.errors.append('section has no background')
        if tag == 'aside':
            self.in_aside = True
            self.aside_text = ''
        for k, v in style.items():
            if k not in ALLOWED_PROPS:
                self.errors.append(f'<{tag}> unsupported property {k}')
            if k == 'margin' and v not in ('0', '0px'):
                self.errors.append(f'<{tag}> margin:{v} (only margin:0 is a no-op)')
            if k.startswith('margin-'):
                self.errors.append(f'<{tag}> {k} unsupported')
            if re.search(r'\d(em|rem|vw|vh)\b', v) and k != 'letter-spacing':
                self.errors.append(f'<{tag}> {k}:{v} uses em/rem/vw/vh')
            if 'var(' in v:
                self.errors.append(f'<{tag}> {k} uses var()')
        if 'e8894f' in (a.get('style') or '').lower():
            self.warns.append(f'<{tag}> uses old accent #E8894F (use amber tokens)')
        fs = px(style.get('font-size'))
        if fs is not None and fs < 24:
            self.errors.append(f'<{tag}> font-size {fs}px < 24px')
        if tag in ('p', 'h1', 'h2', 'h3') and 'font-size' not in style and tag == 'p':
            pass
        b = a.get('data-build-in')
        if b is not None:
            if style.get('position') != 'absolute':
                self.errors.append(f'<{tag}> data-build-in on a non-pinned element')
            if not BUILD_RE.match(b.strip()):
                self.errors.append(f'<{tag}> bad data-build-in="{b}"')
            m = re.search(r'\s(\d+)', b)
            self.builds.append(int(m.group(1)) if m else 1)
        if style.get('position') == 'absolute':
            if self.pos_children:
                self.pos_children[-1] += 1
                if self.pos_children[-1] > 24:
                    self.errors.append('>24 positioned children in one <div>')
            L, T, W, H = (px(style.get(x)) for x in ('left', 'top', 'width', 'height'))
            if tag in ('p', 'h1', 'h2', 'h3') and W is None and not (style.get('left') and style.get('right')):
                self.warns.append(f'pinned <{tag}> without width')
            parent_rel = any(s.get('position') == 'relative' for (_, s, _) in self.stack)
            if not parent_rel:
                if L is not None and W is not None and L + W > 1792 + 1:
                    self.warns.append(f'pinned <{tag}> right edge {L + W:.0f} > 1792')
                if T is not None and H is not None and T + H > 952 + 1:
                    self.warns.append(f'pinned <{tag}> bottom edge {T + H:.0f} > 952')
        if tag == 'div':
            self.div_depth += 1
            self.max_div_depth = max(self.max_div_depth, self.div_depth)
            self.pos_children.append(0)
        if tag == 'svg':
            self.in_svg = 1
            self.svg_start = self.getpos()
            vb = a.get('viewbox') or a.get('viewBox')
            if not a.get('aria-label'):
                self.warns.append('svg without aria-label')
            if vb:
                parts = vb.replace(',', ' ').split()
                if len(parts) == 4 and a.get('width') and a.get('height'):
                    if px(a['width']) != float(parts[2]) or px(a['height']) != float(parts[3]):
                        self.warns.append(f'svg width/height {a["width"]}x{a["height"]} != viewBox {parts[2]}x{parts[3]}')
        if tag in ('br', 'img', 'hr', 'x-shape', 'x-icon', 'x-connector'):
            return
        self.stack.append((tag, style, a))

    def handle_startendtag(self, tag, attrs):
        self.handle_starttag(tag, attrs)
        if not self.in_svg and tag not in ('br', 'img', 'hr', 'x-shape', 'x-icon', 'x-connector') and self.stack and self.stack[-1][0] == tag:
            self.handle_endtag(tag)

    def handle_endtag(self, tag):
        if self.in_svg:
            if tag == 'svg':
                self.in_svg -= 1
                if self.in_svg == 0 and self.stack and self.stack[-1][0] == 'svg':
                    self.stack.pop()
            return
        if tag == 'aside':
            self.in_aside = False
        if self.in_aside:
            return
        if tag == 'div':
            self.div_depth -= 1
            if self.pos_children:
                self.pos_children.pop()
        while self.stack:
            t, _, _ = self.stack.pop()
            if t == tag:
                break

    def handle_data(self, data):
        if self.in_aside:
            self.aside_text += data


def lint_file(path):
    src = open(path, encoding='utf-8').read()
    sid = os.path.splitext(os.path.basename(path))[0]
    L = Linter()
    L.feed(src)
    stripped = src.strip()
    if not stripped.startswith('<section') or not stripped.endswith('</section>'):
        L.errors.append('file must hold exactly one <section> and nothing else')
    if L.sections != [sid]:
        L.errors.append(f'section ids {L.sections} != [{sid}]')
    if L.count > 200:
        L.errors.append(f'{L.count} elements > 200')
    if L.max_div_depth > 15:
        L.errors.append(f'div depth {L.max_div_depth} > 15')
    for m in re.finditer(r'<svg.*?</svg>', src, re.S):
        if len(m.group(0).encode()) > 52 * 1024:
            L.errors.append(f'svg {len(m.group(0).encode())} B > 52 KB')
    notes = L.aside_text
    hidden = re.search(r'<section[^>]*\bhidden\b', src) is not None
    if notes is None:
        L.warns.append('no speaker notes')
    else:
        if not re.search(r'</aside>\s*</section>\s*$', src):
            L.errors.append('<aside> must be the last child of the section')
        if len(notes) > 4000:
            L.errors.append(f'notes {len(notes)} chars > 4000')
        if '**' in notes or '`' in notes:
            L.warns.append('markdown marks (** or `) in notes')
        clicks = len(re.findall(r'\[щелчок', notes))
        steps = sorted(set(L.builds))
        if steps and steps != list(range(1, len(steps) + 1)):
            L.errors.append(f'build orders {steps} are not 1..k')
        if not hidden and clicks != len(steps):
            L.errors.append(f'notes have {clicks} [щелчок] but slide has {len(steps)} build steps')
    return L, notes


def main(args):
    files = []
    for a in args:
        if os.path.isdir(a):
            files += sorted(os.path.join(a, f) for f in os.listdir(a) if f.endswith('.html'))
        else:
            files.append(a)
    bad = 0
    for f in files:
        L, notes = lint_file(f)
        status = 'OK ' if not L.errors else 'ERR'
        if L.errors:
            bad += 1
        n = len(notes) if notes else 0
        print(f'{status} {os.path.basename(f)}: {L.count} el, builds {sorted(set(L.builds))}, notes {n} ch')
        for e in dict.fromkeys(L.errors):
            print('   error:', e)
        for w in dict.fromkeys(L.warns):
            print('   warn: ', w)
    print(f'{len(files)} files, {bad} with errors')
    return 1 if bad else 0


if __name__ == '__main__':
    sys.exit(main(sys.argv[1:]))
