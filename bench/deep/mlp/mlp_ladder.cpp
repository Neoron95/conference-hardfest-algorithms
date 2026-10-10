// mlp_ladder.cpp — «лестница MLP»: K независимых цепочек pointer chasing по одному случайному циклу
// (Саттоло) из строк кэша по 64 Б. Метод — Lemire, testingmlp (lanes). Печатает нс на одно обращение
// в зависимости от K и рабочего набора; MLP_eff = ns(K=1) / ns(K).
//   g++ -O2 mlp_ladder.cpp -o build/mlp_ladder && taskset -c 2 build/mlp_ladder [huge=0|1] [ws_kb ...]
#include "common.h"

struct alignas(64) Line { uint32_t next; uint32_t pad[15]; };

static uint64_t sink;

template <int K>
static double run(const Line* a, const uint32_t* starts, long steps_per_lane) {
  uint32_t p[K];
  for (int k = 0; k < K; ++k) p[k] = starts[k];
  double t0 = now_ns();
  for (long i = 0; i < steps_per_lane; ++i)
    for (int k = 0; k < K; ++k) p[k] = a[p[k]].next;   // K независимых зависимых цепочек
  double t1 = now_ns();
  for (int k = 0; k < K; ++k) sink += p[k];
  return (t1 - t0) / ((double)steps_per_lane * K);
}

int main(int argc, char** argv) {
  bool huge = argc > 1 && atoi(argv[1]) == 1;
  std::vector<size_t> ws_kb;
  for (int i = 2; i < argc; ++i) ws_kb.push_back((size_t)atol(argv[i]));
  if (ws_kb.empty()) ws_kb = {1024, 8192, 16384, 65536, 262144};
  printf("ws_kb,pages,K,ns_per_access,mlp_eff\n");
  uint64_t rng = 0x9e3779b97f4a7c15ULL;
  auto rnd = [&]() { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; };
  for (size_t kb : ws_kb) {
    const size_t n = kb * 1024 / sizeof(Line);
    Line* a = (Line*)alloc_pages(n * sizeof(Line), huge);
    std::vector<uint32_t> perm(n), order(n);
    for (size_t i = 0; i < n; ++i) perm[i] = (uint32_t)i;
    for (size_t i = n - 1; i > 0; --i) std::swap(perm[i], perm[rnd() % i]);  // Саттоло: один цикл
    for (size_t i = 0; i < n; ++i) a[perm[i]].next = perm[(i + 1) % n];
    // order[j] — j-й узел цикла; старты K полос — через n/K узлов, полосы не пересекаются за проход
    uint32_t p = 0;
    for (size_t j = 0; j < n; ++j) { order[j] = p; p = a[p].next; }
    const long target = 1L << 24;  // не меньше 16M обращений на точку
    double base = 0;
    auto point = [&](int K, auto fn) {
      uint32_t starts[64];
      for (int k = 0; k < K; ++k) starts[k] = order[(size_t)k * n / K];
      long per_lane = (long)(n / K);
      long reps = std::max(1L, target / (long)n);
      std::vector<double> v;
      for (int r = 0; r < 3; ++r) v.push_back(fn(a, starts, per_lane * reps));
      double ns = median(v);
      if (K == 1) base = ns;
      printf("%zu,%s,%d,%.2f,%.1f\n", kb, huge ? "thp" : "4k", K, ns, base / ns);
      fflush(stdout);
    };
    point(1, run<1>);   point(2, run<2>);   point(4, run<4>);   point(8, run<8>);
    point(12, run<12>); point(16, run<16>); point(24, run<24>); point(32, run<32>);
    point(48, run<48>); point(64, run<64>);
    munmap(a, n * sizeof(Line));
  }
  fprintf(stderr, "sink=%llu anon_huge_kb(last)=%ld\n", (unsigned long long)sink, anon_huge_kb());
}
