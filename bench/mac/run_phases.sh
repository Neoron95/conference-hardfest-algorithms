#!/usr/bin/env bash
# Счётчики M2 по фазам хеш-таблиц: вставки / выгрузка / деструктор для std::unordered_set,
# той же таблицы на pmr-буфере (без malloc и free) и flat_hash_set. Нужен sudo.
#   sudo ./run_phases.sh <метка>   → results/<метка>/counters_phases_{ui,background}.csv, ≈1–2 минуты
set -uo pipefail
cd "$(dirname "$0")"
LABEL=${1:?метка, например m2c}
OUT=results/$LABEL
mkdir -p "$OUT"
[[ $(id -u) -eq 0 ]] || { echo "запустите через sudo" >&2; exit 1; }
for q in ui background; do
  echo "[$(date +%T)] counters --phases qos=$q" | tee -a "$OUT/run.log" >&2
  ./build/counters --phases --qos "$q" --reps 7 > "$OUT/counters_phases_$q.csv" 2>> "$OUT/run.log" \
    || echo "FAILED phases $q (см. $OUT/run.log)" | tee -a "$OUT/run.log" >&2
done
chown -R "${SUDO_USER:-$(logname)}" "$OUT" 2>/dev/null || true
echo "готово: $OUT/counters_phases_*.csv"
