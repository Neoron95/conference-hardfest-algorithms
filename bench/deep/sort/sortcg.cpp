// sortcg.cpp — один вызов алгоритма для callgrind (--toggle-collect=run_alg*):
// инструкции, условные ветвления и промахи предсказателя (модель valgrind) на 2^18 элементов.
// Запуск: valgrind --tool=callgrind --branch-sim=yes --toggle-collect='run_alg*' ./sortcg <alg> [N] [kind]
// alg: sort | sort_cmp | pdq | pdqb | radix | unique | simd (если собран с -DHAVE_XSS)
#include "common.h"
#include "pdqsort.h"
#include <memory>
#ifdef HAVE_XSS
#include "x86simdsort-static-incl.h"
#endif

struct PlainLess { bool operator()(u64 a, u64 b) const { return a < b; } };

static void radix8(Vec& v) {
  const size_t n = v.size();
  std::unique_ptr<u64[]> buf(new u64[n]);
  uint32_t cnt[8][256] = {};
  for (u64 x : v) for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
  u64* src = v.data(); u64* dst = buf.get();
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;
    size_t off[256]; size_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v.data()) std::memcpy(v.data(), src, n * sizeof(u64));
}

__attribute__((noinline)) void run_alg(const std::string& alg, Vec& v) {
  if (alg == "sort") std::sort(v.begin(), v.end());
  else if (alg == "sort_cmp") { PlainLess c; std::sort(v.begin(), v.end(), c); }
  else if (alg == "pdq") pdqsort(v.begin(), v.end());
  else if (alg == "pdqb") pdqsort_branchless(v.begin(), v.end());
  else if (alg == "radix") radix8(v);
  else if (alg == "unique") v.erase(std::unique(v.begin(), v.end()), v.end());
#ifdef HAVE_XSS
  else if (alg == "simd") x86simdsortStatic::qsort<u64>(v.data(), v.size());
#endif
  else { fprintf(stderr, "unknown alg\n"); exit(2); }
}

int main(int argc, char** argv) {
  std::string alg = argc > 1 ? argv[1] : "sort";
  size_t N = argc > 2 ? std::stoull(argv[2]) : (1u << 18);
  std::string kind = argc > 3 ? argv[3] : "random";
  Vec v = make_input(kind, N, kind == "equal" ? 1 : kind == "runs" ? N / 2 : N, 17);
  if (alg == "unique") std::sort(v.begin(), v.end());
  Vec ref(v); std::sort(ref.begin(), ref.end());
  run_alg(alg, v);
  if (alg != "unique" && v != ref) { fprintf(stderr, "WRONG\n"); return 2; }
  printf("%s N=%zu ok\n", alg.c_str(), N);
  return 0;
}
