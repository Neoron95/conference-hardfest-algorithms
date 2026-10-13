// Paper cut-out characters for slide 3 "КОМУ ПРИГОДИТСЯ ЭТОТ ДОКЛАД".
// Reuses filters (scene.html) and helpers from scene.js (piece/M/S/P/PP/INK, noodle, capsule, head, hoodieTorso, sneaker, text...).
// window.renderChar('dev'|'reviewer'|'perf') draws one standing figure into an 800x800 transparent canvas.
'use strict';

// world coords follow the v3-interview figure (head centre 347,328; shoulders ~y 516; feet y 1000)
const K = 0.8;
const frame = s => `<g transform="translate(400,782) scale(${K}) translate(-350,-1000)">${s}</g>`;
const rad = d => d * Math.PI / 180;
function l2w(cx, cy, r, lx, ly) { const a = rad(r); return [cx + lx * Math.cos(a) - ly * Math.sin(a), cy + lx * Math.sin(a) + ly * Math.cos(a)]; }
const MONO = ` style="font-family:'JetBrains Mono';font-weight:700"`;

const SK_REV = { skin: '#D99A70', skinD: '#BC7B52', hair: '#5A3A28', hairL: '#734B33', nose: '#CF5B30', blush: '#D9735E' };
const SK_PERF = { skin: '#F6C3A0', skinD: '#E0A07A', hair: '#B4502A', hairD: '#8E3B1C', hairL: '#C9663A', nose: '#EC7A55', blush: '#F08A88' };

// ---------- body parts ----------
function legs(o) {
  // o: {pants, pantsD, cuff, stripe}
  let s = '';
  s += M(`<path d="M274,690 L348,690 L342,950 L282,950 Z" fill="${o.pants}"/>`);
  s += M(`<path d="M354,690 L428,690 L420,950 L360,950 Z" fill="${o.pantsD || o.pants}"/>`);
  s += S(`<rect x="277" y="926" width="70" height="28" rx="4" fill="${o.cuff}"/><rect x="356" y="926" width="68" height="28" rx="4" fill="${o.cuff}"/>`);
  s += sneaker(344, 998, -1, o.stripe, 1.0) + sneaker(360, 998, 1, o.stripe, 1.0);
  return s;
}

function sleeveG(sx, sy, wx, wy, L, side, col, cuff, stitch, w1 = 60, w2 = 48) {
  const n = noodle(sx, sy, wx, wy, L, side, w1, w2, col);
  const a = n.endA, ca = Math.cos(a), sa = Math.sin(a), hw = w2 / 2 + 3;
  const cuffP = `<path d="M${pt(wx - sa * hw - ca * 4, wy + ca * hw - sa * 4)} L${pt(wx + sa * hw - ca * 4, wy - ca * hw - sa * 4)} L${pt(wx + sa * (hw - 4) + ca * 14, wy - ca * (hw - 4) + sa * 14)} L${pt(wx - sa * (hw - 4) + ca * 14, wy + ca * (hw - 4) + sa * 14)} Z" fill="${cuff}"/>`;
  const st = stitch ? `<path d="M${pt(wx - sa * (hw - 5) - ca * 16, wy + ca * (hw - 5) - sa * 16)} L${pt(wx + sa * (hw - 5) - ca * 16, wy - ca * (hw - 5) - sa * 16)}" stroke="${stitch}" stroke-opacity="0.6" stroke-width="2.5" stroke-dasharray="6 5"/>` : '';
  return { svg: M(n.svg) + st + S(cuffP), a, hx: wx + ca * 30, hy: wy + sa * 30 };
}

// mitten hand: palm blob centred at (x,y), fingers along angle a (deg)
function palm(x, y, a, skin) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(a)})`,
    M(`<path d="M-22,-20 C-4,-30 24,-26 30,-8 C36,10 24,26 4,26 C-14,27 -27,14 -27,0 C-27,-10 -26,-16 -22,-20 Z" fill="${skin}"/>`));
}
function thumb(x, y, a, skin) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(a)})`, S(`<path d="M-9,10 C-12,-6 -8,-20 0,-21 C9,-21 12,-8 9,10 C6,16 -6,16 -9,10 Z" fill="${skin}"/>`));
}

// generic torso silhouette (same cut as hoodieTorso) + hem band
const TORSO = `M236,508 C246,476 290,458 336,456 L378,456 C424,458 456,478 466,512 L478,716 L222,716 Z`;
function hem(col, stitch) {
  return M(`<path d="M222,700 L478,700 L481,742 L219,742 Z" fill="${col}"/>`) +
    `<path d="M226,712 L474,712" stroke="${stitch}" stroke-opacity="0.5" stroke-width="2.5" stroke-dasharray="7 6" fill="none"/>`;
}

// ---------- heads ----------
// reviewer: brown hair with a top bun, full beard, no glasses
function headReviewer(o) {
  const k = SK_REV, pdx = o.look ? o.look[0] : 7, pdy = o.look ? o.look[1] : 0;
  let s = '';
  s += M(`<rect x="-26" y="70" width="56" height="70" fill="${k.skinD}"/>`);
  // bun (behind the cap)
  s += M(`<ellipse cx="-14" cy="-134" rx="40" ry="34" fill="${k.hair}"/>`);
  s += S(`<path d="M-44,-110 C-30,-100 6,-100 18,-110 L16,-98 C2,-90 -30,-90 -42,-98 Z" fill="${C.amberD}"/>`);
  s += M(`<ellipse cx="-90" cy="16" rx="22" ry="29" fill="${k.skin}"/>`);
  s += P(`<path d="M-80,-58 C-62,-96 44,-102 78,-66 C92,-48 94,-8 92,26 C90,72 56,100 8,100 C-42,100 -76,76 -82,30 C-88,0 -90,-34 -80,-58 Z" fill="${k.skin}"/>`);
  s += S(`<path d="M-100,4 C-92,-4 -84,8 -92,18 C-86,24 -90,36 -100,34 C-94,28 -96,12 -100,4 Z" fill="${k.skinD}"/>`);
  // hair cap swept back, with side part line
  s += P(`<path d="M-88,-2 C-102,-60 -70,-112 -6,-116 C52,-120 94,-92 98,-48 C84,-60 58,-70 30,-68 L36,-54 C6,-64 -30,-60 -52,-46 L-60,-8 L-70,-26 L-76,6 Z" fill="${k.hair}"/>`);
  s += S(`<path d="M-56,-96 C-30,-110 20,-110 52,-94" stroke="${k.hairL}" stroke-width="6" fill="none" stroke-linecap="round"/>` +
    `<path d="M-70,-70 C-50,-86 -10,-92 20,-86" stroke="${k.hairL}" stroke-width="5" fill="none" stroke-linecap="round"/>`);
  // beard: from sideburn round the jaw
  s += P(`<path d="M-80,-10 L-66,-12 C-64,26 -40,44 -6,50 C24,56 62,48 92,22 C96,58 82,104 40,122 C6,136 -40,126 -64,96 C-82,72 -86,30 -80,-10 Z" fill="${k.hair}"/>`);
  // eyes
  if (o.blink) {
    s += S(`<path d="M-38,-6 Q-22,4 -6,-6 L-6,-2 Q-22,8 -38,-2 Z M32,-6 Q50,4 68,-6 L68,-2 Q50,8 32,-2 Z" fill="${C.ink}"/>`);
  } else {
    s += S(`<ellipse cx="-20" cy="-6" rx="17" ry="20" fill="${C.white}"/><ellipse cx="48" cy="-6" rx="18" ry="21" fill="${C.white}"/>`);
    s += S(`<circle cx="${f1(-19 + pdx)}" cy="${f1(-4 + pdy)}" r="9" fill="${C.ink}"/><circle cx="${f1(49 + pdx)}" cy="${f1(-4 + pdy)}" r="9.5" fill="${C.ink}"/>` +
      `<circle cx="${f1(-16 + pdx)}" cy="${f1(-8 + pdy)}" r="3" fill="#fff"/><circle cx="${f1(52 + pdx)}" cy="${f1(-8 + pdy)}" r="3" fill="#fff"/>`);
  }
  // brows: left level, right raised (attentive)
  s += S(`<path d="M-46,-40 C-36,-50 -12,-52 -2,-44 L-4,-34 C-16,-40 -34,-38 -44,-30 Z" fill="${k.hair}"/>` +
    `<path d="M24,-50 C36,-64 66,-66 80,-54 L76,-42 C64,-50 42,-50 28,-40 Z" fill="${k.hair}"/>`);
  s += S(`<ellipse cx="22" cy="34" rx="14" ry="8" fill="${k.blush}" opacity="0.7"/>`);
  // moustache + smile
  s += S(`<path d="M8,62 C30,40 60,40 70,48 C84,38 100,44 104,58 C92,56 82,60 74,66 C60,58 34,60 8,62 Z" fill="${k.hairL}"/>`);
  s += S(`<path d="M30,72 C46,78 66,78 80,70 C78,86 66,94 54,94 C42,94 32,86 30,72 Z" fill="${C.mouth}"/><path d="M40,88 C48,82 62,82 70,86 C64,94 46,94 40,88 Z" fill="${C.tongue}"/>`);
  s += M(`<path d="M70,4 C76,-6 94,0 106,16 C118,32 112,48 96,50 C80,52 66,40 64,26 C63,18 65,10 70,4 Z" fill="${k.nose}"/>`);
  return s;
}

// perf author: ginger bob with a fringe, no glasses
function hairBackPerf() {
  const k = SK_PERF;
  return P(`<path d="M-116,-20 C-118,-96 -60,-140 4,-140 C74,-140 120,-96 116,-20 L114,78 C96,92 74,88 60,78 L-62,78 C-82,92 -104,92 -120,80 Z" fill="${k.hairD}"/>`);
}
function headPerf(o) {
  const k = SK_PERF, pdx = o.look ? o.look[0] : 7, pdy = o.look ? o.look[1] : 0;
  let s = '';
  s += M(`<rect x="-24" y="70" width="52" height="70" fill="${k.skinD}"/>`);
  s += P(`<path d="M-80,-58 C-62,-96 44,-102 78,-66 C92,-48 94,-8 92,26 C90,72 56,100 8,100 C-42,100 -76,76 -82,30 C-88,0 -90,-34 -80,-58 Z" fill="${k.skin}"/>`);
  // fringe
  s += P(`<path d="M-96,-30 C-104,-100 -44,-130 10,-128 C66,-126 104,-98 104,-44 L92,-36 L84,-56 L68,-36 L58,-62 L40,-40 L28,-64 L10,-44 L-2,-66 L-18,-46 L-32,-66 L-46,-44 L-58,-62 L-70,-36 L-78,-52 Z" fill="${k.hair}"/>`);
  // side lock over the ear
  s += P(`<path d="M-118,-36 L-74,-44 C-80,-4 -78,40 -64,80 C-84,92 -106,90 -122,80 Z" fill="${k.hair}"/>`);
  s += S(`<path d="M-40,-112 C-10,-122 30,-120 60,-106" stroke="${k.hairL}" stroke-width="6" fill="none" stroke-linecap="round"/>` +
    `<path d="M-104,-10 C-102,20 -98,50 -90,70" stroke="${k.hairL}" stroke-width="5" fill="none" stroke-linecap="round"/>`);
  // eyes + lashes
  s += S(`<ellipse cx="-20" cy="-4" rx="17" ry="20" fill="${C.white}"/><ellipse cx="48" cy="-4" rx="18" ry="21" fill="${C.white}"/>`);
  s += S(`<circle cx="${f1(-19 + pdx)}" cy="${f1(-2 + pdy)}" r="9" fill="${C.ink}"/><circle cx="${f1(49 + pdx)}" cy="${f1(-2 + pdy)}" r="9.5" fill="${C.ink}"/>` +
    `<circle cx="${f1(-16 + pdx)}" cy="${f1(-6 + pdy)}" r="3" fill="#fff"/><circle cx="${f1(52 + pdx)}" cy="${f1(-6 + pdy)}" r="3" fill="#fff"/>`);
  s += S(`<path d="M-4,-18 L6,-26 M2,-12 L12,-18 M64,-20 L74,-28 M70,-14 L80,-20" stroke="${C.ink}" stroke-width="5" stroke-linecap="round"/>`);
  // brows (thin, ginger-brown)
  s += S(`<path d="M-42,-34 C-32,-44 -12,-46 -2,-40 L-4,-33 C-16,-38 -32,-36 -40,-28 Z M26,-42 C38,-52 62,-54 76,-44 L72,-36 C60,-44 42,-44 30,-34 Z" fill="${k.hairD}"/>`);
  s += S(`<ellipse cx="20" cy="38" rx="15" ry="9" fill="${k.blush}" opacity="0.75"/>`);
  // big open smile
  s += S(`<path d="M20,58 C40,64 66,62 80,52 C78,80 62,92 46,90 C30,88 20,74 20,58 Z" fill="${C.mouth}"/>` +
    `<path d="M32,82 C40,74 58,74 66,80 C60,90 42,92 32,82 Z" fill="${C.tongue}"/><path d="M26,60 C42,64 62,62 76,56 L74,62 C60,68 42,70 28,66 Z" fill="${C.white}"/>`);
  s += M(`<path d="M68,10 C73,2 87,6 97,18 C107,30 103,43 90,45 C77,46 66,37 64,25 C63,19 64,14 68,10 Z" fill="${k.nose}"/>`);
  return s;
}

// ---------- props ----------
function codeCard(label, stripe, icon) {
  let s = PP(`<rect x="-120" y="-90" width="240" height="180" rx="12" fill="${C.cream}"/>`);
  s += M(`<path d="M-120,-78 Q-120,-90 -108,-90 L108,-90 Q120,-90 120,-78 L120,-60 L-120,-60 Z" fill="${stripe}"/>`);
  s += INK(text(0, 8, label, 62, C.ink, 'middle', MONO));
  if (icon === 'sort') {
    let b = '';
    [16, 24, 32, 40, 48].forEach((h, i) => { b += `<rect x="${-66 + i * 28}" y="${72 - h}" width="20" height="${h}" rx="3" fill="${stripe}"/>`; });
    s += S(b);
  } else {
    let b = '';
    const full = [1, 0, 1, 1, 0];
    full.forEach((f, i) => {
      b += `<rect x="${-72 + i * 30}" y="38" width="24" height="34" rx="4" fill="${f ? stripe : 'none'}" stroke="${f ? stripe : '#9A9184'}" stroke-width="4"/>`;
    });
    s += S(b);
  }
  return s;
}

function qm(x, y, size, rot, color, stroke) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(rot)})`, M(text(0, 0, '?', size, color, 'middle', ` stroke="${stroke}" stroke-width="2"`)));
}

// diff sheet in local coords (centred, 270x340)
const DIFF_ROWS = [ // type, code-bar length (sheet-local)
  [' ', 150], ['-', 170], ['-', 120], ['+', 180], ['+', 140], [' ', 110], ['+', 160],
];
function diffRows() {
  let s = '';
  DIFF_ROWS.forEach((r, i) => {
    const y = -112 + i * 40;
    const col = r[0] === '-' ? C.pink : r[0] === '+' ? C.teal : null;
    let row = '';
    if (col) row += `<rect x="-122" y="${y - 17}" width="244" height="34" rx="4" fill="${col}" fill-opacity="0.28"/>`;
    // sign
    if (r[0] === '-') row += `<rect x="-112" y="${y - 4}" width="22" height="8" rx="2" fill="${C.pinkD}"/>`;
    if (r[0] === '+') row += `<rect x="-112" y="${y - 4}" width="22" height="8" rx="2" fill="${C.tealDD}"/><rect x="-105" y="${y - 11}" width="8" height="22" rx="2" fill="${C.tealDD}"/>`;
    // code bars (two words)
    const L = r[1], w1 = Math.round(L * 0.38);
    const bc = col ? (r[0] === '-' ? '#9C2F67' : '#1F7A64') : '#8C8579';
    row += `<rect x="-78" y="${y - 5}" width="${w1}" height="10" rx="5" fill="${bc}"/><rect x="${-78 + w1 + 12}" y="${y - 5}" width="${L - w1 - 12}" height="10" rx="5" fill="${bc}"/>`;
    s += row;
  });
  return S(s);
}
function diffSheet() {
  let s = PP(`<rect x="-135" y="-170" width="270" height="340" rx="10" fill="${C.cream}"/>`);
  s += M(`<path d="M-135,-158 Q-135,-170 -123,-170 L123,-170 Q135,-170 135,-158 L135,-140 L-135,-140 Z" fill="${C.greyM}"/>`);
  s += INK(text(-116, -150, 'diff', 22, C.cream, 'start', MONO));
  s += diffRows();
  return s;
}

function stopwatch() {
  let s = '';
  s += M(`<rect x="-14" y="-92" width="28" height="22" rx="5" fill="${C.greyD}"/><rect x="-24" y="-104" width="48" height="18" rx="7" fill="${C.amber}"/>`);
  s += S(`<rect x="44" y="-74" width="22" height="16" rx="5" fill="${C.greyD}" transform="rotate(42 55 -66)"/>`);
  s += P(`<circle cx="0" cy="0" r="74" fill="${C.greyL}"/>`);
  s += PP(`<circle cx="0" cy="0" r="58" fill="${C.cream}"/>`);
  // elapsed wedge (12 -> ~4 o'clock)
  const a1 = rad(-90), a2 = rad(30), r = 46;
  s += S(`<path d="M0,0 L${pt(Math.cos(a1) * r, Math.sin(a1) * r)} A${r},${r} 0 0 1 ${pt(Math.cos(a2) * r, Math.sin(a2) * r)} Z" fill="${C.teal}" fill-opacity="0.85"/>`);
  let ticks = '';
  for (let i = 0; i < 12; i++) { const a = rad(i * 30 - 90); ticks += `<path d="M${pt(Math.cos(a) * 50, Math.sin(a) * 50)} L${pt(Math.cos(a) * 56, Math.sin(a) * 56)}" stroke="${C.ink}" stroke-width="${i % 3 ? 3 : 5}" stroke-linecap="round"/>`; }
  s += ticks;
  s += S(`<path d="M0,0 L${pt(Math.cos(a2) * 44, Math.sin(a2) * 44)}" stroke="${C.ink}" stroke-width="7" stroke-linecap="round"/><circle cx="0" cy="0" r="8" fill="${C.ink}"/>`);
  return s;
}

function phone() {
  let s = P(`<rect x="-52" y="-96" width="104" height="192" rx="18" fill="${C.slateD}"/>`);
  s += M(`<rect x="-42" y="-80" width="84" height="150" rx="6" fill="${C.cream}"/>`);
  s += S(`<rect x="-14" y="-90" width="28" height="6" rx="3" fill="${C.slate}"/><circle cx="0" cy="82" r="6" fill="${C.slate}"/>`);
  // tiny result bars
  s += S(`<rect x="-30" y="-56" width="60" height="16" rx="4" fill="${C.teal}"/><rect x="-30" y="-28" width="40" height="16" rx="4" fill="${C.amber}"/><rect x="-30" y="0" width="52" height="16" rx="4" fill="${C.pink}"/>` +
    `<rect x="-30" y="32" width="34" height="9" rx="4" fill="#B5AC9E"/><rect x="-30" y="48" width="48" height="9" rx="4" fill="#B5AC9E"/>`);
  return s;
}

function serverCI() {
  // bottom centre at (0,0); 2 rack units + label
  let s = '';
  s += M(`<rect x="-78" y="-12" width="22" height="14" rx="3" fill="${C.greyD}"/><rect x="56" y="-12" width="22" height="14" rx="3" fill="${C.greyD}"/>`);
  s += P(`<rect x="-92" y="-232" width="184" height="226" rx="12" fill="${C.slate}"/>`);
  [[-214], [-148], [-82]].forEach(([y], i) => {
    s += M(`<rect x="-80" y="${y}" width="160" height="56" rx="6" fill="${C.slateL}"/>`);
    s += S(`<circle cx="-60" cy="${y + 28}" r="7" fill="${i === 1 ? C.amber : C.teal}"/><circle cx="-38" cy="${y + 28}" r="7" fill="${C.teal}"/>` +
      `<rect x="-8" y="${y + 14}" width="70" height="7" rx="3" fill="${C.slateD}"/><rect x="-8" y="${y + 26}" width="70" height="7" rx="3" fill="${C.slateD}"/><rect x="-8" y="${y + 38}" width="70" height="7" rx="3" fill="${C.slateD}"/>`);
  });
  // label tag
  s += g('rotate(-4)', PP(`<rect x="-62" y="-292" width="124" height="72" rx="8" fill="${C.cream}"/>`) + INK(text(0, -236, 'CI', 60, C.ink)));
  return s;
}

// ---------- characters ----------
function devChar() {
  let s = '';
  s += legs({ pants: '#2E3136', pantsD: C.denim, cuff: C.denimL, stripe: C.teal });
  s += hoodieTorso() + hem(C.tealD, '#C9F2E6');
  s += g('translate(347,328) rotate(-3)', head({ look: [9, -3], browUp: true, mouth: 'smile' }));
  // arms: elbows down, forearms up, cards held from below
  const la = sleeveG(252, 522, 112, 548, 250, -1, C.teal, C.cream, '#C9F2E6');
  const ra = sleeveG(450, 516, 590, 544, 250, 1, C.teal, C.cream, '#C9F2E6');
  const c1 = { x: la.hx - 8, y: la.hy - 98, r: -8 };
  const c2 = { x: ra.hx + 8, y: ra.hy - 98, r: 8 };
  s += la.svg + ra.svg;
  s += palm(la.hx, la.hy - 6, -90, C.skin) + palm(ra.hx, ra.hy - 6, -90, C.skin);
  s += g(`translate(${f1(c1.x)},${f1(c1.y)}) rotate(${c1.r})`, codeCard('sort', C.teal, 'sort'));
  s += g(`translate(${f1(c2.x)},${f1(c2.y)}) rotate(${c2.r})`, codeCard('hash', C.pink, 'hash'));
  s += thumb(la.hx + 12, la.hy - 26, 20, C.skin) + thumb(ra.hx - 12, ra.hy - 26, -20, C.skin);
  s += qm(440, 156, 112, 14, C.amber, C.amberD);
  return s;
}

function reviewerChar() {
  const k = SK_REV;
  let s = '';
  s += legs({ pants: '#3E4A3F', pantsD: '#4A5749', cuff: '#5E6B5C', stripe: C.amber });
  // sweater
  s += P(`<path d="${TORSO}" fill="${C.amber}"/>`);
  s += hem(C.amberD, '#FFF1C9');
  // cable knit braids
  let cab = '';
  for (const x of [296, 404]) { for (let y = 520; y < 690; y += 26) cab += `<path d="M${x - 10},${y} Q${x},${y + 13} ${x + 10},${y} M${x - 10},${y + 13} Q${x},${y + 26} ${x + 10},${y + 13}" stroke="${C.amberD}" stroke-width="5" fill="none" stroke-linecap="round"/>`; }
  s += S(cab);
  s += g('translate(347,328) rotate(4)', headReviewer({ look: [8, 7] }));
  // crew collar over the neck base
  s += M(`<path d="M300,458 C318,480 382,480 400,458 L414,468 C398,500 302,500 286,468 Z" fill="${C.amberD}"/>`);
  // sheet held by the character's left hand (viewer right), magnifier in the other hand
  const SH = { x: 534, y: 676, r: 5 };
  const ra = sleeveG(450, 516, 690, 648, 296, -1, C.amber, C.amberD, null);
  s += ra.svg + palm(ra.hx - 4, ra.hy, 180, k.skin);
  s += g(`translate(${SH.x},${SH.y}) rotate(${SH.r})`, diffSheet());
  s += thumb(ra.hx - 22, ra.hy - 8, -100, k.skin);
  // magnifier: lens centre in sheet-local coords over rows 3-4
  const LC = { x: 10, y: 0 }, LR = 70;
  const lw = l2w(SH.x, SH.y, SH.r, LC.x, LC.y);
  const hdir = rad(135); // handle towards lower-left
  const h0 = [lw[0] + Math.cos(hdir) * (LR + 8), lw[1] + Math.sin(hdir) * (LR + 8)];
  const h1 = [lw[0] + Math.cos(hdir) * (LR + 110), lw[1] + Math.sin(hdir) * (LR + 110)];
  // magnified content (clipped to the lens)
  const cid = 'lensclip';
  let mag = `<clipPath id="${cid}"><circle cx="${LC.x}" cy="${LC.y}" r="${LR - 4}"/></clipPath>`;
  mag += `<circle cx="${LC.x}" cy="${LC.y}" r="${LR - 4}" fill="${C.cream}"/>`;
  mag += `<g clip-path="url(#${cid})"><g transform="translate(${LC.x},${LC.y}) scale(1.7) translate(${-LC.x},${-LC.y})">${diffRows()}</g></g>`;
  mag += `<circle cx="${LC.x}" cy="${LC.y}" r="${LR - 4}" fill="${C.sweat}" fill-opacity="0.22"/>`;
  s += g(`translate(${SH.x},${SH.y}) rotate(${SH.r})`, mag);
  // left arm crossing to the handle
  const la = sleeveG(252, 522, h1[0] - 34, h1[1] + 22, 230, -1, C.amber, C.amberD, null);
  s += M(capsule(h0[0], h0[1], h1[0], h1[1], 22, 28, C.kraftD)) + S(capsule(h0[0] - 4, h0[1] + 4, h0[0] - 24, h0[1] + 24, 30, 30, C.slateD));
  s += M(`<circle cx="${f1(lw[0])}" cy="${f1(lw[1])}" r="${LR}" fill="none" stroke="${C.slateD}" stroke-width="16"/>`);
  s += S(`<path d="M${pt(lw[0] - 40, lw[1] - 22)} A46,46 0 0 1 ${pt(lw[0] - 10, lw[1] - 46)}" stroke="#FFFFFF" stroke-opacity="0.7" stroke-width="8" fill="none" stroke-linecap="round"/>`);
  s += la.svg + palm(h1[0] - 8, h1[1] + 2, 135 - 180, k.skin);
  s += thumb(h1[0] + 4, h1[1] - 12, 40, k.skin);
  return s;
}

function perfChar() {
  const k = SK_PERF;
  let s = '';
  // server stands on the floor at the viewer's left
  s += g('translate(108,1000)', serverCI());
  s += legs({ pants: C.greyD, pantsD: '#6A7077', cuff: C.greyM, stripe: C.pink });
  // head is mirrored (faces left)
  s += g('translate(347,328) scale(-1,1)', hairBackPerf());
  // grey tee + pink cardigan panels
  s += P(`<path d="${TORSO}" fill="${C.greyL}"/>`);
  s += M(`<path d="M300,462 C318,486 384,486 402,462 L404,472 C386,500 316,500 298,472 Z" fill="${C.greyM}"/>`);
  s += P(`<path d="M236,508 C246,476 290,458 316,456 L326,470 C320,540 322,640 330,742 L219,742 Z" fill="${C.pink}"/>`);
  s += P(`<path d="M466,512 C456,478 420,458 388,456 L378,470 C384,540 382,640 372,742 L481,742 Z" fill="${C.pink}"/>`);
  s += S(`<circle cx="318" cy="560" r="7" fill="${C.cream}"/><circle cx="320" cy="616" r="7" fill="${C.cream}"/><circle cx="322" cy="672" r="7" fill="${C.cream}"/>`);
  s += M(`<path d="M222,708 L330,708 L331,742 L219,742 Z M372,708 L478,708 L481,742 L372,742 Z" fill="${C.pinkD}"/>`);
  s += M(`<path d="M246,612 L306,612 L308,664 L250,664 Z" fill="${C.pinkD}"/>`);
  s += g('translate(347,328) scale(-1,1) rotate(6)', headPerf({ look: [6, -9] }));
  // raised arm (viewer left) with stopwatch
  const la = sleeveG(254, 520, 160, 420, 200, -1, C.pink, C.cream, '#FFD3E8');
  const sw = { x: la.hx - 14, y: la.hy - 86 };
  s += la.svg + palm(la.hx, la.hy - 4, -80, k.skin);
  s += g(`translate(${f1(sw.x)},${f1(sw.y)}) rotate(-10)`, stopwatch());
  s += thumb(la.hx + 18, la.hy - 22, 30, k.skin);
  // other arm holds the phone at waist height
  const ra = sleeveG(450, 516, 556, 640, 200, 1, C.pink, C.cream, '#FFD3E8');
  s += ra.svg + palm(ra.hx, ra.hy, -60, k.skin);
  s += g(`translate(${f1(ra.hx + 6)},${f1(ra.hy - 64)}) rotate(8)`, phone());
  s += thumb(ra.hx - 22, ra.hy - 30, -30, k.skin);
  return s;
}

window.renderChar = function (name) {
  POSE = 0; UID = 0;
  const f = { dev: devChar, reviewer: reviewerChar, perf: perfChar }[name];
  document.getElementById('root').innerHTML = frame(f());
};
