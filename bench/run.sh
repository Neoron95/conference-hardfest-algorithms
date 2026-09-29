#!/usr/bin/env bash
# Прогон экспериментов E1–E9. Каждая конфигурация — отдельный процесс,
# закреплённый на одном ядре; строки CSV дописываются в results/<E>.csv сразу.
#   ./run.sh s1            — все эксперименты, метка сессии s1
#   ./run.sh s2 E1 E2      — только выбранные
set -uo pipefail
cd "$(dirname "$0")"
SESSION=${1:?session label}; shift
EXPS=${*:-E1 E2 E2b E3 E4 E5 E6 E7 E8 E9 E10}
CPU=${CPU:-2}
BLOCKS=${BLOCKS:-7}
GCC=build/bench_gcc
CXX=build/bench_clang_libcxx
CLS=build/bench_clang_libstdcxx
mkdir -p results
N20=1048576

log() { echo "[$(date +%T)] $*" | tee -a results/run.log >&2; }
b() {  # b <exp> <binary> [args...] — один процесс, строки в results/<exp>.csv
  local exp=$1 bin=$2; shift 2
  [[ -x $bin ]] || { log "skip $bin (нет бинарника)"; return; }
  local out=results/$exp.csv
  [[ -s $out ]] || $bin --header > "$out"
  log "$exp $bin $*"
  taskset -c "$CPU" "$bin" --exp "$exp" --session "$SESSION" --blocks "$BLOCKS" "$@" >> "$out" \
    || log "FAILED: $exp $bin $*"
}

env_info() {
  {
    echo "date: $(date -Is)"; echo "session: $SESSION"; uname -r
    lscpu | grep -E 'Model name|^CPU\(s\)|L1d|L2|L3|Hypervisor'
    echo "THP: $(cat /sys/kernel/mm/transparent_hugepage/enabled)"
    ldd --version | head -1; g++ --version | head -1; clang++-18 --version | head -1
    for x in $GCC $CLS $CXX; do [[ -x $x ]] && echo "$x: $($x --info)"; done
    echo "load: $(cat /proc/loadavg)"
  } >> results/env.txt
}

env_info
for E in $EXPS; do
  case $E in
  E1)  # N = U = 2^20, все алгоритмы, все связки
    for bin in $GCC $CXX $CLS; do b E1 $bin --n $N20 --u $N20; done ;;
  E2)  # кривая U = N/2
    for n in 16 64 256 1024 4096 16384 65536 262144 524288 1048576 2097152 4194304; do
      b E2 $GCC --n $n --u $((n / 2)) --algs sort,uset,radix,flat
      b E2 $CXX --n $n --u $((n / 2)) --algs sort,uset
    done ;;
  E2b)  # контроль к E2 на малых N: пул не 64 входа, а 2^18 / N (256K элементов в пуле)
    for n in 16 64 256 1024 4096; do
      for bin in $GCC $CXX; do
        b E2b $bin --n $n --u $((n / 2)) --algs sort,uset --pool $((262144 / n)) --variant pool_256K_elems
      done
    done ;;
  E3)  # доля уникальных, N = 2^20
    for bin in $GCC $CXX; do
      b E3 $bin --n $N20 --u 1 --variant all_equal
      for f in 0.01 0.1 0.5 1; do b E3 $bin --n $N20 --ufrac $f --variant "ufrac_$f"; done
    done ;;
  E4)  # порядок входа, N = 2^20, U = N/2
    for bin in $GCC $CXX; do
      for o in random runs sorted; do b E4 $bin --n $N20 --u $((N20 / 2)) --order $o; done
    done ;;
  E5)  # «бенчмарк врал»: sort+unique, N = 1024, U = 512
    # P = число разных входов, batch = буферов, подготовленных до таймера
    # (batch = 1: один буфер, вход восстанавливается перед каждым вызовом).
    for bin in $GCC $CXX; do
      for alg in sort radix; do
        o="--n 1024 --u 512 --algs $alg --work $N20 --blocks 9"
        b E5 $bin $o --pool 1  --batch 1  --variant a_one_array_restored
        b E5 $bin $o --pool 1  --batch 64 --variant b_64_identical_copies
        b E5 $bin $o --pool 64 --batch 64 --variant c_64_different
        b E5 $bin $o --pool 8  --batch 8  --variant d_8_different_64KB
        b E5 $bin $o --pool 4  --batch 4  --variant d4_4_different_32KB
        b E5 $bin $o --pool 64 --batch 1  --variant e_64_different_one_buffer
        for p in 2 4 8 16; do b E5 $bin $o --pool $p --batch 1 --variant "f_${p}_different_one_buffer"; done
        for k in 4 8 16; do b E5 $bin $o --pool 1 --batch $k --variant "g_${k}_identical_copies"; done
      done
    done ;;
  E6)  # sort, все ключи равны
    for bin in $GCC $CXX $CLS; do b E6 $bin --n $N20 --u 1 --algs sort --blocks 9; done ;;
  E7)  # плотные id 1..U (как rowid SQLite) против случайных 64-бит, N = 2U = 2^20
    for bin in $GCC $CXX; do
      for k in random dense; do b E7 $bin --n $N20 --u $((N20 / 2)) --keys $k; done
    done ;;
  E8)  # локальные 2^20 отсортированных уникальных + дельта 2^16 с 50% дублей
    for bin in $GCC $CXX; do
      b E8 $bin --keys e8 --nlocal $N20 --n $((N20 + 65536)) \
        --algs sort,uset,radix,flat,merge_inplace,merge_union
    done ;;
  E9)  # доп.: прозрачные huge pages для кучи glibc (GLIBC_TUNABLES=glibc.malloc.hugetlb=1)
    for bin in $GCC $CXX; do
      GLIBC_TUNABLES=glibc.malloc.hugetlb=1 b E9 $bin --n $N20 --u $N20 --variant thp_malloc
      b E9 $bin --n $N20 --u $N20 --variant default_malloc
      GLIBC_TUNABLES=glibc.malloc.hugetlb=1 b E9 $bin --n $N20 --u $((N20 / 2)) --algs sort,uset --variant thp_malloc
      b E9 $bin --n $N20 --u $((N20 / 2)) --algs sort,uset --variant default_malloc
    done ;;
  E10)  # unordered_set: выгрузка v.assign (2 обхода узлов) против одного обхода
    for bin in $GCC $CXX; do
      b E10 $bin --n $N20 --u $N20 --algs sort,uset,uset_1pass
      b E10 $bin --n $N20 --u $((N20 / 2)) --algs sort,uset,uset_1pass
    done ;;
  *) log "unknown experiment $E" ;;
  esac
done
log "session $SESSION done: $EXPS"
