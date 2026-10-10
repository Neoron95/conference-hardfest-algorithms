#!/usr/bin/env bash
set -euo pipefail
: "${RUNTIME_NODE:?Set bundled Node}"
: "${RUNTIME_PYTHON:?Set bundled Python}"
: "${NODE_PATH:?Set bundled Node packages}"
: "${PRESENTATIONS_SKILL_DIR:?Set installed Presentations skill}"
TASK_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
cd "$TASK_ROOT"
export ARTIFACT_TOOL_PATH="$NODE_PATH/@oai/artifact-tool/dist/artifact_tool.mjs"
export RUNTIME_NODE_MODULES="$NODE_PATH"
export HARDFEST_DECK=hardfest_v9
export PPTX_WORK="$TASK_ROOT/prep/.v9-build/review-6-7"
mkdir -p prep/.v9-build
"$RUNTIME_PYTHON" prep/deck/pptx/sync_speaker_notes_v9.py
"$RUNTIME_NODE" prep/deck/pptx/extract.js --deck hardfest_v9 vote meme-boxing
"$RUNTIME_NODE" prep/deck/pptx/build_artifact.mjs vote meme-boxing
"$RUNTIME_PYTHON" prep/deck/pptx/finish_package.py "$PPTX_WORK/stages.pptx"
"$RUNTIME_NODE" prep/deck/pptx/build_approve_v9.mjs
"$RUNTIME_PYTHON" prep/deck/pptx/assemble_v9.py
"$RUNTIME_PYTHON" prep/deck/hardfest_v9/notes/generate_script_v9.py
"$RUNTIME_NODE" prep/deck/pptx/finalize_v9.mjs "${1:-$TASK_ROOT/prep/deck/hardfest2026_deck_v9.pptx}"
