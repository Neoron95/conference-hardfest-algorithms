#!/usr/bin/env bash
# Поиск в готовой таблице: доля попаданий p = 0 / 0,5 / 1, таблица от L1 до RAM.
#   ./run_lookup.sh → results/lookup.csv
set -uo pipefail
cd "$(dirname "$0")"
OUT=results/lookup.csv
CPU=${CPU:-3}
echo "toolchain,kind,U,p,Q,ns_per_query_med,min,max,sink" > "$OUT"
for bin in build/lk_gcc build/lk_clang_libcxx; do
  for kind in uset flat lower_bound; do
    for U in 1024 65536 1048576 4194304; do
      for p in 0 0.5 1; do
        taskset -c "$CPU" "$bin" "$kind" "$U" "$p" 65536 7 >> "$OUT" || echo "FAILED $bin $kind $U $p" >&2
      done
    done
    echo "[$(date +%T)] $bin $kind done"
  done
done
echo DONE_LOOKUP
