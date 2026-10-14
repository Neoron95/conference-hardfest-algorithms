#!/usr/bin/env bash
# Build the PPTX files from ../project (the deck as published).
# Output: out/hardfest2026_deck_mac_{clicks,clicks_prod,editable,editable_prod}.pptx
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p out
echo "== 1. pages";            python3 make_pages.py
echo "== 2. clicks: layers";   node layersA.js && python3 cropA.py
echo "== 3. clicks: pptx";     node buildA.js
python3 post.py build/A/raw.pptx build/A/plan.json out/hardfest2026_deck_mac_clicks.pptx fonts/embed
# основная часть = видимые слайды до «Спасибо» (final-thanks) включительно, без слайдов-ответов на вопросы
MAIN=$(python3 -c "import json;print(next(p['n'] for p in json.load(open('build/pages.json')) if p['id']=='final-thanks'))")
echo "== 3p. clicks prod ($MAIN main slides, no notes)"
MAXN=$MAIN NONOTES=1 OUT=build/AP node buildA.js
python3 post.py build/AP/raw.pptx build/AP/plan.json out/hardfest2026_deck_mac_clicks_prod.pptx fonts/embed
echo "== 4. editable: extract"; node extractB.js && python3 convertB.py
echo "== 5. editable: pptx";   node buildB.js
python3 post.py build/B/raw.pptx build/B/plan.json out/hardfest2026_deck_mac_editable.pptx fonts/embed --kern
echo "== 6. editable prod ($MAIN main slides, no notes)"
MAXN=$MAIN NONOTES=1 OUT=build/P node buildB.js
python3 post.py build/P/raw.pptx build/P/plan.json out/hardfest2026_deck_mac_editable_prod.pptx fonts/embed --kern
echo "== 7. QA preview of the editable variant"; python3 previewB.py
ls -la out
