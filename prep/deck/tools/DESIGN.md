# Deck rebuild — shared rules for every slide author

Deck: «O(n) проиграл O(n log n)», HardFest 2026. You rewrite slide files of a Slides-type
artifact. The source of truth for WHAT each slide shows and says is the verbatim script:

- `SCRIPT` = /home/user/conference-hardfest-algorithms/prep/script/full_script.md — for each slide:
  «На экране» (what is visible after fixes, build steps), «Говорю» (verbatim spoken text with
  [ремарки]), «Если отстаю», «Под рукой». Section «Что текст требует от колоды» at the end lists
  deck changes per slide. Follow them.
- `ERRATA` = /tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/research/errata.md
  (P0/P1/P2 fixes with exact replacement texts; §4 number consistency). All P0 are mandatory.
- `ORIG` = /tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/deckbuild/orig_slides/<id>.html
  — the current slides. Reuse their data (SVG polylines, numbers, tables) — never invent data.
- `FORMAT` = /tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/artifact-files/54d62b61-af0a-4fc1-9e3a-902dd05bdfee/artifact-type/reference/format.md
  (the whole allowed HTML/CSS subset — read it fully before writing) and `layout.md`,
  `styles.md`, `diagrams.md` in the same folder.
- Facts, if you need more: research/apple.md, cpp.md, priorart.md, bench.md, beyond.md in the scratchpad
  `research/` folder; /home/user/conference-hardfest-algorithms/bench/results/summary.md;
  /home/user/conference-hardfest-algorithms/prep/research/qa.md (§В: backup slides NB1–NB5).

Write each slide to `OUT` = prep/deck/project/slides/<id>.html
and run `python3 /tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/deckbuild/lint.py <file>`
until it prints no `error:` lines (fix `warn:` lines too unless they are deliberate). Do NOT touch
files of other slides. Do not render, screenshot or open the deck in a browser.

## File format (hard rules — see FORMAT)

- The file holds exactly one `<section id="<id>" style="…">…</section>`, nothing before or after.
  The last child is `<aside>` with speaker notes (plain text, `<br>` allowed between paragraphs,
  ≤ 3,900 characters). No `<style>`, classes, `margin` (except `margin:0`), `margin-*`,
  `padding-top/left…` (use `padding` shorthand), `border-collapse`, `em/rem/var()`.
- Every text element sets `font-size` ≥ 24px (axis labels too). No `font-size` on `<span>`.
- ≤ 200 elements per slide; ≤ 24 positioned children per `<div>`; ≤ 15 nested divs.
- SVG: `width`/`height` attributes equal the `viewBox` size; no `<text>` inside (labels are
  pinned `<p>` over the svg); ≤ 52 KB; `aria-label` = alt text.
- Pinned boxes (`position:absolute`) stay inside the 128px margins: `left+width ≤ 1792`,
  `top+height ≤ 952`; if the slide has a footer, content ends at y ≤ 920.
- Text wraps only at spaces. Width budget ≈ 0.6 × font-size per character (Cyrillic and bold:
  0.65). Height ≈ lines × font-size × line-height. Size every box so its text fits — nothing may
  shrink or overflow. Give every pinned text a `width`.

## Builds (this is why many slides are rebuilt)

- A click shows the next build step. **Each `[щелчок]` in the slide's «Говорю» text is exactly
  one build step**, numbered 1, 2, 3… in order. Elements visible from the start carry no build.
- `data-build-in="fade N"` works ONLY on `position:absolute` children of the section (or of a
  `position:relative` div). Put everything that appears on a click into pinned boxes; the heading
  and kicker may stay in flow. Several elements may share one order N.
- If the script's text ends with a `[щелчок]` that only advances to the next slide (cover, qos),
  write it in the notes as `[→ следующий слайд]`, not `[щелчок]`, and do not make a build step.
- If a script step is impossible as written (e.g. data we do not have), keep the click count
  consistent with the notes you write.
- Use `fade` for everything (calm, conference style); `rise` only for the one big number on
  `result`, `flat`, `x33`.

## Tokens

Fonts: text `'IBM Plex Sans', Arial, sans-serif`; code `'JetBrains Mono', 'Courier New', monospace`.

| Role | Light slide | Dark slide |
|---|---|---|
| background | `#F5F4EF` | `#151922` |
| ink / main text | `#1B1F27` | `#F5F4EF` |
| secondary text | `#4A5360` | `#C9CED8` |
| labels, footer | `#6A7280` | `#9AA3B2` |
| rules, hairlines | `#DAD7CE` | `rgba(255,255,255,.12)` / `#2A3040` |
| card | `#FFFFFF`, border `1px solid #DAD7CE`, radius 16px | `#0F1219`, border `1px solid #2A3040` |

**Algorithm colors — used ONLY for the four algorithms** (bars, lines, card top borders, names):

| Algorithm | Fill/line | Text on light | Pale fill |
|---|---|---|---|
| sort + unique | `#2F6FDB` | `#2F6FDB` | `#D6E3FA` |
| unordered_set (узловой хеш) | `#D9622B` | `#B9501F` | `#FBE3D6` |
| flat_hash_set (плоский хеш) | `#13806C` | `#13806C` | `#D3EDE7` |
| radix + unique | `#7B5CC4` | `#6A4BB3` | `#E6DEF6` |

**Amber — the single non-algorithm accent**: «ваш ход» (votes, questions to the room), kicker
round numbers, highlight of the key row, «подозрительно быстро», the `utility` line, the ①②③
«ружья» badges, and placeholders. Replace the old orange accent `#E8894F` everywhere (it clashes
with the hash color).

| Amber use | Light slide | Dark slide |
|---|---|---|
| text | `#8A5F00` | `#E3A21A` |
| line / border | `#B07800` | `#E3A21A` |
| pale highlight fill | `#FBEFD2` | `#3A2E12` |

Cores/ladder charts: **P-core = solid ink line `#1B1F27`**, **E-core = grey dashed `#8A8F99`
(`stroke-dasharray="14 10"`)**, **utility = amber `#B07800` solid**; cache boundaries = light grey
vertical lines `#C9C5BA` labelled with pinned `<p>` (≥ 24px). Algorithm colors are NOT used there.

Diff code colors (only `diff` and `review`): comment `#8A8F99`, removed `#F08A7A`, added `#7BD88F`,
code panel `#0F1219`. «Approve ✓» and «Changes requested» are amber (not green/red).

Heat map (flip, outcontract table): winner cell filled with the winner's pale fill, ink text;
tie = no fill and «≈».

## Typography scale (one scale for the whole deck)

- Cover title 120px/700; statement slides 72–88px/700.
- Slide title `<h2>`: 56px, weight 600, line-height 1.1, color ink; max 2 lines (≈ 48 chars per
  line at 56px across 1664px). It states the claim (use the title from SCRIPT «### N. `id` — …»,
  shortened if needed to fit 2 lines, keeping the numbers).
- Kicker `<p>` above the title: 24px, weight 600, uppercase, letter-spacing 2px, color labels
  (`#6A7280` / `#9AA3B2`), with the round number in amber text: e.g.
  `РАУНД <span style="color:#8A5F00">1</span> ИЗ 4 · РАЗМЕР И ПАМЯТЬ`. Kicker texts:
  - slides 7–10: «Раунд 1 из 4 · размер и память»
  - slides 11–12: «Раунд 2 из 4 · реализация хеша»
  - slides 13–17: «Раунд 3 из 4 · данные и тикет» (share-q: «Ставка №2 · Раунд 3 из 4 · данные и тикет», amber)
  - slides 19, 21, 22: «Раунд 4 из 4 · процессор»
  - slides 23–26: «После четырёх раундов»
  - intro slides 1–6, learned, x33: no round kicker (diff: «Код-ревью, вторник, 17:40»; vote: «Ваша ставка» amber)
  - backup slides: «Backup · для вопросов»
- Body 32–36px (line-height 1.35); labels, table cells, axis labels ≥ 28px on main slides
  (≥ 24px allowed only in footers and dense backup tables); big numbers 96–300px, line-height 1.
- Code 32–36px JetBrains Mono.

## Layout

- Content slide: `<section id style="background:…; color:…; font-family:'IBM Plex Sans', Arial,
  sans-serif; padding:112px 128px 160px; display:flex; flex-direction:column; gap:24px">`, then
  kicker `<p>`, then `<h2>`, then the body. Kicker+title always start at y = 112 so they do not hop.
  Body content below the title typically starts at y ≈ 300 (one-line title) or ≈ 360 (two lines).
- Footer (source/conditions line): ONE pinned `<p style="position:absolute; left:128px;
  bottom:64px; width:1664px; font-size:24px; line-height:1.3; color:#6A7280">`, max 2 lines
  (≈ 200 chars). It is the only thing below y 920.
- Dark statement slides (diff, vote, share-q, learned, x33, review, final, backup, cover):
  `background:#151922`.
- ≤ 35–40 words readable on screen after each build step; everything else goes to notes.
- Keep a slide simple; prefer big numbers, bars, two columns, tables over paragraphs.

## Placeholders

The user must fill some values. Write them exactly as the script does, in square brackets, in
amber text so they are easy to find: `<span style="color:#8A5F00">[модель iPhone, чип, iOS]</span>`
(dark slide: `#E3A21A`). Standard forms: `[модель iPhone]` in titles and panel headers,
`[модель iPhone, чип, iOS]` in footers, `[дата сессии А]`, `[дата сессии Б]`, `[домерить на iPhone]`,
`[N дней]`, `[доля этапа в синхронизации]`, `[что поехало в прод]`. Never invent a value.

Repository link (P0-14 resolved): URL text `github.com/Neoron95/conference-hardfest-algorithms`;
QR code SVG ready at /tmp/claude-0/-home-user-conference-hardfest-algorithms/77ae4688-5a5b-5b88-9a3c-fc8957e66e48/scratchpad/qr.svg
(296×296, paste it verbatim as an inline `<svg>` inside a pinned or flow box).

## Speaker notes (`<aside>`)

Plain text, in this order, paragraphs separated by `<br>`:
1. `План M:SS · к концу M:SS.` (from SCRIPT's italic line)
2. The «Говорю» text verbatim from SCRIPT (keep the [ремарки]; convert the trailing
   slide-advance click to `[→ следующий слайд]` as described above).
3. `Если отстаю (−NN с): …` from SCRIPT.
4. `Под рукой: …` — only if it still fits under 3,900 characters in total; shorten or drop the
   least important bullet first. No markdown (`**`, backticks) — plain text only.
Escape `&` as `&amp;`, `<` as `&lt;` in notes and code.

## Hidden slides

Old slides that are fully merged into others (`twoways`, `bigo`, `questions`) stay in the deck
as hidden archive: add the attribute `hidden` to their `<section>` (content unchanged except
fixing lint errors). Nobody deletes files.

## When you finish a slide

Run lint. Then re-read your file against: (1) SCRIPT «На экране» for that slide — every element
and every build step present, in order; (2) the number of `[щелчок]` in notes = number of build
steps; (3) every number on the slide matches SCRIPT/ERRATA exactly; (4) nothing overflows by your
width/height estimate; (5) colors follow the tokens.
