// Renders every build step of a slide (what is visible after click 0, 1, 2 …) into one contact sheet,
// and prints which elements appear on each click. usage: node steps.js [outdir] [ids...]
let chromium;
try { ({ chromium } = require('playwright')); }
catch (e) { ({ chromium } = require(require('child_process').execSync('npm root -g').toString().trim() + '/playwright')); }
const fs = require('fs'), path = require('path');
const DECKDIR = path.join(__dirname, '..');
const deck = JSON.parse(fs.readFileSync(path.join(DECKDIR, 'deck.json'), 'utf8'));
const CSS = fs.readFileSync(path.join(DECKDIR, 'hf.css'), 'utf8');
const argv = process.argv.slice(2);
const OUT = argv[0] || '/tmp/hardfest-steps';
const ids = argv.slice(1).length ? argv.slice(1) : deck.order.slice(0, 26);
fs.mkdirSync(OUT, { recursive: true });

(async () => {
  const browser = await chromium.launch();
  const page = await browser.newPage({ viewport: { width: 1920, height: 1080 } });
  const report = {};
  for (const id of ids) {
    const html = fs.readFileSync(path.join(DECKDIR, 'slides', id + '.html'), 'utf8').replace(/<section([^>]*)\shidden(\s|>)/, '<section$1$2');
    const doc = `<!doctype html><html><head><meta charset="utf-8"><style>${CSS}
html,body{margin:0;width:1920px;height:1080px;background:#000;overflow:hidden}aside{display:none}video{background:#1E1E1E}</style></head><body>${html}</body></html>`;
    const tmp = path.join(DECKDIR, 'slides', `.steps-${id}.html`);
    fs.writeFileSync(tmp, doc);
    await page.goto('file://' + tmp, { waitUntil: 'load' });
    fs.unlinkSync(tmp);
    await page.evaluate(() => document.fonts.ready);
    const steps = await page.evaluate(() => {
      const els = [...document.querySelectorAll('[data-build-in]')];
      const by = {};
      for (const el of els) {
        const n = +el.getAttribute('data-build-in').split(/\s+/)[1];
        const t = (el.tagName === 'VIDEO' ? '[видео ' + (el.getAttribute('src') || '').split('/').pop() + ']'
                 : el.tagName === 'IMG' ? '[картинка ' + (el.getAttribute('src') || '').split('/').pop() + ']'
                 : el.tagName === 'SVG' || el.tagName === 'svg' ? '[график]'
                 : el.textContent.trim().replace(/\s+/g, ' ')) || '[фигура]';
        (by[n] = by[n] || []).push(t.slice(0, 70));
      }
      return by;
    });
    const max = Math.max(0, ...Object.keys(steps).map(Number));
    const shots = [];
    for (let k = 0; k <= max; k++) {
      await page.evaluate((k) => {
        for (const el of document.querySelectorAll('[data-build-in]')) {
          const n = +el.getAttribute('data-build-in').split(/\s+/)[1];
          el.style.visibility = n <= k ? 'visible' : 'hidden';
        }
      }, k);
      const f = path.join(OUT, `${id}-${k}.png`);
      await page.screenshot({ path: f });
      shots.push(f);
    }
    report[id] = steps;
    // contact sheet via a second page
    const sheet = await browser.newPage({ viewport: { width: 1940, height: 10 + Math.ceil(shots.length / 2) * 560 } });
    const imgs = shots.map((f, i) => `<div style="position:absolute;left:${10 + (i % 2) * 970}px;top:${10 + Math.floor(i / 2) * 560}px"><div style="font:bold 20px sans-serif;color:#fff">${id} · после щелчка ${i}</div><img src="data:image/png;base64,${fs.readFileSync(f).toString('base64')}" style="width:950px;border:1px solid #555"></div>`).join('');
    await sheet.setContent(`<body style="margin:0;background:#333">${imgs}</body>`);
    await sheet.screenshot({ path: path.join(OUT, `${id}.png`), fullPage: true });
    await sheet.close();
    shots.forEach(f => fs.unlinkSync(f));
  }
  fs.writeFileSync(path.join(OUT, 'steps.json'), JSON.stringify(report, null, 1));
  for (const id of ids) {
    console.log(`## ${id}`);
    for (const k of Object.keys(report[id]).sort((a, b) => a - b)) console.log(`  ${k}: ${report[id][k].join(' | ')}`);
  }
  await browser.close();
})();
