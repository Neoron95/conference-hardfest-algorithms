// Paper cut-out scene renderer for slide 30, variant 1 "Выучил один билет".
// window.drawScene(scene, t) draws scene 'A' (benchmark, 6 s loop) or 'B' (user, 5 s loop) at time t.
(function () {
'use strict';
const W = 1640, H = 1120;
const C = {
  teal: '#46CDAE', tealD: '#2F9F86', tealM: '#3BB89B', tealL: '#8FE3CF',
  pink: '#E2489B', pinkD: '#B53379',
  amber: '#F2C14E', amberD: '#C9962E',
  cream: '#F3EBDD', creamD: '#DCCFB8', white: '#FBF6EC',
  grey: '#8F8F8F', greyD: '#6E6E6E',
  ink: '#1E1E21', char: '#2C2C30', char2: '#44474D',
  skin: '#F4B58C', skinD: '#DE9670', nose: '#E8673E', blush: '#F08C7E',
  kraft: '#C79A66', kraftL: '#DDB585', kraftD: '#A37446', kraftDD: '#7F5733',
  denim: '#34363B', denimL: '#5E6268',
  slate: '#59616B', slateD: '#474E57', slateL: '#727A85',
  mouth: '#5B1D27', tongue: '#EE6F8C', sweat: '#BFE4F2',
};
const FONT = "Montserrat, sans-serif";

// ---------- helpers ----------
const clamp = (x, a, b) => Math.max(a, Math.min(b, x));
const seg = (t, a, b) => clamp((t - a) / (b - a), 0, 1);
const sm = u => u * u * (3 - 2 * u);
const lerp = (a, b, u) => a + (b - a) * u;
const r1 = v => Math.round(v * 100) / 100;
function hash(n) { const x = Math.sin(n * 127.1 + 311.7) * 43758.5453; return (x - Math.floor(x)) * 2 - 1; }
function track(t, kf, ease = sm) {
  if (t <= kf[0][0]) return kf[0][1];
  for (let i = 0; i < kf.length - 1; i++) {
    const [t0, v0] = kf[i], [t1, v1] = kf[i + 1];
    if (t <= t1) {
      const u = ease((t - t0) / (t1 - t0));
      return Array.isArray(v0) ? v0.map((x, j) => lerp(x, v1[j], u)) : lerp(v0, v1, u);
    }
  }
  return kf[kf.length - 1][1];
}
const lin = u => u;
// paper piece: every group gets its own torn edge, grain, rim and drop shadow
const pp = (c, extra = '') => `<g filter="url(#pp)" ${extra}>${c}</g>`;
const pps = (c, extra = '') => `<g filter="url(#pps)" ${extra}>${c}</g>`;
const ink = (c, extra = '') => `<g filter="url(#ink)" ${extra}>${c}</g>`;
const G = (c, tr) => `<g transform="${tr}">${c}</g>`;
const path = (d, fill, extra = '') => `<path d="${d}" fill="${fill}" ${extra}/>`;
const rect = (x, y, w, h, rx, fill, extra = '') => `<rect x="${r1(x)}" y="${r1(y)}" width="${r1(w)}" height="${r1(h)}" rx="${rx}" fill="${fill}" ${extra}/>`;
const circ = (x, y, r, fill, extra = '') => `<circle cx="${r1(x)}" cy="${r1(y)}" r="${r1(r)}" fill="${fill}" ${extra}/>`;
const ell = (x, y, rx, ry, fill, extra = '') => `<ellipse cx="${r1(x)}" cy="${r1(y)}" rx="${r1(rx)}" ry="${r1(ry)}" fill="${fill}" ${extra}/>`;
const txt = (x, y, s, size, fill, anchor = 'middle', ls = 0, weight = 800) =>
  `<text x="${r1(x)}" y="${r1(y)}" font-family="${FONT}" font-weight="${weight}" font-size="${size}" fill="${fill}" text-anchor="${anchor}" letter-spacing="${ls}">${s}</text>`;
function limb(x1, y1, x2, y2, w, fill) {
  const dx = x2 - x1, dy = y2 - y1, L = Math.hypot(dx, dy), a = Math.atan2(dy, dx) * 180 / Math.PI;
  return G(rect(-w / 2, -w / 2, L + w, w, w / 2, fill), `translate(${r1(x1)},${r1(y1)}) rotate(${r1(a)})`);
}
// two-bone IK: returns elbow; bend=+1 elbow on clockwise side
function ik(S, Hh, L1, L2, bend) {
  let dx = Hh[0] - S[0], dy = Hh[1] - S[1];
  let d = Math.hypot(dx, dy);
  const dm = Math.min(d, L1 + L2 - 0.5);
  const a = Math.atan2(dy, dx);
  const ca = clamp((L1 * L1 + dm * dm - L2 * L2) / (2 * L1 * dm), -1, 1);
  const th = a + bend * Math.acos(ca);
  const E = [S[0] + L1 * Math.cos(th), S[1] + L1 * Math.sin(th)];
  const fa = Math.atan2(Hh[1] - E[1], Hh[0] - E[0]);
  const Wr = [E[0] + L2 * Math.cos(fa), E[1] + L2 * Math.sin(fa)];
  return { E, W: Wr, ua: th, fa };
}

// ---------- defs: paper filters ----------
const DEFS = `
<defs>
 <filter id="pp" x="-20%" y="-20%" width="140%" height="140%" color-interpolation-filters="sRGB">
  <feTurbulence type="fractalNoise" baseFrequency="0.035" numOctaves="2" seed="3" result="w"/>
  <feDisplacementMap in="SourceGraphic" in2="w" scale="4.5" xChannelSelector="R" yChannelSelector="G" result="d"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.45" numOctaves="1" seed="8" result="w2"/>
  <feDisplacementMap in="d" in2="w2" scale="2.4" xChannelSelector="G" yChannelSelector="R" result="s"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.32" numOctaves="3" seed="12" result="gf"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.02" numOctaves="2" seed="31" result="gc"/>
  <feComposite in="gf" in2="gc" operator="arithmetic" k1="0" k2="0.8" k3="0.2" k4="0" result="g0"/>
  <feColorMatrix in="g0" type="matrix" values="0.62 0.62 0.62 0 -0.43  0.62 0.62 0.62 0 -0.43  0.62 0.62 0.62 0 -0.43  0 0 0 0 1" result="g"/>
  <feBlend in="g" in2="s" mode="soft-light" result="tx"/>
  <feComposite in="tx" in2="s" operator="in" result="t1"/>
  <feMorphology in="s" operator="erode" radius="2.2" result="er"/>
  <feComposite in="s" in2="er" operator="out" result="rim"/>
  <feFlood flood-color="#FFF6E6" flood-opacity="0.32"/>
  <feComposite in2="rim" operator="in" result="rimc"/>
  <feMerge result="m"><feMergeNode in="t1"/><feMergeNode in="rimc"/></feMerge>
  <feDropShadow in="m" dx="2.5" dy="5" stdDeviation="4.5" flood-color="#000" flood-opacity="0.6"/>
 </filter>
 <filter id="pps" x="-30%" y="-30%" width="160%" height="160%" color-interpolation-filters="sRGB">
  <feTurbulence type="fractalNoise" baseFrequency="0.08" numOctaves="2" seed="5" result="w"/>
  <feDisplacementMap in="SourceGraphic" in2="w" scale="3" xChannelSelector="R" yChannelSelector="G" result="d"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.5" numOctaves="1" seed="9" result="w2"/>
  <feDisplacementMap in="d" in2="w2" scale="1.6" xChannelSelector="G" yChannelSelector="R" result="s"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.36" numOctaves="3" seed="14" result="g0"/>
  <feColorMatrix in="g0" type="matrix" values="0.55 0.55 0.55 0 -0.33  0.55 0.55 0.55 0 -0.33  0.55 0.55 0.55 0 -0.33  0 0 0 0 1" result="g"/>
  <feBlend in="g" in2="s" mode="soft-light" result="tx"/>
  <feComposite in="tx" in2="s" operator="in" result="t1"/>
  <feDropShadow in="t1" dx="1.5" dy="3" stdDeviation="2.5" flood-color="#000" flood-opacity="0.5"/>
 </filter>
 <filter id="ink" x="-10%" y="-25%" width="120%" height="150%" color-interpolation-filters="sRGB">
  <feTurbulence type="fractalNoise" baseFrequency="0.7" numOctaves="1" seed="4" result="w"/>
  <feDisplacementMap in="SourceGraphic" in2="w" scale="1.8" xChannelSelector="R" yChannelSelector="G" result="d"/>
  <feTurbulence type="fractalNoise" baseFrequency="0.9" numOctaves="2" seed="21" result="g0"/>
  <feColorMatrix in="g0" type="matrix" values="0 0 0 0 0  0 0 0 0 0  0 0 0 0 0  0 0 0 -1.6 1.55" result="holes"/>
  <feComposite in="d" in2="holes" operator="in"/>
 </filter>
</defs>`;

// ---------- props ----------
function door(label, flipSY) {
  const x = 1478, y = 168, w = 144, h = 882;
  let s = '';
  s += pp(rect(x - 14, y - 14, w + 28, h + 14, 4, '#3E3B39'));            // frame
  s += pp(rect(x, y, w, h, 3, '#6F6A65'));                                 // leaf
  s += pp(rect(x + 18, y + 300, w - 36, 250, 4, '#625D58'));               // panels
  s += pp(rect(x + 18, y + 590, w - 36, 262, 4, '#625D58'));
  s += pp(rect(x + 14, y + 420, 18, 70, 6, C.amberD) + circ(x + 23, y + 455, 13, C.amber)); // handle
  // sign plate (flips around its centre)
  const cx = x + w / 2, cy = y + 150;
  let plate = pp(rect(-76, -66, 152, 132, 8, C.cream)) +
    pps(circ(-60, -50, 4.5, C.greyD) + circ(60, -50, 4.5, C.greyD) + circ(-60, 50, 4.5, C.greyD) + circ(60, 50, 4.5, C.greyD)) +
    ink(txt(0, -16, 'ауд.', 36, C.ink, 'middle', 0.5) + txt(0, 48, label, 64, C.ink, 'middle', -1));
  s += G(plate, `translate(${cx},${cy}) scale(1,${r1(flipSY)})`);
  return s;
}

function examDesk() {
  let s = '';
  s += pp(rect(50, 700, 34, 352, 6, C.kraftDD)) + pp(rect(786, 700, 34, 352, 6, C.kraftDD)); // legs
  s += pp(rect(30, 664, 810, 50, 4, C.kraftD));       // apron
  s += pp(rect(16, 632, 838, 36, 6, C.kraft));        // top
  s += pps(rect(26, 634, 818, 8, 4, C.kraftL));       // lit edge
  return s;
}

function ticketTray() {
  // long tray that holds the fan of tickets
  const x = 432, y = 588, w = 396, h = 52;
  return pp(rect(x, y, w, h, 6, C.kraftD)) + pp(rect(x + 6, y + 4, w - 12, 10, 4, C.kraftDD)) +
    pp(rect(x + w / 2 - 82, y + 16, 164, 32, 4, C.cream)) +
    ink(txt(x + w / 2, y + 41, 'БИЛЕТЫ', 24, C.ink, 'middle', 3));
}

// ticket: local origin = grip point; body x -55..55, y -160..30
function ticket(label, accent, face, sx = 1) {
  let s = pp(rect(-55, -160, 110, 190, 6, C.cream));
  s += pps(rect(-55, -160, 110, 18, 4, accent));
  if (face) {
    s += ink(txt(0, -104, '№', 34, C.ink) + txt(0, -36, label, 72, C.ink, 'middle', -2));
    s += pps(rect(-36, -18, 72, 6, 3, C.creamD) + rect(-30, -6, 60, 6, 3, C.creamD));
  } else {
    s += ink(txt(-46, -114, '№', 28, C.ink, 'start') + txt(-49, -62, label, 50, C.ink, 'start', -2));
    s += pps(rect(-44, -42, 56, 6, 3, C.creamD) + rect(-44, -29, 42, 6, 3, C.creamD));
  }
  return sx === 1 ? s : G(s, `scale(${r1(sx)},1)`);
}

function studentDesk(cx) {
  // school desk with a modesty panel: slab top at y 780
  let s = '';
  s += pp(rect(cx - 122, 940, 20, 112, 5, C.kraftDD) + rect(cx + 102, 940, 20, 112, 5, C.kraftDD));
  s += pp(rect(cx - 128, 800, 256, 150, 5, C.kraftD));
  s += pps(rect(cx - 106, 830, 212, 8, 3, C.kraftDD, 'opacity="0.6"'));
  s += pp(rect(cx - 134, 776, 268, 30, 5, C.kraft));
  s += pps(rect(cx - 128, 778, 256, 7, 3, C.kraftL));
  return s;
}

// ---------- author (examiner) ----------
const AX = 216, AY = 440;              // neck base in world
const SHOULDER = [AX + 86, AY + 20];   // near (viewer-right) shoulder in world
const UL = 132, FL = 128;

function shoe(x, y, stripe) {
  let s = pp(path(`M${x - 44},${y} L${x - 44},${y - 26} Q${x - 40},${y - 42} ${x - 14},${y - 42} L${x + 4},${y - 38} Q${x + 22},${y - 26} ${x + 42},${y - 22} Q${x + 66},${y - 18} ${x + 66},${y - 2} L${x + 66},${y} Z`, C.white));
  s += pps(rect(x - 48, y - 10, 118, 16, 7, C.creamD));
  s += pps(path(`M${x - 18},${y - 36} L${x - 6},${y - 37} L${x + 16},${y - 12} L${x + 4},${y - 12} Z`, stripe) +
          path(`M${x - 2},${y - 33} L${x + 9},${y - 32} L${x + 30},${y - 12} L${x + 18},${y - 12} Z`, stripe));
  return s;
}

function authorHead(o) {
  let s = '';
  // ear
  s += pp(ell(-70, -106, 19, 25, C.skin) + ell(-72, -104, 9, 13, C.skinD));
  // face
  s += pp(path('M-58,-186 C-60,-214 -30,-216 0,-214 L50,-212 C76,-210 80,-188 80,-162 L82,-108 C84,-58 52,-40 20,-38 L-8,-38 C-44,-38 -60,-60 -60,-100 Z', C.skin));
  s += pps(circ(50, -92, 12, '#F7978A', 'opacity="0.5"'));
  // hair (spiky top + fringe)
  s += pp(path('M-60,-140 L-96,-150 L-82,-164 L-112,-186 L-86,-196 L-104,-230 L-70,-224 L-74,-262 L-38,-240 L-22,-276 L4,-246 L32,-274 L44,-238 L78,-252 L70,-218 L100,-212 L80,-190 L64,-192 L54,-170 L42,-188 L26,-172 L12,-192 L-4,-174 L-16,-194 L-30,-178 L-40,-160 L-48,-152 Z', C.char));
  s += pps(path('M-40,-206 L-58,-232 L-30,-222 L-16,-248 L0,-222 L22,-244 L26,-214 L-6,-200 Z', '#3B3B40'));
  // brows
  const by = -o.brow;
  s += pps(limb(-8, -166 + by, 22, -168 + by, 12, C.char) + limb(46, -170 + by, 80, -164 + by, 12, C.char));
  // glasses + eyes
  const eyes = [[8, -128, 27], [64, -126, 29]];
  let gl = '';
  for (const [ex, ey, er] of eyes) {
    gl += circ(ex, ey, er - 4, C.white);
  }
  s += pps(gl);
  if (o.blink) {
    s += pps(eyes.map(([ex, ey, er]) => rect(ex - er + 8, ey - 3, 2 * er - 16, 7, 3, C.char)).join(''));
  } else {
    const [lx, ly] = o.look;
    s += pps(eyes.map(([ex, ey]) => circ(ex + lx, ey + ly, 10.5, C.ink) + circ(ex + lx - 3, ey + ly - 4, 3.2, '#fff')).join(''));
  }
  s += pps(eyes.map(([ex, ey, er]) => `<circle cx="${ex}" cy="${ey}" r="${er}" fill="none" stroke="${C.char}" stroke-width="8"/>`).join('') +
    `<path d="M35,-130 Q36,-138 37,-130" fill="none" stroke="${C.char}" stroke-width="7"/>` +
    `<path d="M-19,-128 L-52,-120" stroke="${C.char}" stroke-width="7" stroke-linecap="round"/>`);
  // nose
  s += pp(G(ell(0, 0, 21, 15, C.nose), 'translate(88,-100) rotate(-12)'));
  // mouth
  if (o.mouth === 'open') {
    s += pps(path('M22,-74 Q44,-38 68,-76 Q46,-68 22,-74 Z', C.mouth) + ell(46, -56, 10, 6, C.tongue));
  } else if (o.mouth === 'o') {
    s += pps(ell(46, -64, 11, 13, C.mouth));
  } else {
    s += pps(`<path d="M24,-72 Q46,-54 68,-76" fill="none" stroke="${C.mouth}" stroke-width="6" stroke-linecap="round"/>`);
  }
  return s;
}

function authorBack(o) {
  let s = '';
  // legs
  s += pp(path('M-82,252 L-18,252 L-24,548 L-86,548 Z', C.denim));
  s += pp(path('M14,252 L84,252 L94,548 L30,548 Z', C.denim));
  s += pps(`<path d="M-70,330 Q-52,340 -36,332 M-66,350 Q-50,358 -34,352 M30,336 Q48,346 66,338 M34,356 Q52,364 70,356" fill="none" stroke="#24262A" stroke-width="4" stroke-linecap="round" opacity="0.8"/>`);
  s += pp(rect(-92, 528, 74, 28, 5, C.denimL)) + pp(rect(24, 528, 76, 28, 5, C.denimL));
  s += shoe(-58, 600, C.teal) + shoe(66, 600, C.teal);
  // far upper arm (behind torso)
  s += pp(limb(-88, 18, -120, 128, 60, C.tealM));
  // neck + hood back
  s += pp(rect(-22, -60, 44, 70, 10, C.skinD));
  s += pp(path('M-86,8 C-92,-40 -50,-58 -10,-50 C40,-58 92,-44 90,8 Z', C.tealD));
  // torso (breathing)
  const br = o.breath || 0;
  s += pp(path(`M-102,${-6 - br} C-60,${-26 - br} 60,${-26 - br} 102,${-6 - br} L114,250 L-112,250 Z`, C.teal));
  s += pps(path('M-104,40 C-98,110 -100,180 -108,236 L-90,236 C-84,170 -86,100 -94,30 Z', C.tealD, 'opacity="0.75"'));
  s += pps(path('M92,30 C88,100 90,170 98,236 L112,236 C108,170 104,100 100,20 Z', C.tealD, 'opacity="0.75"'));
  s += pp(rect(-114, 236, 230, 32, 6, C.tealD));                 // hem band
  // pocket
  s += pp(path('M-70,146 L74,146 L90,232 L-86,232 Z', C.tealM) + `<path d="M-62,156 L66,156" stroke="${C.tealL}" stroke-width="3" stroke-dasharray="9 7" opacity="0.7"/>`);
  // collar V + neck skin
  s += pp(path('M-30,-22 L32,-22 L2,34 Z', C.skin));
  s += pp(path('M-58,-26 C-40,-14 -16,18 2,40 C18,18 42,-14 60,-26 L66,-12 C46,6 22,40 2,62 C-18,40 -44,6 -64,-12 Z', C.tealM));
  // drawstrings
  s += pps(limb(-16, 26, -22, 118, 10, C.cream) + limb(20, 26, 26, 110, 10, C.cream));
  s += pps(circ(-16, 26, 8, '#A3A3A3') + circ(20, 26, 8, '#A3A3A3') + circ(-16, 26, 3.5, C.char) + circ(20, 26, 3.5, C.char));
  s += pps(rect(-27, 112, 11, 18, 3, '#9C9C9C') + rect(21, 104, 11, 18, 3, '#9C9C9C'));
  // head
  s += G(authorHead(o), `rotate(${r1(o.tilt || 0)},0,-40)`);
  return G(s, `translate(${AX},${AY})`);
}

function authorFarHand() {
  // forearm + hand resting on the desk (drawn after the desk)
  let s = pp(limb(-120, 128, -84, 190, 54, C.tealM));
  s += pp(G(rect(-24, -30, 22, 60, 6, C.cream), 'translate(-80,190) rotate(30)'));
  s += pp(path('M-74,178 C-60,170 -30,174 -24,190 C-22,202 -56,206 -74,200 Z', C.skin));
  return G(s, `translate(${AX},${AY})`);
}

function authorNearArm(hand, holding) {
  const S = SHOULDER;
  const k = ik(S, hand, UL, FL, 1);
  const fa = k.fa * 180 / Math.PI;
  let s = '';
  s += pp(limb(S[0], S[1], k.E[0], k.E[1], 62, C.tealM));
  s += pp(limb(k.E[0], k.E[1], k.W[0] - 34 * Math.cos(k.fa), k.W[1] - 34 * Math.sin(k.fa), 56, C.teal));
  s += pp(G(rect(-48, -28, 22, 56, 7, C.cream), `translate(${r1(k.W[0])},${r1(k.W[1])}) rotate(${r1(fa)})`));
  // fist
  let hnd = ell(0, 0, 27, 24, C.skin) + G(ell(0, 0, 17, 9, C.skin), 'translate(4,-18) rotate(-24)');
  let lines = `<path d="M10,-4 L22,-4 M10,6 L22,6 M8,15 L19,15" stroke="${C.skinD}" stroke-width="3.5" stroke-linecap="round"/>`;
  // keep the fist upright-ish when holding a ticket
  const ha = holding ? clamp(fa, -60, 60) * 0.4 : fa;
  s += pp(hnd + lines, `transform="translate(${r1(k.W[0])},${r1(k.W[1])}) rotate(${r1(ha)})"`);
  return s;
}

// ---------- CPU student ----------
const DESK1 = 1030, DESK2 = 1306, SY = 646, K = 1.12;

function cpuShoe(x, y) {
  let s = pp(path(`M${x + 34},${y} L${x + 34},${y - 22} Q${x + 30},${y - 36} ${x + 10},${y - 36} L${x - 4},${y - 32} Q${x - 18},${y - 22} ${x - 34},${y - 18} Q${x - 54},${y - 14} ${x - 54},${y - 2} L${x - 54},${y} Z`, C.white));
  s += pps(rect(x - 58, y - 9, 96, 14, 6, C.creamD) + path(`M${x + 12},${y - 31} L${x + 21},${y - 30} L${x + 4},${y - 11} L${x - 6},${y - 11} Z`, C.amber));
  return s;
}

function mitten(x, y, ang, open) {
  let s;
  if (open) {
    s = ell(0, -6, 22, 27, C.cream) + G(ell(0, 0, 13, 8, C.cream), 'translate(-20,6) rotate(-40)') +
      `<path d="M-8,-26 L-8,-12 M2,-28 L2,-12 M12,-25 L12,-12" stroke="${C.char2}" stroke-width="3" stroke-linecap="round"/>`;
  } else {
    s = ell(0, 0, 22, 19, C.cream) + G(ell(0, 0, 12, 7, C.cream), 'translate(-6,-15) rotate(-20)') +
      `<path d="M8,-8 L18,-8 M8,2 L19,2 M7,11 L16,11" stroke="${C.char2}" stroke-width="3" stroke-linecap="round"/>`;
  }
  return pp(s, `transform="translate(${r1(x)},${r1(y)}) rotate(${r1(ang)})"`);
}

function cpuArm(S, Hh, bend, open, handAng) {
  const k = ik(S, Hh, 78, 78, bend);
  const d = `M${r1(S[0])},${r1(S[1])} L${r1(k.E[0])},${r1(k.E[1])} L${r1(k.W[0])},${r1(k.W[1])}`;
  let s = pp(`<path d="${d}" fill="none" stroke="${C.char2}" stroke-width="18" stroke-linecap="round" stroke-linejoin="round"/>`);
  const ang = handAng !== undefined ? handAng : k.fa * 180 / Math.PI + 90;
  s += mitten(k.W[0], k.W[1], ang, open);
  return s;
}

// face states: 'happy','listen','worried','relief','hop'
function cpuFace(o) {
  let s = '';
  const L = [-50, -20], R = [24, -20];
  const er = 31;
  // blush
  s += pps(circ(-86, 22, 11, C.pink, 'opacity="0.45"') + circ(58, 22, 11, C.pink, 'opacity="0.45"'));
  // eye whites + rims
  s += pps(circ(L[0], L[1], er, C.white) + circ(R[0], R[1], er, C.white));
  if (o.blink) {
    s += pps(`<path d="M${L[0] - 20},${L[1] + 2} Q${L[0]},${L[1] + 14} ${L[0] + 20},${L[1] + 2} M${R[0] - 20},${R[1] + 2} Q${R[0]},${R[1] + 14} ${R[0] + 20},${R[1] + 2}" fill="none" stroke="${C.ink}" stroke-width="6" stroke-linecap="round"/>`);
  } else {
    const pr = o.pupil || 15;
    const [lx, ly] = o.look;
    s += pps(circ(L[0] + lx, L[1] + ly, pr, C.ink) + circ(R[0] + lx, R[1] + ly, pr, C.ink) +
      circ(L[0] + lx - 5, L[1] + ly - 5, 4.5, '#fff') + circ(R[0] + lx - 5, R[1] + ly - 5, 4.5, '#fff'));
    if (o.lid) { // tired half-closed lids
      s += pps(path(`M${L[0] - er},${L[1]} A${er},${er} 0 0 1 ${L[0] + er},${L[1]} Z`, C.slateL) + path(`M${R[0] - er},${R[1]} A${er},${er} 0 0 1 ${R[0] + er},${R[1]} Z`, C.slateL));
    }
  }
  s += pps(`<circle cx="${L[0]}" cy="${L[1]}" r="${er}" fill="none" stroke="${C.ink}" stroke-width="5"/><circle cx="${R[0]}" cy="${R[1]}" r="${er}" fill="none" stroke="${C.ink}" stroke-width="5"/>`);
  // brows
  let b;
  if (o.face === 'worried') b = limb(-72, -62, -34, -72, 10, C.ink) + limb(6, -74, 44, -64, 10, C.ink);
  else if (o.face === 'relief') b = limb(-72, -66, -30, -64, 10, C.ink) + limb(2, -64, 44, -66, 10, C.ink);
  else b = limb(-74, -70, -30, -78, 10, C.ink) + limb(4, -78, 46, -72, 10, C.ink);
  s += pps(b);
  // mouth
  const mx = -14, my = 42;
  if (o.face === 'happy' || o.face === 'hop') {
    s += pps(path(`M${mx - 34},${my - 8} Q${mx},${my + 46} ${mx + 34},${my - 8} Q${mx},${my + 2} ${mx - 34},${my - 8} Z`, C.mouth) + ell(mx, my + 16, 13, 8, C.tongue));
  } else if (o.face === 'listen') {
    s += pps(`<path d="M${mx - 24},${my - 2} Q${mx},${my + 20} ${mx + 24},${my - 2}" fill="none" stroke="${C.mouth}" stroke-width="6" stroke-linecap="round"/>`);
  } else if (o.face === 'worried') {
    s += pps(`<path d="M${mx - 28},${my + 8} Q${mx - 19},${my - 4} ${mx - 9},${my + 6} Q${mx},${my + 14} ${mx + 9},${my + 4} Q${mx + 19},${my - 6} ${mx + 28},${my + 8}" fill="none" stroke="${C.mouth}" stroke-width="6" stroke-linecap="round"/>`);
  } else if (o.face === 'relief') {
    s += pps(`<path d="M${mx - 18},${my + 2} Q${mx},${my + 12} ${mx + 18},${my + 2}" fill="none" stroke="${C.mouth}" stroke-width="6" stroke-linecap="round"/>`);
  }
  return s;
}

function cpu(o) {
  // o: x,y (body centre), sq (squash), armL {hand, open}, armR {...}, face..., legs 'sit'|'tuck'
  const x = o.x, y = o.y;
  let back = '', body = '', front = '';
  // legs
  const legs = o.legs === 'tuck'
    ? [[[-46, 118], [-70, 160], [-56, 210]], [[46, 118], [30, 168], [44, 214]]]
    : [[[-46, 118], [-92, 212], [-84, 344]], [[46, 118], [14, 216], [24, 350]]];
  for (const [h, k, a] of legs) {
    back += pp(`<path d="M${h[0]},${h[1]} L${k[0]},${k[1]} L${a[0]},${a[1]}" fill="none" stroke="${C.char2}" stroke-width="20" stroke-linecap="round" stroke-linejoin="round"/>`);
    back += cpuShoe(a[0], a[1] + 18);
  }
  // body
  body += pp(rect(-122, -124, 244, 248, 22, C.slateD));
  body += pp(rect(-110, -112, 220, 224, 16, C.slate));
  // pins
  let pins = '';
  for (const py of [-78, -39, 0, 39, 78]) { pins += rect(-152, py - 8, 36, 16, 4, C.amber) + rect(116, py - 8, 36, 16, 4, C.amber); }
  back += pp(pins);
  body += ink(txt(-8, -84, 'CPU', 25, C.cream, 'middle', 4));
  body += pp(rect(-98, -70, 176, 160, 22, C.cream));
  body += cpuFace(o);
  // arms
  const SL = [-112, 4], SR = [112, 4];
  let armsBack = '', armsFront = '';
  if (o.armL) armsFront += cpuArm(SL, o.armL.hand, o.armL.bend, o.armL.open, o.armL.ang);
  if (o.armR) armsFront += cpuArm(SR, o.armR.hand, o.armR.bend, o.armR.open, o.armR.ang);
  const tr = `translate(${r1(x)},${r1(y)}) scale(${r1(K / Math.sqrt(o.sq || 1))},${r1(K * (o.sq || 1))})`;
  return { back: G(back, tr), body: G(body, tr), arms: G(armsFront, tr) };
}

function badge(x, y, sc, color, r = 56) {
  if (sc <= 0.01) return '';
  const s = pp(circ(0, 0, r, color)) + pps(circ(0, 0, r - 10, 'none', `stroke="${C.white}" stroke-width="3" opacity="0.35"`)) +
    pp(`<path d="M${-r * 0.43},${r * 0.02} L${-r * 0.12},${r * 0.34} L${r * 0.45},${-r * 0.32}" fill="none" stroke="${C.white}" stroke-width="${r * 0.27}" stroke-linecap="round" stroke-linejoin="round"/>`);
  return G(s, `translate(${r1(x)},${r1(y)}) scale(${r1(sc)})`);
}

function sparkles(x, y, u, list, color) {
  if (u <= 0.01) return '';
  let s = '';
  for (const [a, r0, len, w] of list) {
    const rad = a * Math.PI / 180, cx = Math.cos(rad), sy = Math.sin(rad);
    const L = len * u;
    const x1 = x + cx * r0, y1 = y + sy * r0;
    // tapered strip
    const nx = -sy, ny = cx;
    const d = `M${r1(x1 + nx * w / 2)},${r1(y1 + ny * w / 2)} L${r1(x1 + cx * L + nx * w / 4)},${r1(y1 + sy * L + ny * w / 4)} L${r1(x1 + cx * L - nx * w / 4)},${r1(y1 + sy * L - ny * w / 4)} L${r1(x1 - nx * w / 2)},${r1(y1 - ny * w / 2)} Z`;
    s += path(d, color);
  }
  return pp(s);
}

function sweat(x, y, sc) {
  if (sc <= 0.01) return '';
  return pp(G(path('M0,-22 C9,-8 15,1 15,9 A15,15 0 0 1 -15,9 C-15,1 -9,-8 0,-22 Z', C.sweat) + ell(-5, 6, 4, 6, '#fff', 'opacity="0.7"'), `translate(${r1(x)},${r1(y)}) scale(${r1(sc)})`));
}

function qmark(x, y, rot, sc, color) {
  if (sc <= 0.01) return '';
  return pp(txt(0, 0, '?', 92, color), `transform="translate(${r1(x)},${r1(y)}) rotate(${r1(rot)}) scale(${r1(sc)})"`);
}

function thought(x, y, u, dots) {
  // x,y = cloud centre; u = appear (0..1 steps); dots = number of dots
  if (u <= 0) return '';
  let s = '';
  if (u > 0.0) s += pp(circ(x - 108, y + 96, 9, C.cream));
  if (u > 0.33) s += pp(circ(x - 82, y + 66, 14, C.cream));
  if (u > 0.66) {
    const sc = u >= 1 ? 1 : 0.75;
    const cloud = circ(-50, 8, 44, C.cream) + circ(0, -14, 54, C.cream) + circ(52, 4, 46, C.cream) + circ(22, 30, 40, C.cream) + circ(-22, 32, 38, C.cream);
    let d = '';
    for (let i = 0; i < dots; i++) d += circ(-34 + i * 34, 10, 10, C.ink);
    s += G(pp(cloud) + pps(d), `translate(${x},${y}) scale(${sc})`);
  }
  return s;
}

// ---------- scene state ----------
const FAN_X = [500, 565, 630, 695, 760], FAN_A = [-9, -4.5, 0, 4.5, 9], FAN_Y = 640;
const FAN_N = 5, HELD = 0;
let POSE = 0;
function fanXform(i, jig) {
  const j = 0.35 * hash(POSE * 11 + i * 17);
  return { x: FAN_X[i], y: FAN_Y + (jig ? jig.y : 0), a: FAN_A[i] + j + (jig ? jig.a : 0) };
}
function fanGrip(i) {
  const f = fanXform(i);
  const rad = f.a * Math.PI / 180;
  return [f.x + 70 * Math.sin(rad), f.y - 70 * Math.cos(rad)];
}

function compose(o) {
  // o: sign, signSY, labels[], accent, held {pos, rot, sc, sx, face, inFan}, hand, author{}, fanJig[], student{}, overlays
  let s = `<rect width="${W}" height="${H}" fill="#000"/>`;
  s += door(o.sign, o.signSY);
  s += authorBack(o.author);
  // fan tickets
  const heldIdx = HELD;
  const fanT = (i) => {
    const f = fanXform(i, o.fanJig && o.fanJig[i]);
    return G(ticket(o.labels[i], o.accent, false), `translate(${r1(f.x)},${r1(f.y)}) rotate(${r1(f.a)}) translate(0,-70)`);
  };
  const heldT = () => {
    const h = o.held;
    return G(ticket(o.labels[heldIdx], o.accent, h.face, h.sx), `translate(${r1(h.pos[0])},${r1(h.pos[1])}) rotate(${r1(h.rot)}) scale(${r1(h.sc)})`);
  };
  for (let i = 0; i < FAN_N; i++) {
    if (i === heldIdx) { if (o.held.inFan) s += heldT(); continue; }
    s += fanT(i);
  }
  s += examDesk();
  s += ticketTray();
  if (!o.held.inFan) s += heldT();
  s += authorFarHand();
  s += authorNearArm(o.hand, true);
  // student
  const st = cpu(o.student);
  s += st.back;
  s += st.body;
  s += studentDesk(DESK1) + studentDesk(DESK2);
  s += st.arms;
  s += o.overlay || '';
  return s;
}

// ---------- timelines ----------
const GRIP = fanGrip(HELD);
const UP = [GRIP[0] - 8, GRIP[1] - 150];
const DISP = [478, 336];

function turn(u) { // squash-flip value and face flag; u 0..1
  return { sx: Math.max(0.1, Math.abs(Math.cos(Math.PI * u))), face: u >= 0.5 };
}
function flipSign(t, t0, dur, a, b) {
  const u = seg(t, t0, t0 + dur);
  return { label: u < 0.5 ? a : b, sy: Math.max(0.06, Math.abs(Math.cos(Math.PI * u))) };
}

function sceneA(t) {
  const pose = Math.round(t * 12);
  // --- examiner hand & ticket ---
  const hand = track(t, [[0, GRIP], [0.5, UP], [0.83, DISP], [4.0, DISP], [4.42, UP], [4.75, GRIP], [6, GRIP]]);
  // presenting bob while holding
  if (t > 0.9 && t < 3.95) hand[1] += Math.round(3 * Math.sin((t - 0.9) * Math.PI * 2 / 1.5));
  const FA = FAN_A[HELD];
  const rot = track(t, [[0, FA], [0.5, FA], [0.83, -5], [4.0, -5], [4.42, FA], [6, FA]]) + 0.5 * hash(pose * 3.1);
  const sc = track(t, [[0, 1], [0.5, 1], [0.83, 1.38], [4.0, 1.38], [4.42, 1], [6, 1]]);
  let tr = { sx: 1, face: false };
  if (t >= 0.5 && t < 0.92) tr = turn(seg(t, 0.5, 0.92));
  else if (t >= 0.92 && t < 4.0) tr = { sx: 1, face: true };
  else if (t >= 4.0 && t < 4.42) tr = turn(1 - seg(t, 4.0, 4.42));
  const lift = GRIP[1] - hand[1];
  const held = { pos: hand, rot, sc, sx: tr.sx, face: tr.face, inFan: lift < 70 && t < 0.6 || (t > 4.5 && lift < 70) };
  // fan tremble after the ticket is returned
  let fanJig = null;
  if (t >= 4.75 && t < 5.25) {
    const k = 1 - seg(t, 4.75, 5.25);
    fanJig = [0, 1, 2, 3, 4].map(i => ({ a: 2.6 * k * hash(pose * 7 + i), y: 2.5 * k * hash(pose * 13 + i) }));
  }
  // --- door sign ---
  let sign = { label: '101', sy: 1 };
  if (t >= 2.5 && t < 2.92) sign = flipSign(t, 2.5, 0.42, '101', '205');
  else if (t >= 2.92 && t < 4.75) sign = { label: '205', sy: 1 };
  else if (t >= 4.75 && t < 5.17) sign = flipSign(t, 4.75, 0.42, '205', '101');
  // --- student ---
  const hop1 = seg(t, 2.75, 3.25), hop2 = seg(t, 5.17, 5.67);
  let sx = DESK1, hy = 0, sq = 1, legs = 'sit';
  if (t >= 2.75 && t < 5.17) sx = lerp(DESK1, DESK2, sm(hop1));
  if (t >= 5.17) sx = lerp(DESK2, DESK1, sm(hop2));
  const inHop = (t > 2.75 && t < 3.25) || (t > 5.17 && t < 5.67);
  if (inHop) {
    const u = t < 4 ? hop1 : hop2;
    hy = -150 * Math.sin(Math.PI * u);
    sq = u < 0.2 ? 0.9 : 1.07;
    legs = 'tuck';
  }
  const landed = (t >= 3.25 && t < 3.42) || (t >= 5.67 && t < 5.84);
  if (landed) sq = 0.93;
  const up = track(t, [[0, 1], [0.33, 1], [0.5, 0], [1.5, 0], [1.62, 1], [2.5, 1], [2.67, 0], [3.33, 0], [3.45, 1], [6, 1]], lin);
  const bobA = inHop ? 0 : Math.round(2.5 * Math.sin(t * Math.PI * 2 / 1.5));
  const sy = SY + hy + bobA + (sq !== 1 ? (1 - sq) * 124 * K : 0);
  // arms: left arm raised (toward examiner) or resting on desk
  const deskY = (778 - sy) / K;
  const armL = up > 0.5
    ? { hand: [-128 + 6 * (1 - up), -178], open: true, bend: 1, ang: -8 }
    : { hand: [-96, Math.min(deskY + 2, 160)], open: false, bend: 1 };
  const armR = { hand: [100, Math.min(deskY + 2, 160)], open: false, bend: -1 };
  if (inHop) { armR.hand = [138, 90]; }
  let face = up > 0.5 ? 'happy' : 'listen';
  if (inHop) face = 'hop';
  const blinkS = (t >= 1.0 && t < 1.17) || (t >= 4.33 && t < 4.5);
  const look = face === 'listen' ? [-9, -6] : [-8, -3];
  const student = { x: sx, y: sy, sq, legs, armL, armR, face, blink: blinkS, look };
  // --- overlays ---
  let ov = '';
  const bsc = track(t, [[0, 1], [0.33, 1], [0.5, 0], [1.5, 0], [1.58, 1.25], [1.67, 0.92], [1.75, 1], [2.5, 1], [2.67, 0], [3.42, 0], [3.5, 1.25], [3.58, 0.92], [3.67, 1], [6, 1]], lin);
  ov += badge(sx + 70, sy - 238, bsc, C.teal);
  const sp1 = t >= 1.58 && t < 2.42 ? (t < 1.67 ? 0.6 : t < 2.25 ? 1 : 0.55) : 0;
  const sp2 = t >= 3.5 && t < 4.25 ? (t < 3.58 ? 0.6 : t < 4.08 ? 1 : 0.55) : 0;
  const spU = Math.max(sp1, sp2);
  const SPL = [[196, 168, 52, 17], [226, 172, 60, 18], [256, 170, 48, 16], [-30, 172, 52, 17], [-58, 176, 58, 18], [-86, 176, 44, 15]];
  ov += sparkles(sx - 8, sy - 50, spU, SPL, C.cream);
  // --- examiner face ---
  const blinkA = (t >= 2.0 && t < 2.17) || (t >= 5.42 && t < 5.58);
  const mouth = (t >= 0.83 && t < 1.42) ? 'open' : (t >= 1.58 && t < 2.08 ? 'o' : 'smile');
  const author = { brow: (t >= 1.58 && t < 2.33) || (t >= 3.5 && t < 3.9) ? 6 : 0, blink: blinkA, look: [8, 2], mouth,
    tilt: 1.2 * Math.sin(t * Math.PI * 2 / 3), breath: Math.round(2 * Math.sin(t * Math.PI * 2 / 2)) };
  return compose({ sign: sign.label, signSY: sign.sy, labels: ['7', '7', '7', '7', '7'], accent: C.teal, held, hand, fanJig, student, author, overlay: ov });
}

function sceneB(t) {
  const pose = Math.round(t * 12);
  // shuffle 0-0.58, pull 0.58-0.92, turn to display 0.92-1.17, hold, return 4.5-4.92
  let hand = track(t, [[0, GRIP], [0.58, GRIP], [0.92, UP], [1.17, DISP], [4.5, DISP], [4.75, UP], [4.92, GRIP], [5, GRIP]]);
  let fanJig = null;
  if (t >= 0.08 && t < 0.58) {
    const k = 1 - seg(t, 0.4, 0.58);
    fanJig = [0, 1, 2, 3, 4].map(i => ({ a: 3 * k * hash(pose * 5 + i * 3), y: -18 * k * (((pose + i) % 2) ? 1 : 0) }));
    hand = [hand[0] + 6 * k * ((pose % 2) ? 1 : -1), hand[1] + fanJig[HELD].y];
  }
  if (t > 1.25 && t < 4.45) hand[1] += Math.round(3 * Math.sin((t - 1.25) * Math.PI * 2 / 1.6));
  const FA = FAN_A[HELD];
  const rot = track(t, [[0, FA], [0.92, FA], [1.17, -5], [4.5, -5], [4.75, FA], [5, FA]]) + 0.5 * hash(pose * 3.1);
  const sc = track(t, [[0, 1], [0.92, 1], [1.17, 1.38], [4.5, 1.38], [4.75, 1], [5, 1]]);
  let tr = { sx: 1, face: false };
  if (t >= 0.92 && t < 1.25) tr = turn(seg(t, 0.92, 1.25));
  else if (t >= 1.25 && t < 4.5) tr = { sx: 1, face: true };
  else if (t >= 4.5 && t < 4.75) tr = turn(1 - seg(t, 4.5, 4.75));
  const lift = GRIP[1] - hand[1];
  const held = { pos: hand, rot, sc, sx: tr.sx, face: tr.face, inFan: lift < 70 && (t < 1 || t > 4.6) };
  // student (always at desk 1)
  const sx = DESK1;
  const trem = t < 3.5 ? Math.round(1.5 * hash(pose * 3)) : 0;
  const sy = SY + Math.round(2 * Math.sin(t * Math.PI * 2 / 1.25));
  const deskY = (778 - sy) / K;
  const scratchUp = track(t, [[0, 1], [3.58, 1], [3.75, 0], [4.58, 0], [4.75, 1], [5, 1]], lin);
  const scr = (t >= 1.5 && t < 3.5) ? ((pose % 2) ? 8 : -6) : 0;
  const armR = scratchUp > 0.5
    ? { hand: [118 + scr, -132], open: false, bend: 1, ang: -150 }
    : { hand: [100, deskY + 2], open: false, bend: -1 };
  const armL = { hand: [-96, deskY + 2], open: false, bend: 1 };
  const relief = t >= 3.67 && t < 4.58;
  const face = relief ? 'relief' : 'worried';
  let look = [-8, -5];
  if (t >= 1.5 && t < 3.5) { const ph = Math.floor((t - 1.5) * 12 / 4) % 4; look = [[-10, -4], [9, -4], [-10, 2], [9, 2]][ph]; }
  const blinkS = (t >= 0.5 && t < 0.67);
  const student = { x: sx + trem, y: sy, sq: 1, legs: 'sit', armL, armR, face, blink: blinkS, look, pupil: relief ? 14 : 11, lid: relief };
  // overlays
  let ov = '';
  const qs = track(t, [[0, 1], [3.5, 1], [3.67, 0], [4.6, 0], [4.92, 1], [5, 1]], lin);
  const bob = (Math.floor(t * 12 / 6) % 2) ? 1 : -1;
  ov += qmark(sx - 116, sy - 178, -16 + 4 * bob, qs * 0.85, C.pink);
  ov += qmark(sx - 30, sy - 214, 6 - 4 * bob, qs, C.pink);
  ov += qmark(sx + 52, sy - 182, 18 + 4 * bob, qs * 0.75, C.pink);
  // sweat drops
  const dropY = track(t, [[0, -40], [1.5, -40], [3.3, 70], [5, 70]], lin);
  const dropS = t < 3.3 ? 1 : (t < 3.42 ? 0.5 : (t >= 4.67 ? (t < 4.83 ? 0.5 : 1) : 0));
  const dropYY = (t >= 4.6) ? -40 : dropY;
  ov += sweat(sx - 124, sy + Math.round(dropYY), dropS);
  ov += sweat(sx + 82, sy - 66, relief ? 0 : 0.72);
  // thought bubble 1.5-3.5
  if (t >= 1.5 && t < 3.67) {
    const u = t < 1.58 ? 0.2 : t < 1.67 ? 0.5 : t < 1.75 ? 0.8 : 1;
    const dots = t < 1.92 ? 0 : t < 2.17 ? 1 : t < 2.42 ? 2 : 3;
    if (t < 3.5) ov += thought(sx + 196, sy - 246, u, dots);
    else ov += thought(sx + 196, sy - 246, 0.8, 0);
  }
  // slow small pink check 3.5-4.5
  if (t >= 3.5 && t < 4.67) {
    const u = t < 4.5 ? Math.floor(seg(t, 3.5, 4.42) * 11) / 11 : 1 - seg(t, 4.5, 4.67);
    ov += badge(sx - 26, sy - 226, 0.3 + 0.62 * u, C.pink, 48);
  }
  // examiner
  const blinkA = (t >= 2.75 && t < 2.92);
  const mouth = (t >= 1.17 && t < 1.67) ? 'open' : 'smile';
  const author = { brow: (t >= 2.0 && t < 3.4) ? 5 : 0, blink: blinkA, look: [8, 2], mouth,
    tilt: 1.2 * Math.sin(t * Math.PI * 2 / 2.5), breath: Math.round(2 * Math.sin(t * Math.PI * 2 / 2.5)) };
  return compose({ sign: '101', signSY: 1, labels: ['41', '3', '12', '58', '16'], accent: C.pink, held, hand, fanJig, student, author, overlay: ov });
}

window.drawScene = function (scene, t) {
  POSE = Math.round(t * 12);
  const body = scene === 'A' ? sceneA(t) : sceneB(t);
  document.getElementById('stage').innerHTML = `<svg xmlns="http://www.w3.org/2000/svg" width="${W}" height="${H}" viewBox="0 0 ${W} ${H}">${DEFS}<rect width="${W}" height="${H}" fill="#000"/><g transform="translate(0,-36)">${body}</g></svg>`;
};
})();
