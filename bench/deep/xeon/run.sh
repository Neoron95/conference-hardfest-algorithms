#!/usr/bin/env bash
# Серия «Xeon и серверная иерархия памяти» (10.10.2026). Всё одним потоком на vCPU 2, как в bench/run.sh.
#   ./run.sh            — всё; результаты в results/
set -uo pipefail
cd "$(dirname "$0")"
R=results; mkdir -p $R build
CPU=${CPU:-2}
BENCH=../../build/bench_gcc
log() { echo "[$(date +%T)] $*" | tee -a $R/run.log >&2; }
steal() { awk '/^cpu /{print "steal_jiffies="$9" user="$2" idle="$5}' /proc/stat; }

{ echo "date: $(date -Is)"; uname -r; lscpu | grep -E 'Model name|^CPU\(s\)|Model:|Stepping|L1d|L2|L3|Hypervisor|Thread'; grep -m1 'model name' /proc/cpuinfo
  echo "THP: enabled=$(cat /sys/kernel/mm/transparent_hugepage/enabled) defrag=$(cat /sys/kernel/mm/transparent_hugepage/defrag) khugepaged/defrag=$(cat /sys/kernel/mm/transparent_hugepage/khugepaged/defrag)"
  grep -E 'MemTotal|MemFree|Hugepagesize' /proc/meminfo; echo "load: $(cat /proc/loadavg)"; echo "steal before: $(steal)"; } > $R/env.txt

g++ -O2 lat.cpp -o build/lat && g++ -O3 -pthread bw.cpp -o build/bw && g++ -O2 ../../probe.cpp -o build/probe || exit 1

log "probe (как 29.09)"; taskset -c $CPU build/probe > $R/probe.txt 2>&1

SMALL=16,32,48,64,96,128,256,512,768,1024,1280,1536,1792,2048,2304,2560,3072,4096,6144,8192,12288,16384,24576,32768,49152,65536,98304,131072,196608,262144,393216,524288,786432,1048576
BIG=2048,3072,4096,8192,16384,32768,65536,131072,262144,524288,1048576
PAGES=4096,8192,16384,32768,65536,131072,262144,524288,1048576
log "lat A: line stride, no THP"; taskset -c $CPU build/lat --stride 64 --reps 2 --sizes $SMALL > $R/lat_line_4k.csv
log "lat B: line stride, THP";    taskset -c $CPU build/lat --stride 64 --thp --reps 2 --sizes $BIG > $R/lat_line_thp.csv
log "lat C: page stride, no THP"; taskset -c $CPU build/lat --stride 4096 --reps 2 --sizes $PAGES > $R/lat_page_4k.csv
log "lat D: page stride, THP";    taskset -c $CPU build/lat --stride 4096 --thp --reps 2 --sizes $PAGES > $R/lat_page_thp.csv
log "lat E: line stride, no THP, повтор больших точек"; taskset -c $CPU build/lat --stride 64 --reps 2 --sizes 16384,65536,262144,1048576 > $R/lat_line_4k_repeat.csv

log "bw"; { build/bw 1 1024; build/bw 4 768; build/bw 1 64; build/bw 4 64; build/bw 2 768; } > $R/bw.txt 2>&1

log "E9 повтор: flat/uset/sort, N=U=2^20, default против glibc.malloc.hugetlb=1, с minflt и vmstat"
vm() { grep -E '^(thp_fault_alloc|thp_fault_fallback|thp_collapse_alloc|compact_stall|compact_success|compact_fail|pgfault|allocstall_normal|allocstall_movable) ' /proc/vmstat | tr '\n' ' '; echo; }
{
  for variant in default thp; do
    for alg in flat uset sort; do
      echo "== $variant $alg"; echo "vmstat before: $(vm)"
      if [[ $variant == thp ]]; then
        GLIBC_TUNABLES=glibc.malloc.hugetlb=1 taskset -c $CPU $BENCH --exp E9d --session deep --blocks 3 --warmup 1 --n 1048576 --u 1048576 --algs $alg --faults 2>&1
      else
        taskset -c $CPU $BENCH --exp E9d --session deep --blocks 3 --warmup 1 --n 1048576 --u 1048576 --algs $alg --faults 2>&1
      fi
      echo "vmstat after:  $(vm)"
    done
  done
  echo "== strace -c flat default (blocks 1)"
  strace -f -c -e trace=mmap,munmap,brk,madvise,mprotect taskset -c $CPU $BENCH --exp E9s --session deep --blocks 1 --warmup 0 --n 1048576 --u 1048576 --algs flat 2>&1 | tail -15
  echo "== strace -c flat thp (blocks 1)"
  GLIBC_TUNABLES=glibc.malloc.hugetlb=1 strace -f -c -e trace=mmap,munmap,brk,madvise,mprotect taskset -c $CPU $BENCH --exp E9s --session deep --blocks 1 --warmup 0 --n 1048576 --u 1048576 --algs flat 2>&1 | tail -15
} > $R/e9_thp.txt 2>&1

log "callgrind: промахи D1 и L2 (как LL) на элемент, N=2^20"
for u in 1048576 524288; do for alg in sort uset radix flat; do
  out=$R/cg_${alg}_U${u}.out
  taskset -c $CPU valgrind --tool=callgrind --cache-sim=yes --I1=65536,16,64 --D1=49152,12,64 --LL=2097152,16,64 \
    --callgrind-out-file=$out $BENCH --exp CG --session deep --blocks 1 --warmup 0 --work 1 --pool 1 --n 1048576 --u $u --algs $alg > /dev/null 2> $R/cg_${alg}_U${u}.log
  callgrind_annotate --inclusive=yes $out 2>/dev/null | grep -E "alg_|PROGRAM TOTALS|^ *Ir" | head -8 > $R/cg_${alg}_U${u}.txt
  log "  cg $alg U=$u: $(grep alg_ $R/cg_${alg}_U${u}.txt | head -1)"
done; done

echo "steal after: $(steal)" >> $R/env.txt; echo "load after: $(cat /proc/loadavg)" >> $R/env.txt
log "done"
