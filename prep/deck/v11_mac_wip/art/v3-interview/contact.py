# usage: python3 contact.py A|B  -> ../contact-A.png ; frames decoded from the final MP4
import subprocess, sys, os
from PIL import Image, ImageDraw, ImageFont
import imageio_ffmpeg
FF = imageio_ffmpeg.get_ffmpeg_exe()
S = sys.argv[1]
FONT = '/tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/fonts/f4.ttf'
if S == 'A':
    title = 'v3-interview-A · «в бенчмарке» · петля 6 с'
    shots = [(0.0, 'карточка «Задача 1» поднята'), (1.7, 'мгновенно пишет строки'), (2.6, 'галочка, поправляет очки, искорки'),
             (3.2, 'стикер: переговорка А → Б'), (3.43, 'доска переезжает вправо'), (4.43, 'снова те же строки и галочка'),
             (4.8, 'губка стирает доску'), (5.5, 'возврат: А, карточка в стопку')]
else:
    title = 'v3-interview-B · «у пользователя» · петля 5 с'
    shots = [(0.0, 'карточка «Задача 12»'), (1.0, 'пустая доска, пот, «?»'), (2.0, 'облачко «…», глаза бегают'),
             (3.0, 'капля стекает, маркер дрожит'), (3.8, 'медленно пишет строку'), (4.4, 'маленькая розовая галочка'),
             (4.6, 'стирает, достаёт карточку'), (4.93, 'возврат к началу')]
mp4 = f'../v3-interview-{S}.mp4'
os.makedirs('cs', exist_ok=True)
W, H = 656, 448
cols = 4; rows = (len(shots) + cols - 1) // cols
pad, lab, head = 16, 46, 70
sheet = Image.new('RGB', (cols * W + (cols + 1) * pad, head + rows * (H + lab + pad) + pad), (20, 20, 20))
d = ImageDraw.Draw(sheet)
d.text((pad, 18), title, fill=(240, 240, 240), font=ImageFont.truetype(FONT, 34))
f = ImageFont.truetype(FONT, 22)
for i, (t, cap) in enumerate(shots):
    n = round(t * 30)
    out = f'cs/{S}_{n:03d}.png'
    subprocess.run([FF, '-y', '-loglevel', 'error', '-i', mp4, '-vf', f"select='eq(n\\,{n})'", '-vsync', '0', '-frames:v', '1', out], check=True)
    im = Image.open(out).convert('RGB').resize((W, H), Image.LANCZOS)
    x = pad + (i % cols) * (W + pad); y = head + (i // cols) * (H + lab + pad)
    d.text((x, y + 4), f't = {t:.2f} с  (кадр {n})', fill=(242, 193, 78), font=f)
    d.text((x, y + 26 - 2), cap, fill=(220, 220, 220), font=ImageFont.truetype(FONT, 18))
    sheet.paste(im, (x, y + lab))
sheet.save(f'../contact-{S}.png', optimize=True)
print(S, sheet.size)
