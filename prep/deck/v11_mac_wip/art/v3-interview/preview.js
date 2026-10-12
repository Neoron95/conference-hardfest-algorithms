// usage: node preview.js A.png B.png logo.png out.png
const { chromium } = require('/opt/node22/lib/node_modules/playwright');
const path = require('path'); const fs = require('fs');
(async () => {
  const [a, b, logo, out] = process.argv.slice(2).map(p => path.resolve(p));
  const css = fs.readFileSync(path.resolve(__dirname, '../../../fonts/local.css'), 'utf8');
  const html = `<!doctype html><html><head><meta charset="utf-8"><style>${css}
  body{margin:0;background:#000} p,h2{margin:0}
  section{position:relative;width:1920px;height:1080px;overflow:hidden;background:#000;color:#fff;font-family:'Montserrat',Arial,sans-serif}
  </style></head><body><section>
  <h2 id="title" style="position:absolute;left:117px;top:115px;width:1424px;font-size:58.67px;font-weight:800;line-height:66px;color:#FFFFFF">ЗАУЧИЛ ОТВЕТЫ К СОБЕСЕДОВАНИЮ</h2>
  <img src="file://${logo}" style="position:absolute;left:1586px;top:144px;width:230px;height:79px">
  <p id="capA" style="position:absolute;left:117px;top:262px;width:820px;text-align:center;font-family:'JetBrains Mono';font-size:42px;line-height:48px;color:#46CDAE">в бенчмарке</p>
  <img src="file://${a}" style="position:absolute;left:117px;top:310px;width:820px;height:560px;object-fit:contain">
  <p id="capB" style="position:absolute;left:983px;top:262px;width:820px;text-align:center;font-family:'JetBrains Mono';font-size:42px;line-height:48px;color:#E2489B">у пользователя</p>
  <img src="file://${b}" style="position:absolute;left:983px;top:310px;width:820px;height:560px;object-fit:contain">
  <p id="bottom" style="position:absolute;left:117px;top:890px;width:1686px;font-size:34px;font-weight:700;line-height:44px;color:#F2C14E">Тот же вход в каждом прогоне — процессор отвечает по памяти. В 2,2 раза лучше правды</p>
  </section></body></html>`;
  const tmp = path.resolve(__dirname, '_preview.html'); fs.writeFileSync(tmp, html);
  const br = await chromium.launch({ args: ['--allow-file-access-from-files'] });
  const p = await br.newPage({ viewport: { width: 1920, height: 1080 } });
  await p.goto('file://' + tmp);
  await p.evaluate(async () => {
    await document.fonts.load('800 58px Montserrat', 'ЗАУЧИЛ ОТВЕТЫ'); await document.fonts.load('700 35px Montserrat', 'Тот же вход');
    await document.fonts.load('400 42px "JetBrains Mono"', 'в бенчмарке у пользователя'); await document.fonts.ready;
  });
  const info = await p.evaluate(() => {
    const r = {};
    for (const id of ['title', 'capA', 'capB', 'bottom']) { const e = document.getElementById(id); const b = e.getBoundingClientRect(); r[id] = { lines: Math.round(b.height / parseFloat(getComputedStyle(e).lineHeight)), right: Math.round(b.left + e.scrollWidth), bottom: Math.round(b.bottom) }; }
    r.fonts = [document.fonts.check('800 58px Montserrat', 'ЗАУЧИЛ'), document.fonts.check('700 35px Montserrat', 'Тот'), document.fonts.check('400 42px "JetBrains Mono"', 'в бенчмарке')];
    // natural one-line width of the bottom line
    const e = document.getElementById('bottom'); const s = e.style.whiteSpace; e.style.whiteSpace = 'nowrap'; e.style.width = 'auto'; r.bottomOneLine = Math.round(e.getBoundingClientRect().width); e.style.whiteSpace = s; e.style.width = '1686px';
    return r;
  });
  console.log(JSON.stringify(info));
  await p.screenshot({ path: out });
  await br.close();
})();
