// common.h — генератор входов и таймер для bench/deep/sort (как в ../../dedup_bench.cpp)
#pragma once
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>

using u64 = uint64_t;
using Vec = std::vector<u64>;

static inline u64 mix64(u64 z) {
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}
struct SplitMix64 {
  u64 s;
  explicit SplitMix64(u64 seed) : s(seed) {}
  u64 next() { return mix64(s += 0x9e3779b97f4a7c15ULL); }
  u64 below(u64 n) { return (u64)(((unsigned __int128)next() * n) >> 64); }
};
template <class T>
static void shuffle_vec(std::vector<T>& a, SplitMix64& r) {
  for (size_t i = a.size(); i > 1; --i) std::swap(a[i - 1], a[r.below(i)]);
}
static inline double now_ns() {
  return (double)std::chrono::duration_cast<std::chrono::nanoseconds>(
             std::chrono::steady_clock::now().time_since_epoch()).count();
}
static inline double median(std::vector<double> v) {
  std::sort(v.begin(), v.end());
  size_t m = v.size();
  return m == 0 ? 0 : (m % 2 ? v[m / 2] : 0.5 * (v[m / 2 - 1] + v[m / 2]));
}

// Виды входа. N элементов, U различных ключей (каждый >= 1 раза).
//  random   — случайные 64-битные, случайный порядок
//  dense    — ключи 1..U, случайный порядок
//  sorted   — random, отсортированный
//  reverse  — random, по убыванию
//  equal    — все равны (U = 1)
//  runs     — сериями одинаковых (ключи в случайном порядке, копии подряд)
//  almost   — sorted, затем S случайных обменов (S = N/100 → «1%»)
//  almost01 — sorted, затем N/1000 обменов
//  e8       — первые N - N/16 отсортированы и уникальны, хвост N/16 случайный (как E8: 2^20 + 2^16)
static Vec make_input(const std::string& kind, size_t N, size_t U, u64 seed) {
  SplitMix64 r(mix64(seed * 0x100000001b3ULL ^ (N << 1) ^ (U << 33)));
  if (kind == "e8") {
    size_t nl = N - N / 16;
    Vec v(nl);
    for (auto& x : v) x = r.next();
    std::sort(v.begin(), v.end());
    v.erase(std::unique(v.begin(), v.end()), v.end());
    while (v.size() < N) v.push_back(r.next());
    return v;
  }
  if (kind == "equal") U = 1;
  Vec keys(U);
  for (size_t i = 0; i < U; ++i) keys[i] = (kind == "dense") ? (u64)(i + 1) : r.next();
  if (kind == "dense") shuffle_vec(keys, r);
  std::vector<uint32_t> cnt(U, 1);
  for (size_t i = U; i < N; ++i) cnt[r.below(U)]++;
  Vec v;
  v.reserve(N);
  for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
  if (kind == "runs") return v;
  if (kind == "sorted" || kind == "almost" || kind == "almost01") {
    std::sort(v.begin(), v.end());
    size_t swaps = kind == "almost" ? N / 100 : kind == "almost01" ? N / 1000 : 0;
    for (size_t s = 0; s < swaps; ++s) std::swap(v[r.below(N)], v[r.below(N)]);
    return v;
  }
  if (kind == "reverse") { std::sort(v.begin(), v.end(), std::greater<u64>()); return v; }
  shuffle_vec(v, r);  // random, dense, equal
  return v;
}
