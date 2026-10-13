# Generates variant_A/B/C.html (deck <section> format) for slide 3 "КОМУ ПРИГОДИТСЯ ЭТОТ ДОКЛАД".
# Image src are relative PNG paths (dev.png, reviewer.png, perf.png) -> replace with uploaded asset URLs later.
H2 = '<h2  style="position:absolute; left:117px; top:103px; width:1424px; font-family:\'Montserrat\', Arial, sans-serif; font-size:58.67px; font-weight:800; line-height:65.71px; color:rgb(255, 255, 255)">КОМУ ПРИГОДИТСЯ ЭТОТ ДОКЛАД</h2>'
LOGO = '<img src="/_blob/95693bade921b745f9f9b0e5005269e3" alt="HardFest"  style="position:absolute; left:1586px; top:144px; width:230px; height:79px; object-fit:contain">'
PAGE = '<p style="position:absolute; top:1004px; left:1683px; width:120px; font-family:Montserrat, Arial, sans-serif; font-size:24px; font-weight:600; line-height:1.25; text-align:right; color:#8f8f8f">3</p>'
ASIDE = '<aside>Доклад будет полезен разработчикам, которые еще как-то работают с алгоритмами и контейнерами. <br>Как напоминание тимлидам и ревьюерам, которые оценивают оптимизации; <br>И совсем редким ребятам, кто пишет перф-тесты.<br><br>Разберём, как сравнивать решения на своих данных и почему замер в CI может дать другой ответ на устройстве пользователя.</aside>'
OPEN = '<section id="audience" style="background:rgb(0, 0, 0); color:rgb(255, 255, 255); font-family:\'Montserrat\', Arial, sans-serif">'
F = "font-family:'Montserrat', Arial, sans-serif"
WHITE = 'rgb(255, 255, 255)'
ROWS = [  # src, alt, title, title split for narrow columns, description
    ('dev.png', 'Бумажный разработчик в бирюзовом худи держит карточки sort и hash, над головой вопросительный знак',
     'Разработчикам', 'Разработчикам', 'Выбираете алгоритмы<br>и контейнеры'),
    ('reviewer.png', 'Бородатый ревьюер в янтарном свитере рассматривает лист дифа через лупу',
     'Тимлидам и ревьюерам', 'Тимлидам<br>и ревьюерам', 'Проверяете перф-изменения<br>на ревью'),
    ('perf.png', 'Автор перф-тестов в розовой кофте держит секундомер и телефон, рядом серверный блок CI',
     'Авторам перф-тестов', 'Авторам<br>перф-тестов', 'Мерите в CI<br>и на целевом устройстве'),
]


def b(n, out=None):
    s = f' data-build-in="fade {n}"' if n else ''
    if out:
        s += f' data-build-out="fade {out}"'
    return s


def tail():
    return [LOGO, '  ' + PAGE, ASIDE, '</section>']


# ---------- A: three cards in a row (art on top, title, grey description); one card per click ----------
def variant_a():
    L = [OPEN, H2]
    COLW, IMG, IT = 562, 510, 244
    TL, TB = 58, 880          # title line-height, common bottom of the title block (titles are bottom-aligned)
    for i, (src, alt, _, t2, d) in enumerate(ROWS):
        x = 117 + i * COLW
        lines = t2.count('<br>') + 1
        L.append(f'<img src="{src}" alt="{alt}"{b(i + 1)} style="position:absolute; left:{x + (COLW - IMG) // 2}px; top:{IT}px; width:{IMG}px; height:{IMG}px; object-fit:contain">')
        L.append(f'<p{b(i + 1)} style="position:absolute; left:{x}px; top:{TB - lines * TL}px; width:{COLW}px; {F}; font-size:48px; font-weight:600; line-height:{TL}px; text-align:center; color:{WHITE}">{t2}</p>')
        L.append(f'<p{b(i + 1)} style="position:absolute; left:{x}px; top:{TB + 12}px; width:{COLW}px; {F}; font-size:34px; font-weight:400; line-height:44px; text-align:center; color:#bdbdbd">{d}</p>')
    return L + tail()


# ---------- B: current three rows, small art on the left of each row; one row per click ----------
def variant_b():
    L = [OPEN, H2]
    for i, (src, alt, t, _, d) in enumerate(ROWS):
        top = 252 + i * 240
        cy = top + 120
        L.append(f'<img src="{src}" alt="{alt}"{b(i + 1)} style="position:absolute; left:117px; top:{top}px; width:240px; height:240px; object-fit:contain">')
        L.append(f'<p{b(i + 1)} style="position:absolute; left:400px; top:{cy - 32}px; width:640px; {F}; font-size:48px; font-weight:600; line-height:64px; color:{WHITE}">{t}</p>')
        L.append(f'<p{b(i + 1)} style="position:absolute; left:1080px; top:{cy - 56}px; width:723px; {F}; font-size:40px; font-weight:400; line-height:56px; color:{WHITE}">{d}</p>')
    return L + tail()


# ---------- C: one group; clicks 1..3 spotlight one figure (others at 0.35), click 4 lights everybody ----------
# Each figure: a dimmed copy that is always there + bright copies on top (click n -> out at n+1, and again at 4).
# Captions work the same way (dim copy under the bright one), so a dimmed figure keeps a dimmed caption.
def variant_c():
    L = [OPEN, H2]
    IMG, IT, CX, CW = 600, 232, [430, 960, 1490], 520

    def cap(i, t, d, attrs, op=None):
        x = CX[i] - CW // 2
        o = f' opacity:{op};' if op else ''
        return [f'<p{attrs} style="position:absolute; left:{x}px; top:842px; width:{CW}px; {F}; font-size:36px; font-weight:600; line-height:46px; text-align:center; color:{WHITE};{o}">{t}</p>',
                f'<p{attrs} style="position:absolute; left:{x}px; top:898px; width:{CW}px; {F}; font-size:32px; font-weight:400; line-height:40px; text-align:center; color:#bdbdbd;{o}">{d}</p>']

    for i, (src, alt, t, _, d) in enumerate(ROWS):
        x = CX[i] - IMG // 2
        st = f'position:absolute; left:{x}px; top:{IT}px; width:{IMG}px; height:{IMG}px; object-fit:contain'
        n = i + 1
        L.append(f'<img src="{src}" alt="{alt} (притушен)" style="{st}; opacity:0.35">')
        if n < 3:
            L += cap(i, t, d, b(n), 0.35)
            L.append(f'<img src="{src}" alt="{alt}"{b(n, n + 1)} style="{st}">')
            L += cap(i, t, d, b(n, n + 1))
            L.append(f'<img src="{src}" alt="{alt}"{b(4)} style="{st}">')
            L += cap(i, t, d, b(4))
        else:
            L.append(f'<img src="{src}" alt="{alt}"{b(n)} style="{st}">')
            L += cap(i, t, d, b(n))
    return L + tail()


if __name__ == '__main__':
    for name, fn in (('A', variant_a), ('B', variant_b), ('C', variant_c)):
        open(f'variant_{name}.html', 'w').write('\n'.join(fn()) + '\n')
        print('wrote', f'variant_{name}.html')
