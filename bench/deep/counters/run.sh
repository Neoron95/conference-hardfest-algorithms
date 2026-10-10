#!/usr/bin/env bash
# Прогон матрицы под valgrind --tool=callgrind с симуляцией кэша и ветвлений.
# Три конфигурации кэша (одна и та же программа, «чужие» кэши):
#   X — этот Xeon:         I1 32K/8/64   D1 48K/12/64   LL 2 MiB/16/64   (L2 ядра; общий L3 не моделируется)
#   E — E-кластер M2 Pro:  I1 128K/8/128 D1 64K/8/128   LL 4 MiB/16/128  (ассоциативность — допущение)
#   P — P-кластер M2 Pro:  I1 192K/12/128 D1 128K/8/128 LL 16 MiB/16/128 (ассоциативность — допущение)
# Результаты: results/raw/<job>.out (callgrind), .meta (stdout харнесса), .ann (callgrind_annotate --inclusive).
#   ./run.sh            — вся матрица, 4 процесса параллельно
#   ./run.sh smoke      — одна короткая задача
set -uo pipefail
cd "$(dirname "$0")"
mkdir -p results/raw
JOBS=${JOBS:-4}
declare -A CACHE=(
  [X]="--I1=32768,8,64 --D1=49152,12,64 --LL=2097152,16,64"
  [E]="--I1=131072,8,128 --D1=65536,8,128 --LL=4194304,16,128"
  [P]="--I1=196608,12,128 --D1=131072,8,128 --LL=16777216,16,128"
)
BIN_gcc=build/counters_gcc
BIN_libcxx=build/counters_libcxx

# job <group> <tc> <cache> <args...>  — одна строка в список задач
job() {
  local group=$1 tc=$2 cache=$3; shift 3
  local v=BIN_$tc
  local name="${group}__${tc}__${cache}__$(echo "$*" | sed -E 's/--//g; s/ +/_/g')"
  echo "$name|${!v}|${CACHE[$cache]}|$*"
}
N20=1048576
gen() {
  if [[ ${1:-} == smoke ]]; then job smoke gcc X --alg uset --n 65536 --u 32768; return; fi
  # 1. Главная таблица: N = 2^20, U = N и N/2, случайный порядок, 4 алгоритма + фазы, обе связки, три кэша
  for tc in gcc libcxx; do for c in X E P; do for u in $N20 $((N20/2)); do
    for a in sort uset flat radix uset_phased flat_phased; do job main $tc $c --alg $a --n $N20 --u $u; done
  done; done; done
  # 2. Кривая по N (U = N/2): где возникает ступенька при LL 4 и 16 МиБ (и 2 МиБ для сравнения)
  for tc in gcc libcxx; do for c in X E P; do
    for n in 65536 131072 262144 524288 1048576 2097152; do
      for a in sort uset flat; do job curve $tc $c --alg $a --n $n --u $((n/2)); done
    done
  done; done
  # 3. Порядок входа: sort на random / runs / sorted (ветвления), N = 2^20, U = N/2
  for tc in gcc libcxx; do for o in random runs sorted; do
    job order $tc X --alg sort --n $N20 --u $((N20/2)) --order $o
    job order $tc X --alg uset --n $N20 --u $((N20/2)) --order $o
  done; done
  # 4. learned: N = 1024, U = 512, 64 вызова: один буфер / 64 копии / 64 разных
  for tc in gcc libcxx; do for m in learned_a learned_b learned_c; do for a in sort radix; do
    job learned $tc X --alg $a --n 1024 --u 512 --mode $m --calls 64
  done; done; done
  # 5. Слияние (E8): локальные 2^20 отсортированы + дельта 2^16
  for tc in gcc libcxx; do for c in X P; do
    for a in sort uset flat radix merge_inplace merge_union; do
      job merge $tc $c --alg $a --keys e8 --nlocal $N20 --n $((N20+65536))
    done
  done; done
  # 6. Плотные ключи (E7): uset и sort, N = 2^20, U = N/2
  for tc in gcc libcxx; do for a in sort uset; do job dense $tc X --alg $a --n $N20 --u $((N20/2)) --keys dense; done; done
}
run_one() {  # name|bin|cacheopts|args
  IFS='|' read -r name bin copts args <<< "$1"
  local out=results/raw/$name
  [[ -s $out.out ]] && { echo "skip $name"; return; }
  local t0=$(date +%s)
  valgrind --tool=callgrind --callgrind-out-file=$out.out --instr-atstart=no --collect-atstart=no \
    --toggle-collect=measured_call --cache-sim=yes --branch-sim=yes $copts $bin $args > $out.meta 2> $out.log \
    || { echo "FAILED $name (см. $out.log)"; return; }
  callgrind_annotate --inclusive=yes --threshold=100 $out.out > $out.ann 2>/dev/null
  echo "done $name in $(( $(date +%s) - t0 )) s"
}
export -f run_one
gen "${1:-}" > results/jobs.txt
echo "jobs: $(wc -l < results/jobs.txt)"
xargs -P "$JOBS" -I{} bash -c 'run_one "$@"' _ {} < results/jobs.txt
# Сравнения std::sort на элемент (без valgrind)
for tc in gcc libcxx; do for o in random runs sorted; do
  v=BIN_$tc; ${!v} --mode compares --n $N20 --u $((N20/2)) --order $o
done; done > results/compares.txt
echo "all done"
