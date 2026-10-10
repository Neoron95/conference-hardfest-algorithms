// sortcmp_bitset.cpp — std::sort из libc++.so (дилиб LLVM 18: ranges::less по значению,
// __use_branchless_sort = false) против той же __introsort из заголовков с явным
// _UseBitSetPartition = true / false. Случайные уникальные uint64, нс/эл.
//   clang++-18 -stdlib=libc++ -std=c++20 -O3 sortcmp_bitset.cpp -o build/sortcmp_bitset
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <functional>
#include <vector>
using u64 = uint64_t;
static inline u64 mix64(u64 z) {
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}
static double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
__attribute__((noinline)) void sort_dylib(u64* f, u64* l) { std::sort(f, l); }
__attribute__((noinline)) void sort_bitset(u64* f, u64* l) {
  std::__1::__introsort<std::__1::_ClassicAlgPolicy, std::ranges::less, u64*, true>(f, l, std::ranges::less{}, 2 * std::__1::__log2i(l - f));
}
__attribute__((noinline)) void sort_branchy(u64* f, u64* l) {
  std::__1::__introsort<std::__1::_ClassicAlgPolicy, std::ranges::less, u64*, false>(f, l, std::ranges::less{}, 2 * std::__1::__log2i(l - f));
}
// компаратор-лямбда: не «простой» -> в заголовках тоже без bitset-разбиения
__attribute__((noinline)) void sort_lambda(u64* f, u64* l) { std::sort(f, l, [](u64 a, u64 b) { return a < b; }); }

int main(int argc, char** argv) {
  const int reps = argc > 1 ? atoi(argv[1]) : 7;
  for (size_t N : {size_t(1) << 16, size_t(1) << 18, size_t(1) << 20}) {
    std::vector<u64> in(N);
    u64 s = 17;
    for (auto& x : in) x = mix64(s += 0x9e3779b97f4a7c15ULL);
    struct V { const char* name; void (*fn)(u64*, u64*); };
    V vs[] = {{"std::sort (dylib)", sort_dylib}, {"__introsort<bitset=true>", sort_bitset},
              {"__introsort<bitset=false>", sort_branchy}, {"std::sort(lambda)", sort_lambda}};
    for (auto& v : vs) {
      std::vector<double> t;
      std::vector<u64> w(N);
      for (int r = 0; r < reps + 1; ++r) {
        w = in;
        double t0 = now_ns();
        v.fn(w.data(), w.data() + N);
        double t1 = now_ns();
        if (r) t.push_back((t1 - t0) / (double)N);
        if (!std::is_sorted(w.begin(), w.end())) { fprintf(stderr, "NOT SORTED\n"); return 1; }
      }
      std::sort(t.begin(), t.end());
      printf("N=%zu,%s,%.1f ns/el (min %.1f)\n", N, v.name, t[t.size() / 2], t[0]);
    }
  }
}
