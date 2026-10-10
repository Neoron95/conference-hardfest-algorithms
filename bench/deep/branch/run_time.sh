#!/usr/bin/env bash
# «Привыкание» по времени (PMU в госте нет): N = 1024, один массив / копии / разные входы,
# для sort, uset, flat, radix; U = 512 (половина повторов) и U = 1024 (все уникальные).
# Плюс малые N (16, 64): пул 64 против большого пула — повтор E2b для всех четырёх алгоритмов.
#   ./run_time.sh [session]   → results/time.csv
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p results
S=${1:-t1}
OUT=results/time.csv
CPU=${CPU:-2}
[[ -s $OUT ]] || build/bb_gcc --header > "$OUT"
G=build/bb_gcc; C=build/bb_clang_libcxx
ALGS=sort,uset,flat,radix
b() { taskset -c "$CPU" "$@" >> "$OUT" || echo "FAILED $*" >&2; }

for bin in $G $C; do
  for u in 512 1024; do
    o="--n 1024 --u $u --algs $ALGS --work 1048576 --blocks 7 --session $S"
    b $bin $o --pool 1  --batch 1  --variant a_one_array_restored
    b $bin $o --pool 1  --batch 64 --variant b_64_identical_copies
    b $bin $o --pool 64 --batch 64 --variant c_64_different
    b $bin $o --pool 64 --batch 1  --variant e_64_different_one_buffer
    b $bin $o --pool 2  --batch 1  --variant f_2_different_one_buffer
    b $bin $o --pool 4  --batch 1  --variant f_4_different_one_buffer
    b $bin $o --pool 16 --batch 1  --variant f_16_different_one_buffer
    echo "[$(date +%T)] $bin U=$u done"
  done
  # отсортированный вход: ветвлений по данным у sort почти нет — «привыкать» нечему
  b $bin --n 1024 --u 512 --order sorted --algs $ALGS --work 1048576 --blocks 7 --session $S --pool 1 --batch 1 --variant s_one_array_sorted
  b $bin --n 1024 --u 512 --order sorted --algs $ALGS --work 1048576 --blocks 7 --session $S --pool 64 --batch 1 --variant s_64_different_sorted
  # малые N: пул 64 (как в сериях доклада) против пула 2^18/N (как E2b)
  for n in 16 64 256; do
    b $bin --n $n --u $((n / 2)) --algs $ALGS --work 1048576 --blocks 7 --session $S --pool 64 --variant pool64
    b $bin --n $n --u $((n / 2)) --algs $ALGS --work 1048576 --blocks 7 --session $S --pool $((262144 / n)) --variant pool_256K_elems
  done
done
echo DONE_TIME
