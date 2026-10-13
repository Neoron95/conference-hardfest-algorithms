# usage: python3 compare.py -> compare.png (A/B/C final states side by side) + variant_C_steps.png (C click by click)
from PIL import Image, ImageDraw, ImageFont
FB = '/home/user/conference-hardfest-algorithms/prep/deck/v11_mac_wip/pptx_tools/fonts/embed/Montserrat-Bold.ttf'
FR = '/home/user/conference-hardfest-algorithms/prep/deck/v11_mac_wip/pptx_tools/fonts/embed/Montserrat-Regular.ttf'
def sheet(items, out, w=960, h=540, cols=3, pad=24, lab=64):
    rows = (len(items) + cols - 1) // cols
    c = Image.new('RGB', (cols * w + (cols + 1) * pad, rows * (h + lab) + (rows + 1) * pad - pad // 2), (34, 34, 36))
    d = ImageDraw.Draw(c); fb = ImageFont.truetype(FB, 30); fr = ImageFont.truetype(FR, 22)
    for i, (path, t, sub) in enumerate(items):
        x = pad + (i % cols) * (w + pad); y = pad + (i // cols) * (h + lab + pad)
        d.text((x, y + 4), t, font=fb, fill=(255, 255, 255))
        d.text((x + d.textlength(t, font=fb) + 16, y + 12), sub, font=fr, fill=(170, 170, 170))
        im = Image.open(path).convert('RGB').resize((w, h), Image.LANCZOS)
        c.paste(im, (x, y + lab - 12)); d.rectangle([x - 1, y + lab - 13, x + w, y + lab - 12 + h], outline=(80, 80, 80))
    c.save(out); print(out, c.size)
sheet([('variant_A.png', 'A. Три карточки в ряд', 'карточка за щелчок (3 щелчка)'),
       ('variant_B.png', 'B. Три строки + арт слева', 'строка за щелчок (3 щелчка)'),
       ('variant_C.png', 'C. Общая сцена', 'подсветка по очереди, затем все (4 щелчка)')], 'compare.png')
sheet([('wip/C_step0.png', 'C · старт', 'все притушены'), ('wip/C_step1.png', 'C · щелчок 1', 'разработчик'),
       ('wip/C_step2.png', 'C · щелчок 2', 'ревьюер'), ('wip/C_step3.png', 'C · щелчок 3', 'автор перф-тестов'),
       ('variant_C.png', 'C · щелчок 4', 'все яркие')], 'variant_C_steps.png', w=640, h=360)
