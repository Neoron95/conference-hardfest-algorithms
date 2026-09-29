// probe.cpp — паспорт машины: эффективная частота ядра и задержка зависимого чтения.
//   g++ -O2 probe.cpp -o build/probe && taskset -c 2 build/probe
// Частота: цепочка зависимых imul (задержка 3 такта на Intel начиная с Sandy Bridge).
// Задержка: случайный цикл по строкам кэша (64 Б, перестановка Саттоло), 4K-страницы.
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>

static double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

int main() {
  for (int rep = 0; rep < 3; ++rep) {
    uint64_t x = 3, m = 5;
    const long iters = 50000000;
    double t0 = now_ns();
    for (long i = 0; i < iters; i++)
      asm volatile("imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\t"
                   "imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0" : "+r"(x) : "r"(m));
    printf("freq_ghz,%.2f\n", iters * 8.0 * 3 / (now_ns() - t0));
  }
  struct alignas(64) Line { Line* next; char pad[56]; };
  uint64_t rng = 12345;
  auto rnd = [&]() { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; };
  for (size_t kb : {16, 32, 128, 1024, 4096, 16384, 65536, 262144, 1048576}) {
    const size_t n = kb * 1024 / sizeof(Line);
    std::vector<Line> a(n);
    std::vector<uint32_t> perm(n);
    for (size_t i = 0; i < n; ++i) perm[i] = (uint32_t)i;
    for (size_t i = n - 1; i > 0; --i) std::swap(perm[i], perm[rnd() % i]);  // Саттоло: один цикл
    for (size_t i = 0; i < n; ++i) a[perm[i]].next = &a[perm[(i + 1) % n]];
    const long steps = kb <= 4096 ? 1L << 24 : 1L << 22;
    Line* p = &a[0];
    for (long i = 0; i < steps / 4; ++i) p = p->next;  // прогрев
    double t0 = now_ns();
    for (long i = 0; i < steps; ++i) p = p->next;
    double ns = (now_ns() - t0) / steps;
    printf("latency_ns,%zu KB,%.1f%s\n", kb, ns, p ? "" : "!");
  }
}
