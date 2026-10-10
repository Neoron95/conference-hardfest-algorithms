// membw.cpp — полоса одного (v)CPU: чтение, запись (с RFO и non-temporal), копирование.
// Сборка: g++ -O3 -mavx2 -fno-tree-loop-distribute-patterns membw.cpp -o membw
// Запуск:  taskset -c 2 ./membw  → CSV: size_mb,op,traffic_bytes,best_gbs,median_gbs,median_ns_per_8B
#include "common.h"
#include <immintrin.h>

static u64 sink = 0;

__attribute__((noinline)) static void read_sum(const u64* p, size_t n) {
  u64 a0 = 0, a1 = 0, a2 = 0, a3 = 0, a4 = 0, a5 = 0, a6 = 0, a7 = 0;
  for (size_t i = 0; i + 8 <= n; i += 8) {
    a0 += p[i]; a1 += p[i + 1]; a2 += p[i + 2]; a3 += p[i + 3];
    a4 += p[i + 4]; a5 += p[i + 5]; a6 += p[i + 6]; a7 += p[i + 7];
  }
  sink += a0 + a1 + a2 + a3 + a4 + a5 + a6 + a7;
}
__attribute__((noinline)) static void write_loop(u64* p, size_t n, u64 v) {
  for (size_t i = 0; i < n; ++i) p[i] = v + i;
}
__attribute__((noinline)) static void write_nt(u64* p, size_t n, u64 v) {
  __m256i x = _mm256_set1_epi64x((long long)v);
  for (size_t i = 0; i + 4 <= n; i += 4) _mm256_stream_si256((__m256i*)(p + i), x);
  _mm_sfence();
}
__attribute__((noinline)) static void copy_loop(u64* d, const u64* s, size_t n) {
  for (size_t i = 0; i < n; ++i) d[i] = s[i];
}
__attribute__((noinline)) static void copy_nt(u64* d, const u64* s, size_t n) {
  for (size_t i = 0; i + 4 <= n; i += 4)
    _mm256_stream_si256((__m256i*)(d + i), _mm256_loadu_si256((const __m256i*)(s + i)));
  _mm_sfence();
}

int main(int argc, char** argv) {
  std::vector<size_t> sizes_mb = {4, 8, 16, 32, 64, 128, 256};
  int reps = argc > 1 ? atoi(argv[1]) : 7;
  printf("size_mb,op,traffic_bytes,best_gbs,median_gbs,median_ns_per_elem\n");
  for (size_t mb : sizes_mb) {
    size_t bytes = mb << 20, n = bytes / 8;
    u64* a = (u64*)aligned_alloc(64, bytes);
    u64* b = (u64*)aligned_alloc(64, bytes);
    memset(a, 1, bytes); memset(b, 2, bytes);  // страницы уже отображены
    struct Op { const char* name; double traffic; void (*fn)(u64*, u64*, size_t); };
    Op ops[] = {
        {"read", 1.0, [](u64* a, u64*, size_t n) { read_sum(a, n); }},
        {"write", 1.0, [](u64* a, u64*, size_t n) { write_loop(a, n, 7); }},
        {"write_nt", 1.0, [](u64* a, u64*, size_t n) { write_nt(a, n, 7); }},
        {"memset", 1.0, [](u64* a, u64*, size_t n) { memset(a, 3, n * 8); }},
        {"copy", 2.0, [](u64* a, u64* b, size_t n) { copy_loop(b, a, n); }},
        {"copy_nt", 2.0, [](u64* a, u64* b, size_t n) { copy_nt(b, a, n); }},
        {"memcpy", 2.0, [](u64* a, u64* b, size_t n) { memcpy(b, a, n * 8); }},
    };
    for (auto& op : ops) {
      std::vector<double> gbs;
      for (int r = 0; r < reps; ++r) {
        double t0 = now_ns();
        op.fn(a, b, n);
        double t1 = now_ns();
        gbs.push_back(op.traffic * (double)bytes / (t1 - t0));  // байт/нс = ГБ/с
      }
      double best = *std::max_element(gbs.begin(), gbs.end()), med = median(gbs);
      printf("%zu,%s,%.0f,%.2f,%.2f,%.3f\n", mb, op.name, op.traffic * (double)bytes, best, med, 8.0 * op.traffic / med);
      fflush(stdout);
    }
    free(a); free(b);
  }
  fprintf(stderr, "sink=%llu\n", (unsigned long long)sink);
  return 0;
}
