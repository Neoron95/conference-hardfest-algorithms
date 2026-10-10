// rob_window.cpp — сколько промахов держит в полёте ядро, если между промахами стоят F инструкций.
// Поток НЕзависимых случайных чтений по рабочему набору 64 МиБ (адрес = mix64(i) & mask),
// между чтениями — F штук nop (занимают слот ROB, не исполняются: метод robsize Henry Wong / Travis Downs).
// Ожидание: нс/чтение ≈ latency / min(MLP_max, ROB/(F+c)). Режимы с malloc — «наполнитель» из реальной жизни.
//   g++ -O2 rob_window.cpp -o build/rob_window && taskset -c 2 build/rob_window
#include "common.h"

static uint64_t sink;

template <int F>
__attribute__((noinline)) static double loads_with_nops(const uint64_t* a, size_t mask, long iters) {
  uint64_t s = 0;
  double t0 = now_ns();
  for (long i = 0; i < iters; ++i) {
    size_t idx = (mix64((uint64_t)i) & mask) * 8;  // индекс строки × 8 слов = шаг 64 Б
    s += a[idx];
    asm volatile(".rept %c0\n\tnop\n\t.endr" ::"i"(F));
  }
  double t1 = now_ns();
  sink += s;
  return (t1 - t0) / iters;
}

enum Mode { LOADS, MALLOC_ONLY, LOADS_MALLOC, LOADS_MALLOC_FREE, LOADS_DEP2, LOADS_DEP2_MALLOC };

__attribute__((noinline)) static double mixed(const uint64_t* a, size_t mask, long iters, Mode m, void** ptrs) {
  uint64_t s = 0;
  double t0 = now_ns();
  for (long i = 0; i < iters; ++i) {
    size_t idx = (mix64((uint64_t)i) & mask) * 8;
    switch (m) {
      case LOADS: s += a[idx]; break;
      case MALLOC_ONLY: ptrs[i] = malloc(32); break;
      case LOADS_MALLOC: s += a[idx]; ptrs[i] = malloc(32); break;
      case LOADS_MALLOC_FREE: s += a[idx]; free(malloc(32)); break;
      case LOADS_DEP2: { uint64_t v = a[idx]; s += a[(v & mask) * 8]; break; }  // ячейка → узел
      case LOADS_DEP2_MALLOC: { uint64_t v = a[idx]; s += a[(v & mask) * 8]; ptrs[i] = malloc(32); break; }
    }
  }
  double t1 = now_ns();
  sink += s;
  return (t1 - t0) / iters;
}

int main() {
  const size_t bytes = 64u << 20, lines = bytes / 64, mask = lines - 1;
  uint64_t* a = (uint64_t*)alloc_pages(bytes, true);
  uint64_t rng = 7;
  for (size_t i = 0; i < bytes / 8; ++i) { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; a[i] = rng; }
  const long iters = 1L << 22;
  printf("exp,param,ns_per_iter\n");
  auto rep = [&](auto fn) { std::vector<double> v; for (int r = 0; r < 3; ++r) v.push_back(fn()); return median(v); };
#define P(F) printf("nops,%d,%.2f\n", F, rep([&] { return loads_with_nops<F>(a, mask, iters); })); fflush(stdout);
  P(0) P(8) P(16) P(32) P(64) P(96) P(128) P(192) P(256) P(384) P(512) P(768) P(1024) P(2048)
#undef P
  std::vector<void*> ptrs(iters);
  auto run_mode = [&](const char* name, Mode m) {
    std::vector<double> v;
    for (int r = 0; r < 3; ++r) {
      v.push_back(mixed(a, mask, iters, m, ptrs.data()));
      if (m == MALLOC_ONLY || m == LOADS_MALLOC || m == LOADS_DEP2_MALLOC) for (long i = 0; i < iters; ++i) free(ptrs[i]);
    }
    printf("mode,%s,%.2f\n", name, median(v)); fflush(stdout);
  };
  run_mode("loads", LOADS);
  run_mode("malloc_only", MALLOC_ONLY);
  run_mode("loads+malloc", LOADS_MALLOC);
  run_mode("loads+malloc+free", LOADS_MALLOC_FREE);
  run_mode("loads_dep2", LOADS_DEP2);
  run_mode("loads_dep2+malloc", LOADS_DEP2_MALLOC);
  fprintf(stderr, "sink=%llu anon_huge_kb=%ld\n", (unsigned long long)sink, anon_huge_kb());
}
