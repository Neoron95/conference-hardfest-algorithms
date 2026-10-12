// sortfam.cpp — одна O(n log n), разные реализации (слайд sortfamily) на Mac.
//   std::sort (системная libc++), pdqsort_branchy (с ветвлениями), pdqsort_branchless (разбиение без ветвлений),
//   LSD radix по байту. Только сортировка, 1M случайных uint64 (все разные), нс на элемент.
//   ./sortfam [--qos ui|utility|background] [--n N] → CSV в stdout
#include "mac_common.h"
#include "../deep/sort/pdqsort.h"
#include <memory>

static void radix_lsd(std::vector<uint64_t>& v) {
  const size_t n = v.size();
  std::unique_ptr<uint64_t[]> buf(new uint64_t[n]);
  uint32_t cnt[8][256] = {};
  for (uint64_t x : v)
    for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
  uint64_t *src = v.data(), *dst = buf.get();
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;
    size_t off[256], sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { uint64_t x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v.data()) memcpy(v.data(), src, n * sizeof(uint64_t));
}

int main(int argc, char** argv) {
  std::string qos = set_qos(qos_from_args(argc, argv));
  size_t N = 1u << 20;
  for (int i = 1; i + 1 < argc; ++i) if (std::string(argv[i]) == "--n") N = std::stoull(argv[i + 1]);
  std::vector<std::vector<uint64_t>> inputs(16);
  for (size_t k = 0; k < inputs.size(); ++k) {
    inputs[k].resize(N);
    for (size_t i = 0; i < N; ++i) inputs[k][i] = mix64(k * 0x100000001b3ULL + i);  // все разные
  }
  struct Alg { const char* name; void (*fn)(std::vector<uint64_t>&); };
  const Alg algs[] = {
      {"std_sort", [](std::vector<uint64_t>& v) { std::sort(v.begin(), v.end()); }},
      // pdqsort() для чисел со std::less сам выбирает безветвенный вариант — своя лямбда-компаратор
      // заставляет взять вариант с ветвлениями.
      {"pdqsort_branchy", [](std::vector<uint64_t>& v) { pdqsort(v.begin(), v.end(), [](uint64_t a, uint64_t b) { return a < b; }); }},
      {"pdqsort_branchless", [](std::vector<uint64_t>& v) { pdqsort_branchless(v.begin(), v.end()); }},
      {"radix_lsd", radix_lsd},
  };
  printf("exp,qos,alg,N,median_ns_el,min_ns_el,max_ns_el\n");
  std::vector<uint64_t> w;
  for (int round = 0; round < 2; ++round)  // первый круг — прогрев, печатаем второй
    for (auto& a : algs) {
      std::vector<double> t;
      for (size_t k = 0; k < inputs.size(); ++k) {
        w = inputs[k];                        // копия вне таймера
        double t0 = now_ns();
        a.fn(w);
        t.push_back((now_ns() - t0) / N);
        if (!std::is_sorted(w.begin(), w.end())) { fprintf(stderr, "%s: not sorted\n", a.name); return 2; }
      }
      if (round == 1) {
        std::sort(t.begin(), t.end());
        printf("sortfam,%s,%s,%zu,%.2f,%.2f,%.2f\n", qos.c_str(), a.name, N, median(t), t.front(), t.back());
        fflush(stdout);
      }
    }
  return 0;
}
