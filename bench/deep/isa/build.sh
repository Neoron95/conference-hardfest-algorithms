#!/usr/bin/env bash
# Сборка isa_bench в двух связках (как ../../build.sh): gcc13/libstdc++ и clang18/libc++.
# Abseil берётся из ../../build/{abseil-cpp,absl-gcc,absl-libcxx}.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
B=../../build
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -DNDEBUG -g"}
libs() { echo "-Wl,--start-group $(find "$1" -name 'libabsl_*.a' | sort | tr '\n' ' ') -Wl,--end-group"; }
g++ $CXXFLAGS -I$B/abseil-cpp isa_bench.cpp $(libs $B/absl-gcc) -o build/isa_gcc
clang++-18 -stdlib=libc++ $CXXFLAGS -I$B/abseil-cpp isa_bench.cpp $(libs $B/absl-libcxx) -o build/isa_clang_libcxx
echo built
