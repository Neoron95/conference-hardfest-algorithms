#!/usr/bin/env bash
# Замеры на Mac без sudo, ≈30–40 минут. Перед запуском: ноутбук от сети, остальные программы закрыты,
# не трогать машину во время прогона (caffeinate не даст ей уснуть).
#   ./run.sh [метка]      → results/<метка>/*.csv, env.txt, run.log
# Повторный запуск с той же меткой дописывает строки, а не стирает.
set -uo pipefail
cd "$(dirname "$0")"
LABEL=${1:-$(date +%Y%m%d-%H%M)}
OUT=results/$LABEL
mkdir -p "$OUT"
B=build/dedup_bench
BLOCKS=${BLOCKS:-7}
N20=1048576
log() { echo "[$(date +%T)] $*" | tee -a "$OUT/run.log" >&2; }

{
  echo "date: $(date)"; echo "label: $LABEL"
  sw_vers 2>/dev/null || uname -a
  for k in hw.model machdep.cpu.brand_string hw.ncpu hw.perflevel0.physicalcpu hw.perflevel1.physicalcpu \
           hw.perflevel0.l2cachesize hw.perflevel1.l2cachesize hw.l1dcachesize hw.cachelinesize hw.memsize \
           hw.pagesize; do
    echo "$k: $(sysctl -n "$k" 2>/dev/null)"
  done
  clang++ --version | head -1
  pmset -g batt 2>/dev/null | head -2
  echo "dedup_bench: $($B --info)"
} > "$OUT/env.txt"

b() {  # b <эксперимент> <qos> [аргументы dedup_bench...]
  local exp=$1 qos=$2; shift 2
  local out=$OUT/$exp.csv
  [[ -s $out ]] || $B --header > "$out"
  log "$exp qos=$qos $*"
  caffeinate -i $B --exp "$exp" --session "$LABEL/$qos" --qos "$qos" --blocks "$BLOCKS" "$@" >> "$out" \
    || log "FAILED: $exp $*"
}
one() {  # one <имя файла> <программа> [аргументы...]
  local name=$1; shift
  log "$name: $*"
  caffeinate -i "$@" >> "$OUT/$name.csv" 2>> "$OUT/run.log" || log "FAILED: $*"
}
command -v caffeinate >/dev/null || caffeinate() { [[ $1 == -i ]] && shift; "$@"; }

# 1. Паспорт ядра: частота и лестница задержек — P-ядро (ui) и E-ядро (background)
one probe build/probe --qos ui
one probe build/probe --qos background
# 2. Первый замер: N = U = 2^20 (слайды result, work, pace, flat)
b E1 ui --n $N20 --u $N20 --algs sort,uset,radix,flat
b E1 background --n $N20 --u $N20 --algs sort,uset,radix,flat
# 3. Кривая: U = N/2, от 16 до 4M (слайд curve)
for n in 16 64 256 1024 4096 16384 65536 131072 262144 524288 1048576 2097152 4194304; do
  b E2 ui --n $n --u $((n / 2)) --algs sort,uset,radix,flat
done
for n in 262144 524288 1048576; do b E2 background --n $n --u $((n / 2)) --algs sort,uset,flat; done
# 4. Фазы unordered_set и flat (слайд alloc-split): вставки / выгрузка / деструктор
[[ -s $OUT/E11_phases.csv ]] || echo "session,toolchain,set,N,U,insert_ns_el,unload_ns_el,dtor_ns_el,total_ns_el" > "$OUT/E11_phases.csv"
for u in $N20 $((N20 / 2)); do
  log "phases U=$u"
  caffeinate -i $B --phases --n $N20 --u $u --session "$LABEL/ui" --qos ui >> "$OUT/E11_phases.csv" || log "FAILED phases"
done
# 5. Аллокатор: стандартный, pmr-буфер, flat (слайд alloc-split)
one alloc build/alloc --qos ui --n $N20 --u $N20
one alloc build/alloc --qos ui --n $N20 --u $((N20 / 2))
# 6. Сколько чтений в полёте и окно (слайды inflight, window), P и E
one mlp build/mlp --qos ui
one mlp build/mlp --qos background
# 7. Семейство сортировок (слайд sortfamily)
one sortfam build/sortfam --qos ui
# 8. Доля разных (share), порядок входа (inputorder), выученный вход (learned), слияние (merge)
b E3 ui --n $N20 --u 1 --variant all_equal
for f in 0.01 0.1 0.5 1; do b E3 ui --n $N20 --ufrac $f --variant "ufrac_$f"; done
for o in random runs sorted; do b E4 ui --n $N20 --u $((N20 / 2)) --order $o; done
o="--n 1024 --u 512 --algs sort --work $N20 --blocks 9"
b E5 ui $o --pool 1 --batch 1 --variant a_one_array_restored
b E5 ui $o --pool 1 --batch 64 --variant b_64_identical_copies
b E5 ui $o --pool 64 --batch 64 --variant c_64_different
b E5 ui $o --pool 64 --batch 1 --variant e_64_different_one_buffer
for p in 2 4 8 16; do b E5 ui $o --pool $p --batch 1 --variant "f_${p}_different_one_buffer"; done
b E8 ui --keys e8 --nlocal $N20 --n $((N20 + 65536)) --algs sort,uset,radix,flat,merge_inplace,merge_union
log "готово: $OUT. Дальше — sudo ./run_counters.sh $LABEL"
