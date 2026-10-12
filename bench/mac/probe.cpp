// probe.cpp — паспорт ядра на Mac: эффективная частота и лестница задержек одного чтения.
//   Частота: цепочка зависимых add (1 такт на команду на Apple-ядрах; на x86 — imul, 3 такта).
//   Лестница: случайный цикл (Саттоло) по строкам 128 Б — размер строки кэша у Apple;
//   каждое чтение приносит адрес следующего, так что параллельности нет.
//   ./probe [--qos ui|utility|background]   → CSV в stdout
#include "mac_common.h"

static double freq_ghz() {
  uint64_t x = 3, m = 5;
  const long iters = 100000000;
  double t0 = now_ns();
  for (long i = 0; i < iters; i++) {
#if defined(__aarch64__)
    asm volatile("add %0, %0, %1\n\tadd %0, %0, %1\n\tadd %0, %0, %1\n\tadd %0, %0, %1\n\t"
                 "add %0, %0, %1\n\tadd %0, %0, %1\n\tadd %0, %0, %1\n\tadd %0, %0, %1"
                 : "+r"(x) : "r"(m));
#elif defined(__x86_64__)
    asm volatile("imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\t"
                 "imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0" : "+r"(x) : "r"(m));
#endif
  }
  double ns = now_ns() - t0;
#if defined(__x86_64__)
  return iters * 8.0 * 3 / ns;  // imul — 3 такта
#else
  return iters * 8.0 / ns;      // add — 1 такт
#endif
}

namespace {  // своя структура в каждом файле: в iOS-приложении все замеры линкуются вместе
struct alignas(128) Line { Line* next; char pad[120]; };
}  // namespace

int main(int argc, char** argv) {
  std::string qos = set_qos(qos_from_args(argc, argv));
  printf("kind,qos,param,value\n");
  for (int r = 0; r < 3; ++r) { printf("freq_ghz,%s,rep%d,%.3f\n", qos.c_str(), r, freq_ghz()); fflush(stdout); }
  uint64_t rng = 12345;
  auto rnd = [&]() { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; };
  for (size_t kb : {16, 32, 64, 96, 128, 192, 256, 512, 1024, 2048, 4096, 8192, 12288, 16384, 24576,
                    32768, 65536, 131072, 262144, 1048576}) {
    const size_t n = kb * 1024 / sizeof(Line);
    Line* a = (Line*)alloc_touched(n * sizeof(Line));
    std::vector<size_t> perm(n);
    for (size_t i = 0; i < n; ++i) perm[i] = i;
    for (size_t i = n - 1; i > 0; --i) std::swap(perm[i], perm[rnd() % i]);
    for (size_t i = 0; i < n; ++i) a[perm[i]].next = &a[perm[(i + 1) % n]];
    const long steps = std::max<long>(1L << 22, (long)n * 4);
    std::vector<double> v;
    Line* p = a;
    for (int r = 0; r < 3; ++r) {
      double t0 = now_ns();
      for (long i = 0; i < steps; ++i) p = p->next;
      v.push_back((now_ns() - t0) / steps);
    }
    printf("latency_ns,%s,%zu_KB,%.2f\n", qos.c_str(), kb, median(v));
    fflush(stdout);
    if (p == nullptr) puts("");  // не даём выкинуть цикл
    free(a);
  }
  return 0;
}
