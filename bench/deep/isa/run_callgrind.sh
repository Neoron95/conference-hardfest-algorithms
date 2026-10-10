#!/usr/bin/env bash
# Инструкции на элемент по фазам: callgrind, сбор только внутри вызовов 2..K (K=3),
# первый вызов — прогрев кучи. Результат: results/cg_<toolchain>_<alg>_<N>_<U>.out и
# таблица results/instructions.csv (см. parse_callgrind.py).
set -euo pipefail
cd "$(dirname "$0")"
CALLS=${CALLS:-3}
run() {  # $1 bin $2 tag $3 alg $4 N $5 U [extra args]
  local bin=$1 tag=$2 alg=$3 N=$4 U=$5; shift 5
  local out=results/cg_${tag}_${alg}_${N}_${U}$( [[ $# -gt 0 ]] && echo "_$(echo "$@" | tr -d ' -')" ).out
  [[ -f $out ]] && return
  valgrind --tool=callgrind --collect-atstart=no --callgrind-out-file=$out \
    $bin --alg $alg --n $N --u $U --calls $CALLS "$@" > ${out%.out}.txt 2> ${out%.out}.log
}
for tc in gcc:build/isa_gcc libcxx:build/isa_clang_libcxx; do
  tag=${tc%%:*}; bin=${tc#*:}
  for N in 262144 1048576; do
    for U in $N $((N/2)); do
      for alg in sort uset flat radix; do run $bin $tag $alg $N $U; done
    done
  done
  # слияние: 2^20 локальных + 2^16 дельты (как E8)
  run $bin $tag merge $((1048576+65536)) 0 --nlocal 1048576
  # libc++: reserve(1000000) -> простое число ячеек -> деление (контроль к «деление дорого»)
  [[ $tag == libcxx ]] && run $bin $tag uset 1048576 1048576 --reserve 1000000
done
echo done
