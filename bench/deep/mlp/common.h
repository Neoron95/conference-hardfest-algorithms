// common.h — общие помощники для bench/deep/mlp: таймер, хеш-финализатор, выделение памяти с THP.
#pragma once
#include <sys/mman.h>
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

static inline double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
// финализатор splitmix64 — биекция, годится и как хеш, и как генератор ключей
static inline uint64_t mix64(uint64_t z) {
  z += 0x9e3779b97f4a7c15ULL;
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}
// Анонимная память, выровненная на 2 МиБ; huge=true → madvise(MADV_HUGEPAGE) (THP у нас в режиме madvise).
static void* alloc_pages(size_t bytes, bool huge) {
  const size_t align = 2u << 20;
  size_t sz = (bytes + align - 1) / align * align;
  char* raw = (char*)mmap(nullptr, sz + align, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  if (raw == MAP_FAILED) { perror("mmap"); exit(1); }
  char* p = (char*)(((uintptr_t)raw + align - 1) & ~(uintptr_t)(align - 1));
  madvise(p, sz, huge ? MADV_HUGEPAGE : MADV_NOHUGEPAGE);
  memset(p, 0, sz);  // первое касание — здесь, а не в таймере
  return p;
}
// Сколько КиБ процесса сейчас лежит на huge pages (контроль, что THP сработал).
static long anon_huge_kb() {
  FILE* f = fopen("/proc/self/smaps_rollup", "r");
  if (!f) return -1;
  char line[256]; long kb = -1;
  while (fgets(line, sizeof line, f))
    if (sscanf(line, "AnonHugePages: %ld kB", &kb) == 1) break;
  fclose(f);
  return kb;
}
static double median(std::vector<double> v) {
  std::sort(v.begin(), v.end());
  size_t n = v.size();
  return n % 2 ? v[n / 2] : 0.5 * (v[n / 2 - 1] + v[n / 2]);
}
