// mlp.cpp — сколько промахов ядро держит в полёте (слайды inflight и window) на Mac.
//   chains: K независимых цепочек pointer chasing по одному циклу из строк 128 Б (метод Лемира);
//           нс на одно обращение при K = 1…64, рабочий набор 64 МиБ.
//   window: поток независимых случайных чтений, между соседними — F пустых команд (nop);
//           когда F × (сколько чтений в полёте) больше окна, чтения начинают ждать по одному.
//   model:  «одно чтение», «чтение + malloc», «ячейка → узел», «ячейка → узел + malloc» — модель вставки.
//   ./mlp [--qos ui|utility|background] → CSV в stdout
#include "mac_common.h"

static uint64_t sink;
constexpr size_t kLine = 128;                    // строка кэша Apple
constexpr size_t kWords = kLine / sizeof(uint64_t);
struct alignas(kLine) Line { uint32_t next; uint32_t pad[kLine / 4 - 1]; };

template <int K>
static double chains(const Line* a, const uint32_t* starts, long steps_per_lane) {
  uint32_t p[K];
  for (int k = 0; k < K; ++k) p[k] = starts[k];
  double t0 = now_ns();
  for (long i = 0; i < steps_per_lane; ++i)
    for (int k = 0; k < K; ++k) p[k] = a[p[k]].next;
  double t1 = now_ns();
  for (int k = 0; k < K; ++k) sink += p[k];
  return (t1 - t0) / ((double)steps_per_lane * K);
}

template <int F>
__attribute__((noinline)) static double loads_with_nops(const uint64_t* a, size_t mask, long iters) {
  uint64_t s = 0;
  double t0 = now_ns();
  for (long i = 0; i < iters; ++i) {
    s += a[(mix64((uint64_t)i) & mask) * kWords];
    asm volatile(".rept %c0\n\tnop\n\t.endr" ::"i"(F));
  }
  double t1 = now_ns();
  sink += s;
  return (t1 - t0) / iters;
}

enum Mode { LOADS, MALLOC_ONLY, LOADS_MALLOC, LOADS_DEP2, LOADS_DEP2_MALLOC };

__attribute__((noinline)) static double model(const uint64_t* a, size_t mask, long iters, Mode m, void** ptrs) {
  uint64_t s = 0;
  double t0 = now_ns();
  for (long i = 0; i < iters; ++i) {
    size_t idx = (mix64((uint64_t)i) & mask) * kWords;
    switch (m) {
      case LOADS: s += a[idx]; break;
      case MALLOC_ONLY: ptrs[i] = malloc(32); break;
      case LOADS_MALLOC: s += a[idx]; ptrs[i] = malloc(32); break;
      case LOADS_DEP2: { uint64_t v = a[idx]; s += a[(v & mask) * kWords]; break; }
      case LOADS_DEP2_MALLOC: { uint64_t v = a[idx]; s += a[(v & mask) * kWords]; ptrs[i] = malloc(32); break; }
    }
  }
  double t1 = now_ns();
  sink += s;
  return (t1 - t0) / iters;
}

int main(int argc, char** argv) {
  std::string qos = set_qos(qos_from_args(argc, argv));
  printf("exp,qos,param,ns\n");
  // ---- chains
  {
    const size_t bytes = 64u << 20, n = bytes / sizeof(Line);
    Line* a = (Line*)alloc_touched(bytes);
    uint64_t rng = 0x9e3779b97f4a7c15ULL;
    auto rnd = [&]() { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; };
    std::vector<uint32_t> perm(n), order(n);
    for (size_t i = 0; i < n; ++i) perm[i] = (uint32_t)i;
    for (size_t i = n - 1; i > 0; --i) std::swap(perm[i], perm[rnd() % i]);
    for (size_t i = 0; i < n; ++i) a[perm[i]].next = perm[(i + 1) % n];
    uint32_t p = 0;
    for (size_t j = 0; j < n; ++j) { order[j] = p; p = a[p].next; }
    const long target = 1L << 24;
    auto point = [&](int K, auto fn) {
      uint32_t starts[64];
      for (int k = 0; k < K; ++k) starts[k] = order[(size_t)k * n / K];
      long per_lane = (long)(n / K), reps = std::max(1L, target / (long)n);
      std::vector<double> v;
      for (int r = 0; r < 3; ++r) v.push_back(fn(a, starts, per_lane * reps));
      printf("chains,%s,%d,%.2f\n", qos.c_str(), K, median(v));
      fflush(stdout);
    };
    point(1, chains<1>);   point(2, chains<2>);   point(4, chains<4>);   point(8, chains<8>);
    point(12, chains<12>); point(16, chains<16>); point(24, chains<24>); point(32, chains<32>);
    point(48, chains<48>); point(64, chains<64>);
    free(a);
  }
  // ---- window + model
  {
    const size_t bytes = 64u << 20, lines = bytes / kLine, mask = lines - 1;
    uint64_t* a = (uint64_t*)alloc_touched(bytes);
    uint64_t rng = 7;
    for (size_t i = 0; i < bytes / 8; ++i) { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; a[i] = rng; }
    const long iters = 1L << 22;
    auto rep = [&](auto fn) { std::vector<double> v; for (int r = 0; r < 3; ++r) v.push_back(fn()); return median(v); };
#define W(F) printf("window,%s,%d,%.2f\n", qos.c_str(), F, rep([&] { return loads_with_nops<F>(a, mask, iters); })); fflush(stdout);
    W(0) W(8) W(16) W(32) W(64) W(96) W(128) W(192) W(256) W(384) W(512) W(640) W(768) W(1024) W(2048)
#undef W
    std::vector<void*> ptrs(iters);
    auto run_mode = [&](const char* name, Mode m) {
      std::vector<double> v;
      for (int r = 0; r < 3; ++r) {
        v.push_back(model(a, mask, iters, m, ptrs.data()));
        if (m == MALLOC_ONLY || m == LOADS_MALLOC || m == LOADS_DEP2_MALLOC)
          for (auto& q : ptrs) { free(q); q = nullptr; }
      }
      printf("model,%s,%s,%.2f\n", qos.c_str(), name, median(v));
      fflush(stdout);
    };
    run_mode("load", LOADS);
    run_mode("malloc", MALLOC_ONLY);
    run_mode("load+malloc", LOADS_MALLOC);
    run_mode("cell->node", LOADS_DEP2);
    run_mode("cell->node+malloc", LOADS_DEP2_MALLOC);
    free(a);
  }
  fprintf(stderr, "sink=%llu\n", (unsigned long long)sink);
  return 0;
}
