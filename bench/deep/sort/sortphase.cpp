// sortphase.cpp — время std::sort по фазам и путям.
//  * sort / unique / erase по отдельности, N = 2^20, random unique;
//  * libc++: три пути — std::sort по умолчанию (тело в libc++.so), заголовочный bitset-путь
//    (PlainLess объявлен «простым» в подменённом sort.h), заголовочный запасной путь (PlainLessNS);
//  * pdqsort / pdqsort_branchless для сравнения;
//  * развёртка по N: ns/эл и ns/(эл·log2 N).
// Вывод CSV: lib,march,alg,input,N,U,phase,ns_per_elem
#include "common.h"
#include "pdqsort.h"

struct PlainLess { bool operator()(u64 a, u64 b) const { return a < b; } };
struct PlainLessNS { bool operator()(u64 a, u64 b) const { return a < b; } };

#ifndef MARCH
#define MARCH "base"
#endif

template <class F>
static double timed(const std::vector<Vec>& pool, int reps, F fn, const char* what) {
  std::vector<double> t;
  Vec w;
  w.reserve(pool[0].size());
  for (int r = 0; r < reps; ++r) {
    const Vec& in = pool[r % pool.size()];
    w.assign(in.begin(), in.end());
    double t0 = now_ns();
    fn(w);
    double t1 = now_ns();
    if (r == 0) {  // проверка
      Vec ref(in); std::sort(ref.begin(), ref.end());
      if (std::string(what) == "sort" && w != ref) { fprintf(stderr, "WRONG\n"); exit(2); }
    }
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
  int reps = 9;
  printf("lib,march,alg,input,N,U,phase,ns_per_elem\n");
  auto line = [&](const char* alg, const char* input, size_t N, size_t U, const char* phase, double ns) {
    printf("%s,%s,%s,%s,%zu,%zu,%s,%.3f\n", lib, MARCH, alg, input, N, U, phase, ns);
    fflush(stdout);
  };
  // 1. Фазы на N = 2^20, random unique
  {
    size_t N = 1u << 20;
    std::vector<Vec> pool(8);
    for (size_t i = 0; i < pool.size(); ++i) pool[i] = make_input("random", N, N, 17 + i);
    line("std::sort", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { std::sort(v.begin(), v.end()); }, "sort"));
    std::vector<Vec> sorted_pool;
    for (auto& p : pool) { Vec s(p); std::sort(s.begin(), s.end()); sorted_pool.push_back(s); }
    line("std::sort", "random", N, N, "unique", timed(sorted_pool, reps, [](Vec& v) { auto e = std::unique(v.begin(), v.end()); (void)e; }, "unique"));
    line("std::sort", "random", N, N, "unique+erase", timed(sorted_pool, reps, [](Vec& v) { v.erase(std::unique(v.begin(), v.end()), v.end()); }, "ue"));
    line("std::sort", "random", N, N, "sort+unique+erase", timed(pool, reps, [](Vec& v) { std::sort(v.begin(), v.end()); v.erase(std::unique(v.begin(), v.end()), v.end()); }, "sue"));
#if defined(_LIBCPP_VERSION)
    line("std::sort(hdr,bitset)", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { PlainLess c; std::sort(v.begin(), v.end(), c); }, "sort"));
    line("std::sort(hdr,nobitset)", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { PlainLessNS c; std::sort(v.begin(), v.end(), c); }, "sort"));
#else
    line("std::sort(hdr,cmp)", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { PlainLess c; std::sort(v.begin(), v.end(), c); }, "sort"));
#endif
    line("pdqsort", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { pdqsort(v.begin(), v.end()); }, "sort"));
    line("pdqsort_branchless", "random", N, N, "sort", timed(pool, reps, [](Vec& v) { pdqsort_branchless(v.begin(), v.end()); }, "sort"));
    line("std::stable_sort", "random", N, N, "sort", timed(pool, 5, [](Vec& v) { std::stable_sort(v.begin(), v.end()); }, "sort"));
    // другие входы: только std::sort по умолчанию и pdqsort_branchless
    const char* kinds[] = {"sorted", "reverse", "equal", "runs", "almost01", "almost", "e8"};
    for (const char* k : kinds) {
      size_t U = std::string(k) == "equal" ? 1 : std::string(k) == "runs" ? N / 2 : N;
      std::vector<Vec> p2(4);
      for (size_t i = 0; i < p2.size(); ++i) p2[i] = make_input(k, N, U, 17 + i);
      line("std::sort", k, N, U, "sort", timed(p2, reps, [](Vec& v) { std::sort(v.begin(), v.end()); }, "sort"));
      line("pdqsort_branchless", k, N, U, "sort", timed(p2, reps, [](Vec& v) { pdqsort_branchless(v.begin(), v.end()); }, "sort"));
    }
  }
  // 2. Развёртка по N (random unique): ns/эл
  for (size_t lg = 10; lg <= 22; lg += 2) {
    size_t N = (size_t)1 << lg;
    size_t P = std::max<size_t>(4, std::min<size_t>(64, (1u << 22) / N));
    std::vector<Vec> pool(P);
    for (size_t i = 0; i < P; ++i) pool[i] = make_input("random", N, N, 100 + i);
    int rr = (int)std::max<size_t>(9, (1u << 23) / N);
    line("std::sort", "random", N, N, "sort", timed(pool, rr, [](Vec& v) { std::sort(v.begin(), v.end()); }, "sort"));
  }
  return 0;
}
