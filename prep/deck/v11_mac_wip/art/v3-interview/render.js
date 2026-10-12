// usage: node render.js A outdir  -> outdir/pose_000.png ... (12 poses per second over the loop)
const { chromium } = require('/opt/node22/lib/node_modules/playwright');
const path = require('path'); const fs = require('fs');
(async () => {
  const [scene, outdir] = process.argv.slice(2);
  const T = scene === 'A' ? 6 : 5, N = T * 12;
  fs.mkdirSync(outdir, { recursive: true });
  const b = await chromium.launch({ args: ['--allow-file-access-from-files'] });
  const work = async (lane, lanes) => {
    const p = await b.newPage({ viewport: { width: 1640, height: 1120 } });
    p.on('pageerror', e => console.log('pageerror:', e.message));
    await p.goto('file://' + path.resolve(__dirname, 'scene.html'));
    await p.evaluate(async () => { await document.fonts.load('800 60px Montserrat', 'Задача переговорка АБ CPU 0123456789?'); await document.fonts.ready; });
    const ok = await p.evaluate(() => document.fonts.check('800 60px Montserrat', 'Задача переговорка АБ'));
    if (!ok) throw new Error('font not loaded');
    for (let i = lane; i < N; i += lanes) {
      await p.evaluate(([s, t]) => window.renderScene(s, t), [scene, i / 12]);
      await p.screenshot({ path: path.join(outdir, `pose_${String(i).padStart(3, '0')}.png`) });
    }
  };
  const t0 = Date.now();
  await Promise.all([0, 1, 2].map(l => work(l, 3)));
  console.log(scene, N, 'poses', ((Date.now() - t0) / 1000).toFixed(1), 's');
  await b.close();
})();
