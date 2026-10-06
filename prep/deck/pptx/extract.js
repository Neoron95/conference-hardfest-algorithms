// Lays out every HTML slide in Chromium and dumps geometry + styles as JSON.
// Pass 1: original fonts (IBM Plex) -> line counts. Pass 2: Montserrat, shrink-to-fit per text leaf.
let chromium;
try { ({ chromium } = require('playwright')); }
catch (e) { ({ chromium } = require(require('child_process').execSync('npm root -g').toString().trim() + '/playwright')); }
const fs = require('fs');
const path = require('path');

// usage: node extract.js [--deck project|hardfest] [slide ids...]
const argv = process.argv.slice(2);
let deckName = 'project';
const di = argv.indexOf('--deck');
if (di >= 0) { deckName = argv[di + 1]; argv.splice(di, 2); }
const DECKDIR = path.join(__dirname, '..', deckName);
const SLIDES = path.join(DECKDIR, 'slides');
const DECK = path.join(DECKDIR, 'deck.json');
const deck = JSON.parse(fs.readFileSync(DECK, 'utf8'));
const NATIVE = !!deck.native;          // native decks are written in Montserrat + final palette: no font swap
const OUT = (process.env.PPTX_WORK || '/tmp/hardfest-pptx') + '/extract' + (deckName === 'project' ? '' : '-' + deckName);
const K = NATIVE ? 1 : parseFloat(process.env.K || '0.92');   // global Montserrat size factor
const CSS = NATIVE && fs.existsSync(path.join(DECKDIR, 'hf.css')) ? fs.readFileSync(path.join(DECKDIR, 'hf.css'), 'utf8') : '';
fs.mkdirSync(OUT, { recursive: true });
fs.mkdirSync(OUT + '/orig', { recursive: true });
fs.mkdirSync(OUT + '/fit', { recursive: true });

const LOGO = NATIVE && fs.existsSync(path.join(DECKDIR, 'assets', 'hardfest_logo.png')) ? 'file://' + path.join(DECKDIR, 'assets', 'hardfest_logo.png') : '';
const frame = (sec) => {   // preview-only overlay: template logo + slide number (the builder adds the real ones)
  if (!LOGO) return '';
  const big = /data-logo="big"/.test(sec);
  const lg = big ? 'left:1436px;top:127px;width:380px;height:131px' : 'left:1586px;top:144px;width:230px;height:79px';
  const num = /data-nonum/.test(sec) ? '' : '<div style="position:absolute;left:1760px;top:960px;width:90px;text-align:right;font:400 26.7px Montserrat;color:#EFEFEF">#</div>';
  return `<img src="${LOGO}" style="position:absolute;${lg}">${num}`;
};
const wrap = (sec) => `<!doctype html><html><head><meta charset="utf-8"><style>${CSS}</style><style>
*{margin:0;padding:0;box-sizing:border-box}
html,body{width:1920px;height:1080px;background:#777}
section{position:relative;width:1920px;height:1080px;overflow:hidden}
aside{display:none}
x-connector{display:block;position:absolute;width:0;height:0}
ul,ol{padding-left:1.2em}
table{border-spacing:0}
</style></head><body>${sec}${frame(sec)}</body></html>`;

function pageScript(arg) {
  const K = arg.K, NATIVE = arg.NATIVE;
  const sec = document.querySelector('section');
  const S = sec.getBoundingClientRect();
  const INLINE = new Set(['span', 'b', 'strong', 'i', 'em', 'code', 'sub', 'sup', 'a', 'u', 's', 'small', 'br', 'mark']);
  const LEAFTAG = new Set(['p', 'h1', 'h2', 'h3', 'h4', 'li', 'td', 'th']);

  const rgb = (c) => {
    if (!c) return null;
    const m = c.match(/rgba?\(([^)]+)\)/);
    if (!m) return null;
    const p = m[1].split(',').map(s => parseFloat(s));
    const a = p.length > 3 ? p[3] : 1;
    if (a === 0) return null;
    const hex = p.slice(0, 3).map(v => Math.round(v).toString(16).padStart(2, '0')).join('').toUpperCase();
    return { hex, a };
  };
  const box = (el) => { const r = el.getBoundingClientRect(); return { x: r.left - S.left, y: r.top - S.top, w: r.width, h: r.height }; };
  const buildOf = (el) => {
    let e = el;
    while (e && e !== sec) {
      const b = e.getAttribute && e.getAttribute('data-build-in');
      if (b) { const m = b.match(/(\w+)\s+(\d+)/); return { effect: m[1], order: +m[2] }; }
      e = e.parentElement;
    }
    return null;
  };
  const isLeaf = (el) => {
    const tag = el.tagName.toLowerCase();
    let hasText = false, hasBlockChild = false;
    for (const n of el.childNodes) {
      if (n.nodeType === 3 && n.textContent.trim()) hasText = true;
      if (n.nodeType === 1) {
        const t = n.tagName.toLowerCase();
        if (!INLINE.has(t)) hasBlockChild = true;
        else if (n.textContent.trim()) hasText = true;
      }
    }
    if (hasBlockChild) return false;
    if (LEAFTAG.has(tag)) return hasText || el.textContent.trim().length > 0;
    return hasText;
  };
  const deco = (el, cs) => {
    const bg = rgb(cs.backgroundColor);
    const sides = ['Top', 'Right', 'Bottom', 'Left'].map(s => ({
      w: parseFloat(cs['border' + s + 'Width']) || 0,
      style: cs['border' + s + 'Style'],
      c: rgb(cs['border' + s + 'Color']),
    }));
    const hasB = sides.some(s => s.w > 0 && s.style !== 'none' && s.c);
    if (!bg && !hasB) return null;
    const r = cs.borderTopLeftRadius;
    return { bg, sides: sides.map(s => (s.w > 0 && s.style !== 'none' && s.c) ? s : null), radius: r };
  };
  const pad = (cs) => ['Top', 'Right', 'Bottom', 'Left'].map(s => parseFloat(cs['padding' + s]) || 0);
  const bw = (cs) => ['Top', 'Right', 'Bottom', 'Left'].map(s => parseFloat(cs['border' + s + 'Width']) || 0);

  // ---- text runs
  function runsOf(el) {
    const runs = [];
    const walk = (node) => {
      for (const n of node.childNodes) {
        if (n.nodeType === 3) {
          const p = n.parentElement; const cs = getComputedStyle(p);
          let t = n.textContent;
          if (!/pre/.test(cs.whiteSpace)) t = t.replace(/[\t\n\r ]+/g, ' ');
          if (!t) continue;
          let va = cs.verticalAlign;
          runs.push({
            t, color: rgb(cs.color), weight: +cs.fontWeight, italic: cs.fontStyle === 'italic',
            family: cs.fontFamily, size: parseFloat(cs.fontSize), upper: cs.textTransform === 'uppercase',
            ls: parseFloat(cs.letterSpacing) || 0, bg: p !== el ? rgb(cs.backgroundColor) : null,
            va: (va === 'sub' || va === 'super') ? va : null,
          });
        } else if (n.nodeType === 1) {
          if (n.tagName.toLowerCase() === 'br') runs.push({ br: true });
          else walk(n);
        }
      }
    };
    walk(el);
    // collapse whitespace across boundaries, trim line ends
    let prevSpace = true;
    for (const r of runs) {
      if (r.br) { prevSpace = true; continue; }
      if (prevSpace) r.t = r.t.replace(/^ +/, '');
      prevSpace = / $/.test(r.t) || (prevSpace && r.t === '');
    }
    for (let i = 0; i < runs.length; i++) {
      const r = runs[i]; if (r.br) continue;
      let j = i + 1; while (j < runs.length && !runs[j].br && runs[j].t === '') j++;
      if (j >= runs.length || runs[j].br) r.t = r.t.replace(/ +$/, '');
    }
    return runs.filter(r => r.br || r.t !== '');
  }
  const lineCount = (el) => {
    const rg = document.createRange(); rg.selectNodeContents(el);
    const tops = [];
    for (const r of rg.getClientRects()) {
      if (r.width < 1) continue;
      const mid = r.top + r.height / 2;
      if (!tops.some(t => Math.abs(t - mid) < 4)) tops.push(mid);
    }
    return tops.length;
  };
  const textWidth = (el) => {
    const rg = document.createRange(); rg.selectNodeContents(el);
    let mx = 0, mn = 1e9;
    for (const r of rg.getClientRects()) { if (r.width < 1) continue; mn = Math.min(mn, r.left); mx = Math.max(mx, r.right); }
    return mx > mn ? mx - mn : 0;
  };

  const leaves = [];
  const collect = (el) => {
    if (el.tagName.toLowerCase() === 'aside' || el.tagName.toLowerCase() === 'svg') return;
    if (isLeaf(el)) { leaves.push(el); return; }
    for (const c of el.children) collect(c);
  };
  for (const c of sec.children) collect(c);

  // pass 1
  const base = leaves.map(el => {
    const cs = getComputedStyle(el);
    const cb = el.getBoundingClientRect();
    const p = pad(cs), b = bw(cs);
    const avail = cb.width - p[1] - p[3] - b[1] - b[3];
    return { lines: lineCount(el), nowrap: cs.whiteSpace === 'nowrap', tw: textWidth(el), avail };
  });

  // font swap
  const all = NATIVE ? [] : sec.querySelectorAll('*');
  const origSize = new Map();
  const plexEls = [sec, ...all].filter(el => /IBM Plex|Arial/.test(getComputedStyle(el).fontFamily) && !/Mono|Courier/.test(getComputedStyle(el).fontFamily));
  for (const el of plexEls) {
    {
      el.style.fontFamily = "'Montserrat'";
      if (el.style.fontSize) { const v = parseFloat(el.style.fontSize); origSize.set(el, v); el.style.fontSize = (v * K) + 'px'; }
      if (el.style.letterSpacing) { const v = parseFloat(el.style.letterSpacing); if (v < 0) el.style.letterSpacing = (v * K) + 'px'; }
    }
  }
  // pass 2: shrink to fit
  const fitLog = [];
  leaves.forEach((el, i) => {
    const cs = getComputedStyle(el);
    if (!/Montserrat/.test(cs.fontFamily)) return;
    if (!origSize.has(el)) return;
    const b0 = base[i];
    const over = () => {
      const c = getComputedStyle(el);
      const cb = el.getBoundingClientRect();
      const p = pad(c), bb = bw(c);
      const avail = cb.width - p[1] - p[3] - bb[1] - bb[3];
      if (b0.nowrap) return textWidth(el) > Math.max(avail, b0.tw) + 0.5;
      return lineCount(el) > b0.lines;
    };
    let f = K;
    const o = origSize.get(el);
    while (over() && f > 0.62) { f -= 0.02; el.style.fontSize = (o * f) + 'px'; }
    if (f < K - 0.001) fitLog.push({ i, text: el.textContent.trim().slice(0, 50), f: +f.toFixed(2), still: over() });
  });

  // ---- title detection
  const h = NATIVE ? sec.querySelector('h2.t') : sec.querySelector('h1, h2');
  const flowPs = [...sec.querySelectorAll('p')].filter(p => getComputedStyle(p).position !== 'absolute' && !p.closest('[style*="position:absolute"]'));
  let kicker = null;
  const isKick = (p) => p && p.tagName.toLowerCase() === 'p' && (parseFloat(getComputedStyle(p).letterSpacing) >= 1.5) && getComputedStyle(p).position !== 'absolute';
  if (NATIVE) kicker = sec.querySelector('p.k');
  else if (h) { const prev = h.previousElementSibling; if (isKick(prev)) kicker = prev; }
  else { kicker = flowPs.find(isKick) || null; }
  // overflow report (native decks are hand-sized: text must fit its box)
  const overflow = [];
  for (const el of leaves) {
    const r = el.getBoundingClientRect();
    const rg = document.createRange(); rg.selectNodeContents(el);
    for (const q of rg.getClientRects()) {
      if (q.width < 1) continue;
      const fsz = parseFloat(getComputedStyle(el).fontSize);
      if (q.right > r.right + 2 || q.bottom > r.bottom + 3 + 0.16 * fsz || q.right > S.right - 4 || q.bottom > S.bottom - 4) {
        overflow.push(el.textContent.trim().slice(0, 60)); break;
      }
    }
  }

  // ---- items
  const items = [];
  const leafSet = new Set(leaves);
  // Preserve the browser's line breaks as editable text, including mixed styles.
  const visualLines = (el) => {
    const lines = [];
    const walk = (node) => {
      if (node.nodeType === 3) {
        const cs = getComputedStyle(node.parentElement);
        for (let i = 0; i < node.textContent.length; i++) {
          const range = document.createRange(); range.setStart(node, i); range.setEnd(node, i + 1);
          const q = range.getBoundingClientRect();
          if (q.width < .1 || q.height < .1) continue;
          let t = node.textContent[i];
          if (!/pre/.test(cs.whiteSpace) && /\s/.test(t)) t = ' ';
          if (cs.textTransform === 'uppercase') t = t.toUpperCase();
          const mid = q.top + q.height / 2;
          let line = lines.find(l => Math.abs(l.mid - mid) < 5);
          if (!line) { line = { mid, x:q.left-S.left, y:q.top-S.top, w:0, h:q.height, runs:[] }; lines.push(line); }
          line.w = Math.max(line.w, q.right - S.left - line.x);
          const style = { color:rgb(cs.color), weight:+cs.fontWeight, italic:cs.fontStyle==='italic', family:cs.fontFamily, size:parseFloat(cs.fontSize), ls:parseFloat(cs.letterSpacing)||0 };
          const last=line.runs.at(-1);
          if (last && JSON.stringify(last.style)===JSON.stringify(style)) last.t+=t;
          else line.runs.push({t,style});
        }
      } else for (const n of node.childNodes) walk(n);
    };
    walk(el);
    return lines.sort((a,b)=>a.mid-b.mid);
  };
  const visit = (el) => {
    const tag = el.tagName.toLowerCase();
    if (tag === 'aside') return;
    const cs = getComputedStyle(el);
    if (cs.display === 'none') return;
    const build = buildOf(el);
    if (tag === 'img') {
      items.push({ type: 'img', ...box(el), build, src: decodeURI(el.src.replace('file://', '')), nw: el.naturalWidth, nh: el.naturalHeight,
        radius: cs.borderTopLeftRadius, fit: cs.objectFit });
      return;
    }
    if (tag === 'video') {
      items.push({ type: 'video', ...box(el), build, src: decodeURI(el.currentSrc.replace('file://', '') || el.getAttribute('src')),
        poster: decodeURI((el.poster || '').replace('file://', '')), loop: el.loop, dur: parseFloat(el.dataset.dur || '6'),
        radius: cs.borderTopLeftRadius });
      return;
    }
    if (tag === 'svg') {
      const elements=[];
      for (const n of el.querySelectorAll('line,rect,circle,ellipse,polygon,polyline,path,text')) {
        if(n.closest('defs')) continue;
        const csn=getComputedStyle(n), ctm=n.getScreenCTM();
        const xy=(x,y)=>({x:ctm.a*x+ctm.c*y+ctm.e-S.left,y:ctm.b*x+ctm.d*y+ctm.f-S.top});
        const attr=k=>parseFloat(n.getAttribute(k)||0);
        const e={kind:n.tagName,fill:rgb(csn.fill),stroke:rgb(csn.stroke),strokeWidth:parseFloat(csn.strokeWidth)*Math.hypot(ctm.a,ctm.b),dash:csn.strokeDasharray,build:buildOf(n)};
        if(n.tagName==='text') { const q=n.getBoundingClientRect();e.x=q.left-S.left;e.y=q.top-S.top;e.w=q.width;e.h=q.height;e.text=n.textContent;e.size=parseFloat(csn.fontSize)*Math.hypot(ctm.a,ctm.b);e.weight=+csn.fontWeight;e.family=csn.fontFamily; }
        else if(n.tagName==='line') e.points=[xy(attr('x1'),attr('y1')),xy(attr('x2'),attr('y2'))];
        else if(n.tagName==='rect') {e.points=[xy(attr('x'),attr('y')),xy(attr('x')+attr('width'),attr('y')+attr('height'))];e.radius=attr('rx');}
        else if(n.tagName==='circle'||n.tagName==='ellipse') {const rx=attr(n.tagName==='circle'?'r':'rx'),ry=attr(n.tagName==='circle'?'r':'ry');e.points=[xy(attr('cx')-rx,attr('cy')-ry),xy(attr('cx')+rx,attr('cy')+ry)];}
        else if(n.tagName==='path') {const len=n.getTotalLength();e.points=Array.from({length:65},(_,i)=>{const p=n.getPointAtLength(len*i/64);return xy(p.x,p.y);});e.closed=/z\s*$/i.test(n.getAttribute('d'));}
        else {e.points=Array.from(n.points,p=>xy(p.x,p.y));e.closed=n.tagName==='polygon';}
        elements.push(e);
      }
      items.push({ type: 'svg', ...box(el), build, viewBox: el.getAttribute('viewBox'), label: el.getAttribute('aria-label') || '', markup: el.outerHTML, elements });
      return;
    }
    if (tag === 'x-connector') {
      let ox = 0, oy = 0, anc = el.parentElement;
      while (anc && anc !== sec) {
        if (getComputedStyle(anc).position !== 'static') { const b = box(anc); ox = b.x; oy = b.y; break; }
        anc = anc.parentElement;
      }
      const a = (k) => parseFloat(el.getAttribute(k));
      items.push({ type: 'conn', x1: a('x1') + ox, y1: a('y1') + oy, x2: a('x2') + ox, y2: a('y2') + oy, route: el.getAttribute('route') || 'straight',
        color: rgb(cs.color), w: parseFloat(el.style.borderWidth) || 2, build, style: el.getAttribute('style') });
      return;
    }
    const d = deco(el, cs);
    if (leafSet.has(el)) {
      const role = el === h ? 'title' : (el === kicker ? 'kicker' : null);
      const runs = runsOf(el);
      const lh = cs.lineHeight === 'normal' ? parseFloat(cs.fontSize) * 1.22 : parseFloat(cs.lineHeight);
      const rg = document.createRange(); rg.selectNodeContents(el);
      const rects = [...rg.getClientRects()].filter(r => r.width >= 1);
      const tr = rects.length ? { top: Math.min(...rects.map(r => r.top)) - S.top, bottom: Math.max(...rects.map(r => r.bottom)) - S.top,
        left: Math.min(...rects.map(r => r.left)) - S.left, right: Math.max(...rects.map(r => r.right)) - S.left } : null;
      items.push({ type: 'text', role, tag, ...box(el), tr, build, deco: d, pad: pad(cs), bw: bw(cs),
        align: cs.textAlign, lh, size: parseFloat(cs.fontSize), nowrap: cs.whiteSpace === 'nowrap',
        lines: lineCount(el), runs, list: tag === 'li' ? (el.parentElement.tagName.toLowerCase()) : null,
        liIndex: tag === 'li' ? [...el.parentElement.children].indexOf(el) + 1 : null,
        display: cs.display, alignItems: cs.alignItems, justify: cs.justifyContent,
        inFlow: cs.position !== 'absolute', visualLines: visualLines(el) });
      return;
    }
    if (d) items.push({ type: 'rect', ...box(el), build, deco: d, tag });
    for (const c of el.children) visit(c);
  };
  for (const c of sec.children) visit(c);

  const scs = getComputedStyle(sec);
  return {
    id: sec.id, bg: rgb(scs.backgroundColor), color: rgb(scs.color), hidden: sec.hasAttribute('hidden'),
    notes: (sec.querySelector('aside') || { innerHTML: '' }).innerHTML,
    logo: sec.dataset.logo || 'small', nonum: sec.hasAttribute('data-nonum'),
    items, fitLog, overflow,
  };
}

(async () => {
  const browser = await chromium.launch(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {});
  const ctx = await browser.newContext({ viewport: { width: 1920, height: 1080 }, deviceScaleFactor: 1 });
  const page = await ctx.newPage();
  const only = argv;
  const ids = only.length ? only : deck.order;
  const summary = [];
  for (const id of ids) {
    const html = fs.readFileSync(path.join(SLIDES, id + '.html'), 'utf8');
    // reveal hidden slides for layout
    let doc = wrap(html.replace(/<section([^>]*)\shidden(\s|>)/, '<section$1 data-was-hidden="1"$2'));
    const tmp = path.join(SLIDES, `.render-${id}.html`);           // file:// page so relative asset paths resolve
    fs.writeFileSync(tmp, doc);
    await page.goto('file://' + tmp, { waitUntil: 'load' });
    fs.unlinkSync(tmp);
    await page.evaluate(() => document.fonts.ready);
    await page.screenshot({ path: `${OUT}/orig/${id}.png` });
    const data = await page.evaluate(pageScript, { K, NATIVE });
    if (/data-was-hidden/.test(await page.content())) data.hidden = true;
    await page.screenshot({ path: `${OUT}/fit/${id}.png` });
    // QR: rasterise the svg with that label
    const qr = await page.$('svg[aria-label^="QR"]');
    if (qr) {
      await page.evaluate(() => { const s = document.querySelector('svg[aria-label^="QR"]'); s.parentElement.style.background = 'transparent'; });
      await qr.screenshot({ path: `${OUT}/${id}_qr.png`, scale: 'device' });
      data.qr = `${OUT}/${id}_qr.png`;
    }
    fs.writeFileSync(`${OUT}/${id}.json`, JSON.stringify(data, null, 1));
    summary.push(`${id}: items=${data.items.length} fit=${data.fitLog.length} ${data.fitLog.filter(f => f.still).length ? 'STILL-OVER ' + JSON.stringify(data.fitLog.filter(f => f.still)) : ''}${data.overflow.length ? ' OVERFLOW ' + JSON.stringify(data.overflow) : ''}`);
  }
  console.log(summary.join('\n'));
  await browser.close();
})();
