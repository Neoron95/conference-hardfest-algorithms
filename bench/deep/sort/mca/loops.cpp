// loops.cpp — три горячих цикла для llvm-mca (маркеры LLVM-MCA-BEGIN/END).
#include <cstdint>
#include <cstddef>
using u64 = uint64_t;

// 1. Рассеивание radix (как в dedup_bench.cpp)
void scatter(const u64* __restrict src, u64* __restrict dst, size_t n, int sh, uint32_t* __restrict off) {
  __asm volatile("# LLVM-MCA-BEGIN scatter");
  for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 255]++] = x; }
  __asm volatile("# LLVM-MCA-END scatter");
}

// 2. libc++ __populate_left_bitset: 64 сравнения с опорным → 64-битная маска, без ветвлений
void populate(const u64* __restrict p, u64 pivot, u64& out) {
  u64 bits = 0;
  __asm volatile("# LLVM-MCA-BEGIN populate");
  for (int j = 0; j < 64; ++j) { bool c = !(p[j] < pivot); bits |= (u64)c << j; }
  __asm volatile("# LLVM-MCA-END populate");
  out = bits;
}

// 3. libc++ __swap_bitmap_pos: обмены по маскам через tzcnt/blsr
void swap_by_masks(u64* first, u64* lm1, u64 l, u64 r) {
  __asm volatile("# LLVM-MCA-BEGIN swapmask");
  while (l != 0 && r != 0) {
    int tl = __builtin_ctzll(l); l &= l - 1;
    int tr = __builtin_ctzll(r); r &= r - 1;
    u64 t = first[tl]; first[tl] = lm1[-tr]; lm1[-tr] = t;
  }
  __asm volatile("# LLVM-MCA-END swapmask");
}

// 4. libstdc++ __unguarded_partition (Хоар): ветвление на каждом сравнении
u64* hoare(u64* first, u64* last, const u64* pivot) {
  __asm volatile("# LLVM-MCA-BEGIN hoare");
  while (true) {
    while (*first < *pivot) ++first;
    --last;
    while (*pivot < *last) --last;
    if (!(first < last)) break;
    u64 t = *first; *first = *last; *last = t;
    ++first;
  }
  __asm volatile("# LLVM-MCA-END hoare");
  return first;
}
