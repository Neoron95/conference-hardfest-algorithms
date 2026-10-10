#!/usr/bin/env bash
# Сборка харнесса счётчиков в двух связках (те же флаги и Abseil, что у ../../build.sh,
# плюс -g для имён функций в callgrind; -g не меняет кодогенерацию):
#   build/counters_gcc      — GCC 13 + libstdc++
#   build/counters_libcxx   — Clang 18 + libc++
set -euo pipefail
cd "$(dirname "$0")"
ROOT=../..
ABSL_SRC=$ROOT/build/abseil-cpp
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -DNDEBUG -g"}
mkdir -p build
absl_libs() { echo "-Wl,--start-group $(find "$1" -name 'libabsl_*.a' | sort | tr '\n' ' ') -Wl,--end-group"; }
g++ $CXXFLAGS -I"$ABSL_SRC" counters.cpp $(absl_libs "$ROOT/build/absl-gcc") -o build/counters_gcc
echo "built build/counters_gcc"
if [[ -f "$ROOT/build/absl-libcxx/absl/container/libabsl_raw_hash_set.a" ]]; then
  clang++-18 -stdlib=libc++ $CXXFLAGS -I"$ABSL_SRC" counters.cpp $(absl_libs "$ROOT/build/absl-libcxx") -o build/counters_libcxx
  echo "built build/counters_libcxx"
else
  echo "absl-libcxx не собран — сначала ../../build.sh" >&2
fi
