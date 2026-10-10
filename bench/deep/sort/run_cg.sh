#!/usr/bin/env bash
# Детерминированные замеры (счётчик сравнений, callgrind) — на ядре 0, параллельно с timing.
set -uo pipefail
cd "$(dirname "$0")"
R=results; T="taskset -c 0"
log() { echo "$(date -u +%H:%M:%S) $*" >> $R/run_cg.log; }
log start
$T build/sortcnt_gcc 1048576 > $R/sortcnt_gcc.csv 2>&1; log "sortcnt gcc"
$T build/sortcnt_libcxx 1048576 > $R/sortcnt_libcxx.csv 2>&1; log "sortcnt libcxx"
mkdir -p $R/cg
cg() { # $1 bin $2 alg $3 kind $4 label
  $T valgrind --tool=callgrind --branch-sim=yes --cache-sim=yes --toggle-collect='run_alg*' \
     --callgrind-out-file=$R/cg/$4.out build/$1 $2 262144 $3 > $R/cg/$4.log 2>&1
  callgrind_annotate --threshold=99 $R/cg/$4.out > $R/cg/$4.txt 2>&1
  log "cg $4"
}
for lib in gcc libcxx; do
  for alg in sort sort_cmp pdq pdqb radix unique; do cg sortcg_$lib $alg random ${lib}_${alg}_random; done
  for kind in sorted equal runs reverse; do cg sortcg_$lib sort $kind ${lib}_sort_${kind}; done
done
cg sortcg_gcc_avx2 simd random gcc_simd_avx2_random
cg sortcg_gcc_avx2 sort random gcc_sort_avx2_random
log "ALL DONE"
