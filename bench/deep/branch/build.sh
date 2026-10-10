#!/usr/bin/env bash
# Сборка branch_bench в двух связках (с -g для построчной атрибуции в callgrind):
#   build/bb_gcc           — GCC 13 + libstdc++ (Abseil из ../../build/absl-gcc)
#   build/bb_clang_libcxx  — Clang 18 + libc++ (Abseil из ../../build/absl-libcxx; если его нет — без flat)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build results
ABSL_SRC=${ABSL_SRC:-../../build/abseil-cpp}
ABSL_GCC=${ABSL_GCC:-../../build/absl-gcc}
ABSL_LIBCXX=${ABSL_LIBCXX:-../../build/absl-libcxx}
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -g -DNDEBUG"}

absl_libs() { echo "-Wl,--start-group $(find "$1" -name 'libabsl_*.a' | sort | tr '\n' ' ') -Wl,--end-group"; }

g++ $CXXFLAGS -I"$ABSL_SRC" branch_bench.cpp $(absl_libs "$ABSL_GCC") -o build/bb_gcc
echo "built build/bb_gcc: $(build/bb_gcc --info)"

if [[ -f "$ABSL_LIBCXX/absl/container/libabsl_raw_hash_set.a" ]]; then
  clang++-18 -stdlib=libc++ $CXXFLAGS -I"$ABSL_SRC" branch_bench.cpp $(absl_libs "$ABSL_LIBCXX") -o build/bb_clang_libcxx
  echo "built build/bb_clang_libcxx (with flat): $(build/bb_clang_libcxx --info)"
else
  clang++-18 -stdlib=libc++ $CXXFLAGS -DNO_FLAT branch_bench.cpp -o build/bb_clang_libcxx
  echo "built build/bb_clang_libcxx (NO_FLAT): $(build/bb_clang_libcxx --info)"
fi
for b in build/bb_*; do "$b" --selftest; done
