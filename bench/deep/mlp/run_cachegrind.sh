#!/usr/bin/env bash
# Симуляция кэша valgrind/cachegrind для алгоритмов дедупликации: инструкции и промахи на элемент.
# Три модели кэша: x86 (этот Xeon: L1d 48K/12, LL=L2 2M/16, строка 64), appleP (128K/8, 16M/16, строка 128),
# appleE (64K/8, 4M/16, строка 128). Считается только внутри run_* (toggle-collect).
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p results/cachegrind
out=results/cachegrind/summary.csv
echo "model,alg,N,U,Ir,Dr,D1mr,DLmr,Dw,D1mw,DLmw" > "$out"
run() {  # model alg N U cache-args...
  local model=$1 alg=$2 N=$3 U=$4; shift 4
  local f=results/cachegrind/cg_${model}_${alg}_${N}_${U}.out
  valgrind --tool=cachegrind --cache-sim=yes "$@" --toggle-collect='run_*' --cachegrind-out-file="$f" ./build/cg_dedup "$alg" "$N" "$U" > /dev/null 2> "$f.log"
  local s; s=$(grep '^summary:' "$f" | sed 's/summary: //')
  # summary: Ir I1mr ILmr Dr D1mr DLmr Dw D1mw DLmw
  echo "$model,$alg,$N,$U,$(echo "$s" | awk '{print $1","$4","$5","$6","$7","$8","$9}')" >> "$out"
}
X86="--I1=32768,8,64 --D1=49152,12,64 --LL=2097152,16,64"
AP="--I1=196608,6,128 --D1=131072,8,128 --LL=16777216,16,128"
AE="--I1=131072,8,128 --D1=65536,8,128 --LL=4194304,16,128"
for cfg in "x86:$X86" "appleP:$AP" "appleE:$AE"; do
  model=${cfg%%:*}; args=${cfg#*:}
  for NU in "1048576 1048576" "1048576 524288" "524288 262144"; do
    set -- $NU
    for alg in sort uset flat open radix; do
      echo "[$(date +%T)] $model $alg N=$1 U=$2"
      run "$model" "$alg" "$1" "$2" $args
    done
  done
done
# разбивка по функциям для узловой таблицы (инструкции в malloc/free) — модель x86, N = U = 2^20
cg_annotate results/cachegrind/cg_x86_uset_1048576_1048576.out > results/cachegrind/annotate_x86_uset_1M.txt 2>&1
cg_annotate results/cachegrind/cg_x86_flat_1048576_1048576.out > results/cachegrind/annotate_x86_flat_1M.txt 2>&1
cg_annotate results/cachegrind/cg_x86_sort_1048576_1048576.out > results/cachegrind/annotate_x86_sort_1M.txt 2>&1
echo DONE
