// usage: node render_slide.js variant_X.html out.png [step|final]
// Wraps a deck <section> into a 1920x1080 page (local fonts, /_blob/ logo -> local file), simulates builds
// (data-build-in/out "fade N") at the given click, screenshots, and checks text bounds/overlaps.
const { chromium } = require('/opt/node22/lib/node_modules/playwright');
const path = require('path'); const fs = require('fs');
const BBOX = { 'dev.png': [80, 41, 720, 794], 'reviewer.png': [195, 108, 604, 794], 'perf.png': [140, 131, 660, 794] }; // opaque content in 800x800
(async () => {
  const [src, out, stepArg] = process.argv.slice(2);
  let sec = fs.readFileSync(path.resolve(src), 'utf8').replace(/\/_blob\/95693bade921b745f9f9b0e5005269e3/g, 'logo_hardfest.png');
  const html = `<!doctype html><html><head><meta charset="utf-8"><link rel="stylesheet" href="fonts/local.css"><style>
body{margin:0;background:#000} section{position:relative;width:1920px;height:1080px;overflow:hidden} p,h2{margin:0} aside{display:none}
</style></head><body>${sec}</body></html>`;
  const tmp = path.resolve(__dirname, '_page_' + path.basename(src)); fs.writeFileSync(tmp, html);
  const b = await chromium.launch({ args: ['--allow-file-access-from-files'] });
  const p = await b.newPage({ viewport: { width: 1920, height: 1080 } });
  p.on('pageerror', e => console.log('pageerror:', e.message));
  await p.goto('file://' + tmp);
  await p.evaluate(async () => { await document.fonts.load('800 58px Montserrat', 'КОМУ'); await document.fonts.load('600 48px Montserrat', 'Разработчикам'); await document.fonts.load('400 36px Montserrat', 'Выбираете'); await document.fonts.ready; await Promise.all([...document.images].map(i => i.decode().catch(() => {}))); });
  const res = await p.evaluate(([stepArg, BBOX]) => {
    const num = (el, a) => { const v = el.getAttribute(a); const m = v && v.match(/(\d+)/); return m ? +m[1] : null; };
    const all = [...document.querySelectorAll('section *')];
    const maxStep = Math.max(0, ...all.flatMap(e => [num(e, 'data-build-in'), num(e, 'data-build-out')]).filter(x => x != null));
    const step = (stepArg == null || stepArg === 'final') ? maxStep : +stepArg;
    for (const e of all) {
      const i = num(e, 'data-build-in'), o = num(e, 'data-build-out');
      const vis = (i == null || i <= step) && (o == null || o > step);
      if (!vis) e.style.visibility = 'hidden';
    }
    const fonts = [document.fonts.check('800 58px Montserrat', 'КОМУ'), document.fonts.check('600 48px Montserrat', 'Раз')];
    // text extents
    const texts = [...document.querySelectorAll('section p, section h2')].filter(e => e.style.visibility !== 'hidden' && e.textContent.trim());
    const tr = texts.map(e => { const r = document.createRange(); r.selectNodeContents(e); const b = r.getBoundingClientRect(); return { t: e.textContent.trim().slice(0, 24), l: Math.round(b.left), r: Math.round(b.right), top: Math.round(b.top), bot: Math.round(b.bottom), lines: Math.round(e.getBoundingClientRect().height / parseFloat(getComputedStyle(e).lineHeight)) }; });
    const imgs = [...document.querySelectorAll('section img')].filter(e => e.style.visibility !== 'hidden').map(e => {
      const r = e.getBoundingClientRect(); const k = r.width / 800; const bb = BBOX[e.getAttribute('src')];
      return bb ? { src: e.getAttribute('src'), l: Math.round(r.left + bb[0] * k), r: Math.round(r.left + bb[2] * k), top: Math.round(r.top + bb[1] * k), bot: Math.round(r.top + bb[3] * k) } : { src: e.getAttribute('src'), l: Math.round(r.left), r: Math.round(r.right), top: Math.round(r.top), bot: Math.round(r.bottom) };
    });
    const issues = [];
    for (const t of tr) {
      if (t.l < 116 || t.r > 1804) issues.push(`out of 117..1803: ${t.t} [${t.l}..${t.r}]`);
      for (const im of imgs) if (t.l < im.r && t.r > im.l && t.top < im.bot && t.bot > im.top) issues.push(`text "${t.t}" overlaps ${im.src} content`);
    }
    for (let a = 0; a < tr.length; a++) for (let c = a + 1; c < tr.length; c++) {
      const x = tr[a], y = tr[c];
      if (x.t === y.t) continue; // stacked dim/bright copies
      if (x.l < y.r && x.r > y.l && x.top < y.bot && x.bot > y.top) issues.push(`text "${x.t}" overlaps "${y.t}"`);
    }
    return { step, maxStep, fonts, tr, imgs, issues };
  }, [stepArg, BBOX]);
  await p.screenshot({ path: out });
  console.log(path.basename(src), 'step', res.step, '/', res.maxStep, 'fonts', res.fonts.join(','));
  for (const t of res.tr) console.log('  text', JSON.stringify(t));
  for (const i of res.imgs) console.log('  img ', JSON.stringify(i));
  console.log('  issues:', res.issues.length ? '\n   - ' + [...new Set(res.issues)].join('\n   - ') : 'none');
  await b.close(); fs.unlinkSync(tmp);
})();
