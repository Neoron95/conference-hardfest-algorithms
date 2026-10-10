// simdsort.cpp — std::sort против x86-simd-sort (AVX-512 и AVX2) на 2^20 случайных u64, плюс unique; и эффективная частота под AVX-512.
//   g++ -std=c++17 -O3 -march=native -I<x86-simd-sort>/src simdsort.cpp -o build/simdsort
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <vector>
#include "avx512-64bit-qsort.hpp"
#include "avx2-64bit-qsort.hpp"
static double now_ns() { return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static uint64_t mix(uint64_t z) { z += 0x9e3779b97f4a7c15ull; z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ull; z = (z ^ (z >> 27)) * 0x94d049bb133111ebull; return z ^ (z >> 31); }
template <class F> static double bench(const std::vector<uint64_t>& in, F f, int reps = 9) {
  std::vector<double> t; std::vector<uint64_t> w(in.size());
  for (int r = 0; r < reps; ++r) { w = in; double t0 = now_ns(); f(w); t.push_back((now_ns() - t0) / in.size()); }
  std::sort(t.begin(), t.end()); return t[reps / 2];
}
int main(int argc, char** argv) {
  size_t n = argc > 1 ? atoll(argv[1]) : 1u << 20; size_t u = argc > 2 ? atoll(argv[2]) : n;
  std::vector<uint64_t> in(n);
  for (size_t i = 0; i < n; ++i) in[i] = mix(i < u ? i : mix(i) % u);  // U уникальных, остальное — повторы
  for (size_t i = n - 1; i > 0; --i) std::swap(in[i], in[mix(i + 777) % (i + 1)]);
  auto uniq = [](std::vector<uint64_t>& v) { v.erase(std::unique(v.begin(), v.end()), v.end()); };
  double s = bench(in, [&](auto& v) { std::sort(v.begin(), v.end()); uniq(v); });
  double a512 = bench(in, [&](auto& v) { avx512_qsort<uint64_t>(v.data(), v.size()); uniq(v); });
  double a2 = bench(in, [&](auto& v) { avx2_qsort<uint64_t>(v.data(), v.size()); uniq(v); });
  std::vector<uint64_t> chk = in; std::sort(chk.begin(), chk.end()); uniq(chk);
  std::vector<uint64_t> c2 = in; avx512_qsort<uint64_t>(c2.data(), c2.size()); uniq(c2);
  printf("N=%zu U=%zu ns/el: std::sort+unique %.1f | avx512_qsort+unique %.1f (x%.2f) | avx2_qsort+unique %.1f (x%.2f) | check %s\n", n, u, s, a512, s / a512, a2, s / a2, chk == c2 ? "ok" : "MISMATCH");
  // частота: цепочка зависимых imul (3 такта) и зависимых vfmadd231pd zmm (4 такта), и 12 независимых FMA-цепочек (пропускная способность)
  { uint64_t x = 3, m = 5; const long it = 50000000; double t0 = now_ns();
    for (long i = 0; i < it; i++) asm volatile("imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0" : "+r"(x) : "r"(m));
    printf("freq_ghz imul-chain %.2f\n", it * 8.0 * 3 / (now_ns() - t0)); }
  { const long it = 50000000; double t0 = now_ns();
    asm volatile("vxorpd %%zmm0,%%zmm0,%%zmm0\n\tvxorpd %%zmm1,%%zmm1,%%zmm1\n\tvxorpd %%zmm2,%%zmm2,%%zmm2" ::: "zmm0", "zmm1", "zmm2");
    for (long i = 0; i < it; i++) asm volatile("vfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm0" ::: "zmm0");
    printf("freq_ghz zmm-fma-dependent-chain (lat 4) %.2f\n", it * 8.0 * 4 / (now_ns() - t0)); }
  { const long it = 50000000; double t0 = now_ns();
    for (long i = 0; i < it; i++) asm volatile(
      "vfmadd231pd %%zmm1,%%zmm2,%%zmm3\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm4\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm5\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm6\n\t"
      "vfmadd231pd %%zmm1,%%zmm2,%%zmm7\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm8\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm9\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm10\n\t"
      "vfmadd231pd %%zmm1,%%zmm2,%%zmm11\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm12\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm13\n\tvfmadd231pd %%zmm1,%%zmm2,%%zmm14" ::: "zmm3","zmm4","zmm5","zmm6","zmm7","zmm8","zmm9","zmm10","zmm11","zmm12","zmm13","zmm14");
    double gf = it * 12.0 * 8 / (now_ns() - t0);  // 8 double-FMA на zmm
    printf("zmm-fma throughput %.1f GFMA/s = %.2f GHz if 2 FMA/cycle, %.2f GHz if 1 FMA/cycle\n", gf / 8, gf / 8 / 2, gf / 8); }
  // то же сразу после тяжёлой AVX-512 нагрузки: imul-цепочка (есть ли остаточный downclock)
  { uint64_t x = 3, m = 5; const long it = 50000000; double t0 = now_ns();
    for (long i = 0; i < it; i++) asm volatile("imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0" : "+r"(x) : "r"(m));
    printf("freq_ghz imul-chain after AVX-512 %.2f\n", it * 8.0 * 3 / (now_ns() - t0)); }
}
