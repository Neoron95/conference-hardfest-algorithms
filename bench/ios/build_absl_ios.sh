#!/usr/bin/env bash
# Abseil для iPhone (arm64, iOS 17+): один статический файл build/libabsl_ios.a для Xcode-проекта.
#   ./build_absl_ios.sh      (2–4 минуты; нужны Xcode и cmake)
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build
ABSL_TAG=20260817.0
SRC=build/abseil-cpp
OUT=build/absl-ios
JOBS=$(sysctl -n hw.ncpu)
command -v cmake >/dev/null || { echo "нет cmake: brew install cmake" >&2; exit 1; }
xcrun --sdk iphoneos --show-sdk-path >/dev/null || { echo "нет iOS SDK: откройте Xcode один раз и примите лицензию" >&2; exit 1; }
if [[ ! -f $SRC/absl/container/flat_hash_set.h ]]; then
  git -c advice.detachedHead=false clone -q --depth 1 --branch "$ABSL_TAG" https://github.com/abseil/abseil-cpp "$SRC"
fi
if [[ ! -f build/libabsl_ios.a ]]; then
  echo "сборка Abseil для iOS…"
  cmake -S "$SRC" -B "$OUT" -DCMAKE_SYSTEM_NAME=iOS -DCMAKE_OSX_SYSROOT=iphoneos \
        -DCMAKE_OSX_ARCHITECTURES=arm64 -DCMAKE_OSX_DEPLOYMENT_TARGET=17.0 \
        -DCMAKE_TRY_COMPILE_TARGET_TYPE=STATIC_LIBRARY -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_CXX_STANDARD=20 -DABSL_PROPAGATE_CXX_STD=ON -DABSL_BUILD_TESTING=OFF > build/absl-ios.cmake.log 2>&1 \
    || { tail -20 build/absl-ios.cmake.log >&2; exit 1; }
  cmake --build "$OUT" -j"$JOBS" --target raw_hash_set hash > build/absl-ios.make.log 2>&1 \
    || { grep -m 15 -E 'error' build/absl-ios.make.log >&2 || tail -20 build/absl-ios.make.log >&2; exit 1; }
  libtool -static -o build/libabsl_ios.a $(find "$OUT" -name 'libabsl_*.a') 2> build/absl-ios.libtool.log
fi
echo "готово: build/libabsl_ios.a ($(du -h build/libabsl_ios.a | cut -f1)); дальше: xcodegen generate && open HashBench.xcodeproj"
