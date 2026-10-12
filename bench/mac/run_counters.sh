#!/usr/bin/env bash
# Аппаратные счётчики M2 (такты, команды, ветвления, ошибки предсказателя, промахи L1D/TLB). Нужен sudo.
#   sudo ./run_counters.sh <метка из run.sh>   → results/<метка>/counters.csv, ≈3–5 минут
set -uo pipefail
cd "$(dirname "$0")"
LABEL=${1:?метка, как в run.sh}
OUT=results/$LABEL
mkdir -p "$OUT"
[[ $(id -u) -eq 0 ]] || { echo "запустите через sudo" >&2; exit 1; }
for q in ui background; do
  echo "[$(date +%T)] counters qos=$q" | tee -a "$OUT/run.log" >&2
  ./build/counters --qos "$q" --reps 5 > "$OUT/counters_$q.csv" 2>> "$OUT/run.log" \
    || echo "FAILED counters $q (см. $OUT/run.log)" | tee -a "$OUT/run.log" >&2
done
chown -R "${SUDO_USER:-$(logname)}" "$OUT" 2>/dev/null || true
echo "готово: $OUT/counters_*.csv"
