#!/usr/bin/env bash
# Сборка dedup_bench в трёх связках:
#   build/bench_gcc              — GCC 13 + libstdc++
#   build/bench_clang_libcxx     — Clang 18 + libc++ (если установлен libc++-18-dev)
#   build/bench_clang_libstdcxx  — Clang 18 + libstdc++ (разделяет компилятор и библиотеку)
#
# Abseil LTS 20260817.0 собирается дважды: под libstdc++ (g++) и под libc++ (clang).
# Готовые каталоги можно подставить через переменные окружения:
#   ABSL_SRC=/путь/к/abseil-cpp  ABSL_GCC=/путь/к/сборке  ABSL_LIBCXX=/путь/к/сборке
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build

ABSL_TAG=20260817.0
ABSL_SRC=${ABSL_SRC:-build/abseil-cpp}
ABSL_GCC=${ABSL_GCC:-build/absl-gcc}
ABSL_LIBCXX=${ABSL_LIBCXX:-build/absl-libcxx}
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -DNDEBUG"}

if [[ ! -f "$ABSL_SRC/absl/container/flat_hash_set.h" ]]; then
  git clone --depth 1 --branch "$ABSL_TAG" https://github.com/abseil/abseil-cpp "$ABSL_SRC"
fi

build_absl() {  # $1 = каталог сборки, дальше — аргументы cmake
  local dir=$1; shift
  if [[ ! -f "$dir/absl/container/libabsl_raw_hash_set.a" ]]; then
    cmake -S "$ABSL_SRC" -B "$dir" -DCMAKE_BUILD_TYPE=Release -DCMAKE_CXX_STANDARD=20 \
          -DABSL_PROPAGATE_CXX_STD=ON -DABSL_BUILD_TESTING=OFF "$@" > "$dir.cmake.log" 2>&1
    cmake --build "$dir" -j"$(nproc)" --target raw_hash_set hash > "$dir.make.log" 2>&1
  fi
}

absl_libs() {  # все статические библиотеки сборки одной группой — порядок не важен
  echo "-Wl,--start-group $(find "$1" -name 'libabsl_*.a' | sort | tr '\n' ' ') -Wl,--end-group"
}

# 1. GCC + libstdc++
build_absl "$ABSL_GCC" -DCMAKE_C_COMPILER=gcc -DCMAKE_CXX_COMPILER=g++
g++ $CXXFLAGS -I"$ABSL_SRC" dedup_bench.cpp $(absl_libs "$ABSL_GCC") -o build/bench_gcc
echo "built build/bench_gcc: $(build/bench_gcc --info)"

# 2. Clang + libstdc++ (Abseil из сборки под libstdc++ — ABI совместим)
if command -v clang++-18 >/dev/null; then
  clang++-18 $CXXFLAGS -I"$ABSL_SRC" dedup_bench.cpp $(absl_libs "$ABSL_GCC") -o build/bench_clang_libstdcxx
  echo "built build/bench_clang_libstdcxx: $(build/bench_clang_libstdcxx --info)"
fi

# 3. Clang + libc++ (нужен libc++-18-dev и libc++abi-18-dev)
if command -v clang++-18 >/dev/null && echo '#include <vector>' | clang++-18 -stdlib=libc++ -x c++ -fsyntax-only - 2>/dev/null; then
  build_absl "$ABSL_LIBCXX" -DCMAKE_C_COMPILER=clang-18 -DCMAKE_CXX_COMPILER=clang++-18 \
             -DCMAKE_CXX_FLAGS=-stdlib=libc++ -DCMAKE_EXE_LINKER_FLAGS=-stdlib=libc++
  clang++-18 -stdlib=libc++ $CXXFLAGS -I"$ABSL_SRC" dedup_bench.cpp $(absl_libs "$ABSL_LIBCXX") \
             -o build/bench_clang_libcxx
  echo "built build/bench_clang_libcxx: $(build/bench_clang_libcxx --info)"
else
  echo "libc++ не найден — связка clang/libc++ пропущена" >&2
fi

# Проверка корректности всех алгоритмов на крайних случаях
for b in build/bench_*; do "$b" --selftest; done
