// malloc_cost.cpp — сколько стоит один malloc(24)/free на glibc 2.39 (x86 VM).
// Серии:
//   pair     : 1M × (malloc(S); free) подряд — путь tcache_get/tcache_put, всё в L1;
//   fresh    : 1M malloc(S) на свежей куче (чанки из top, с page faults), потом
//              1M free в порядке выделения;
//   recycled : второй круг: 1M malloc(S) из tcache/fastbin, free в порядке выделения;
//   random   : третий круг: 1M malloc(S), free в случайном порядке;
//   scrambled: четвёртый круг после случайного free: malloc отдаёт адреса в
//              порядке LIFO fastbin — т.е. в случайном порядке; меряем и это.
// Для каждого круга: нс/malloc, нс/free, доля соседних адресов (Δ = +S_chunk),
// средний |Δ|, RSS до/после.
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <malloc.h>
#include <string>
#include <vector>

static double now_ns() {
  return (double)std::chrono::duration_cast<std::chrono::nanoseconds>(
             std::chrono::steady_clock::now().time_since_epoch()).count();
}
static long rss_kb() {
  FILE* f = fopen("/proc/self/statm", "r");
  long pages = 0, rss = 0;
  if (f) { if (fscanf(f, "%ld %ld", &pages, &rss) != 2) rss = 0; fclose(f); }
  return rss * 4;
}
struct SplitMix64 {
  uint64_t s;
  uint64_t next() { uint64_t z = (s += 0x9e3779b97f4a7c15ULL); z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL; z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL; return z ^ (z >> 31); }
  uint64_t below(uint64_t n) { return (uint64_t)(((unsigned __int128)next() * n) >> 64); }
};

struct AddrStats { double frac_next = 0, frac_within_4k = 0, mean_abs_delta = 0, frac_desc = 0; };
static AddrStats addr_stats(const std::vector<char*>& p, long step) {
  AddrStats a; size_t n = p.size(); if (n < 2) return a;
  size_t nxt = 0, w4k = 0, desc = 0; double sum = 0;
  for (size_t i = 1; i < n; ++i) {
    long d = p[i] - p[i - 1];
    if (d == step) ++nxt;
    if (d < 0) ++desc;
    if (d > -4096 && d < 4096) ++w4k;
    sum += (double)(d < 0 ? -d : d);
  }
  a.frac_next = (double)nxt / (n - 1); a.frac_within_4k = (double)w4k / (n - 1);
  a.frac_desc = (double)desc / (n - 1); a.mean_abs_delta = sum / (n - 1);
  return a;
}

int main(int argc, char** argv) {
  size_t N = 1u << 20, S = 24; int rounds_pair = 5;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    if (a == "--n") N = std::stoull(argv[++i]);
    else if (a == "--size") S = std::stoull(argv[++i]);
  }
  printf("series,size,N,ns_per_malloc,ns_per_free,frac_delta_eq_chunk,frac_within_4k,frac_desc,mean_abs_delta_B,rss_before_kb,rss_after_malloc_kb,rss_after_free_kb\n");
  // --- pair: malloc+free в цикле (всё в tcache, одна и та же строка кэша)
  {
    double best = 1e18;
    for (int r = 0; r < rounds_pair; ++r) {
      double t0 = now_ns();
      for (size_t i = 0; i < N; ++i) { char* p = (char*)malloc(S); *(volatile char*)p = 1; free(p); }
      double t = (now_ns() - t0) / N;
      best = std::min(best, t);
    }
    printf("pair,%zu,%zu,%.2f,-,-,-,-,-,-,-,-\n", S, N, best);
    // pair, 8 живых: цикл по 8 указателям (tcache хранит 7, восьмой уходит в fastbin и
    // возвращается через _int_malloc): имитация «tcache промахнулся»
    for (size_t live : {size_t(7), size_t(8), size_t(64)}) {
      std::vector<char*> ring(live, nullptr);
      double bst = 1e18;
      for (int r = 0; r < rounds_pair; ++r) {
        double t0 = now_ns();
        for (size_t i = 0; i < N; ++i) { size_t k = i % live; if (ring[k]) free(ring[k]); ring[k] = (char*)malloc(S); *(volatile char*)ring[k] = 1; }
        double t = (now_ns() - t0) / N;
        bst = std::min(bst, t);
      }
      for (auto& p : ring) { free(p); p = nullptr; }
      printf("ring_%zu_live,%zu,%zu,%.2f,-,-,-,-,-,-,-,-\n", live, S, N, bst);
    }
  }
  long chunk = (long)(((S + 8 + 15) / 16) * 16); if (chunk < 32) chunk = 32;
  std::vector<char*> ptrs(N);
  SplitMix64 rng{42};
  std::vector<uint32_t> perm(N);
  for (uint32_t i = 0; i < N; ++i) perm[i] = i;
  for (size_t i = N; i > 1; --i) std::swap(perm[i - 1], perm[rng.below(i)]);
  // consolidated_*: перед кругом free(100 КиБ) из кучи — это >= FASTBIN_CONSOLIDATION_THRESHOLD (64 КиБ),
  // glibc сливает все fastbin-чанки в большие свободные куски; дальше malloc режет их подряд через _int_malloc
  // (так выглядит куча между вызовами в dedup_bench: массив ячеек 8 МБ освобождается каждый вызов).
  const char* names[] = {"fresh_seqfree", "recycled_seqfree", "recycled_randfree", "scrambled_seqfree", "scrambled_randfree", "consolidated_seqfree", "consolidated_randfree", "consolidated2_seqfree"};
  for (int round = 0; round < 8; ++round) {
    if (round >= 5) { void* big = malloc(100 * 1024); memset(big, 1, 100 * 1024); free(big); }
    long r0 = rss_kb();
    double t0 = now_ns();
    for (size_t i = 0; i < N; ++i) { ptrs[i] = (char*)malloc(S); ptrs[i][0] = 1; }
    double tm = (now_ns() - t0) / N;
    long r1 = rss_kb();
    AddrStats st = addr_stats(ptrs, chunk);
    bool randfree = (round == 2 || round == 4 || round == 6);
    t0 = now_ns();
    if (randfree) for (size_t i = 0; i < N; ++i) free(ptrs[perm[i]]);
    else for (size_t i = 0; i < N; ++i) free(ptrs[i]);
    double tf = (now_ns() - t0) / N;
    long r2 = rss_kb();
    printf("%s,%zu,%zu,%.2f,%.2f,%.3f,%.3f,%.3f,%.0f,%ld,%ld,%ld\n", names[round], S, N, tm, tf, st.frac_next, st.frac_within_4k, st.frac_desc, st.mean_abs_delta, r0, r1, r2);
  }
  long before_trim = rss_kb();
  malloc_trim(0);
  printf("after_malloc_trim,%zu,%zu,-,-,-,-,-,-,%ld,-,%ld\n", S, N, before_trim, rss_kb());
  return 0;
}
