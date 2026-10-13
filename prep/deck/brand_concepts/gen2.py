import re,os,sys
sys.path.insert(0,os.path.dirname(os.path.abspath(__file__)))
BASE=os.path.join(os.path.dirname(os.path.abspath(__file__)),'..','v11_mac_wip','project','slides')+'/'
def glyph(color='#FFFFFF'):
    return (f'<rect x="41" y="47" width="78" height="20" rx="10" fill="{color}"></rect>'
            f'<circle cx="167" cy="57" r="17" fill="{color}"></circle>'
            f'<polyline points="60,116 112,167 164,116" fill="none" stroke="{color}" stroke-width="22" stroke-linecap="round" stroke-linejoin="round"></polyline>')
def read(sid): return open(BASE+sid+'.html').read()
def sub(s,a,b):
    assert s.count(a)==1,(a[:80],s.count(a)); return s.replace(a,b)
OUT=os.path.join(os.path.dirname(os.path.abspath(__file__)),'slides2')+'/'
os.makedirs(OUT,exist_ok=True)
B='#001EF0'; L1='#FAFBFF'; L2='#F1F3FF'; L3='#E3E7FF'
PX="font-family:'IBM Plex Mono', 'Courier New', monospace; "
MS='font-family:Montserrat, Arial, sans-serif; '
LOGO='<img src="/_blob/95693bade921b745f9f9b0e5005269e3" alt="HardFest" style="position:absolute; top:144px; left:1586px; width:230px; height:79px; object-fit:contain">'
LOGO_INV=LOGO.replace('object-fit:contain"','object-fit:contain; filter:invert(1)"')
def pn(n,color='#8f8f8f',fam=MS): return f'<p style="position:absolute; top:1004px; left:1683px; width:120px; {fam}font-size:24px; font-weight:600; line-height:1.25; text-align:right; color:{color}">{n}</p>'
def g(top,left,size,color='#FFFFFF',label='знак компании'):
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="30 30 170 160" aria-label="{label}" style="position:absolute; top:{top}px; left:{left}px; width:{size}px; height:{round(size*160/170)}px">{glyph(color)}</svg>'
def save(name,body,bg):
    s=f'<section id="{name}" style="background:{bg}">\n  '+'\n  '.join(body)+'\n</section>\n'
    open(OUT+name+'.html','w').write(s); print('wrote',name)

# ---- Concept 1: brand light ----
save('C1-cover',[
  g(110,117,130),
  f'<h1 style="position:absolute; top:330px; left:117px; width:1300px; {PX}font-size:120px; font-weight:700; line-height:1.02; letter-spacing:-5px; color:#ffffff">O(n) ПРОИГРАЛ<br>O(n log n)</h1>',
  f'<p style="position:absolute; top:610px; left:117px; width:1100px; {PX}font-size:40px; font-weight:400; line-height:1.3; color:{L3}">Ваш алгоритм не выбирал процессор, на котором работает</p>',
  f'<p style="position:absolute; top:820px; left:117px; width:1100px; {PX}font-size:36px; font-weight:700; line-height:1.3; color:#ffffff">НИКИТА НАГОРНОВ</p>',
  f'<p style="position:absolute; top:870px; left:117px; width:1100px; {PX}font-size:30px; font-weight:400; line-height:1.3; color:{L3}">iOS · Исходный код · codesrc.ru</p>',
  LOGO],B)
rows=[('Все id разные','миллион узлов — процессор ждёт память','sort ×2,9',True),
      ('Разных только 1 %','10 тысяч узлов — все помещаются в кэш','хеш ×3,3',False),
      ('Нужен отсортированный результат','половина разных · хешу приходится ещё сортировать','sort ×1,6',True),
      ('Нужен порядок первого появления','половина разных · сортировке — ещё раз сортировать','хеш ×3,4',False)]
body=[f'<p style="position:absolute; top:72px; left:117px; width:1400px; {PX}font-size:28px; font-weight:500; line-height:1.3; letter-spacing:1px; text-transform:uppercase; color:{B}">Миллион id · M2 Pro · хеш = unordered_set</p>',
      f'<h2 style="position:absolute; top:115px; left:117px; width:1400px; {PX}font-size:60px; font-weight:700; line-height:1.1; letter-spacing:-2px; color:#000000">ОДНА МАШИНА — РАЗНЫЕ ЗАДАЧИ</h2>',
      LOGO_INV]
for i,(t,s,res,srt) in enumerate(rows):
    y=290+i*165
    body+= [f'<div style="position:absolute; top:{y}px; left:117px; width:1686px; height:145px; background:{L2}; border-radius:32px"></div>',
            f'<p style="position:absolute; top:{y+24}px; left:157px; width:1150px; {PX}font-size:40px; font-weight:700; line-height:1.25; color:#000000">{t}</p>',
            f'<p style="position:absolute; top:{y+82}px; left:157px; width:1150px; {PX}font-size:28px; font-weight:400; line-height:1.3; color:#4b5070">{s}</p>',
            f'<p style="position:absolute; top:{y+30}px; left:1373px; width:400px; {PX}font-size:44px; font-weight:700; line-height:1.95; text-align:center; color:#ffffff; background:{B if srt else "#000000"}; border-radius:20px">{res}</p>']
body.append(pn(28,'#8a8fa8',PX))
save('C1-share',body,'#FFFFFF')
save('C1-meme',[
  LOGO_INV,
  f'<div style="position:absolute; top:250px; left:117px; width:1686px; height:740px; background:{L3}; border-radius:40px"></div>',
  f'<p style="position:absolute; top:100px; left:117px; width:1400px; {PX}font-size:60px; font-weight:700; line-height:1.1; letter-spacing:-2px; color:#000000">В РЕЗЮМЕ У ОБОИХ O(n)</p>',
  f'<p style="position:absolute; top:290px; left:400px; width:600px; {PX}font-size:40px; font-weight:700; line-height:1.2; text-align:center; color:{B}">unordered_set</p>',
  f'<p style="position:absolute; top:290px; left:950px; width:600px; {PX}font-size:40px; font-weight:700; line-height:1.2; text-align:center; color:#000000">flat_hash_set</p>',
  f'<img src="/_blob/5ac1923aedf620917ca0d4eb1b53d6cf" alt="Два одинаковых разработчика указывают друг на друга" style="position:absolute; top:350px; left:330px; width:1260px; height:620px; object-fit:contain; border-radius:32px">',
  g(895,1500,60,B),
  pn(26,'#8a8fa8',PX)],'#FFFFFF')

# ---- Concept 2: hybrid on dark HardFest ----
ab=read('about')
plates=[('iOS-РАЗРАБОТЧИК',820),('ИСХОДНЫЙ КОД',880)]
add=''.join(f'\n  <p style="position:absolute; top:{y}px; left:150px; width:{40+24*len(t)}px; padding:4px 20px; {PX}font-size:40px; font-weight:700; line-height:1.25; color:#ffffff; background:{B}">{t}</p>' for t,y in plates)
add+='\n  '+g(330,650,80)
ab=sub(ab,'<p style="position:absolute; top:645px; left:895px; width:908px; '+MS+'font-size:48px; font-weight:400; line-height:1.33; color:#ffffff">iOS · «Исходный код»</p>',
       f'<p style="position:absolute; top:645px; left:895px; width:908px; {MS}font-size:44px; font-weight:400; line-height:1.33; color:#ffffff">codesrc.ru</p>'+add)
open(OUT+'C2-about.html','w').write(re.sub(r'<section id="[^"]*"','<section id="C2-about"',ab,count=1)); print('wrote C2-about')
save('C2-meme',[
  f'<h2 style="position:absolute; top:103px; left:117px; width:1424px; {MS}font-size:58.7px; font-weight:800; line-height:1.12; color:#ffffff">В РЕЗЮМЕ У ОБОИХ O(n)</h2>',
  LOGO,
  f'<div style="position:absolute; top:250px; left:117px; width:1686px; height:740px; background:{L3}; border-radius:40px"></div>',
  f'<p style="position:absolute; top:290px; left:400px; width:600px; {PX}font-size:40px; font-weight:700; line-height:1.2; text-align:center; color:{B}">unordered_set</p>',
  f'<p style="position:absolute; top:290px; left:950px; width:600px; {PX}font-size:40px; font-weight:700; line-height:1.2; text-align:center; color:#000000">flat_hash_set</p>',
  f'<img src="/_blob/5ac1923aedf620917ca0d4eb1b53d6cf" alt="Два одинаковых разработчика указывают друг на друга" style="position:absolute; top:350px; left:330px; width:1260px; height:620px; object-fit:contain">',
  g(895,1500,60,B),
  pn(26)],'#000000')

# ---- Task 2 (current dark style): icon row with the real site ----
a=open(os.path.join(os.path.dirname(os.path.abspath(__file__)),'slides','about-co-a.html')).read()
a=a.replace('[сайт компании]','codesrc.ru').replace('<section id="about-co-a"','<section id="T2-about-row"')
open(OUT+'T2-about-row.html','w').write(a); print('wrote T2-about-row')
