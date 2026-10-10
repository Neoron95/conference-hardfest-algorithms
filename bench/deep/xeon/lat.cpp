// lat.cpp — лестница задержек зависимого чтения (pointer chasing, Drepper 2007 §3.3.2)
// с выбором шага (строка 64 Б или страница 4 КБ) и прозрачных huge pages (madvise + выравнивание 2 МБ).
//   g++ -O2 lat.cpp -o build/lat
//   build/lat --stride 64 --sizes 16,32,...,1048576          # в КБ
//   build/lat --stride 4096 --thp --sizes 4096,...,1048576
// При шаге в страницу строка внутри страницы выбирается случайно (hash(i) % 64), иначе все
// элементы попали бы в одни и те же наборы L1/L2 (set aliasing) и измерялся бы не TLB, а ассоциативность.
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#include <sys/mman.h>

static double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
static size_t anon_huge_kb() {  // AnonHugePages процесса из /proc/self/smaps_rollup
  FILE* f = fopen("/proc/self/smaps_rollup", "r");
  if (!f) return 0;
  char line[256]; size_t kb = 0;
  while (fgets(line, sizeof line, f)) if (sscanf(line, "AnonHugePages: %zu kB", &kb) == 1) break;
  fclose(f);
  return kb;
}
static uint64_t mix(uint64_t z) { z += 0x9e3779b97f4a7c15ull; z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ull; z = (z ^ (z >> 27)) * 0x94d049bb133111ebull; return z ^ (z >> 31); }

int main(int argc, char** argv) {
  size_t stride = 64; bool thp = false; long steps_small = 1L << 24, steps_big = 1L << 22; int reps = 1;
  std::vector<size_t> sizes_kb;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    if (a == "--stride") stride = std::stoull(argv[++i]);
    else if (a == "--thp") thp = true;
    else if (a == "--reps") reps = std::stoi(argv[++i]);
    else if (a == "--steps") steps_small = steps_big = std::stol(argv[++i]);
    else if (a == "--sizes") { std::string s = argv[++i]; size_t p = 0; while (p < s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); sizes_kb.push_back(std::stoull(s.substr(p, q - p))); p = q + 1; } }
  }
  if (sizes_kb.empty()) { fprintf(stderr, "need --sizes\n"); return 2; }
  const size_t HUGE = 2u << 20;
  printf("# stride=%zu thp=%d  columns: size_KB,elements,pages4K,ns_per_load,anon_huge_KB\n", stride, thp);
  for (size_t kb : sizes_kb) {
    const size_t bytes = kb * 1024;
    const size_t n = bytes / stride;
    if (n < 2) continue;
    // выравненное на 2 МБ анонимное отображение
    const size_t len = ((bytes + HUGE - 1) / HUGE) * HUGE + HUGE;
    char* raw = (char*)mmap(nullptr, len, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (raw == MAP_FAILED) { perror("mmap"); return 1; }
    char* base = (char*)(((uintptr_t)raw + HUGE - 1) & ~(uintptr_t)(HUGE - 1));
    const size_t ulen = ((bytes + HUGE - 1) / HUGE) * HUGE;
    madvise(base, ulen, thp ? MADV_HUGEPAGE : MADV_NOHUGEPAGE);
    // адрес элемента i: base + i*stride + (stride>=4096 ? случайная строка внутри страницы : 0)
    auto addr = [&](size_t i) -> char** {
      size_t off = (stride >= 4096) ? (mix(i) % (stride / 64)) * 64 : 0;
      return (char**)(base + i * stride + off);
    };
    std::vector<uint32_t> perm(n);
    for (size_t i = 0; i < n; ++i) perm[i] = (uint32_t)i;
    uint64_t rng = 0x12345 + kb;
    auto rnd = [&]() { rng ^= rng << 13; rng ^= rng >> 7; rng ^= rng << 17; return rng; };
    for (size_t i = n - 1; i > 0; --i) std::swap(perm[i], perm[rnd() % i]);  // Саттоло: один цикл
    for (size_t i = 0; i < n; ++i) *addr(perm[i]) = (char*)addr(perm[(i + 1) % n]);
    const long steps = bytes <= (4u << 20) ? steps_small : steps_big;
    double best = 1e30;
    for (int r = 0; r < reps; ++r) {
      char** p = addr(0);
      for (long i = 0; i < steps / 4; ++i) p = (char**)*p;  // прогрев
      double t0 = now_ns();
      for (long i = 0; i < steps; ++i) p = (char**)*p;
      double ns = (now_ns() - t0) / steps;
      if (p == nullptr) ns = -1;  // чтобы цикл не выбросили
      if (ns < best) best = ns;
    }
    printf("%zu,%zu,%zu,%.2f,%zu\n", kb, n, bytes / 4096, best, anon_huge_kb());
    fflush(stdout);
    munmap(raw, len);
  }
}
