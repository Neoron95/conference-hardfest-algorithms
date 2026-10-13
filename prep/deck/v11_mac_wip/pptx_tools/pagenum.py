"""Номер страницы (правый нижний угол) на видимых слайдах по порядку deck.json.
Обложка (первый видимый) считается, но номера на ней нет."""
import re,json,sys
P=sys.argv[1]  # .../project
TAG='<p style="position:absolute; top:1004px; left:1683px; width:120px; font-family:Montserrat, Arial, sans-serif; font-size:24px; font-weight:600; line-height:1.25; text-align:right; color:#8f8f8f">{n}</p>'
RX=re.compile(r'\s*<p(?: id="[^"]*")? style="position:absolute; top:1004px; left:1683px; width:120px;[^"]*">\d+</p>')
order=json.load(open(f'{P}/deck.json'))['order']
n=0; changed=[]
for sid in order:
    p=f'{P}/slides/{sid}.html'; s=open(p).read(); s0=s
    s=RX.sub('',s)
    if not re.search(r'<section[^>]*\shidden[\s>]',s):
        n+=1
        if n>1:
            i=s.rfind('<aside>')
            if i<0: i=s.rfind('</section>')
            j=s.rfind('\n',0,i)
            if s[j+1:i].strip()=='': s=s[:j]+'\n  '+TAG.format(n=n)+s[j:]
            else: s=s[:i]+TAG.format(n=n)+s[i:]
    if s!=s0: open(p,'w').write(s); changed.append(sid)
print(n,'visible;',len(changed),'files changed:',' '.join(changed))
