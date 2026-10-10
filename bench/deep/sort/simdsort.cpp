// simdsort.cpp — x86-simd-sort (AVX-512 / AVX2) против std::sort на uint64.
// Сборка: см. build.sh (-march=skylake-avx512 → AVX-512; -mavx2 → AVX2; -DNO_XSS → только std::sort).
// Вывод CSV: lib,isa,alg,input,N,ns_per_elem_sort,ns_per_elem_sort_unique
#include "common.h"
#include "pdqsort.h"
#ifndef NO_XSS
#include "x86simdsort-static-incl.h"
#endif
#ifndef ISA
#define ISA "none"
#endif

template <class F>
static double timed(const std::vector<Vec>& pool, int reps, F fn) {
  std::vector<double> t; Vec w; w.reserve(pool[0].size());
  for (int r = 0; r < reps; ++r) {
    const Vec& in = pool[r % pool.size()];
    w.assign(in.begin(), in.end());
    double t0 = now_ns(); fn(w); double t1 = now_ns();
    if (r == 0) { Vec ref(in); std::sort(ref.begin(), ref.end()); ref.erase(std::unique(ref.begin(), ref.end()), ref.end());
      Vec ww(w); if (!std::is_sorted(ww.begin(), ww.end())) std::sort(ww.begin(), ww.end()); ww.erase(std::unique(ww.begin(), ww.end()), ww.end());
      if (ww != ref) { fprintf(stderr, "WRONG\n"); exit(2); } }
    t.push_back((t1 - t0) / (double)in.size());
  }
  return median(t);
}

int main(int argc, char** argv) {
  const char* lib =
#if defined(_LIBCPP_VERSION)
      "libc++";
#else
      "libstdc++";
#endif
  int reps = argc > 1 ? atoi(argv[1]) : 9;
  printf("lib,isa,alg,input,N,ns_sort,ns_sort_unique\n");
  const char* kinds[] = {"random", "sorted", "equal", "runs"};
  for (size_t lg : {16, 18, 20, 22}) {
    size_t N = (size_t)1 << lg;
    for (const char* k : kinds) {
      if (lg != 20 && std::string(k) != "random") continue;
      size_t U = std::string(k) == "equal" ? 1 : std::string(k) == "runs" ? N / 2 : N;
      size_t P = std::max<size_t>(4, std::min<size_t>(32, (1u << 22) / N));
      std::vector<Vec> pool(P);
      for (size_t i = 0; i < P; ++i) pool[i] = make_input(k, N, U, 17 + i);
      int rr = (int)std::max<size_t>(reps, (1u << 23) / N);
      auto row = [&](const char* alg, auto s, auto su) {
        printf("%s,%s,%s,%s,%zu,%.3f,%.3f\n", lib, ISA, alg, k, N, timed(pool, rr, s), timed(pool, rr, su)); fflush(stdout);
      };
      row("std::sort", [](Vec& v) { std::sort(v.begin(), v.end()); },
          [](Vec& v) { std::sort(v.begin(), v.end()); v.erase(std::unique(v.begin(), v.end()), v.end()); });
      row("pdqsort_branchless", [](Vec& v) { pdqsort_branchless(v.begin(), v.end()); },
          [](Vec& v) { pdqsort_branchless(v.begin(), v.end()); v.erase(std::unique(v.begin(), v.end()), v.end()); });
#ifndef NO_XSS
      row("x86simdsort", [](Vec& v) { x86simdsortStatic::qsort<u64>(v.data(), v.size()); },
          [](Vec& v) { x86simdsortStatic::qsort<u64>(v.data(), v.size()); v.erase(std::unique(v.begin(), v.end()), v.end()); });
#endif
    }
  }
  return 0;
}
