#!/usr/bin/env bash
# Mac в режиме QoS utility — та же строчка, что на iPhone уводит работу на E-ядра (слайд qos).
#   ./run_utility.sh <метка>   → results/<метка>/E1.csv, E2.csv (session <метка>/utility), ≈2–3 минуты
set -uo pipefail
cd "$(dirname "$0")"
LABEL=${1:?метка, например m2c}
OUT=results/$LABEL
mkdir -p "$OUT"
B=build/dedup_bench
BLOCKS=${BLOCKS:-7}
log() { echo "[$(date +%T)] $*" | tee -a "$OUT/run.log" >&2; }
RUN=(); command -v caffeinate >/dev/null && RUN=(caffeinate -i)
b() {
  local exp=$1; shift
  local out=$OUT/$exp.csv
  [[ -s $out ]] || $B --header > "$out"
  log "$exp qos=utility $*"
  "${RUN[@]}" $B --exp "$exp" --session "$LABEL/utility" --qos utility --blocks "$BLOCKS" "$@" >> "$out" \
    || log "FAILED: $exp $*"
}
b E1 --n 1048576 --u 1048576 --algs sort,uset,radix,flat
for n in 524288 1048576; do b E2 --n $n --u $((n / 2)) --algs sort,uset,flat; done
log "готово: $OUT/E1.csv, E2.csv"
