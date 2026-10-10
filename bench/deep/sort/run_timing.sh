#!/usr/bin/env bash
# Замеры, чувствительные ко времени: строго последовательно на ядре 2.
set -uo pipefail
cd "$(dirname "$0")"
R=results; T="taskset -c 2"
log() { echo "$(date -u +%H:%M:%S) $*" >> $R/run_timing.log; }
log "start $(uname -r) $(grep -m1 'model name' /proc/cpuinfo)"
g++ -O2 ../../probe.cpp -o build/probe 2>/dev/null && $T build/probe > $R/probe.txt 2>&1; log "probe done"
$T build/membw 7 > $R/membw.csv 2> $R/membw.err; log "membw done"
$T build/radix_deep --n 1048576 --keys random > $R/radix_1M_random.csv 2>&1; log "radix 1M random done"
$T build/radix_deep --n 1048576 --keys dense --variants r8,r8_force,r8_swwc,full > $R/radix_1M_dense.csv 2>&1; log "radix 1M dense done"
$T build/radix_deep --n 262144 --keys random --reps 15 > $R/radix_256K_random.csv 2>&1; log "radix 256K done"
$T build/radix_deep --n 4194304 --keys random --reps 5 > $R/radix_4M_random.csv 2>&1; log "radix 4M done"
$T build/radix_deep_native --n 1048576 --keys random --variants r8,r8_swwc,r8_swwc_nt,r11,full > $R/radix_1M_random_native.csv 2>&1; log "radix native done"
for b in sortphase_gcc sortphase_libcxx sortphase_clang_libstdcxx sortphase_gcc_native sortphase_libcxx_native; do
  $T build/$b > $R/$b.csv 2>&1; log "$b done"
done
for b in simdsort_base simdsort_native simdsort_avx2 simdsort_avx512 simdsort_libcxx_base simdsort_libcxx_avx512; do
  $T build/$b 9 > $R/$b.csv 2>&1; log "$b done"
done
# базовая линия на этой VM (она не та, что в ../../results: L3 480 МиБ вместо 260)
B=../../build
for bin in bench_gcc bench_clang_libcxx; do
  $B/$bin --header > $R/baseline_$bin.csv
  $T $B/$bin --exp E1 --session deep --n 1048576 --u 1048576 --algs sort,uset,radix,flat >> $R/baseline_$bin.csv 2>>$R/run_timing.log
  $T $B/$bin --exp E6 --session deep --n 1048576 --u 1 --algs sort >> $R/baseline_$bin.csv 2>>$R/run_timing.log
  $T $B/$bin --exp E4 --session deep --n 1048576 --u 524288 --order sorted --algs sort,uset >> $R/baseline_$bin.csv 2>>$R/run_timing.log
  log "baseline $bin done"
done
log "ALL DONE"
