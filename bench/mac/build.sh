#!/usr/bin/env bash
# Сборка замеров для Mac (Apple clang + системная libc++). Нужны: Xcode Command Line Tools, cmake, git.
#   ./build.sh            → build/dedup_bench, probe, mlp, sortfam, alloc, counters
# Abseil (flat_hash_set) скачивается и собирается один раз в build/.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
CXX=${CXX:-clang++}
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -DNDEBUG"}
JOBS=$(sysctl -n hw.ncpu 2>/dev/null || nproc)
ABSL_TAG=20260817.0
ABSL_SRC=${ABSL_SRC:-build/abseil-cpp}
ABSL_BUILD=${ABSL_BUILD:-build/absl}

command -v "$CXX" >/dev/null || { echo "нет $CXX: xcode-select --install" >&2; exit 1; }
command -v cmake >/dev/null || { echo "нет cmake: brew install cmake" >&2; exit 1; }

if [[ ! -f "$ABSL_SRC/absl/container/flat_hash_set.h" ]]; then
  git -c advice.detachedHead=false clone -q --depth 1 --branch "$ABSL_TAG" https://github.com/abseil/abseil-cpp "$ABSL_SRC"
fi
if [[ ! -f "$ABSL_BUILD/absl/container/libabsl_raw_hash_set.a" ]]; then
  echo "сборка Abseil (1–3 минуты)…"
  cmake -S "$ABSL_SRC" -B "$ABSL_BUILD" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20 \
        -DABSL_PROPAGATE_CXX_STD=ON -DABSL_BUILD_TESTING=OFF -DCMAKE_CXX_COMPILER="$CXX" > build/absl.cmake.log 2>&1
  cmake --build "$ABSL_BUILD" -j"$JOBS" --target raw_hash_set hash > build/absl.make.log 2>&1
fi
LIBS=$(find "$ABSL_BUILD" -name 'libabsl_*.a' | sort | tr '\n' ' ')
if [[ $(uname) == Linux ]]; then LIBS="-Wl,--start-group $LIBS -Wl,--end-group"
else LIBS="$LIBS -framework CoreFoundation"; fi  # absl/time (часовые пояса) на macOS ходит в CoreFoundation

ok=(); fail=()
build() {  # build <имя> <исходник> [флаги...]
  local name=$1 src=$2; shift 2
  if $CXX $CXXFLAGS -I"$ABSL_SRC" "$src" "$@" -o "build/$name" 2> "build/$name.log"; then ok+=("$name")
  else
    fail+=("$name")
    echo "НЕ СОБРАЛСЯ $name — первые ошибки из build/$name.log:" >&2
    grep -m 12 -E 'error|Undefined|undefined|ld:' "build/$name.log" >&2 || tail -n 12 "build/$name.log" >&2
  fi
}
build dedup_bench ../dedup_bench.cpp $LIBS
build counters counters.cpp $LIBS
build alloc alloc.cpp $LIBS
build sortfam sortfam.cpp
build probe probe.cpp
build mlp mlp.cpp

echo "собрано: ${ok[*]}"
[[ ${#fail[@]} -eq 0 ]] || echo "не собрано: ${fail[*]}" >&2
[[ -x build/dedup_bench ]] && build/dedup_bench --selftest && echo "dedup_bench: $(build/dedup_bench --info)"
