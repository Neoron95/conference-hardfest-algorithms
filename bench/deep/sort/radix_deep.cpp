// radix_deep.cpp — LSD radix изнутри: время каждого прохода, варианты разрядности,
// пропуск константных байтов, software write-combining, префетч.
// Сборка: g++ -O3 -mavx2 radix_deep.cpp -o radix_deep   (NT-вариант требует AVX2)
// Запуск: ./radix_deep [--n N] [--keys random|dense] [--reps R] [--variants a,b,c]
// Вывод CSV: N,keys,variant,phase,ns_per_elem,gbs  (gbs: полезный трафик 16 байт/эл на проход)
#include "common.h"
#include <immintrin.h>
#include <functional>
#include <map>

struct Phases { std::vector<std::pair<std::string, double>> v; void add(const std::string& n, double ns) { v.push_back({n, ns}); } };

// ---- обобщённый LSD по BITS бит за проход; последний проход может быть уже
template <int BITS>
static void lsd(u64* src, u64* dst, size_t n, Phases& ph, bool skip, u64*& out) {
  constexpr int K = 1 << BITS;
  constexpr int PASSES = (64 + BITS - 1) / BITS;
  static std::vector<uint32_t> cnt;  // PASSES x K счётчиков
  cnt.assign((size_t)PASSES * K, 0);
  double t0 = now_ns();
  for (size_t i = 0; i < n; ++i) {
    u64 x = src[i];
    for (int p = 0; p < PASSES; ++p) cnt[(size_t)p * K + ((x >> (p * BITS)) & (K - 1))]++;
  }
  ph.add("hist", now_ns() - t0);
  static std::vector<uint32_t> off;
  off.resize(K);
  for (int p = 0; p < PASSES; ++p) {
    const int sh = p * BITS;
    const uint32_t* c = &cnt[(size_t)p * K];
    if (skip && c[(src[0] >> sh) & (K - 1)] == n) { ph.add("p" + std::to_string(p), 0.0); continue; }
    t0 = now_ns();
    uint32_t sum = 0;
    for (int i = 0; i < K; ++i) { off[i] = sum; sum += c[i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & (K - 1)]++] = x; }
    ph.add("p" + std::to_string(p), now_ns() - t0);
    std::swap(src, dst);
  }
  out = src;
}

// ---- 8-битные проходы с вариантами рассеивания
enum class Scatter { Plain, Prefetch, SWWC, SWWC_NT, Unroll2 };

static void scatter_plain(const u64* src, u64* dst, size_t n, int sh, uint32_t* off) {
  for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 255]++] = x; }
}
static void scatter_prefetch(const u64* src, u64* dst, size_t n, int sh, uint32_t* off) {
  for (size_t i = 0; i < n; ++i) {
    u64 x = src[i];
    uint32_t& o = off[(x >> sh) & 255];
    dst[o++] = x;
    __builtin_prefetch(dst + o + 8, 1, 0);  // следующая строка этого потока записи
  }
}
static void scatter_unroll2(const u64* src, u64* dst, size_t n, int sh, uint32_t* off) {
  size_t i = 0;
  for (; i + 2 <= n; i += 2) {
    u64 x = src[i], y = src[i + 1];
    unsigned bx = (x >> sh) & 255, by = (y >> sh) & 255;
    dst[off[bx]++] = x;
    dst[off[by]++] = y;
  }
  for (; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 255]++] = x; }
}
// software write-combining: 256 буферов по 8 элементов (64 Б = строка) в L1,
// в dst уходят только целые строки. dst должен быть выровнен на 64.
template <bool NT>
static void scatter_swwc(const u64* src, u64* dst, size_t n, int sh, uint32_t* off0) {
  alignas(64) static u64 buf[256][8];
  static uint32_t pos[256];
  static uint8_t fill[256];
  for (int b = 0; b < 256; ++b) { pos[b] = off0[b]; fill[b] = 0; }
  for (size_t i = 0; i < n; ++i) {
    u64 x = src[i];
    unsigned b = (x >> sh) & 255;
    uint32_t idx = pos[b] + fill[b];
    buf[b][idx & 7] = x;
    ++fill[b];
    if ((idx & 7) == 7) {  // строка dst[idx-7..idx] готова
      if (fill[b] == 8) {
        u64* d = dst + (idx - 7);
        if (NT) {
          _mm256_stream_si256((__m256i*)d, _mm256_load_si256((const __m256i*)&buf[b][0]));
          _mm256_stream_si256((__m256i*)(d + 4), _mm256_load_si256((const __m256i*)&buf[b][4]));
        } else {
          _mm256_storeu_si256((__m256i*)d, _mm256_load_si256((const __m256i*)&buf[b][0]));
          _mm256_storeu_si256((__m256i*)(d + 4), _mm256_load_si256((const __m256i*)&buf[b][4]));
        }
      } else {  // корзина началась посреди строки
        memcpy(dst + idx + 1 - fill[b], &buf[b][8 - fill[b]], fill[b] * 8);
      }
      pos[b] = idx + 1;
      fill[b] = 0;
    }
  }
  for (int b = 0; b < 256; ++b)
    if (fill[b]) memcpy(dst + pos[b], &buf[b][pos[b] & 7], fill[b] * 8);
  if (NT) _mm_sfence();
}

static void lsd8(u64* src, u64* dst, size_t n, Phases& ph, bool skip, Scatter sc, u64*& out, bool hist_per_pass = false) {
  static uint32_t cnt[8][256];
  memset(cnt, 0, sizeof cnt);
  double t0 = now_ns();
  if (!hist_per_pass)
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 255]++; }
  ph.add("hist", now_ns() - t0);
  for (int p = 0; p < 8; ++p) {
    const int sh = 8 * p;
    t0 = now_ns();
    if (hist_per_pass) { memset(cnt[p], 0, sizeof cnt[p]); for (size_t i = 0; i < n; ++i) cnt[p][(src[i] >> sh) & 255]++; }
    if (skip && cnt[p][(src[0] >> sh) & 255] == n) { ph.add("p" + std::to_string(p), 0.0); continue; }
    uint32_t off[256];
    uint32_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[p][i]; }
    switch (sc) {
      case Scatter::Plain: scatter_plain(src, dst, n, sh, off); break;
      case Scatter::Prefetch: scatter_prefetch(src, dst, n, sh, off); break;
      case Scatter::Unroll2: scatter_unroll2(src, dst, n, sh, off); break;
      case Scatter::SWWC: scatter_swwc<false>(src, dst, n, sh, off); break;
      case Scatter::SWWC_NT: scatter_swwc<true>(src, dst, n, sh, off); break;
    }
    ph.add("p" + std::to_string(p), now_ns() - t0);
    std::swap(src, dst);
  }
  out = src;
}

// ---- «как в bench»: вся операция одним таймером (alloc + hist + проходы + memcpy + unique + erase + free)
static void full_like_bench(Vec& v) {
  const size_t n = v.size();
  std::unique_ptr<u64[]> buf(new u64[n]);
  uint32_t cnt[8][256] = {};
  for (u64 x : v) for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
  u64* src = v.data(); u64* dst = buf.get();
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;
    size_t off[256]; size_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v.data()) std::memcpy(v.data(), src, n * sizeof(u64));
  v.erase(std::unique(v.begin(), v.end()), v.end());
}

int main(int argc, char** argv) {
  size_t N = 1u << 20; std::string keys = "random"; int reps = 7;
  std::vector<std::string> variants = {"r8", "r8_force", "r8_histpp", "r11", "r16", "r8_pf", "r8_unroll2", "r8_swwc", "r8_swwc_nt", "full"};
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    if (a == "--n") N = std::stoull(argv[++i]);
    else if (a == "--keys") keys = argv[++i];
    else if (a == "--reps") reps = atoi(argv[++i]);
    else if (a == "--variants") { variants.clear(); std::string s = argv[++i]; size_t p = 0; while (p <= s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); if (q > p) variants.push_back(s.substr(p, q - p)); p = q + 1; } }
  }
  const size_t U = N;  // все уникальны, как в E1 (dense: 1..N перемешаны)
  std::vector<Vec> pool(8);
  for (size_t i = 0; i < pool.size(); ++i) pool[i] = make_input(keys, N, U, 17 + i);
  u64* A = (u64*)aligned_alloc(64, N * 8);
  u64* B = (u64*)aligned_alloc(64, N * 8);
  memset(A, 0, N * 8); memset(B, 0, N * 8);
  printf("N,keys,variant,phase,ns_per_elem,gbs\n");
  for (auto& var : variants) {
    std::map<std::string, std::vector<double>> acc;
    std::vector<std::string> order;
    for (int r = 0; r < reps; ++r) {
      const Vec& in = pool[r % pool.size()];
      if (var == "full") {
        Vec w(in);
        double t0 = now_ns(); full_like_bench(w); double t1 = now_ns();
        Vec ref(in); std::sort(ref.begin(), ref.end()); ref.erase(std::unique(ref.begin(), ref.end()), ref.end());
        if (w != ref) { fprintf(stderr, "WRONG full\n"); return 2; }
        if (r == 0) order.push_back("total");
        acc["total"].push_back((t1 - t0) / (double)N);
        continue;
      }
      memcpy(A, in.data(), N * 8);
      Phases ph; u64* out = nullptr;
      double t0 = now_ns();
      if (var == "r8") lsd8(A, B, N, ph, true, Scatter::Plain, out);
      else if (var == "r8_force") lsd8(A, B, N, ph, false, Scatter::Plain, out);
      else if (var == "r8_histpp") lsd8(A, B, N, ph, true, Scatter::Plain, out, true);
      else if (var == "r8_pf") lsd8(A, B, N, ph, true, Scatter::Prefetch, out);
      else if (var == "r8_unroll2") lsd8(A, B, N, ph, true, Scatter::Unroll2, out);
      else if (var == "r8_swwc") lsd8(A, B, N, ph, true, Scatter::SWWC, out);
      else if (var == "r8_swwc_nt") lsd8(A, B, N, ph, true, Scatter::SWWC_NT, out);
      else if (var == "r11") lsd<11>(A, B, N, ph, true, out);
      else if (var == "r16") lsd<16>(A, B, N, ph, true, out);
      else { fprintf(stderr, "unknown variant %s\n", var.c_str()); return 2; }
      double t1 = now_ns();
      ph.add("total", t1 - t0);
      if (!std::is_sorted(out, out + N)) { fprintf(stderr, "WRONG %s (not sorted)\n", var.c_str()); return 2; }
      Vec ref(in); std::sort(ref.begin(), ref.end());
      if (memcmp(out, ref.data(), N * 8) != 0) { fprintf(stderr, "WRONG %s (mismatch)\n", var.c_str()); return 2; }
      for (auto& [name, ns] : ph.v) { if (r == 0) order.push_back(name); acc[name].push_back(ns / (double)N); }
    }
    for (auto& name : order) {
      double m = median(acc[name]);
      double gbs = (name == "hist" || name == "total") ? 0.0 : (m > 0 ? 16.0 / m : 0.0);
      printf("%zu,%s,%s,%s,%.3f,%.2f\n", N, keys.c_str(), var.c_str(), name.c_str(), m, gbs);
    }
    fflush(stdout);
  }
  free(A); free(B);
  return 0;
}
