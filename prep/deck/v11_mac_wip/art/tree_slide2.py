# SORT + UNIQUE: дерево деления + проход unique (заменяет старый 8-й)
S='/tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad'
F="font-family:Montserrat, Arial, sans-serif"
M="font-family:'JetBrains Mono', 'Courier New', monospace"
levels=[[[7,3,8,1,3,9,5,2]],[[3,1,3,2],[7,8,9,5]],[[1,2],[3,3],[5,7],[8,9]],[[1],[2],[3],[3],[5],[7],[8],[9]]]
W,H,G,EX=100,84,12,44
ROWS=[290,430,570,710]
CX=960
out=[]
def P(top,left,width,style,text,build=None):
    b=f' {build}' if build else ''
    out.append(f'  <p{b} style="position:absolute; top:{top}px; left:{left}px; width:{width}px; {style}">{text}</p>')
centers={}; lefts={}
for k,groups in enumerate(levels):
    n=sum(len(g) for g in groups); total=n*W+(n-1)*G+(len(groups)-1)*EX
    x=CX-total//2; build=None if k==0 else f'data-build-in="fade {k}"'
    gc=[]; lefts[k]=[]
    for gi,g in enumerate(groups):
        gx=x
        for v in g:
            if k==3: st=f"{M}; font-size:48px; font-weight:700; line-height:{H-6}px; text-align:center; color:#000000; background:#46cdae; border:3px solid #46cdae; border-radius:14px"
            elif k==0: st=f"{M}; font-size:48px; font-weight:700; line-height:{H-6}px; text-align:center; color:#ffffff; border:3px solid #ffffff; border-radius:14px"
            else: st=f"{M}; font-size:48px; font-weight:700; line-height:{H-6}px; text-align:center; color:#ffffff; border:3px solid #8f8f8f; border-radius:14px"
            P(ROWS[k],x,W,st,str(v),build); lefts[k].append(x); x+=W+G
        gc.append((gx+(x-G-gx)//2)); x+=EX
    centers[k]=gc
for k in range(1,4):
    lines=[]
    for ci,c in enumerate(centers[k]):
        p=centers[k-1][ci//2]
        lines.append(f'<line x1="{p}" y1="{ROWS[k-1]+H+6}" x2="{c}" y2="{ROWS[k]-6}" stroke="#8F8F8F" stroke-width="3"></line>')
    out.append(f'  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 1920 1080" aria-label="деление, уровень {k}" data-build-in="fade {k}" style="position:absolute; top:0px; left:0px; width:1920px; height:1080px">{"".join(lines)}</svg>')
lab=['8 чисел','опорное 3','÷2 → по 2','÷2 → по 1']
for k in range(4):
    col='#bdbdbd' if k==0 else '#f2c14e'
    P(ROWS[k]+18,117,240,f"{F}; font-size:32px; font-weight:700; line-height:1.4; color:{col}",lab[k],None if k==0 else f'data-build-in="fade {k}"')
    if k: P(ROWS[k]+18,1590,213,f"{F}; font-size:26px; font-weight:600; line-height:1.7; text-align:right; color:#8f8f8f",'проход по 8',f'data-build-in="fade {k}"')
P(ROWS[1]+62,117,300,f"{F}; font-size:24px; font-weight:600; line-height:1.3; color:#8f8f8f",'≤ 3 | &gt; 3','data-build-in="fade 1"')
# шаг 4: логарифм
P(850,117,1686,f"{F}; font-size:48px; font-weight:800; line-height:1.25; color:#ffffff",'Три деления: <span style="color:#f2c14e">log₂ 8 = 3</span> · миллион — 20','data-build-in="fade 4" data-build-out="fade 5"')
P(925,117,1686,f"{F}; font-size:34px; font-weight:600; line-height:1.3; color:#46cdae",'Каждый уровень — проход по всем числам: n × log₂ n','data-build-in="fade 4" data-build-out="fade 5"')
# шаг 5: unique
x3a,x3b=lefts[3][2],lefts[3][3]
out.append(f'  <div data-build-in="fade 5" style="position:absolute; top:{ROWS[3]+H+14}px; left:{x3a}px; width:{x3b+W-x3a}px; height:8px; display:flex; flex-direction:column; background:#46cdae; border-radius:4px">\n  </div>')
P(ROWS[3]+H+24,x3a,x3b+W-x3a,f"{F}; font-size:30px; font-weight:700; line-height:1.3; text-align:center; color:#46cdae",'рядом!','data-build-in="fade 5"')
out.append(f'  <div data-build-in="fade 5" style="position:absolute; top:{ROWS[3]}px; left:{x3b}px; width:{W}px; height:{H}px; display:flex; flex-direction:column; background:#000000b8; border-radius:14px">\n  </div>')
P(890,117,1686,f"{F}; font-size:44px; font-weight:700; line-height:1.27; color:#ffffff",'unique — один проход: берём число, если оно <span style="color:#46cdae">не равно соседу</span>','data-build-in="fade 5"')
notes=('Давайте для начала вспомним теорию. Первый способ — сортировка. Возьмём восемь чисел.<br><br>'
 '[щелчок] Внутри std::sort — быстрая сортировка, точнее её доработанная версия, introsort. Берём опорное число, например три: всё, что не больше трёх, — налево, остальное — направо.<br><br>'
 '[щелчок] Дальше то же самое внутри каждой половины.<br><br>'
 '[щелчок] И ещё раз — пока куски не станут по одному. Восемь пополам, пополам, пополам — три раза. Это и есть логарифм по основанию два: log₂ 8 = 3. Для миллиона — двадцать.<br><br>'
 '[щелчок] На каждом уровне мы проходим по всем числам — отсюда n log n. Собирать обратно ничего не нужно: каждое число уже стоит на своём месте.<br><br>'
 '[щелчок] И смотрите: одинаковые встали рядом. Остаётся один проход слева направо: берём число, если оно не равно соседу. Вся работа — сравнения и перестановки в одном массиве, без лишней памяти.<br>[→ следующий слайд]<br><br>'
 '──────────<br>Подсказки<br>'
 '• Пополам — идеальный случай: опорное попадает в середину. На случайных данных части неровные и уровней немного больше, но их число всё равно растёт как log n. Если деление слишком глубокое (в libstdc++ предел 2·log₂N), introsort переходит на пирамидальную сортировку и в n² не скатывается.<br>'
 '• Равные опорному могут попасть в любую из двух частей. Маленькие куски досортировываются вставками.<br>'
 '• Собирать половины (сливать) нужно в сортировке слиянием — так устроены std::stable_sort и TimSort в Python. std::sort делит на месте.<br>'
 '• log₂ 1 048 576 = 20. На деле std::sort делает 22–25 сравнений на число, нижняя граница — ≈18,6.<br>'
 '• Если спросят „а в других языках?“ — Java для примитивов: dual-pivot quicksort, Python: TimSort, Go: pdqsort (с 1.19), Rust sort_unstable: ipnsort, наследник pdqsort.<br>'
 '• В замере: std::sort, потом std::unique сдвигает уникальные в начало, хвост удаляем erase.')
html=f'''<section id="algo-tree" data-transition="fade" style="background:#000000">
  <h2 style="position:absolute; top:115px; left:117px; width:1424px; {F}; font-size:58.7px; font-weight:800; line-height:1.12; color:#ffffff">SORT + UNIQUE</h2>
  <img src="/_blob/95693bade921b745f9f9b0e5005269e3" alt="HardFest" style="position:absolute; top:144px; left:1586px; width:230px; height:79px; object-fit:contain">
'''+'\n'.join(out)+f'''
  <aside>{notes}</aside>
</section>
'''
open(f'{S}/pubmac/project/slides/algo-tree.html','w').write(html)
print(len(notes))
