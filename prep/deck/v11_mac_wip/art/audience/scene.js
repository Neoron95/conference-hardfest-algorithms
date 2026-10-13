// Paper cut-out scene renderer for "Заучил ответы к собеседованию" (variant 3).
// renderScene('A'|'B', tp) draws the scene for (quantised) time tp in seconds.
'use strict';

const C = {
  teal: '#46CDAE', tealD: '#2FA68A', tealDD: '#238A72', tealL: '#8FE3CF',
  pink: '#E2489B', pinkD: '#B52F78',
  amber: '#F2C14E', amberD: '#D9A332', amberB: '#E3AE3A',
  cream: '#F3EBDD', creamD: '#DCCFB8', white: '#FBF7EE',
  skin: '#F4B488', skinD: '#DE9468', nose: '#E8603A', blush: '#EC8B7C',
  hair: '#2B2B2E', ink: '#1C1C1E', glasses: '#2A1F1A',
  denim: '#383B42', denimL: '#62666E',
  kraft: '#C99A68', kraftD: '#A47548', kraftDD: '#7F5935',
  grey: '#8F8F8F', greyD: '#5E646B', greyL: '#B9BEC4', greyM: '#7C8289',
  slate: '#56606B', slateL: '#6B7581', slateD: '#434A53',
  limb: '#8A9199', mouth: '#4A1524', tongue: '#EE6F8E', sweat: '#BDE6F7',
};

// ---------- helpers ----------
const clamp = (x, a, b) => Math.max(a, Math.min(b, x));
const lerp = (a, b, u) => a + (b - a) * u;
const seg = (t, a, b) => clamp((t - a) / (b - a), 0, 1);
const ease = u => u * u * (3 - 2 * u);
const f1 = v => (Math.round(v * 10) / 10);
const pt = (x, y) => `${f1(x)},${f1(y)}`;
function hash(a, b) { let h = (a * 374761393 + b * 668265263) | 0; h = (h ^ (h >>> 13)) * 1274126177 | 0; return ((h ^ (h >>> 16)) >>> 0) / 4294967295; }
function mulberry(seed) { return function () { seed |= 0; seed = seed + 0x6D2B79F5 | 0; let t = Math.imul(seed ^ seed >>> 15, 1 | seed); t = t + Math.imul(t ^ t >>> 7, 61 | t) ^ t; return ((t ^ t >>> 14) >>> 0) / 4294967296; }; }

const SCENE_DX = 40;      // whole-scene horizontal balance
let POSE = 0;               // pose index (12 per second), used for stop-motion boil
let UID = 0;                // unique ids for per-frame clipPaths
const boil = (id, amp) => (hash(POSE, id) - 0.5) * 2 * amp;

const piece = (f, s, extra = '') => `<g filter="url(#${f})"${extra}>${s}</g>`;
const P = s => piece('felt', s);
const PP = s => piece('paper', s);
const M = s => piece('feltM', s);
const S = s => piece('feltS', s);
const INK = s => piece('ink', s);
const g = (tr, s) => `<g transform="${tr}">${s}</g>`;

function capsule(x1, y1, x2, y2, w1, w2, fill) {
  const a = Math.atan2(y2 - y1, x2 - x1), nx = -Math.sin(a), ny = Math.cos(a);
  const q = [[x1 + nx * w1 / 2, y1 + ny * w1 / 2], [x2 + nx * w2 / 2, y2 + ny * w2 / 2], [x2 - nx * w2 / 2, y2 - ny * w2 / 2], [x1 - nx * w1 / 2, y1 - ny * w1 / 2]];
  return `<path d="M${q.map(p => pt(p[0], p[1])).join(' L')} Z" fill="${fill}"/>` +
    `<circle cx="${f1(x1)}" cy="${f1(y1)}" r="${f1(w1 / 2)}" fill="${fill}"/><circle cx="${f1(x2)}" cy="${f1(y2)}" r="${f1(w2 / 2)}" fill="${fill}"/>`;
}
function ik(sx, sy, hx, hy, a, b, bend) {
  let dx = hx - sx, dy = hy - sy, d = Math.hypot(dx, dy);
  const dmax = a + b - 1, dmin = Math.abs(a - b) + 1;
  if (d > dmax) { hx = sx + dx / d * dmax; hy = sy + dy / d * dmax; d = dmax; }
  if (d < dmin) d = dmin;
  const ang = Math.atan2(dy, dx);
  const A = Math.acos(clamp((a * a + d * d - b * b) / (2 * a * d), -1, 1));
  const ea = ang + bend * A;
  return { ex: sx + a * Math.cos(ea), ey: sy + a * Math.sin(ea), hx, hy };
}
// rubber-hose limb: curved paper strip from (sx,sy) to (hx,hy) of nominal length L, bulging to `side`
function noodle(sx, sy, hx, hy, L, side, w1, w2, color) {
  const dx = hx - sx, dy = hy - sy, d = Math.hypot(dx, dy) || 1;
  const sag = d < L ? Math.sqrt(3 * d * (L - d) / 8) : 0;
  const nx = -dy / d * side, ny = dx / d * side;
  const qx = (sx + hx) / 2 + nx * sag * 2, qy = (sy + hy) / 2 + ny * sag * 2;
  const N = 18, A = [], B = [];
  for (let i = 0; i <= N; i++) {
    const t = i / N, u = 1 - t;
    const x = u * u * sx + 2 * u * t * qx + t * t * hx, y = u * u * sy + 2 * u * t * qy + t * t * hy;
    const tx = 2 * u * (qx - sx) + 2 * t * (hx - qx), ty = 2 * u * (qy - sy) + 2 * t * (hy - qy);
    const tl = Math.hypot(tx, ty) || 1, w = lerp(w1, w2, t) / 2;
    A.push(pt(x - ty / tl * w, y + tx / tl * w)); B.push(pt(x + ty / tl * w, y - tx / tl * w));
  }
  const endA = Math.atan2(hy - qy, hx - qx);
  return { svg: `<path d="M${A.join(' L')} L${B.reverse().join(' L')} Z" fill="${color}"/><circle cx="${f1(sx)}" cy="${f1(sy)}" r="${f1(w1 / 2)}" fill="${color}"/><circle cx="${f1(hx)}" cy="${f1(hy)}" r="${f1(w2 / 2)}" fill="${color}"/>`, endA, qx, qy };
}
function text(x, y, s, size, fill, anchor = 'middle', extra = '') {
  return `<text x="${f1(x)}" y="${f1(y)}" font-size="${size}" fill="${fill}" text-anchor="${anchor}"${extra}>${s}</text>`;
}
// cursive "code" scribble: loops grouped in words
function scribble(x0, y0, len, seed, h = 17, loopW = 21) {
  const r = mulberry(seed); let d = '', x = x0, first = true;
  const words = []; let rem = len;
  while (rem > 30) { const w = Math.min(rem, 46 + r() * 80); words.push(w); rem -= w + 24; }
  const a = loopW / (2 * Math.PI), b = loopW * 0.42;
  for (const w of words) {
    const n = Math.max(1, Math.round(w / loopW));
    const hs = []; for (let i = 0; i <= n; i++) hs.push(h * (0.55 + 0.6 * r()));
    for (let s = -Math.PI / 2; s <= 2 * Math.PI * n - Math.PI / 2 + 0.01; s += 0.2) {
      const li = clamp(Math.floor((s + Math.PI / 2) / (2 * Math.PI)), 0, n);
      const X = x + a * (s + Math.PI / 2) - b * Math.sin(s), Y = y0 - hs[li] * Math.cos(s) * 0.5 - hs[li] * 0.25 + h * 0.25;
      d += (first ? 'M' : 'L') + pt(X, Y) + ' '; first = false;
    }
    x += w + 24; first = true;
  }
  return d;
}

// ---------- static-ish props ----------
function table() {
  // drawn in two parts: back legs (behind person) and top+front (in front of torso)
  return {
    back: M(`<rect x="168" y="690" width="24" height="268" fill="${C.kraftDD}"/><rect x="646" y="690" width="24" height="268" fill="${C.kraftDD}"/>`),
    front: P(`<path d="M96,600 L708,600 L748,694 L58,694 Z" fill="${C.kraft}"/>`) +
      P(`<rect x="58" y="692" width="690" height="40" rx="4" fill="${C.kraftD}"/>`) +
      M(`<rect x="74" y="728" width="38" height="272" fill="${C.kraftD}"/>`) +
      M(`<rect x="694" y="728" width="38" height="272" fill="${C.kraftD}"/>`),
  };
}

function chair() {
  return M(`<rect x="160" y="436" width="40" height="276" rx="8" fill="${C.greyD}"/>`) +
    M(`<rect x="206" y="736" width="240" height="22" rx="6" fill="${C.greyD}"/>`) +
    M(`<rect x="226" y="752" width="20" height="248" fill="#4E545A"/><rect x="408" y="752" width="20" height="248" fill="#4E545A"/>`);
}

function sneaker(x, y, dir, stripe, s = 1) {
  // heel at (x,y) bottom; points in dir (+1 right / -1 left)
  const body = `<path d="M0,0 L-2,-30 C6,-44 34,-48 52,-44 C74,-40 98,-30 112,-14 C119,-6 118,2 110,4 L4,4 Z" fill="${C.white}"/>`;
  const sole = `<path d="M-3,-6 L116,-6 C118,0 116,6 108,7 L2,7 Z" fill="${C.creamD}"/>`;
  const str = `<path d="M30,-38 L50,-40 L74,-10 L56,-10 Z" fill="${stripe}"/>`;
  const lace = `<path d="M60,-40 L78,-30 M66,-44 L84,-34" stroke="${C.greyL}" stroke-width="5" stroke-linecap="round" fill="none"/><rect x="58" y="-46" width="30" height="20" fill="none"/>`;
  return g(`translate(${f1(x)},${f1(y)}) scale(${dir * s},${s})`, M(body + sole) + S(str) + S(lace));
}

// ---------- cards ----------
// held card (big): "Задача" + number, coloured top stripe
function bigCard(num, stripe) {
  return PP(`<rect x="-170" y="-122" width="340" height="244" rx="12" fill="${C.cream}"/>`) +
    M(`<path d="M-170,-110 Q-170,-122 -158,-122 L158,-122 Q170,-122 170,-110 L170,-90 L-170,-90 Z" fill="${stripe}"/>`) +
    INK(text(0, -26, 'Задача', 60, C.ink) + text(0, 98, num, 122, C.ink));
}
// small stack card: one-line title + statement squiggles
function smallCard(num, stripe, seed) {
  return PP(`<rect x="-114" y="-52" width="228" height="104" rx="9" fill="${C.cream}"/>`) +
    S(`<path d="M-114,-44 Q-114,-52 -106,-52 L106,-52 Q114,-52 114,-44 L114,-42 L-114,-42 Z" fill="${stripe}"/>`) +
    INK(text(-98, -12, 'Задача ' + num, 35, C.ink, 'start')) +
    S(`<path d="${scribble(-92, 24, 150, seed, 9, 13)}" stroke="#8C8579" stroke-width="5" fill="none" stroke-linecap="round" stroke-linejoin="round"/>`);
}

const STACK = [ // back -> front
  { x: 198, y: 546, r: -4 },
  { x: 221, y: 589, r: -1 },
  { x: 244, y: 632, r: 2.5 },
];
const LEFT_DX = -36;
const IY = -30;  // interviewer sits a bit higher
const HELD = { x: 664, y: 262, r: -5, s: 1 };
const ONSTACK = { x: 246, y: 610, r: 2.5, s: 0.67 };

function stack(nums, stripe) {
  let out = '';
  STACK.forEach((c, i) => { out += g(`translate(${c.x},${c.y}) rotate(${c.r})`, smallCard(nums[i], stripe, 30 + i * 7)); });
  return out;
}

// ---------- sticker "переговорка А/Б" ----------
function sticker(letter, sy) {
  const back = Math.abs(sy) < 0.2;
  const inner = PP(`<path d="M-128,0 L128,0 L124,186 C60,192 -60,180 -126,190 Z" fill="${back ? C.amberD : C.amber}"/>`) +
    (back ? '' : INK(text(0, 58, 'переговорка', 33, C.ink) + text(0, 166, letter, 106, C.ink))) +
    S(`<rect x="-44" y="-16" width="88" height="30" fill="${C.cream}" fill-opacity="0.85" transform="rotate(3)"/>`);
  return g(`translate(268,706) rotate(${f1(-4 + boil(31, 0.6))}) scale(1,${Math.max(0.06, sy)})`, inner);
}

// ---------- interviewer (author) ----------
function head(o) {
  // local coords, head centre (0,0), facing right
  const pdx = o.look ? o.look[0] : 7, pdy = o.look ? o.look[1] : 0;
  let s = '';
  s += M(`<rect x="-26" y="70" width="56" height="70" fill="${C.skinD}"/>`); // neck
  s += M(`<ellipse cx="-90" cy="14" rx="22" ry="29" fill="${C.skin}"/>`);
  s += P(`<path d="M-80,-58 C-62,-96 44,-102 78,-66 C92,-48 94,-8 92,26 C90,72 56,100 8,100 C-42,100 -76,76 -82,30 C-88,0 -90,-34 -80,-58 Z" fill="${C.skin}"/>`);
  s += S(`<path d="M-100,2 C-92,-6 -84,6 -92,16 C-86,22 -90,34 -100,32 C-94,26 -96,10 -100,2 Z" fill="${C.skinD}"/>`);
  // hair
  s += P(`<path d="M-90,-12 L-116,-22 L-100,-40 L-136,-64 L-98,-80 L-112,-122 L-66,-106 L-52,-152 L-16,-116 L6,-160 L30,-116 L64,-144 L64,-100 L104,-114 L88,-72 L114,-58 L82,-46 C70,-54 52,-60 34,-60 L42,-38 L14,-54 L6,-30 L-12,-54 L-28,-30 L-44,-54 L-56,-26 L-64,-44 L-66,-4 L-74,-18 Z" fill="${C.hair}"/>`);
  s += S(`<path d="M-72,-22 L-60,-22 L-60,10 L-70,4 Z" fill="${C.hair}"/>`);
  s += M(`<path d="M-84,-70 L-118,-92 L-74,-90 L-64,-128 L-40,-100 L-14,-140 L2,-104 L36,-128 L30,-94 L66,-104 L48,-78 C20,-84 -40,-86 -84,-70 Z" fill="#3B3B40"/>`);
  // brows
  const by = o.browUp ? -6 : 0;

  // eyes (whites + pupils) under glasses
  if (o.blink) {
    s += S(`<path d="M-38,-6 Q-22,4 -6,-6 L-6,-2 Q-22,8 -38,-2 Z M32,-6 Q50,4 68,-6 L68,-2 Q50,8 32,-2 Z" fill="${C.ink}"/>`);
  } else {
    s += S(`<ellipse cx="-22" cy="-6" rx="19" ry="22" fill="${C.white}"/><ellipse cx="50" cy="-6" rx="20" ry="23" fill="${C.white}"/>`);
    s += S(`<circle cx="${f1(-21 + pdx)}" cy="${f1(-4 + pdy)}" r="9.5" fill="${C.ink}"/><circle cx="${f1(51 + pdx)}" cy="${f1(-4 + pdy)}" r="10" fill="${C.ink}"/>` +
      `<circle cx="${f1(-18 + pdx)}" cy="${f1(-8 + pdy)}" r="3" fill="#fff"/><circle cx="${f1(54 + pdx)}" cy="${f1(-8 + pdy)}" r="3" fill="#fff"/>`);
  }
  // glasses
  s += S(`<path d="M-54,-10 L-80,-2" stroke="${C.glasses}" stroke-width="7" stroke-linecap="round"/>` +
    `<circle cx="-22" cy="-7" r="30" fill="none" stroke="${C.glasses}" stroke-width="8"/>` +
    `<circle cx="50" cy="-7" r="32" fill="none" stroke="${C.glasses}" stroke-width="8.5"/>` +
    `<path d="M7,-12 Q13,-18 19,-12" stroke="${C.glasses}" stroke-width="7" fill="none"/>`);
  // thick felt brows (drawn over hair fringe so they read)
  s += S(`<path d="M-50,${-46 + by} C-40,${-58 + by} -14,${-60 + by} -4,${-52 + by} L-6,${-40 + by} C-18,${-46 + by} -38,${-44 + by} -48,${-34 + by} Z" fill="${C.ink}"/>` +
    `<path d="M24,${-52 + by * 1.5} C36,${-64 + by * 1.5} 66,${-66 + by * 1.5} 80,${-54 + by * 1.5} L76,${-42 + by * 1.5} C64,${-50 + by * 1.5} 42,${-50 + by * 1.5} 28,${-40 + by * 1.5} Z" fill="${C.ink}"/>`);
  // nose + blush
  s += S(`<ellipse cx="34" cy="44" rx="17" ry="10" fill="${C.blush}" opacity="0.75"/>`);
  s += M(`<path d="M70,6 C76,-4 92,2 104,16 C116,30 112,46 96,48 C80,50 68,40 66,26 C65,18 66,12 70,6 Z" fill="${C.nose}"/>`);
  // mouth
  if (o.mouth === 'open') {
    s += S(`<path d="M18,58 C36,62 62,60 76,52 C74,78 58,90 44,88 C28,86 18,72 18,58 Z" fill="${C.mouth}"/>` +
      `<path d="M30,80 C38,72 56,72 64,78 C58,88 40,90 30,80 Z" fill="${C.tongue}"/>`);
  } else if (o.mouth === 'o') {
    s += S(`<ellipse cx="50" cy="68" rx="12" ry="14" fill="${C.mouth}"/><ellipse cx="50" cy="75" rx="8" ry="5" fill="${C.tongue}"/>`);
  } else {
    s += S(`<path d="M24,64 C40,72 60,70 72,58 L74,64 C60,78 38,80 22,70 Z" fill="${C.mouth}"/>`);
  }
  return s;
}

function hoodieTorso() {
  let s = '';
  s += P(`<path d="M236,508 C246,476 290,458 336,456 L378,456 C424,458 456,478 466,512 L480,712 L220,712 Z" fill="${C.teal}"/>`);
  // hood (behind neck) + V
  s += M(`<path d="M270,506 C262,458 300,432 348,432 C398,432 436,458 430,506 L398,526 L300,526 Z" fill="${C.tealD}"/>`);
  s += S(`<path d="M318,470 L384,470 L352,520 Z" fill="${C.skinD}"/>`);
  s += M(`<path d="M300,470 C312,500 330,520 352,526 C330,534 300,520 290,500 Z M404,470 C394,500 376,520 352,526 C374,534 404,520 414,500 Z" fill="${C.teal}"/>`);
  // drawstrings
  s += S(`<path d="M327,512 L321,598 L331,598 L335,512 Z M371,512 L377,602 L387,602 L379,512 Z" fill="${C.cream}"/>` +
    `<circle cx="331" cy="514" r="6" fill="${C.greyL}"/><circle cx="375" cy="514" r="6" fill="${C.greyL}"/>`);
  // pocket top (rest hidden by table) + stitches
  s += M(`<path d="M282,606 L428,606 L452,700 L258,700 Z" fill="${C.tealD}"/>`);
  s += `<path d="M290,616 L420,616 M246,520 L262,700 M456,520 L470,700" stroke="#C9F2E6" stroke-opacity="0.55" stroke-width="2.5" stroke-dasharray="7 6" fill="none"/>`;
  return s;
}

function interviewerLegs() {
  let s = '';
  s += M(`<rect x="436" y="720" width="50" height="232" fill="#2E3136"/>`);
  s += M(`<rect x="488" y="720" width="54" height="232" fill="${C.denim}"/>`);
  s += S(`<rect x="432" y="928" width="58" height="26" rx="4" fill="${C.denimL}"/><rect x="484" y="928" width="62" height="26" rx="4" fill="${C.denimL}"/>`);
  s += sneaker(432, 996, 1, C.teal, 0.98) + sneaker(486, 1000, 1, C.teal, 1.04);
  return s;
}

function sleeve(sx, sy, hx, hy, L, side) {
  // teal sleeve strip + cream inner cuff at the wrist; returns svg and wrist direction
  const n = noodle(sx, sy, hx, hy, L, side, 62, 50, C.teal);
  const a = n.endA, ca = Math.cos(a), sa = Math.sin(a);
  const cuff = `<path d="M${pt(hx - sa * 27 - ca * 4, hy + ca * 27 - sa * 4)} L${pt(hx + sa * 27 - ca * 4, hy - ca * 27 - sa * 4)} L${pt(hx + sa * 23 + ca * 12, hy - ca * 23 + sa * 12)} L${pt(hx - sa * 23 + ca * 12, hy + ca * 23 + sa * 12)} Z" fill="${C.cream}"/>`;
  const stitch = `<path d="M${pt(hx - sa * 22 - ca * 14, hy + ca * 22 - sa * 14)} L${pt(hx + sa * 22 - ca * 14, hy - ca * 22 - sa * 14)}" stroke="#C9F2E6" stroke-opacity="0.6" stroke-width="2.5" stroke-dasharray="6 5"/>`;
  return { svg: M(n.svg) + stitch + S(cuff), a };
}

function interviewer(st) {
  // st: {breath, look, blink, mouth, browUp, card:{x,y,r,s,num,stripe}, backHandDY}
  const by = st.breath;
  const parts = {};
  // torso + head
  let body = M(noodle(250, 524, 214, 720, 210, 1, 62, 54, C.teal).svg) + hoodieTorso();
  body += g(`translate(347,${f1(328 + by * 0.6)}) rotate(${f1(st.headTilt || 0)})`, head(st));
  parts.body = g(`translate(${f1(boil(1, 0.6))},${f1(by + IY)})`, body);
  // back (left) arm: hangs along the body, lower part hidden by the table
  parts.backArm = '';
  // front arm holding card: hand at bottom-left of the card
  const c = st.card, rr = c.r * Math.PI / 180;
  const lx = -66 * c.s, ly = 122 * c.s - 4;
  const hx = c.x + lx * Math.cos(rr) - ly * Math.sin(rr), hy = c.y + lx * Math.sin(rr) + ly * Math.cos(rr);
  const fa = sleeve(448, 514 + by + IY, hx - 6, hy + 34, 200, 1);
  parts.frontArmBehind = fa.svg +
    M(`<path d="M${f1(hx - 30)},${f1(hy + 30)} C${f1(hx - 34)},${f1(hy - 6)} ${f1(hx - 10)},${f1(hy - 20)} ${f1(hx + 22)},${f1(hy - 16)} C${f1(hx + 40)},${f1(hy - 8)} ${f1(hx + 36)},${f1(hy + 28)} ${f1(hx + 14)},${f1(hy + 40)} Z" fill="${C.skin}"/>`);
  parts.card = g(`translate(${f1(c.x)},${f1(c.y)}) rotate(${f1(c.r)}) scale(${f1(c.s * 100) / 100})`, bigCard(c.num, c.stripe));
  parts.thumb = S(`<path d="M${pt(hx - 10, hy + 6)} C${pt(hx - 14, hy - 18)} ${pt(hx - 2, hy - 30)} ${pt(hx + 10, hy - 26)} C${pt(hx + 20, hy - 20)} ${pt(hx + 16, hy - 2)} ${pt(hx + 8, hy + 8)} Z" fill="${C.skin}"/>`);
  return parts;
}

// ---------- whiteboard ----------
const BOARD = { x: 958, y: 372, w: 476, h: 330 };
const LINES = [ // board-local
  { x: 58, y: 96, len: 212, seed: 3 },
  { x: 98, y: 168, len: 170, seed: 8 },
  { x: 98, y: 240, len: 128, seed: 15 },
];
const CHECK = { x: 352, y: 214 };

function checkMark(color, sc, pos = CHECK) {
  return g(`translate(${pos.x},${pos.y}) scale(${f1(sc * 100) / 100}) rotate(-6)`,
    M(`<path d="M-58,-4 L-34,-28 L-10,-4 L46,-70 L70,-46 L-10,40 Z" fill="${color}"/>`));
}

function board(st) {
  // st: {dx, sx (flip scale), lines:[p0,p1,p2], check, checkColor, wipeX (local; content right of it survives), tray:'sponge'|'marker'|'both', capColor}
  const X = BOARD.x + st.dx, Y = BOARD.y, W = BOARD.w, H = BOARD.h;
  let s = '';
  // stand: legs, crossbar, wheels
  s += M(`<path d="M${X + 48},${Y + H - 10} L${X + 66},${Y + H - 10} L${X + 40},986 L${X + 24},986 Z M${X + W - 66},${Y + H - 10} L${X + W - 48},${Y + H - 10} L${X + W - 24},986 L${X + W - 40},986 Z" fill="${C.greyD}"/>`);
  s += M(`<rect x="${X + 36}" y="900" width="${W - 72}" height="16" rx="5" fill="${C.greyD}"/>`);
  s += S(`<circle cx="${X + 32}" cy="986" r="15" fill="#3B3F44"/><circle cx="${X + W - 32}" cy="986" r="15" fill="#3B3F44"/>` +
    `<circle cx="${X + 32}" cy="986" r="5" fill="${C.greyL}"/><circle cx="${X + W - 32}" cy="986" r="5" fill="${C.greyL}"/>`);
  // panel (flips around vertical centre)
  let p = '';
  p += P(`<rect x="0" y="0" width="${W}" height="${H}" rx="10" fill="${C.greyL}"/>`);
  p += PP(`<rect x="16" y="16" width="${W - 32}" height="${H - 32}" rx="4" fill="${st.sx < 0.2 ? C.creamD : C.cream}"/>`);
  if (st.sx >= 0.2) {
    // content
    const id = 'c' + (UID++);
    const wipe = st.wipeX == null ? -100 : st.wipeX;
    let content = '';
    LINES.forEach((L, i) => {
      const pr = st.lines[i] || 0;
      if (pr <= 0) return;
      const cid = id + 'l' + i;
      content += `<clipPath id="${cid}"><rect x="${Math.max(L.x - 30, wipe)}" y="${L.y - 40}" width="${Math.max(0, L.x - 30 + (L.len + 40) * pr - Math.max(L.x - 30, wipe))}" height="80"/></clipPath>`;
      content += `<g clip-path="url(#${cid})">` + M(`<path d="${scribble(L.x, L.y, L.len, L.seed)}" stroke="#26262A" stroke-width="9" fill="none" stroke-linecap="round" stroke-linejoin="round"/>`) + `</g>`;
    });
    const cpos = st.checkPos || CHECK;
    if (st.check > 0 && wipe < cpos.x + 40) content += checkMark(st.checkColor, st.check, cpos);
    p += content;
  }
  // tray
  p += M(`<rect x="22" y="${H - 4}" width="${W - 44}" height="18" rx="4" fill="${C.greyM}"/>`);
  if (st.tray === 'sponge' || st.tray === 'both') p += sponge(W - 110, H - 22, 0);
  if (st.tray === 'marker' || st.tray === 'both') p += marker(W - 210, H - 12, 0, st.capColor);
  s += g(`translate(${f1(X + W / 2)},${Y}) scale(${f1(Math.max(st.sx, 0.04) * 100) / 100},1) translate(${-W / 2},0)`, p);
  return s;
}

function sponge(x, y, rot) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(rot)})`,
    M(`<rect x="-46" y="-26" width="92" height="44" rx="9" fill="${C.amber}"/>`) +
    S(`<rect x="-46" y="10" width="92" height="14" rx="5" fill="${C.greyD}"/>` +
      `<circle cx="-26" cy="-12" r="4" fill="${C.amberD}"/><circle cx="-4" cy="-4" r="5" fill="${C.amberD}"/><circle cx="20" cy="-14" r="3.5" fill="${C.amberD}"/><circle cx="30" cy="0" r="4" fill="${C.amberD}"/>`));
}
function marker(x, y, rot, cap) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(rot)})`,
    S(`<rect x="-34" y="-9" width="56" height="18" rx="6" fill="#2F3237"/><rect x="18" y="-10" width="26" height="20" rx="6" fill="${cap}"/><path d="M-34,-6 L-46,0 L-34,6 Z" fill="#2F3237"/>`));
}

// ---------- CPU candidate ----------
function cpu(st) {
  // st: {x,y (body centre), hand:[x,y] right-hand target (world), hold:'marker'|'sponge'|null, cap, mood:'happy'|'worried', look:[dx,dy],
  //      blink, leftHand:[x,y] (world) or null, glassesDY, sweat:{x,y,s} local or null, legsHop}
  const cx = st.x, cy = st.y;
  let s = '';
  const legY = cy + 128, footY = 996;
  // legs
  s += M(capsule(cx - 48, legY, cx - 62, footY - 26, 20, 18, C.limb) + capsule(cx + 48, legY, cx + 62, footY - 26, 20, 18, C.limb));
  s += sneaker(cx - 34, footY, -1, C.amber, 0.82) + sneaker(cx + 34, footY, 1, C.amber, 0.82);
  // left arm (rubber-hose paper strip)
  const lsx = cx - 124, lsy = cy - 18;
  const lh = st.leftHand || [cx - 150, cy + 140];
  const ln = noodle(lsx, lsy, lh[0], lh[1], st.leftL || 220, st.leftSide || 1, 19, 16, C.limb);
  const lk = { hx: lh[0], hy: lh[1] };
  const leftArm = M(ln.svg) +
    S(`<circle cx="${f1(lk.hx)}" cy="${f1(lk.hy)}" r="22" fill="${C.white}"/><ellipse cx="${f1(lk.hx + 12)}" cy="${f1(lk.hy - 12)}" rx="10" ry="8" fill="${C.white}"/>`);
  // right arm
  const rsx = cx + 124, rsy = cy - 18;
  const rh = st.hand || [cx + 160, cy + 130];
  const rn = noodle(rsx, rsy, rh[0], rh[1], 285, st.rightSide || 1, 19, 16, C.limb);
  const rk = { hx: rh[0], hy: rh[1] };
  let rightArm = M(rn.svg);
  let held = '';
  if (st.hold === 'marker') held = marker(rk.hx + 10, rk.hy - 14, -40, st.cap);
  if (st.hold === 'sponge') held = sponge(rk.hx + 6, rk.hy - 14, -10);
  rightArm += held + S(`<circle cx="${f1(rk.hx)}" cy="${f1(rk.hy)}" r="22" fill="${C.white}"/><ellipse cx="${f1(rk.hx - 13)}" cy="${f1(rk.hy - 12)}" rx="10" ry="8" fill="${C.white}"/>`);
  if (!st.leftFront) s += leftArm;
  // pins
  let pins = '';
  for (const py of [-104, -68, 26, 62, 98]) {
    pins += `<rect x="${cx - 156}" y="${cy + py - 10}" width="34" height="20" rx="3" fill="${C.amber}"/>`;
    pins += `<rect x="${cx + 122}" y="${cy + py - 10}" width="34" height="20" rx="3" fill="${C.amber}"/>`;
  }
  s += M(pins);
  // body
  s += P(`<rect x="${cx - 134}" y="${cy - 134}" width="268" height="268" rx="20" fill="${C.slate}"/>`);
  s += M(`<rect x="${cx - 116}" y="${cy - 116}" width="232" height="232" rx="14" fill="${C.slateL}"/>`);
  s += S(`<circle cx="${cx - 100}" cy="${cy - 100}" r="7" fill="${C.amber}"/>`);
  s += INK(text(cx + 70, cy + 108, 'CPU', 26, C.cream));
  // face plate
  s += PP(`<rect x="${cx - 98}" y="${cy - 100}" width="196" height="178" rx="18" fill="${C.cream}"/>`);
  // face
  const L = st.look || [0, 0];
  const ey = cy - 30;
  const gy = ey + (st.glassesDY || 0);
  let face = '';
  if (st.blink) {
    face += S(`<path d="M${cx - 66},${ey} Q${cx - 44},${ey + 12} ${cx - 22},${ey} L${cx - 22},${ey + 5} Q${cx - 44},${ey + 17} ${cx - 66},${ey + 5} Z M${cx + 22},${ey} Q${cx + 44},${ey + 12} ${cx + 66},${ey} L${cx + 66},${ey + 5} Q${cx + 44},${ey + 17} ${cx + 22},${ey + 5} Z" fill="${C.ink}"/>`);
  } else {
    face += S(`<circle cx="${cx - 44}" cy="${ey}" r="30" fill="#fff"/><circle cx="${cx + 44}" cy="${ey}" r="30" fill="#fff"/>`);
    face += S(`<circle cx="${f1(cx - 44 + L[0])}" cy="${f1(ey + L[1])}" r="14" fill="${C.ink}"/><circle cx="${f1(cx + 44 + L[0])}" cy="${f1(ey + L[1])}" r="14" fill="${C.ink}"/>` +
      `<circle cx="${f1(cx - 39 + L[0])}" cy="${f1(ey - 5 + L[1])}" r="4.5" fill="#fff"/><circle cx="${f1(cx + 49 + L[0])}" cy="${f1(ey - 5 + L[1])}" r="4.5" fill="#fff"/>`);
  }
  // glasses (square-ish, chip-like)
  face += S(`<rect x="${cx - 82}" y="${gy - 36}" width="76" height="72" rx="16" fill="none" stroke="${C.ink}" stroke-width="8"/>` +
    `<rect x="${cx + 6}" y="${gy - 36}" width="76" height="72" rx="16" fill="none" stroke="${C.ink}" stroke-width="8"/>` +
    `<rect x="${cx - 8}" y="${gy - 8}" width="16" height="8" fill="${C.ink}"/>`);
  // brows
  if (st.mood === 'worried') {
    face += S(`<path d="M${cx - 78},${gy - 52} L${cx - 26},${gy - 66} L${cx - 24},${gy - 56} L${cx - 76},${gy - 42} Z M${cx + 78},${gy - 52} L${cx + 26},${gy - 66} L${cx + 24},${gy - 56} L${cx + 76},${gy - 42} Z" fill="${C.ink}"/>`);
    // wobbly worried mouth
    face += S(`<path d="M${cx - 34},${cy + 50} C${cx - 20},${cy + 30} ${cx + 20},${cy + 30} ${cx + 34},${cy + 50} C${cx + 22},${cy + 44} ${cx - 22},${cy + 44} ${cx - 34},${cy + 50} Z" fill="${C.mouth}"/>` +
      `<path d="M${cx - 30},${cy + 54} q8,-8 16,0 q8,-8 16,0 q8,-8 16,0 q8,-8 14,0" stroke="${C.ink}" stroke-width="5" fill="none" stroke-linecap="round"/>`);
  } else {
    face += S(`<path d="M${cx - 76},${gy - 50} Q${cx - 50},${gy - 70} ${cx - 22},${gy - 56} L${cx - 24},${gy - 46} Q${cx - 50},${gy - 58} ${cx - 74},${gy - 40} Z M${cx + 76},${gy - 50} Q${cx + 50},${gy - 70} ${cx + 22},${gy - 56} L${cx + 24},${gy - 46} Q${cx + 50},${gy - 58} ${cx + 74},${gy - 40} Z" fill="${C.ink}"/>`);
    face += S(`<path d="M${cx - 44},${cy + 26} C${cx - 20},${cy + 34} ${cx + 20},${cy + 34} ${cx + 44},${cy + 26} C${cx + 40},${cy + 60} ${cx + 18},${cy + 70} ${cx},${cy + 70} C${cx - 18},${cy + 70} ${cx - 40},${cy + 60} ${cx - 44},${cy + 26} Z" fill="${C.mouth}"/>` +
      `<path d="M${cx - 20},${cy + 62} C${cx - 10},${cy + 50} ${cx + 12},${cy + 50} ${cx + 22},${cy + 62} C${cx + 12},${cy + 70} ${cx - 10},${cy + 70} ${cx - 20},${cy + 62} Z" fill="${C.tongue}"/>`);
  }
  s += face;
  if (st.sweat) {
    const w = st.sweat;
    s += g(`translate(${f1(cx + w.x)},${f1(cy + w.y)}) scale(${w.s})`, S(`<path d="M0,-30 C10,-14 20,0 20,12 C20,26 10,34 0,34 C-10,34 -20,26 -20,12 C-20,0 -10,-14 0,-30 Z" fill="${C.sweat}"/><ellipse cx="-7" cy="12" rx="4" ry="8" fill="#fff"/>`));
  }
  if (st.leftFront) s += leftArm;
  s += rightArm;
  return g(`translate(${f1(boil(2, 0.7))},${f1(boil(3, 0.7) + (st.hop || 0))})`, s);
}

// ---------- effects ----------
function sparkles(x, y, dir, sc, color) {
  // three short tapered dashes radiating (like the courier / boxers memes)
  const out = [[-34, 0, 34], [0, 0, 40], [34, 0, 34]];
  let s = '';
  [[-40, 52], [0, 60], [40, 52]].forEach((v, i) => {
    const a = (dir * (-55 + i * 30)) * Math.PI / 180;
    const r0 = 26, r1 = 26 + v[1] * sc;
    const x0 = x + Math.sin(a) * r0, y0 = y - Math.cos(a) * r0, x1 = x + Math.sin(a) * r1, y1 = y - Math.cos(a) * r1;
    s += capsule(x0, y0, x1, y1, 7, 13, color);
  });
  return S(s);
}
function qmark(x, y, size, rot, color) {
  return g(`translate(${f1(x)},${f1(y)}) rotate(${f1(rot)})`, M(text(0, 0, '?', size, color, 'middle', ` stroke="${C.pinkD}" stroke-width="2"`)));
}
function bubble(x, y, sc, dots) {
  let s = '';
  const cl = [[0, 0, 64], [-70, 12, 46], [66, 14, 48], [-34, -36, 44], [34, -38, 46], [0, 36, 46], [-56, 38, 32], [58, 38, 32]];
  let cloud = cl.map(c => `<circle cx="${c[0]}" cy="${c[1]}" r="${c[2]}" fill="${C.cream}"/>`).join('');
  s += P(cloud);
  s += S(`<circle cx="-92" cy="96" r="18" fill="${C.cream}"/>`) + S(`<circle cx="-118" cy="134" r="11" fill="${C.cream}"/>`);
  let d = '';
  for (let i = 0; i < dots; i++) d += `<circle cx="${-40 + i * 40}" cy="6" r="11" fill="${C.ink}"/>`;
  if (d) s += S(d);
  return g(`translate(${f1(x)},${f1(y)}) scale(${f1(sc * 100) / 100})`, s);
}

// ---------- scene A: benchmark ----------
function sceneA(tp) {
  const T = 6;
  const out = [];
  const tb = table();
  const breath = Math.sin(2 * Math.PI * tp / 2) * 2.5;

  // card
  let card = { ...HELD };
  if (tp >= 4.5 && tp < 5.0) { const u = ease(seg(tp, 4.5, 4.92)); card = mixCard(HELD, ONSTACK, u); }
  else if (tp >= 5.0 && tp < 5.58) card = { ...ONSTACK };
  else if (tp >= 5.58) { const u = ease(seg(tp, 5.58, 6.0)); card = mixCard(ONSTACK, HELD, u); }
  if (tp < 0.26) card.r = [-8, -3.5, -5.5][Math.floor(tp * 12)] ?? -5;   // little "present!" settle
  card.r += boil(5, 0.35);
  card.num = '1'; card.stripe = C.teal;

  // board motion (control): flip+slide right 3.25..3.5, back 5.0..5.25
  const fl = [0.55, 0.08, 0.55, 1], dxs = [26, 56, 86, 110], dxb = [86, 56, 26, 0];
  let bdx = 0, bsx = 1, phase = 0;
  const pi = Math.round(tp * 12);
  if (pi >= 39 && pi <= 42) { bsx = fl[pi - 39]; bdx = dxs[pi - 39]; }
  else if (pi > 42 && pi < 60) bdx = 110;
  else if (pi >= 60 && pi <= 63) { bsx = fl[pi - 60]; bdx = dxb[pi - 60]; }
  // sticker flip A->Б at 3.0..3.25, back at 5.25..5.5
  let sl = 'А', ssy = 1;
  const sf = [0.55, 0.06, 0.55];
  if (pi >= 36 && pi <= 38) { ssy = sf[pi - 36]; sl = pi < 37 ? 'А' : 'Б'; if (pi === 38) sl = 'Б'; }
  else if (pi > 38 && pi < 63) sl = 'Б';
  else if (pi >= 63 && pi <= 65) { ssy = sf[pi - 63]; sl = pi === 63 ? 'Б' : 'А'; }

  // writing progress
  const W1 = [1.5, 1.75, 2.0, 2.25], W2 = [3.583, 3.833, 4.083, 4.333];
  let lines = [0, 0, 0], check = 0, wipeX = null, content = 0;
  const writeAt = (Wt) => {
    const ls = [0, 1, 2].map(i => seg(tp + 1e-6, Wt[i] - 0.001, Wt[i + 1] - 0.0833));
    return ls;
  };
  let writing = -1; // index of line being written
  if (tp >= 1.5 && tp < 3.333) {
    lines = writeAt(W1);
    if (tp >= 2.25) { const k = Math.round((tp - 2.25) * 12); check = [0.55, 1.18, 1.0][Math.min(k, 2)]; }
  }
  if (tp >= 3.583 && tp < 5.0) {
    lines = writeAt(W2);
    if (tp >= 4.333) { const k = Math.round((tp - 4.333) * 12); check = [0.55, 1.18, 1.0][Math.min(k, 2)]; }
  }
  if (pi === 40) { lines = [0, 0, 0]; check = 0; } // flipped: clean side
  if (pi === 39) { lines = [1, 1, 1]; check = 1; }
  // wipe 4.5..5.0 (sponge sweeps left->right)
  let spongePos = null;
  const wipePath = [[40, 80], [120, 250], [200, 90], [280, 250], [360, 110], [430, 240]];
  if (pi >= 54 && pi < 60) {
    const k = pi - 54; const wp = wipePath[k];
    wipeX = wp[0] + 30;
    spongePos = [BOARD.x + bdx + wp[0], BOARD.y + wp[1]];
  }
  if (pi >= 60) { lines = [0, 0, 0]; check = 0; }

  // CPU state
  const cpuX = 868 + bdx, cpuY = 652;
  let hop = 0;
  if ((pi >= 39 && pi <= 42) || (pi >= 60 && pi <= 63)) hop = [-16, -6, -18, -4][(pi >= 60 ? pi - 60 : pi - 39)];
  const bx = BOARD.x + bdx, byy = BOARD.y;
  let hand = [cpuX + 196, cpuY - 98], hold = 'marker', look = [-9, -2], leftHand = null, glassesDY = 0, leftFront = false;
  let mood = 'happy', blink = false;
  // writing hand follows the line head
  const wr = (lw) => {
    for (let i = 0; i < 3; i++) if (lw[i] > 0 && lw[i] < 1) return i;
    return -1;
  };
  const wi = wr(lines);
  if ((tp >= 1.5 && tp < 2.25) || (tp >= 3.583 && tp < 4.333)) {
    const i = wi >= 0 ? wi : (lines[2] >= 1 ? 2 : 0);
    const L = LINES[i]; const pr = lines[i];
    hand = [bx + L.x + L.len * pr + 10, byy + L.y + 18];
    look = [10, -6];
  } else if ((tp >= 2.25 && tp < 2.5) || (tp >= 4.333 && tp < 4.5)) {
    hand = [bx + CHECK.x - 20, byy + CHECK.y + 30]; look = [10, -2];
  } else if (tp >= 2.5 && tp < 3.0) {
    // adjust glasses with left hand, look at the audience
    hand = [cpuX + 204, cpuY - 70];
    leftHand = [cpuX - 4, cpuY - 40]; leftFront = true; glassesDY = (pi % 2 === 0) ? -5 : -2; look = [0, 0];
  } else if (tp >= 3.0 && tp < 3.583) {
    look = [-10, 6]; hand = [cpuX + 196, cpuY - 98];
  } else if (tp >= 4.5 && tp < 5.0) {
    hold = 'sponge'; hand = spongePos ? [spongePos[0] - 6, spongePos[1] + 16] : hand; look = [10, -4];
  } else if (tp >= 5.0) {
    look = [-9, -2];
  }
  if (pi === 25 || pi === 70) blink = true;
  // left hand on hip otherwise
  if (!leftHand) leftHand = [cpuX - 132, cpuY + 58];
  const tray = hold === 'sponge' ? 'marker' : 'sponge';

  // sparkles of confidence
  let fx = '';
  if (tp >= 2.41 && tp < 3.17) {
    const k = Math.round((tp - 2.4167) * 12) % 2;
    fx += sparkles(cpuX - 150, cpuY - 130, -1, k ? 1.0 : 0.85, C.cream) + sparkles(cpuX + 150, cpuY - 130, 1, k ? 0.85 : 1.0, C.cream);
  }
  if (tp >= 4.33 && tp < 4.75) {
    const k = Math.floor((tp - 4.33) * 12) % 2;
    fx += sparkles(cpuX - 150, cpuY - 130, -1, k ? 1.0 : 0.85, C.cream) + sparkles(cpuX + 150, cpuY - 130, 1, k ? 0.85 : 1.0, C.cream);
  }

  // interviewer
  const iv = interviewer({
    breath, mouth: 'open', blink: pi === 22 || pi === 64,
    look: (tp >= 3.0 && tp < 3.6) ? [9, 3] : [8, 1],
    card, backHandDY: 0, headTilt: Math.sin(2 * Math.PI * tp / 3) * 1.2,
  });

  out.push(board({ dx: bdx, sx: bsx, lines, check, checkColor: C.teal, wipeX, tray, capColor: C.teal }));
  out.push(g(`translate(${LEFT_DX},0)`, [chair(), interviewerLegs(), tb.back, iv.body, tb.front, stack(['1', '1', '1'], C.teal),
    iv.backArm, sticker(sl, ssy), iv.frontArmBehind, iv.card, iv.thumb].join('')));
  out.push(cpu({ x: cpuX, y: cpuY, hand, hold, cap: C.teal, mood, look, blink, leftHand, leftFront, glassesDY, hop, leftBend: -1 }));
  out.push(fx);
  return out.join('\n');
}

// card travels along an arc that passes right of the interviewer's face (control point low-right)
function mixCard(a, b, u) {
  const qx = 600, qy = 640, v = 1 - u;
  return { x: v * v * a.x + 2 * v * u * qx + u * u * b.x, y: v * v * a.y + 2 * v * u * qy + u * u * b.y, r: lerp(a.r, b.r, u), s: lerp(a.s, b.s, u) };
}

// ---------- scene B: user ----------
function sceneB(tp) {
  const out = [];
  const tb = table();
  const pi = Math.round(tp * 12);
  const breath = Math.sin(2 * Math.PI * tp / 2.5) * 2.5;

  // card: held; 4.5..4.75 dips to the stack, 4.75..5 comes back up (draws "the next" task)
  let card = { ...HELD };
  if (pi >= 54 && pi <= 59) {
    const u = [0.35, 0.75, 0.95, 0.7, 0.35, 0.1][pi - 54];
    card = mixCard(HELD, ONSTACK, u);
  }
  if (pi < 3) card.r = [-8, -3.5, -5.5][pi];
  card.r += boil(5, 0.35);
  card.num = '12'; card.stripe = C.pink;

  // thinking 1.5..3.5
  const thinking = tp >= 1.5 && tp < 3.5;
  let look = [-9, -2];
  if (thinking) look = [[12, -4], [12, -4], [12, -4], [-8, 2], [-8, 2], [-8, 2]][pi % 6];
  // hand with marker: ready near board, trembling while thinking
  const cpuX = 868, cpuY = 652;
  const bx = BOARD.x, byy = BOARD.y;
  let hand = [cpuX + 196, cpuY - 92];
  if (thinking) hand = [hand[0] + boil(41, 6), hand[1] + boil(42, 5)];
  // one line slowly 3.5..4.25 (+ hesitation), small pink check 4.17..4.5
  let lines = [0, 0, 0], check = 0, wipeX = null, hold = 'marker';
  const lineLen = 0.62;  // fraction of LINES[0]
  if (tp >= 3.5 && tp < 4.5) {
    const steps = [0.1, 0.2, 0.28, 0.28, 0.4, 0.52, 0.62, 0.7, 0.78, 0.78, 0.78, 0.78];
    lines[0] = steps[Math.min(pi - 42, 11)] / 1.0;
    const L = LINES[0];
    if (tp < 4.25) hand = [bx + L.x + L.len * lines[0] + 10, byy + L.y + 18];
    else hand = [bx + 282, byy + 196];
    look = [10, -6];
    if (pi >= 50) check = [0.2, 0.32, 0.44, 0.52][Math.min(pi - 50, 3)];
  }
  // quick wipe 4.5..4.83
  if (pi >= 54 && pi <= 57) {
    lines[0] = 0.78; check = 0.52;
    const wp = [[40, 90], [150, 110], [260, 100], [380, 120]][pi - 54];
    wipeX = wp[0] + 30; hold = 'sponge';
    hand = [bx + wp[0] - 6, byy + wp[1] + 16];
    look = [10, -4];
  }
  // scale lines[0] so the visible line is shorter than A's (one modest line)
  const linesDraw = [lines[0], 0, 0];

  // sweat drop: sits 0..1.5, slides 1.5..3.5, falls, new one grows 4.58..5
  let sweat = null;
  if (tp < 1.5) sweat = { x: 112, y: -112 + boil(51, 1.5), s: 1 };
  else if (tp < 3.5) { const u = seg(tp, 1.5, 3.42); sweat = { x: 112 + u * 26, y: -112 + u * 150, s: 1 }; }
  else if (pi >= 55) sweat = { x: 112, y: -112, s: [0.35, 0.5, 0.65, 0.8, 0.9][Math.min(pi - 55, 4)] };
  // second, smaller static drop on the left for the poster read
  // question marks (bobbing)
  const bob = (pi % 12) < 6 ? 0 : 1;
  let fx = '';
  fx += qmark(cpuX - 118, cpuY - 168 - bob * 8, 112, -14, C.pink);
  fx += qmark(cpuX - 34, cpuY - 196 - (1 - bob) * 8, 84, 8, C.pink);
  // thought bubble with "..."
  if (thinking) {
    const k = pi - 18;
    const sc = k === 0 ? 0.6 : (pi >= 41 ? 0.7 : 1);
    const dots = k < 2 ? 0 : (k < 7 ? 1 : (k < 12 ? 2 : 3));
    fx += bubble(cpuX + 150, cpuY - 360, sc, dots);
  }
  const iv = interviewer({
    breath, mouth: 'o', blink: pi === 20 || pi === 47, browUp: true,
    look: [8, 2], card,
    backHandDY: (thinking && pi % 3 === 0) ? -10 : 0,
    headTilt: Math.sin(2 * Math.PI * tp / 2.5) * 1.2,
  });
  const tray = hold === 'sponge' ? 'marker' : 'sponge';
  out.push(board({ dx: 0, sx: 1, lines: linesDraw, check, checkColor: C.pink, checkPos: { x: 300, y: 112 }, wipeX, tray, capColor: C.pink }));
  out.push(g(`translate(${LEFT_DX},0)`, [chair(), interviewerLegs(), tb.back, iv.body, tb.front, stack(['7', '31', '16'], C.pink),
    iv.backArm, sticker('А', 1), iv.frontArmBehind, iv.card, iv.thumb].join('')));
  out.push(cpu({ x: cpuX + (thinking ? boil(61, 1.5) : 0), y: cpuY, hand, hold, cap: C.pink, mood: 'worried', look, blink: pi === 8, leftHand: [cpuX - 150, cpuY + 120], sweat, rightBend: 1 }));
  // small check for B drawn smaller: handled via checkMark scale (<=0.82)
  out.push(fx);
  return out.join('\n');
}

window.renderScene = function (scene, tp) {
  POSE = Math.round(tp * 12); UID = 0;
  document.getElementById('root').innerHTML = `<g transform="translate(${SCENE_DX},0)">` + (scene === 'A' ? sceneA(tp) : sceneB(tp)) + '</g>';
};
