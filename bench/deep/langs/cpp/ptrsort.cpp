// ptrsort.cpp — «что сортирует ваш язык: значения или указатели».
// Та же сортировка 2^20 случайных 64-битных ключей, но:
//   values      — std::sort над vector<uint64_t> (как в докладе);
//   ptr_seq     — vector<Box*>, объекты выделены new по одному в порядке массива
//                 (как список объектов, созданных подряд: TLAB/bump-аллокатор);
//   ptr_shuf    — те же объекты, но указатели перемешаны (объекты «разбросаны»
//                 по куче — как после GC-перемещений или долгой жизни);
//   ptr_shuf32  — объект 32 Б (как PyLong 64-битного числа: 36 Б → 48 Б malloc)
// Сравнение по *p — это модель Python sorted(list_of_int) и Java sort над Long[].
// Вывод: CSV variant,N,ns_per_elem (медиана 5)
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <memory>
#include <vector>

using u64 = uint64_t;
static inline u64 mix64(u64 z) {
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}
struct SplitMix64 { u64 s; u64 next() { return mix64(s += 0x9e3779b97f4a7c15ULL); }
  u64 below(u64 n) { return (u64)(((unsigned __int128)next() * n) >> 64); } };
using Clock = std::chrono::steady_clock;

template <size_t SZ> struct Box { u64 v; char pad[SZ - 8]; };

template <class F> static double median_ns(size_t N, int reps, F f) {
  std::vector<double> t;
  for (int i = 0; i < reps; ++i) {
    auto a = Clock::now(); f(); auto b = Clock::now();
    t.push_back(std::chrono::duration<double, std::nano>(b - a).count() / N);
  }
  std::sort(t.begin(), t.end());
  return t[t.size() / 2];
}

template <size_t SZ> static void run_ptr(const char* name, const std::vector<u64>& keys, bool shuf, size_t N) {
  using B = Box<SZ>;
  std::vector<std::unique_ptr<B>> own(N);
  for (size_t i = 0; i < N; ++i) { own[i] = std::make_unique<B>(); own[i]->v = keys[i]; }
  std::vector<B*> base(N);
  for (size_t i = 0; i < N; ++i) base[i] = own[i].get();
  if (shuf) { SplitMix64 r{99}; for (size_t i = N; i > 1; --i) std::swap(base[i - 1], base[r.below(i)]); }
  // ВАЖНО: ключи keys[i] — случайны, поэтому даже ptr_seq — это случайные значения;
  // отличие только в том, где лежат объекты относительно порядка указателей.
  std::vector<B*> work;
  double ns = median_ns(N, 5, [&] {
    work = base;  // копия указателей внутри таймера (8 МБ memcpy, как у values)
    std::sort(work.begin(), work.end(), [](const B* a, const B* b) { return a->v < b->v; });
  });
  std::printf("%s,%zu,%.2f\n", name, N, ns);
}

int main(int argc, char** argv) {
  size_t N = argc > 1 ? std::strtoull(argv[1], nullptr, 10) : (1u << 20);
  SplitMix64 r{17};
  std::vector<u64> keys(N);
  for (auto& k : keys) k = r.next();
  std::printf("variant,N,ns_per_elem\n");
  {
    std::vector<u64> work;
    double ns = median_ns(N, 5, [&] { work = keys; std::sort(work.begin(), work.end()); });
    std::printf("values,%zu,%.2f\n", N, ns);
  }
  run_ptr<16>("ptr_seq16", keys, false, N);
  run_ptr<16>("ptr_shuf16", keys, true, N);
  run_ptr<32>("ptr_seq32", keys, false, N);
  run_ptr<32>("ptr_shuf32", keys, true, N);
  run_ptr<48>("ptr_shuf48", keys, true, N);
}
