#!/usr/bin/env bash
# Rebuild V8 with bundled runtimes discovered by load_workspace_dependencies.
set -euo pipefail
: "${RUNTIME_NODE:?Set the bundled Node executable}"
: "${RUNTIME_PYTHON:?Set the bundled Python executable}"
: "${NODE_PATH:?Set the bundled Node packages directory}"
: "${PRESENTATIONS_SKILL_DIR:?Set the installed Presentations skill directory}"
TASK_ROOT="$(cd "$(dirname "$0")/../../.." && pwd)"
cd "$TASK_ROOT"
export HARDFEST_DECK=hardfest_v8
export PPTX_WORK="$TASK_ROOT/prep/.v8-build"
export ARTIFACT_TOOL_PATH="$NODE_PATH/@oai/artifact-tool/dist/artifact_tool.mjs"
export RUNTIME_NODE_MODULES="$NODE_PATH"
mkdir -p "$PPTX_WORK"
"$RUNTIME_PYTHON" prep/deck/hardfest_v8/notes/generate_script_v8.py
"$RUNTIME_PYTHON" prep/deck/pptx/sync_notes_v8.py
"$RUNTIME_NODE" prep/deck/pptx/extract.js --deck hardfest_v8
"$RUNTIME_NODE" prep/deck/pptx/build_artifact.mjs
"$RUNTIME_PYTHON" prep/deck/pptx/finish_package.py "$PPTX_WORK/v8-authored.pptx"
"$RUNTIME_PYTHON" prep/deck/pptx/merge_v8.py prep/deck/hardfest2026_deck_v7_6.pptx "$PPTX_WORK/v8-authored.pptx" "$PPTX_WORK/v8-candidate.pptx"
"$RUNTIME_PYTHON" prep/deck/pptx/validate_v8.py "$PPTX_WORK/v8-candidate.pptx"
"$RUNTIME_NODE" prep/deck/pptx/finalize_v8.mjs "${1:-$TASK_ROOT/prep/deck/hardfest2026_deck_v8.pptx}"
"$RUNTIME_NODE" prep/deck/pptx/export_pdf.js "$TASK_ROOT/prep/deck/hardfest2026_deck_v8.pdf"
"$RUNTIME_PYTHON" - <<'PY'
import shutil
from pathlib import Path
root=Path.cwd()
shutil.copyfile(root/'prep/.v8-build/v8-candidate.manifest.json',root/'prep/deck/hardfest_v8/deck_v8.json')
PY
