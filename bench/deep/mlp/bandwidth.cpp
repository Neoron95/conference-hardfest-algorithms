// bandwidth.cpp — полоса памяти одного vCPU: потоковая сумма uint64 по 256 МиБ и memcpy 256 МиБ.
//   g++ -O3 bandwidth.cpp -o build/bandwidth && taskset -c 2 build/bandwidth
#include "common.h"
static uint64_t sink;
__attribute__((noinline)) static double sum_pass(const uint64_t* a, size_t n) {
  uint64_t s0 = 0, s1 = 0, s2 = 0, s3 = 0;
  double t0 = now_ns();
  for (size_t i = 0; i < n; i += 4) { s0 += a[i]; s1 += a[i + 1]; s2 += a[i + 2]; s3 += a[i + 3]; }
  double t1 = now_ns();
  sink += s0 + s1 + s2 + s3;
  return t1 - t0;
}
int main() {
  const size_t bytes = 256u << 20, n = bytes / 8;
  uint64_t* a = (uint64_t*)alloc_pages(bytes, true);
  uint64_t* b = (uint64_t*)alloc_pages(bytes, true);
  for (size_t i = 0; i < n; ++i) a[i] = i;
  printf("exp,gb_per_s_median,gb_per_s_best\n");
  std::vector<double> v;
  for (int r = 0; r < 7; ++r) v.push_back(bytes / sum_pass(a, n));
  double best = *std::max_element(v.begin(), v.end());
  printf("stream_sum_256MiB,%.1f,%.1f\n", median(v), best);
  v.clear();
  for (int r = 0; r < 7; ++r) { double t0 = now_ns(); memcpy(b, a, bytes); v.push_back(2.0 * bytes / (now_ns() - t0)); }
  best = *std::max_element(v.begin(), v.end());
  printf("memcpy_256MiB_rw,%.1f,%.1f\n", median(v), best);
  fprintf(stderr, "sink=%llu b0=%llu\n", (unsigned long long)sink, (unsigned long long)b[n - 1]);
}
