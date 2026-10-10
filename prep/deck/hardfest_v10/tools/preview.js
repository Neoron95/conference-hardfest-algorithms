// Превью слайдов V10: рендерит slides/<id>.html под hf.css в preview/<NN>-<id>.png (1920x1080, все билды раскрыты).
// Usage: node tools/preview.js [id ...]   (без аргументов — основной маршрут с 13-го слайда)
const fs = require('fs');
const path = require('path');
const { execSync } = require('child_process');
const pw = require(execSync('npm root -g').toString().trim() + '/playwright');

const DECK = path.resolve(__dirname, '..');
const deck = JSON.parse(fs.readFileSync(path.join(DECK, 'deck.json'), 'utf8'));
const css = fs.readFileSync(path.join(DECK, 'hf.css'), 'utf8');
const FONTS = '<link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700;800&display=swap">';

function page(id, order) {
  let body = fs.readFileSync(path.join(DECK, 'slides', id + '.html'), 'utf8');
  body = body.replace(/<aside>[\s\S]*?<\/aside>/, '');
  // видео -> постер, относительные ассеты -> абсолютный путь
  body = body.replace(/<video([^>]*)>\s*<\/video>/g, (m, a) => {
    const poster = (a.match(/poster="([^"]*)"/) || [])[1] || '';
    const style = (a.match(/style="([^"]*)"/) || [])[1] || '';
    return `<img src="${poster}" style="${style}">`;
  });
  // страница пишется в preview/, поэтому ../assets/ из slides/ работает без замены
  const num = `<div style="position:absolute;left:1760px;top:960px;width:90px;text-align:right;font:400 26.7px Montserrat;color:#EFEFEF">${order}</div>`;
  const logo = `<img src="../assets/hardfest_logo.png" style="position:absolute;left:1586px;top:144px;width:230px;height:79px">`;
  return `<!doctype html><html><head><meta charset="utf-8">${FONTS}<style>${css}
html,body{margin:0;width:1920px;height:1080px;background:#000;overflow:hidden}aside{display:none}</style></head>
<body>${body}${logo}${num}</body></html>`;
}

(async () => {
  const only = process.argv.slice(2);
  const ids = only.length ? only : deck.order.slice(12, deck.mainCount);
  fs.mkdirSync(path.join(DECK, 'preview'), { recursive: true });
  const browser = await pw.chromium.launch();
  const pg = await browser.newPage({ viewport: { width: 1920, height: 1080 }, deviceScaleFactor: 1 });
  for (const id of ids) {
    const order = deck.order.indexOf(id) + 1;
    const tmp = path.join(DECK, 'preview', '_page.html');
    fs.writeFileSync(tmp, page(id, order));
    await pg.goto('file://' + tmp, { waitUntil: 'load' });
    try { await pg.evaluate(() => document.fonts.ready); } catch (e) {}
    await pg.waitForTimeout(150);
    const issues = await pg.evaluate(() => {
      const out = [];
      const t = document.querySelector('.t');
      if (t && t.getBoundingClientRect().height > 75) out.push('title wraps to ' + Math.round(t.getBoundingClientRect().height / 66) + ' lines');
      for (const el of document.querySelectorAll('section *')) {
        const r = el.getBoundingClientRect();
        if (!r.width || !r.height) continue;
        if (el.tagName === 'P' && !el.classList.contains('t') && !el.classList.contains('k')) {
          const lh = parseFloat(getComputedStyle(el).lineHeight);
          const lines = Math.round(r.height / lh), brs = el.querySelectorAll('br').length;
          if (lines > brs + 1) {
            const ws = el.style.whiteSpace; el.style.whiteSpace = 'nowrap';
            const need = el.scrollWidth; el.style.whiteSpace = ws;
            out.push('wraps to ' + lines + ' lines (' + (brs + 1) + ' expected), needs ' + need + 'px of ' + Math.round(r.width) + ': ' + (el.textContent || '').trim().slice(0, 40));
          }
        }
        if (r.right > 1750 && r.bottom > 934 && el.tagName !== 'IMG' && !(el.closest('.meme-caption'))) out.push('touches slide-number zone: ' + (el.textContent || '').trim().slice(0, 40));
        if (r.bottom > 1082 || r.right > 1922) out.push((el.tagName.toLowerCase()) + ' overflows canvas: ' + (el.textContent || '').trim().slice(0, 40));
        if (el.classList.contains('abs') && el.tagName === 'P' && r.bottom > 962 && !el.classList.contains('lbl')) out.push('p below content area: ' + (el.textContent || '').trim().slice(0, 40));
      }
      return out;
    });
    for (const i of issues) console.log('  !', id, i);
    const out = path.join(DECK, 'preview', String(order).padStart(2, '0') + '-' + id + '.png');
    await pg.screenshot({ path: out });
    console.log('wrote', path.relative(DECK, out));
  }
  await browser.close();
})();
