#!/usr/bin/env bash
# Матрица callgrind --branch-sim=yes --cache-sim=yes: промахи предсказания на элемент.
# Сбор счётчиков только внутри вызова алгоритма (CALLGRIND_TOGGLE_COLLECT в branch_bench.cpp).
# Модель предсказателя callgrind — простая (таблица 2-битных счётчиков, индекс = адрес ⊕ короткая
# история), она НЕ «выучивает» вход: это честная оценка «невыученных» ветвлений по данным.
#   ./run_cg.sh            — вся матрица; результаты: results/cg.csv, results/cg/*.out, *.ann.txt
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p results/cg
OUT=results/cg.csv
CPU=${CPU:-1}
echo "label,toolchain,alg,order,N,U,pool,calls,Ir_el,Bc_el,Bcm_el,Bcm_pct,Bi_el,Bim_el,D1mr_el,DLmr_el,Dr_el" > "$OUT"

run() {  # run <bin> <alg> <order> <N> <U> <calls> [extra label]
  local bin=$1 alg=$2 order=$3 n=$4 u=$5 calls=$6 extra=${7:-}
  local tc; tc=$("$bin" --info)
  local label="${tc}_${alg}_${order}_N${n}_U${u}${extra}"
  local f="results/cg/$label.out"
  taskset -c "$CPU" valgrind --tool=callgrind --collect-atstart=no --branch-sim=yes --cache-sim=yes \
    --callgrind-out-file="$f" "$bin" --mode cg --algs "$alg" --order "$order" --n "$n" --u "$u" \
    --pool 8 --calls "$calls" > /dev/null 2> "results/cg/$label.log" \
    || { echo "FAILED $label" >&2; return; }
  ./cg_parse.py "$f" $((n * calls)) "$label" "$tc" "$alg" "$order" "$n" "$u" 8 "$calls" >> "$OUT"
  callgrind_annotate --show=Bcm,Bc,Ir --sort=Bcm --threshold=99.5 "$f" 2>/dev/null \
    | grep -v -E "^\s*$" | head -60 > "results/cg/$label.ann.txt"
  echo "[$(date +%T)] $label $(tail -1 "$OUT" | cut -d, -f9-12)"
}

G=build/bb_gcc; C=build/bb_clang_libcxx

# 1. Основная матрица: 4 алгоритма × 2 библиотеки × случайный/отсортированный × N = 1024, 65536 (U = N/2)
for bin in $G $C; do
  for order in random sorted; do
    for alg in sort uset flat radix; do
      run $bin $alg $order 1024 512 64
      run $bin $alg $order 65536 32768 8
    done
  done
done

# 2. Разделение sort на фазы: только сортировка / только unique (на отсортированном входе)
for bin in $G $C; do
  run $bin sortonly random 65536 32768 8
  run $bin sortonly sorted 65536 32768 8
  run $bin unique sorted 65536 32768 8
  run $bin sortonly random 65536 65536 8
done

# 3. Все уникальные (условия голосования), N = 65536
for bin in $G $C; do
  for alg in sort uset flat radix; do run $bin $alg random 65536 65536 8; done
done

# 4. Кривая по N для sort (случайный, U = N/2): где именно рождаются промахи
for bin in $G $C; do
  for n in 16 24 32 64 128 256 4096 16384; do
    calls=$(( 65536 / n )); [[ $calls -lt 8 ]] && calls=8
    run $bin sort random $n $((n / 2)) $calls
  done
done

# 5. libc++ с std::less<u64> — инстанцируется из заголовков (с -g): построчная атрибуция
run $C sortless random 65536 32768 8
run $C sortless random 1024 512 64
callgrind_annotate --auto=yes --show=Bcm,Bc,Ir --sort=Bcm --threshold=99 \
  results/cg/clang18-libc++_sortless_random_N65536_U32768.out 2>/dev/null > results/cg/lines_libcxx_sortless_random_N65536.txt
callgrind_annotate --auto=yes --show=Bcm,Bc,Ir --sort=Bcm --threshold=99 \
  results/cg/gcc13-libstdc++_sort_random_N65536_U32768.out 2>/dev/null > results/cg/lines_libstdcxx_sort_random_N65536.txt
callgrind_annotate --auto=yes --show=Bcm,Bc,Ir --sort=Bcm --threshold=99 \
  results/cg/gcc13-libstdc++_uset_random_N65536_U32768.out 2>/dev/null > results/cg/lines_libstdcxx_uset_random_N65536.txt
callgrind_annotate --auto=yes --show=Bcm,Bc,Ir --sort=Bcm --threshold=99 \
  results/cg/gcc13-libstdc++_flat_random_N65536_U32768.out 2>/dev/null > results/cg/lines_libstdcxx_flat_random_N65536.txt
echo DONE_CG
