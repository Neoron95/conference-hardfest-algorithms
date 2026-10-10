// cg_dedup.cpp — драйвер для valgrind --tool=cachegrind: один вызов алгоритма дедупликации,
// счёт инструкций и промахов (симуляция) только внутри функции run_*  (--toggle-collect='run_*').
//   ./cg_dedup <sort|uset|flat|open|radix> N U
#include "common.h"
#include <unordered_set>
#ifdef HAVE_ABSL
#include "absl/container/flat_hash_set.h"
#endif
static std::vector<uint64_t> in, out;

extern "C" __attribute__((noinline)) void run_sort() {
  out = in; std::sort(out.begin(), out.end()); out.erase(std::unique(out.begin(), out.end()), out.end());
}
extern "C" __attribute__((noinline)) void run_uset() {
  std::unordered_set<uint64_t> s; s.reserve(in.size());
  for (uint64_t k : in) s.insert(k);
  out.assign(s.begin(), s.end());
}
#ifdef HAVE_ABSL
extern "C" __attribute__((noinline)) void run_flat() {
  absl::flat_hash_set<uint64_t> s; s.reserve(in.size());
  for (uint64_t k : in) s.insert(k);
  out.assign(s.begin(), s.end());
}
#endif
extern "C" __attribute__((noinline)) void run_open() {  // своя открытая адресация, 2N слотов
  size_t n = in.size(), ns = 2 * n, mask = ns - 1; int shift = 64 - __builtin_ctzll(ns);
  std::vector<uint64_t> slots(ns, 0);
  for (uint64_t k : in) for (size_t i = mix64(k) >> shift;; i = (i + 1) & mask) { if (slots[i] == 0) { slots[i] = k; break; } if (slots[i] == k) break; }
  out.clear(); for (uint64_t s : slots) if (s) out.push_back(s);
}
extern "C" __attribute__((noinline)) void run_radix() {  // LSD radix по 8 байтам + unique
  size_t n = in.size(); out = in; std::vector<uint64_t> tmp(n);
  for (int pass = 0; pass < 8; ++pass) {
    size_t cnt[256] = {0}; int sh = pass * 8;
    for (uint64_t x : out) cnt[(x >> sh) & 255]++;
    size_t pos[256]; size_t acc = 0; for (int b = 0; b < 256; ++b) { pos[b] = acc; acc += cnt[b]; }
    for (uint64_t x : out) tmp[pos[(x >> sh) & 255]++] = x;
    out.swap(tmp);
  }
  out.erase(std::unique(out.begin(), out.end()), out.end());
}
int main(int argc, char** argv) {
  std::string alg = argc > 1 ? argv[1] : "sort";
  size_t N = argc > 2 ? atol(argv[2]) : 1 << 20, U = argc > 3 ? atol(argv[3]) : N;
  std::vector<uint64_t> uniq(U); for (size_t i = 0; i < U; ++i) uniq[i] = mix64(i + 1000003);
  in.resize(N); for (size_t i = 0; i < N; ++i) in[i] = uniq[i % U];
  { uint64_t r = 42; for (size_t i = N - 1; i > 0; --i) { r = mix64(r); std::swap(in[i], in[r % (i + 1)]); } }
  out.reserve(N);
  if (alg == "sort") run_sort(); else if (alg == "uset") run_uset(); else if (alg == "open") run_open(); else if (alg == "radix") run_radix();
#ifdef HAVE_ABSL
  else if (alg == "flat") run_flat();
#endif
  else { fprintf(stderr, "unknown alg\n"); return 2; }
  printf("%s N=%zu U=%zu -> %zu unique\n", alg.c_str(), N, U, out.size());
}
