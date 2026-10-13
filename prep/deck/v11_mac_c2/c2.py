"""C2 «гибрид»: тёмная колода HardFest + фирменные акценты «Исходного кода».
usage: python3 c2.py <project_dir>   (меняет файлы на месте)"""
import re,json,sys,os
P=sys.argv[1]
B='#001EF0'; L3='#E3E7FF'
PX="font-family:'IBM Plex Mono', 'Courier New', monospace; "
MS='font-family:Montserrat, Arial, sans-serif; '
def glyph(c):
    return (f'<rect x="41" y="47" width="78" height="20" rx="10" fill="{c}"></rect><circle cx="167" cy="57" r="17" fill="{c}"></circle>'
            f'<polyline points="60,116 112,167 164,116" fill="none" stroke="{c}" stroke-width="22" stroke-linecap="round" stroke-linejoin="round"></polyline>')
def g(top,left,w,c,label='знак компании «Исходный код»',extra=''):
    return f'<svg xmlns="http://www.w3.org/2000/svg" viewBox="30 30 170 160" aria-label="{label}" {extra}style="position:absolute; top:{top}px; left:{left}px; width:{w}px; height:{round(w*160/170)}px">{glyph(c)}</svg>'
def plate(text,top,left,fs=36):
    w=round(fs*0.6*len(text)+44)
    return f'<p style="position:absolute; top:{top}px; left:{left}px; width:{w}px; padding:4px 20px; {PX}font-size:{fs}px; font-weight:700; line-height:1.25; color:#ffffff; background:{B}">{text}</p>'
def sub(s,a,b,n=1):
    assert s.count(a)==n,(a[:90],s.count(a)); return s.replace(a,b)
order=json.load(open(f'{P}/deck.json'))['order']
def path(sid): return f'{P}/slides/{sid}.html'
changed=set()
for sid in order:
    s=open(path(sid)).read(); s0=s
    # 1. моноширинный шрифт бренда
    s=s.replace("'JetBrains Mono'","'IBM Plex Mono'")
    # 2. верхняя подпись (кикер) — IBM Plex Mono
    def kick(m):
        st=m.group(1)
        st=re.sub(r"font-family:[^;]*;\s*",'',st)
        st=st.replace('letter-spacing:2.5px','letter-spacing:1px').replace('font-weight:600','font-weight:700')
        return f'<p style="{PX}{st}"'
    s=re.sub(r'<p\s+style="((?=[^"]*top:72px)(?=[^"]*font-size:29\.3px)[^"]*)"',kick,s)
    # 3. знак у номера страницы
    hidden=re.search(r'<section[^>]*\shidden[\s>]',s)
    m=re.search(r'\n(\s*)<p(?: id="[^"]*")? style="position:absolute; top:1004px; left:1683px;',s)
    if m and not hidden and 'aria-label="знак компании «Исходный код»" data-mark' not in s:
        s=s[:m.start()]+'\n'+m.group(1)+g(1006,1722,30,'#8f8f8f',extra='data-mark="1" ')+s[m.start():]
    if s!=s0: changed.add(sid)
    open(path(sid),'w').write(s)

def edit(sid,fn):
    s=open(path(sid)).read(); s=fn(s); open(path(sid),'w').write(s); changed.add(sid)

# обложка: вторая строка подписи — синяя плашка
def cover(s):
    return sub(s,'<span style="color:#46cdae"><b>Никита Нагорнов</b></span><br>iOS, компания «Исходный код»</p>',
               '<span style="color:#46cdae"><b>Никита Нагорнов</b></span></p>\n  '+plate('iOS · ИСХОДНЫЙ КОД',894,117,32))
edit('cover',cover)
# слайд 2: плашки на фото, знак, сайт
def about(s):
    a=f'<p style="position:absolute; top:645px; left:895px; width:908px; {MS}font-size:48px; font-weight:400; line-height:1.33; color:#ffffff">iOS · «Исходный код»</p>'
    b=(f'<p style="position:absolute; top:645px; left:895px; width:908px; {MS}font-size:44px; font-weight:400; line-height:1.33; color:#ffffff">codesrc.ru</p>\n  '
       +plate('iOS-РАЗРАБОТЧИК',820,150,40)+'\n  '+plate('ИСХОДНЫЙ КОД',880,150,40)+'\n  '+g(330,650,80,'#FFFFFF'))
    return sub(s,a,b)
edit('about',about)
# мемы: светло-голубая карточка, подпись синим IBM Plex Mono, знак в углу
def card(top=250,h=740):
    return f'<div style="position:absolute; top:{top}px; left:117px; width:1686px; height:{h}px; background:{L3}; border-radius:40px"></div>'
def meme(sid,caption_old,caption_new,img_top=None):
    def f(s):
        # карточка — сразу после заголовка, чтобы лежать под картинкой
        s=re.sub(r'(</h2>\n)',r'\1  '+card().replace('\\','\\\\')+'\n',s,count=1)
        if caption_old:
            s=sub(s,caption_old,caption_new)
        s=s.replace('\n  <p style="position:absolute; top:1004px;','\n  '+g(912,1712,60,B,label='знак компании в углу карточки')+'\n  <p style="position:absolute; top:1004px;',1)
        return s
    edit(sid,f)
CAP=lambda t: f'<p style="position:absolute; top:900px; left:117px; width:1686px; {PX}font-size:44px; font-weight:700; line-height:1.2; text-align:center; text-transform:uppercase; color:{B}">{t}</p>'
meme('meme-quest',
  f'<p style="position:absolute; top:904px; left:117px; width:1686px; {MS}font-size:46px; font-weight:700; line-height:1.15; text-align:center; color:#ffffff">Записался на <span style="color:#46cdae">квест</span></p>',
  CAP('Записался на <span style="color:#000000">квест</span>'))
meme('meme-address',
  f'<p style="position:absolute; top:904px; left:117px; width:1686px; {MS}font-size:46px; font-weight:700; line-height:1.15; text-align:center; color:#ffffff">Адрес точный. <span style="color:#46cdae">Но неполный</span></p>',
  CAP('Адрес точный. <span style="color:#000000">Но неполный</span>'))
def receipt_fix(s):
    s=sub(s,'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 40 150" aria-label="акцентная скобка" style="position:absolute; top:900px; left:117px; width:40px; height:130px"><polyline points="6,0 6,48 34,75 6,102 6,150" fill="none" stroke="#46CDAE" stroke-width="8" stroke-linejoin="round"></polyline></svg>\n  ','')
    return s
edit('meme-receipt',receipt_fix)
meme('meme-receipt',
  f'<p style="position:absolute; top:930px; left:190px; width:1500px; {MS}font-size:56px; font-weight:700; line-height:1.21; color:#ffffff">Считаем всё!</p>',
  CAP('Считаем всё!'))
def spiders(s):
    s=re.sub(r'(</h2>\n)',r'\1  '+card()+'\n',s,count=1)
    s=s.replace('text-align:center; color:#ffffff">flat_hash_set','text-align:center; color:#000000">flat_hash_set')
    s=s.replace('\n  <p style="position:absolute; top:1004px;','\n  '+g(912,1712,60,B,label='знак компании в углу карточки')+'\n  <p style="position:absolute; top:1004px;',1)
    return s
edit('meme-spiders',spiders)
# финальная мысль: синий штамп со знаком
def final(s):
    old=re.search(r'  <p data-build-in="pop 1" style="[^"]*">ПРОВЕРЕНО<br>НА СЕБЕ</p>',s).group(0)
    box='top:650px; left:1150px; width:600px; height:150px'
    new=(f'  <p data-build-in="pop 1" style="position:absolute; {box}; padding:22px 30px 22px 170px; background:{B}; border-radius:28px; {PX}font-size:46px; font-weight:700; line-height:1.15; text-align:left; color:#ffffff; transform:rotate(-8deg)">ПРОВЕРЕНО<br>НА СЕБЕ</p>'
         f'\n  <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 600 150" aria-label="знак-галочка компании на штампе" data-build-in="pop 1" style="position:absolute; {box}; transform:rotate(-8deg)"><g transform="translate(20,10) scale(0.6)">{glyph("#FFFFFF")}</g></svg>')
    return s.replace(old,new)
edit('final-thought',final)
# спасибо: синяя плашка компании
def thanks(s):
    return sub(s,'<span style="color:#46cdae"><b>Никита Нагорнов</b></span><br>iOS, компания «Исходный код»</p>',
               '<span style="color:#46cdae"><b>Никита Нагорнов</b></span></p>\n  '+plate('iOS · ИСХОДНЫЙ КОД · codesrc.ru',894,117,32))
edit('final-thanks',thanks)
# шрифт бренда в deck.json
d=json.load(open(f'{P}/deck.json'))
d['faces']['ibm-plex-mono']={'family':'IBM Plex Mono','href':'https://fonts.googleapis.com/css2?family=IBM+Plex+Mono:wght@400;500;700&display=swap'}
d['title']=d['title'].replace('V11 Mac (главная машина — M2 Pro)','C2 «Исходный код» (тёмный HardFest + фирменные акценты)')
open(f'{P}/deck.json','w').write(json.dumps(d,ensure_ascii=False,indent=2)+'\n')
print(len(changed),'slides changed')
