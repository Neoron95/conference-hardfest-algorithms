# Readability pass — brief for each agent

Deck: conference talk «O(n) проиграл O(n log n)» (HardFest 2026), shown on a projector in a big hall, 1920×1080 canvas, black background.
Goal: the user wants every slide readable from the back rows. Where text or elements are too small, enlarge them a bit and re-balance the layout so the slide reads better. Slides that are already fine stay UNCHANGED.

## Files
- Baseline slides (read-only, do not edit): `readab/base/slides/<id>.html` — one `<section>` per file.
- Your output: copy a slide to `readab/out/<group>/slides/<id>.html` ONLY if you change it, and edit that copy. Never write anywhere else (no git, no publishing, no other groups' folders, never edit `base/`).
- Format rules (closed CSS subset, must be respected): `readab/format.md`. Key points: px units only; no margin, z-index, em/rem; font-size 8–400; line-height 0.5–4× font-size; transforms limited; `<svg>` is a picture (scale it by changing width/height in proportion to its viewBox); `<aside>` is speaker notes.
- Render: `python3 readab/render.py <slide.html> <out_prefix>` → one PNG per click state (`<prefix>-0.png` = before any click, `-1` after first click…) and `<prefix>_sheet.png` contact sheet. Run it from the scratchpad dir. Look at the PNGs with the Read tool. Render the baseline first (prefix `readab/out/<group>/png/<id>_before`) and your edit after (`…/<id>_after`). Videos render as their poster image.

## What counts as too small (projector rules)
- Main body text / statements: ≥ 32px is comfortable; 28–30px acceptable; below 28px → enlarge if there is room.
- Secondary captions, axis/chart labels, units, legends, footnotes: ≥ 24px hard minimum; prefer 26–28px.
- Code / monospace: ≥ 28px.
- Thin lines and tiny markers in diagrams that carry meaning: make them visible (e.g. bar chart bars, small boxes).
- Big empty areas next to small content are a sign the content should grow.

## Do NOT change
- Any wording (text on the slide), `<aside>` speaker notes, slide ids, `data-build-in` / `data-build-out` values (order of clicks must stay identical), `data-video`, image `src`, colors, fonts, the overall design idea.
- Deck-wide elements: kicker line (top:72px, 29.3px uppercase grey), the h2 title (top ~103–115px, 58.7px), HardFest logo (top:144 left:1586 230×79), page number (top:1004 left:1683, 24px). Leave them exactly as they are.
- The small status board in the top-right corner on some slides (three boxes «работа + ожидание + выброшено» at top 34–102px) — leave as is.
- Meme images (slides named meme-*): do not resize the meme picture itself; only captions if they are too small.

## Allowed
- font-size, line-height, letter-spacing; top/left/width/height of elements; scaling svg/img boxes (keep aspect ratio); moving elements to use free space; widening text boxes so that bigger text does not wrap badly.

## Hard checks for your result (every click state!)
- Content stays inside left ≥ 117px, right edge ≤ 1803px, bottom ≤ 990px; nothing collides with the logo box (x 1586–1816, y 144–223) or the title.
- No overlaps, no clipped or overflowing text, no new ugly line breaks (a word alone on a line, a number separated from its unit). Elements that appear on later clicks must still fit with everything already on screen; elements that replace each other (build-out then build-in at the same place) must still line up.
- Diagrams stay correct: labels still point at their bars/boxes; things that were aligned stay aligned.
- If enlarging would require a redesign, do a modest safe enlargement or leave the slide and mention it in the report.

## Report (your final message)
Short, in Russian, one line per slide of your group:
`<id> — без изменений` or `<id> — что увеличено (было → стало px), что подвинуто; риски, если есть`.
Also list the after-sheet paths of changed slides. Keep the whole report under ~40 lines.
