// Инстанциация libc++ 18 __introsort для uint64_t из заголовков — так, как это делает
// src/algorithm.cpp дилиба (компаратор ranges::less по значению), но с явным флагом
// _UseBitSetPartition: true (BlockQuickSort, __bitset_partition) и false
// (__partition_with_equals_on_right). Только для ассемблера и сравнения времени.
#include <algorithm>
#include <cstdint>
#include <functional>
__attribute__((noinline)) void sort_u64_bitset(unsigned long* f, unsigned long* l) {
  std::__1::__introsort<std::__1::_ClassicAlgPolicy, std::ranges::less, unsigned long*, true>(f, l, std::ranges::less{}, 2 * std::__1::__log2i(l - f));
}
__attribute__((noinline)) void sort_u64_branchy(unsigned long* f, unsigned long* l) {
  std::__1::__introsort<std::__1::_ClassicAlgPolicy, std::ranges::less, unsigned long*, false>(f, l, std::ranges::less{}, 2 * std::__1::__log2i(l - f));
}
// Что реально выберет дилиб LLVM 18: __use_branchless_sort<ranges::less, unsigned long*>
static_assert(!std::__1::__use_branchless_sort<std::ranges::less, unsigned long*>::value, "dylib: bitset partition OFF");
static_assert(std::__1::__use_branchless_sort<std::ranges::less&, unsigned long*>::value, "header: by-reference ON");
