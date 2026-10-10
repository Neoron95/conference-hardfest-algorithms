// sortcnt.cpp — сравнения на элемент у std::sort (libc++ / libstdc++) и pdqsort на разных входах.
// Для libc++ собирается с подменённым заголовком __algorithm/sort.h (см. build.sh), в котором
// CountLess объявлен «простым» компаратором: тогда идёт тот же путь, что у std::sort по умолчанию
// (bitset partition), а не запасной __partition_with_equals_on_right.
// Вывод CSV: lib,path,input,N,U,cmp_per_elem
#include "common.h"
#include "pdqsort.h"

struct CountLess {  // «простой» (bitset partition в libc++)
  static inline u64 cnt = 0;
  bool operator()(u64 a, u64 b) const { ++cnt; return a < b; }
};
struct CountLessNS {  // не «простой»: libc++ идёт по запасному пути без bitset
  static inline u64 cnt = 0;
  bool operator()(u64 a, u64 b) const { ++cnt; return a < b; }
};

int main(int argc, char** argv) {
  size_t N = argc > 1 ? std::stoull(argv[1]) : (1u << 20);
  const char* lib =
#if defined(_LIBCPP_VERSION)
      "libc++";
#else
      "libstdc++";
#endif
  printf("lib,path,input,N,U,cmp_per_elem\n");
  struct In { const char* kind; size_t U; };
  In inputs[] = {{"random", N}, {"random", N / 2}, {"dense", N / 2}, {"sorted", N}, {"sorted", N / 2}, {"reverse", N},
                 {"equal", 1}, {"runs", N / 2}, {"almost01", N}, {"almost", N}, {"e8", N}};
  for (auto& in : inputs) {
    Vec v0 = make_input(in.kind, N, in.U, 17);
    auto run = [&](const char* path, auto fn) {
      Vec v(v0);
      double c = fn(v);
      if (!std::is_sorted(v.begin(), v.end())) { fprintf(stderr, "NOT SORTED %s %s\n", path, in.kind); exit(2); }
      printf("%s,%s,%s,%zu,%zu,%.2f\n", lib, path, in.kind, N, in.U, c / (double)N);
    };
    run("std::sort(simple)", [](Vec& v) { CountLess::cnt = 0; CountLess c; std::sort(v.begin(), v.end(), c); return (double)CountLess::cnt; });
#if defined(_LIBCPP_VERSION)
    run("std::sort(nonsimple)", [](Vec& v) { CountLessNS::cnt = 0; CountLessNS c; std::sort(v.begin(), v.end(), c); return (double)CountLessNS::cnt; });
#endif
    run("pdqsort", [](Vec& v) { CountLess::cnt = 0; pdqsort(v.begin(), v.end(), CountLess()); return (double)CountLess::cnt; });
    run("pdqsort_branchless", [](Vec& v) { CountLess::cnt = 0; pdqsort_branchless(v.begin(), v.end(), CountLess()); return (double)CountLess::cnt; });
    fflush(stdout);
  }
  return 0;
}
