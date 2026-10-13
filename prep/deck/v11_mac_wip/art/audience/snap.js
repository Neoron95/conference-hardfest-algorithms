// usage: node snap.js [outdir] [names...]  -> <outdir>/<name>.png (800x800, transparent) + <outdir>/_check.png (all on black)
const { chromium } = require('/opt/node22/lib/node_modules/playwright');
const path = require('path');
(async () => {
  const [outdirArg, ...namesArg] = process.argv.slice(2);
  const outdir = path.resolve(outdirArg || __dirname);
  const names = namesArg.length ? namesArg : ['dev', 'reviewer', 'perf'];
  const b = await chromium.launch({ args: ['--allow-file-access-from-files'] });
  const p = await b.newPage({ viewport: { width: 800, height: 800 } });
  p.on('console', m => console.log('console:', m.text()));
  p.on('pageerror', e => console.log('pageerror:', e.message));
  await p.goto('file://' + path.resolve(__dirname, 'scene.html'));
  await p.evaluate(async () => {
    await document.fonts.load('800 60px Montserrat', 'CI?');
    await document.fonts.load('700 60px "JetBrains Mono"', 'sort hash diff');
    await document.fonts.ready;
  });
  const fc = await p.evaluate(() => [document.fonts.check('800 60px Montserrat', 'CI'), document.fonts.check('700 60px "JetBrains Mono"', 'sort')]);
  console.log('fonts', fc);
  for (const n of names) {
    await p.evaluate(n => window.renderChar(n), n);
    await p.screenshot({ path: path.join(outdir, n + '.png'), omitBackground: true });
    console.log('wrote', n);
  }
  await b.close();
})();
