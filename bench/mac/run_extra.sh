#!/usr/bin/env bash
# Карта победителей: кто быстрее при каждом размере, если все id разные (E2U) и если разных 10 % (E2D).
# Работает на Mac и на Linux (CI): на Linux процесс закрепляется на одном ядре.
#   ./run_extra.sh <метка> [ui background]    → results/<метка>/E2U.csv, E2D.csv
set -uo pipefail
cd "$(dirname "$0")"
LABEL=${1:?метка}; shift
QOSES=${*:-ui background}
OUT=results/$LABEL
mkdir -p "$OUT"
B=build/dedup_bench
BLOCKS=${BLOCKS:-7}
log() { echo "[$(date +%T)] $*" | tee -a "$OUT/run.log" >&2; }
PIN=()
if [[ $(uname) == Linux ]]; then PIN=(taskset -c "${CPU:-2}"); QOSES=ui; fi
command -v caffeinate >/dev/null && PIN=(caffeinate -i)
b() {
  local exp=$1 qos=$2; shift 2
  local out=$OUT/$exp.csv
  [[ -s $out ]] || $B --header > "$out"
  log "$exp qos=$qos $*"
  "${PIN[@]}" $B --exp "$exp" --session "$LABEL/$qos" --qos "$qos" --blocks "$BLOCKS" "$@" >> "$out" \
    || log "FAILED: $exp $*"
}
for q in $QOSES; do
  for n in 1024 4096 16384 65536 262144 524288 1048576 2097152 4194304; do
    b E2U "$q" --n $n --u $n --algs sort,uset,radix,flat
    b E2D "$q" --n $n --u $((n / 10)) --algs sort,uset,radix,flat
  done
done
log "готово: $OUT/E2U.csv, E2D.csv"
