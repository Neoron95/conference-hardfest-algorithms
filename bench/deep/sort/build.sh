#!/usr/bin/env bash
# Сборка bench/deep/sort. Нужны g++ 13, clang++-18 + libc++-18-dev.
set -euo pipefail
cd "$(dirname "$0")"
mkdir -p build patch/__algorithm
F="-std=c++20 -O3 -DNDEBUG"

# Подменённый libc++ sort.h: CountLess/PlainLess объявлены «простыми» компараторами,
# чтобы заголовочная инстанциация шла по тому же bitset-пути, что и std::sort по умолчанию.
LIBCXX_SORT=/usr/lib/llvm-18/include/c++/v1/__algorithm/sort.h
python3 - "$LIBCXX_SORT" patch/__algorithm/sort.h <<'PY'
import sys
src = open(sys.argv[1]).read()
src = src.replace("_LIBCPP_BEGIN_NAMESPACE_STD", "struct CountLess; struct PlainLess;\n_LIBCPP_BEGIN_NAMESPACE_STD", 1)
anchor = "template <class _Tp>\nstruct __is_simple_comparator<greater<_Tp>&> : true_type {};"
assert anchor in src
src = src.replace(anchor, anchor + "\ntemplate <>\nstruct __is_simple_comparator<::CountLess&> : true_type {};\ntemplate <>\nstruct __is_simple_comparator<::PlainLess&> : true_type {};", 1)
open(sys.argv[2], "w").write(src)
PY

g++ $F -mavx2 -fno-tree-loop-distribute-patterns membw.cpp -o build/membw
g++ $F -mavx2 radix_deep.cpp -o build/radix_deep
g++ $F -mavx2 -march=native radix_deep.cpp -o build/radix_deep_native

g++ $F sortcnt.cpp -o build/sortcnt_gcc
clang++-18 -stdlib=libc++ $F -Ipatch sortcnt.cpp -o build/sortcnt_libcxx

g++ $F sortphase.cpp -o build/sortphase_gcc
g++ $F -march=native -DMARCH='"native"' sortphase.cpp -o build/sortphase_gcc_native
clang++-18 -stdlib=libc++ $F -Ipatch sortphase.cpp -o build/sortphase_libcxx
clang++-18 -stdlib=libc++ $F -Ipatch -march=native -DMARCH='"native"' sortphase.cpp -o build/sortphase_libcxx_native
clang++-18 $F sortphase.cpp -o build/sortphase_clang_libstdcxx

g++ $F -g sortcg.cpp -o build/sortcg_gcc
clang++-18 -stdlib=libc++ $F -g sortcg.cpp -o build/sortcg_libcxx
g++ $F -g -mavx2 -DHAVE_XSS -Ixss sortcg.cpp -o build/sortcg_gcc_avx2

g++ $F -march=skylake-avx512 -DISA='"avx512"' -Ixss simdsort.cpp -o build/simdsort_avx512
g++ $F -mavx2 -DISA='"avx2"' -Ixss simdsort.cpp -o build/simdsort_avx2
g++ $F -DNO_XSS -DISA='"base"' simdsort.cpp -o build/simdsort_base
g++ $F -march=native -DNO_XSS -DISA='"native"' simdsort.cpp -o build/simdsort_native
clang++-18 -stdlib=libc++ $F -DNO_XSS -DISA='"base"' simdsort.cpp -o build/simdsort_libcxx_base
clang++-18 -stdlib=libc++ $F -march=skylake-avx512 -DISA='"avx512"' -Ixss simdsort.cpp -o build/simdsort_libcxx_avx512
echo built
