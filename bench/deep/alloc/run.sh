#!/usr/bin/env bash
# Прогон декомпозиции unordered_set по аллокаторам. Ядро задаётся CPU (по умолчанию 3).
set -uo pipefail
cd "$(dirname "$0")"
CPU=${CPU:-3}
N=${N:-1048576}
CALLS=${CALLS:-9}
OUT=results/uset_decomp.csv
build/uset_decomp_gcc --header > "$OUT"
: > results/uset_decomp_addr.txt
for bin in build/uset_decomp_gcc build/uset_decomp_clang_libcxx; do
  for u in $N $((N / 2)); do
    for dump in assign 1pass; do
      echo "[$(date +%T)] $bin U=$u dump=$dump" >&2
      taskset -c "$CPU" "$bin" --n "$N" --u "$u" --calls "$CALLS" --dump "$dump" --addr 2>&1 \
        | tee -a results/uset_decomp_raw.log | awk -v f="$OUT" -v a=results/uset_decomp_addr.txt '/^addr,/{print >> a; next} {print >> f}'
    done
  done
done
# тот же std-вариант под jemalloc 5.3 (LD_PRELOAD) — другой аллокатор, тот же код
for bin in build/uset_decomp_gcc build/uset_decomp_clang_libcxx; do
  for u in $N $((N / 2)); do
    echo "[$(date +%T)] jemalloc $bin U=$u" >&2
    LD_PRELOAD=/usr/lib/x86_64-linux-gnu/libjemalloc.so.2 taskset -c "$CPU" "$bin" --n "$N" --u "$u" --calls "$CALLS" --dump assign --variants std,node,flat --addr 2>&1 \
      | sed 's/^\([^,]*\),\([^,]*\),/\1,\2_jemalloc,/' | awk -v f="$OUT" -v a=results/uset_decomp_addr.txt '/^addr,/{print >> a; next} {print >> f}'
  done
done
echo done
