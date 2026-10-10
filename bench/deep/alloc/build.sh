#!/usr/bin/env bash
# Сборка bench/deep/alloc: gcc13/libstdc++ и clang18/libc++ (Abseil из ../../build, см. ../../build.sh).
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
B=../../build
CXXFLAGS=${CXXFLAGS:-"-std=c++20 -O3 -DNDEBUG -g"}
libs() { echo "-Wl,--start-group $(find "$1" -name 'libabsl_*.a' | sort | tr '\n' ' ') -Wl,--end-group"; }
g++ $CXXFLAGS malloc_cost.cpp -o build/malloc_cost_gcc
g++ $CXXFLAGS -I$B/abseil-cpp uset_decomp.cpp $(libs $B/absl-gcc) -o build/uset_decomp_gcc
clang++-18 -stdlib=libc++ $CXXFLAGS -I$B/abseil-cpp uset_decomp.cpp $(libs $B/absl-libcxx) -o build/uset_decomp_clang_libcxx
echo built
