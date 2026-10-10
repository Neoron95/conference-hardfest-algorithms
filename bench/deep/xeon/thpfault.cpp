// thpfault.cpp — цена первого касания свежей памяти: 4K-страницы против THP (madvise), свежий mmap на каждой итерации.
//   g++ -O2 thpfault.cpp -o build/thpfault && taskset -c 2 build/thpfault 32 8
#include <chrono>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <sys/mman.h>
static double now_ms() { return std::chrono::duration<double, std::milli>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static size_t anon_huge_kb() { FILE* f = fopen("/proc/self/smaps_rollup", "r"); char l[256]; size_t kb = 0; while (f && fgets(l, sizeof l, f)) if (sscanf(l, "AnonHugePages: %zu kB", &kb) == 1) break; if (f) fclose(f); return kb; }
int main(int argc, char** argv) {
  size_t mb = argc > 1 ? atoi(argv[1]) : 32; int reps = argc > 2 ? atoi(argv[2]) : 8;
  const size_t HUGE = 2u << 20, bytes = mb << 20;
  for (int thp = 0; thp < 2; ++thp) {
    printf("# %s, %zu MB, fresh mmap each rep: ms per rep (touch 1 byte per 4K), MB/s, AnonHugePages after touch\n", thp ? "THP madvise" : "4K pages", mb);
    for (int r = 0; r < reps; ++r) {
      char* raw = (char*)mmap(nullptr, bytes + HUGE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      char* base = (char*)(((uintptr_t)raw + HUGE - 1) & ~(uintptr_t)(HUGE - 1));
      madvise(base, bytes, thp ? MADV_HUGEPAGE : MADV_NOHUGEPAGE);
      double t0 = now_ms();
      for (size_t off = 0; off < bytes; off += 4096) base[off] = 1;
      double t1 = now_ms();
      for (size_t off = 0; off < bytes; off += 4096) base[off] = 2;  // второе касание — уже отображено
      double t2 = now_ms();
      printf("rep %d: first touch %.2f ms (%.0f MB/s, %.3f ms per 2MB), second touch %.3f ms, AnonHugePages %zu kB\n", r, t1 - t0, mb / ((t1 - t0) / 1000), (t1 - t0) / (mb / 2.0), t2 - t1, anon_huge_kb());
      munmap(raw, bytes + HUGE);
    }
  }
  // контроль: то же без munmap — повторное касание того же отображения после MADV_DONTNEED
  printf("# THP, %zu MB, one mapping, MADV_DONTNEED between reps (страницы возвращаются ядру гостя, но не хосту?)\n", mb);
  char* raw = (char*)mmap(nullptr, bytes + HUGE, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
  char* base = (char*)(((uintptr_t)raw + HUGE - 1) & ~(uintptr_t)(HUGE - 1));
  madvise(base, bytes, MADV_HUGEPAGE);
  for (int r = 0; r < reps; ++r) {
    double t0 = now_ms();
    for (size_t off = 0; off < bytes; off += 4096) base[off] = 1;
    double t1 = now_ms();
    printf("rep %d: touch %.2f ms (%.3f ms per 2MB) AnonHugePages %zu kB\n", r, t1 - t0, (t1 - t0) / (mb / 2.0), anon_huge_kb());
    madvise(base, bytes, MADV_DONTNEED);
  }
}
