#!/usr/bin/env node
// Renders the looping motion-graphics clips for the HardFest 2026 deck.
//
// Each clip is a self-contained HTML page next to this script that exposes
//   window.CLIP   = { duration, poster }   (seconds)
//   window.render = t => void             (pure: draws the frame for time t)
// The page is opened at its exact output size (deviceScaleFactor 1), t is stepped at 30 fps
// over [0, duration) and every frame is screenshotted to /tmp, then encoded as H.264 with AVFoundation (macOS) or libx264.
// Frame t = duration is identical to t = 0, so the clip loops seamlessly.
//
// Usage:  node render.js [clip ...] [--poster-only] [--fullfade] [--keep-frames]
//   clip          cover_chip | nodes_scatter | memory_flight | flat_probe | sort_unique_v5 | hash_insert_v5 | radix_pass_v5 | merge_unique_v5 (default: all)
//   --poster-only only refresh the poster PNGs
//   --fullfade    also fade the static diagram (die, buckets, lanes, slot row) out and back in
//                 at the loop point; by default only the moving parts reset and the diagram stays
//   --keep-frames keep the PNG frame dumps in /tmp/anim_frames
//
// Output: ../../<clip>.mp4 and ../../<clip>.png (i.e. hardfest/assets/).

const { execSync, execFileSync } = require('child_process');
const fs = require('fs');
const path = require('path');
let chromium;
try { ({ chromium } = require('playwright')); }
catch { ({ chromium } = require(path.join(execSync('npm root -g').toString().trim(), 'playwright'))); }

const FPS = 30;
const CLIPS = {
  cover_chip:    { w: 1600, h: 1360 },
  nodes_scatter: { w: 1880, h: 1040 },
  memory_flight: { w: 1720, h: 840 },
  flat_probe:    { w: 1800, h: 920 },
  sort_unique_v5: { w: 1800, h: 720 },
  hash_insert_v5: { w: 1800, h: 720 },
  radix_pass_v5:  { w: 1800, h: 720 },
  merge_unique_v5:{ w: 1800, h: 720 },
};

const SRC = __dirname;
const OUT = path.resolve(__dirname, '..', '..');
const FRAMES = process.env.ANIM_WORK || '/tmp/anim_frames';

const args = process.argv.slice(2);
const flags = new Set(args.filter(a => a.startsWith('--')));
let names = args.filter(a => !a.startsWith('--'));
if (!names.length) names = Object.keys(CLIPS);
for (const n of names) if (!CLIPS[n]) { console.error(`unknown clip: ${n}`); process.exit(1); }

let ffmpeg = process.env.FFMPEG_PATH;
if (!ffmpeg && process.platform !== 'darwin') {
  ffmpeg = execSync(`python3 -c "import imageio_ffmpeg as f; print(f.get_ffmpeg_exe())"`).toString().trim();
}

async function renderClip(browser, name) {
  const { w, h } = CLIPS[name];
  const page = await browser.newPage({ viewport: { width: w, height: h }, deviceScaleFactor: 1 });
  const url = 'file://' + path.join(SRC, `${name}.html`) + (flags.has('--fullfade') ? '?fullfade=1' : '');
  await page.goto(url, { waitUntil: 'load' });
  if (process.env.ANIM_FONT_DIR) {
    const directory = path.resolve(process.env.ANIM_FONT_DIR);
    const faces = [['Regular',400],['SemiBold',600],['Bold',700],['ExtraBold',800]];
    await page.addStyleTag({ content: faces.map(([face, weight]) =>
      `@font-face{font-family:HFStatic;src:url("file://${path.join(directory, `Montserrat-${face}.ttf`)}");font-weight:${weight};} svg text{font-family:HFStatic!important;}`).join('\n') });
  }
  await page.evaluate(() => document.fonts.ready);
  const clip = await page.evaluate(() => window.CLIP);
  const shot = async (t, file) => {
    await page.evaluate(tt => window.render(tt), t);
    await page.evaluate(async () => {
      await document.fonts.ready;
      await new Promise(resolve => requestAnimationFrame(() => requestAnimationFrame(resolve)));
    });
    await page.screenshot({ path: file, type: 'png', clip: { x: 0, y: 0, width: w, height: h } });
  };

  const poster = path.join(OUT, `${name}.png`);
  await shot(clip.poster, poster);
  console.log(`${name}: poster t=${clip.poster}s -> ${poster}`);
  if (flags.has('--poster-only')) { await page.close(); return; }

  const dir = path.join(FRAMES, name);
  fs.rmSync(dir, { recursive: true, force: true });
  fs.mkdirSync(dir, { recursive: true });
  const n = Math.round(clip.duration * FPS);
  const t0 = Date.now();
  for (let k = 0; k < n; k++) {
    await shot(k / FPS, path.join(dir, `f${String(k).padStart(4, '0')}.png`));
  }
  await page.close();
  console.log(`${name}: ${n} frames in ${((Date.now() - t0) / 1000).toFixed(1)}s`);

  const mp4 = path.join(OUT, `${name}.mp4`);
  if (!ffmpeg && process.platform === 'darwin') {
    const cache = path.join(FRAMES, 'swift-cache'); fs.mkdirSync(cache, { recursive: true });
    execFileSync('swift', ['-module-cache-path', cache, path.join(SRC, 'encode_frames.swift'), dir, mp4, String(w), String(h), String(FPS)], { stdio: 'inherit' });
  } else execFileSync(ffmpeg, [
    '-y', '-loglevel', 'error',
    '-framerate', String(FPS), '-i', path.join(dir, 'f%04d.png'),
    // RGB -> BT.709 limited range (pure #000 stays Y=16 -> decodes back to 0,0,0), tagged accordingly
    '-vf', 'scale=out_color_matrix=bt709:out_range=tv,format=yuv420p',
    '-c:v', 'libx264', '-pix_fmt', 'yuv420p', '-crf', '20', '-preset', 'slow',
    '-color_primaries', 'bt709', '-color_trc', 'bt709', '-colorspace', 'bt709', '-color_range', 'tv',
    '-movflags', '+faststart', '-r', String(FPS), '-an',
    mp4,
  ], { stdio: 'inherit' });
  console.log(`${name}: ${mp4} (${(fs.statSync(mp4).size / 1e6).toFixed(2)} MB)`);
  if (!flags.has('--keep-frames')) fs.rmSync(dir, { recursive: true, force: true });
}

(async () => {
  const browser = await chromium.launch(process.env.CHROME_PATH ? { executablePath: process.env.CHROME_PATH } : {});
  try {
    for (const n of names) await renderClip(browser, n);
  } finally {
    await browser.close();
  }
})().catch(e => { console.error(e); process.exit(1); });
