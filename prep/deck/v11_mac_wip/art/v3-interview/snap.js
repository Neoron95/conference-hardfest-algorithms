// usage: node snap.js A out_prefix tp1 tp2 ...   -> out_prefix_<tp>.png ; prints font check + timing
const { chromium } = require('/opt/node22/lib/node_modules/playwright');
const path = require('path');
(async () => {
  const [scene, prefix, ...tps] = process.argv.slice(2);
  const b = await chromium.launch({ args: ['--allow-file-access-from-files'] });
  const p = await b.newPage({ viewport: { width: 1640, height: 1120 } });
  p.on('console', m => console.log('console:', m.text()));
  p.on('pageerror', e => console.log('pageerror:', e.message));
  await p.goto('file://' + path.resolve(__dirname, 'scene.html'));
  await p.evaluate(async () => {
    await document.fonts.load('800 60px Montserrat', 'Задача переговорка АБ CPU 0123456789?');
    await document.fonts.ready;
  });
  const fc = await p.evaluate(() => [document.fonts.check('800 60px Montserrat', 'Задача'), [...document.fonts].filter(f => f.status === 'loaded').map(f => f.family + ' ' + f.weight + ' ' + f.unicodeRange.slice(0, 12)).join(' | ')]);
  console.log('font', fc[0], fc[1]);
  for (const t of tps) {
    const t0 = Date.now();
    await p.evaluate(([s, t]) => window.renderScene(s, t), [scene, parseFloat(t)]);
    await p.screenshot({ path: `${prefix}_${t}.png` });
    console.log('t', t, Date.now() - t0, 'ms');
  }
  await b.close();
})();
