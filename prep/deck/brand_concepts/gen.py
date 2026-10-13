import re,os
BASE=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','v11_mac_wip','project','slides')+'/'
OUT=os.path.join(os.path.dirname(os.path.abspath(__file__)),'slides')+'/'
BLUE='#081DE6'
F='font-family:Montserrat, Arial, sans-serif; '
def glyph(color='#FFFFFF'):
    return (f'<rect x="41" y="47" width="78" height="20" rx="10" fill="{color}"></rect>'
            f'<circle cx="167" cy="57" r="17" fill="{color}"></circle>'
            f'<polyline points="60,116 112,167 164,116" fill="none" stroke="{color}" stroke-width="22" stroke-linecap="round" stroke-linejoin="round"></polyline>')
def icon(top,left,size,bg=BLUE,fg='#FFFFFF',radius=48,extra='',label='логотип «Исходного кода»'):
    rect=f'<rect x="0" y="0" width="220" height="220" rx="{radius}" fill="{bg}"></rect>' if bg else ''
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 220 220" aria-label="{label}" {extra}style="position:absolute; top:{top}px; left:{left}px; width:{size}px; height:{size}px">{rect}{glyph(fg)}</svg>'
def read(sid): return open(BASE+sid+'.html').read()
def save(name,s):
    s=re.sub(r'<section id="[^"]*"',f'<section id="{name}"',s,count=1)
    open(OUT+name+'.html','w').write(s); print('wrote',name)
def sub(s,a,b):
    assert s.count(a)==1,(a[:80],s.count(a)); return s.replace(a,b)

# ---------- Task 2: slide 2 variants ----------
about=read('about')
# 2a: company row with icon instead of plain text line
a=sub(about,f'<p style="position:absolute; top:645px; left:895px; width:908px; {F}font-size:48px; font-weight:400; line-height:1.33; color:#ffffff">iOS · «Исходный код»</p>',
  icon(628,895,88)+f'\n  <p style="position:absolute; top:628px; left:1007px; width:796px; {F}font-size:48px; font-weight:700; line-height:1.2; color:#ffffff">Исходный код</p>'
  f'\n  <p style="position:absolute; top:688px; left:1007px; width:796px; {F}font-size:30px; font-weight:500; line-height:1.2; color:#bdbdbd">iOS-разработчик · <span style="color:#8f9bff">[сайт компании]</span></p>')
a=sub(a,f'top:796px; left:895px; width:908px; {F}font-size:40px','top:806px; left:895px; width:908px; '+F+'font-size:40px')
save('about-co-a',a)
# 2b: keep text, add a blue company card at the bottom
b=about
b=sub(b,f'<p style="position:absolute; top:796px; left:895px; width:908px; {F}font-size:40px; font-weight:400; line-height:1.4; color:#46cdae">Алгоритмы. Компиляторы. Айфоны.</p>',
  f'<p style="position:absolute; top:735px; left:895px; width:908px; {F}font-size:40px; font-weight:400; line-height:1.4; color:#46cdae">Алгоритмы. Компиляторы. Айфоны.</p>'
  f'\n  <div style="position:absolute; top:836px; left:895px; width:640px; height:104px; background:{BLUE}; border-radius:24px"></div>'
  +'\n  '+icon(848,915,80,bg=None)+
  f'\n  <p style="position:absolute; top:850px; left:1015px; width:500px; {F}font-size:36px; font-weight:700; line-height:1.15; color:#ffffff">Исходный код</p>'
  f'\n  <p style="position:absolute; top:894px; left:1015px; width:500px; {F}font-size:26px; font-weight:500; line-height:1.2; color:#c9d0ff">[сайт компании] · мы нанимаем</p>')
save('about-co-b',b)

# ---------- Concept A: brand signature ----------
# A2: tiny mark next to the page number on a content slide
sh=read('share-v2')
sh=sub(sh,'<p style="position:absolute; top:1004px; left:1683px;',icon(1002,1640,34,radius=8,label='знак компании')+'\n  <p style="position:absolute; top:1004px; left:1683px;')
save('A-share-mark',sh)
# A3: final stamp in brand style: blue stamp with the check glyph
ft=read('final-thought')
old=re.search(r'  <p data-build-in="pop 1" style="[^"]*">ПРОВЕРЕНО<br>НА СЕБЕ</p>',ft).group(0)
box='top:650px; left:1150px; width:600px; height:150px'
ft=ft.replace(old,
  f'  <p data-build-in="pop 1" style="position:absolute; {box}; padding:22px 30px 22px 170px; background:{BLUE}; border-radius:28px; {F}font-size:46px; font-weight:800; line-height:1.15; letter-spacing:2px; text-align:left; color:#ffffff; transform:rotate(-8deg)">ПРОВЕРЕНО<br>НА СЕБЕ</p>'
  f'\n  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150" aria-label="знак-галочка компании" data-build-in="pop 1" style="position:absolute; {box}; transform:rotate(-8deg)"><g transform="translate(20,10) scale(0.6)">{glyph()}</g></svg>')
save('A-final-stamp',ft)

# ---------- Concept B: brand blue finale ----------
fb=read('final-thought')
fb=sub(fb,'<section id="final-thought" style="background:#000000">',f'<section id="final-thought" style="background:{BLUE}">')
fb=fb.replace('color:#8f8f8f">Победителя нет — <span style="color:#46cdae">есть условия.</span> Так что','color:#c9d0ff">Победителя нет — <span style="color:#ffffff">есть условия.</span> Так что')
old=re.search(r'  <p data-build-in="pop 1" style="[^"]*">ПРОВЕРЕНО<br>НА СЕБЕ</p>',fb).group(0)
fb=fb.replace(old,
  f'  <p data-build-in="pop 1" style="position:absolute; {box}; padding:22px 30px 22px 170px; background:#ffffff; border-radius:28px; {F}font-size:46px; font-weight:800; line-height:1.15; letter-spacing:2px; text-align:left; color:{BLUE}; transform:rotate(-8deg)">ПРОВЕРЕНО<br>НА СЕБЕ</p>'
  f'\n  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150" aria-label="знак-галочка компании" data-build-in="pop 1" style="position:absolute; {box}; transform:rotate(-8deg)"><g transform="translate(20,10) scale(0.6)">{glyph(BLUE)}</g></svg>')
fb=fb.replace('color:#8f8f8f">39</p>','color:#c9d0ff">39</p>')
save('B-final-blue',fb)
# B2: section divider in brand blue (example: act 2)
div=f'''<section id="B-divider" style="background:{BLUE}">
  <img src="/_blob/95693bade921b745f9f9b0e5005269e3" alt="HardFest" style="position:absolute; top:144px; left:1586px; width:230px; height:79px; object-fit:contain">
  <p style="position:absolute; top:330px; left:117px; width:900px; {F}font-size:40px; font-weight:700; line-height:1.2; letter-spacing:3px; text-transform:uppercase; color:#c9d0ff">Часть 2</p>
  <h2 style="position:absolute; top:400px; left:117px; width:1300px; {F}font-size:120px; font-weight:800; line-height:1.05; color:#ffffff">ТРИ<br>ПОДОЗРЕВАЕМЫХ</h2>
  <p style="position:absolute; top:690px; left:117px; width:1100px; {F}font-size:40px; font-weight:600; line-height:1.3; color:#c9d0ff">работа · ожидание · выброшенная работа</p>
  {icon(560,1420,300,bg=None)}
  <aside>Пример разделителя части в фирменном синем.</aside>
</section>
'''
open(OUT+'B-divider.html','w').write(div); print('wrote B-divider')
