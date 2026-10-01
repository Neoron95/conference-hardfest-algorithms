// Renders the deck illustrations (HTML/SVG sources in this folder) to PNG in ../../ (hardfest/assets/).
// Usage: node render.js [name ...]   (no args = all)
const path = require('path');
const { execSync } = require('child_process');
const pw = require(execSync('npm root -g').toString().trim() + '/playwright');

const IMAGES = [
  { name: 'case_sync',   w: 1720, h: 1120, transparent: false },
  { name: 'phone_frame', w: 840,  h: 1640, transparent: true  },
  { name: 'backup_art',  w: 1520, h: 2160, transparent: false },
];

(async () => {
  const only = process.argv.slice(2);
  const browser = await pw.chromium.launch();
  for (const img of IMAGES) {
    if (only.length && !only.includes(img.name)) continue;
    const page = await browser.newPage({ viewport: { width: img.w, height: img.h }, deviceScaleFactor: 1 });
    await page.goto('file://' + path.join(__dirname, img.name + '.html'));
    await page.evaluate(async () => {
      await document.fonts.ready;
      await Promise.all(['600 60px Montserrat', '700 60px Montserrat', '600 60px "JetBrains Mono"', '700 60px "JetBrains Mono"']
        .map(f => document.fonts.load(f)));
    });
    await page.waitForFunction(() => window.__ready !== false);
    const out = path.join(__dirname, '..', '..', img.name + '.png');
    await page.screenshot({ path: out, clip: { x: 0, y: 0, width: img.w, height: img.h }, omitBackground: img.transparent });
    console.log('wrote', out);
    await page.close();
  }
  await browser.close();
})();
