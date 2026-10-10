// lookup_bench.cpp — «промах предсказания + промах кэша»: поиск в готовой таблице.
// Таблица из U ключей построена заранее (вне таймера). Поток из Q запросов, доля p из них
// есть в таблице (hit), остальные — нет (miss), порядок случайный. При p = 0 и p = 1 ветвление
// «нашёл / не нашёл» внутри find предсказуемо, при p = 0,5 — нет. Объём работы с памятью
// при hit и miss одинаков с точностью до длины цепочки. Разница времени между p = 0,5 и
// средним от p = 0 и p = 1 — цена промахов предсказания; сравниваем её при таблице в L1
// (U = 1024) и в L2/L3/RAM (U = 2^16, 2^20, 2^22): если цена растёт с размером таблицы —
// промах предсказания отменяет и спекулятивно начатые чтения следующих запросов (MLP).
//
//   lookup_bench <uset|flat|lower_bound> <U> <p> <Q> [reps=7]  → CSV-строка
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <string>
#include <unordered_set>
#include <vector>
#ifndef NO_FLAT
#include "absl/container/flat_hash_set.h"
#endif

using u64 = uint64_t;
struct Rng {
  u64 s;
  explicit Rng(u64 seed) : s(seed) {}
  u64 next() { u64 z = (s += 0x9e3779b97f4a7c15ULL); z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL; z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL; return z ^ (z >> 31); }
  size_t below(size_t n) { return (size_t)(((unsigned __int128)next() * n) >> 64); }
  double unit() { return (double)(next() >> 11) * (1.0 / 9007199254740992.0); }
};
static double now_ns() { return (double)std::chrono::duration_cast<std::chrono::nanoseconds>(std::chrono::steady_clock::now().time_since_epoch()).count(); }

template <class Set>
static u64 run_set(const Set& s, const std::vector<u64>& q) {
  u64 found = 0;
  for (u64 x : q) {
    auto it = s.find(x);
    if (it != s.end()) found += *it;  // зависит от результата поиска; ветвление внутри find — в библиотеке
  }
  return found;
}
static u64 run_lb(const std::vector<u64>& sorted, const std::vector<u64>& q) {
  u64 found = 0;
  for (u64 x : q) {
    auto it = std::lower_bound(sorted.begin(), sorted.end(), x);
    if (it != sorted.end() && *it == x) found += *it;
  }
  return found;
}

static std::string toolchain() {
#if defined(_LIBCPP_VERSION)
  return "clang" + std::to_string(__clang_major__) + "-libc++";
#else
  return "gcc" + std::to_string(__GNUC__) + "-libstdc++";
#endif
}

int main(int argc, char** argv) {
  if (argc < 5) { fprintf(stderr, "usage: lookup_bench <uset|flat|lower_bound> U p Q [reps]\n"); return 2; }
  const std::string kind = argv[1];
  const size_t U = std::stoull(argv[2]);
  const double p = std::atof(argv[3]);
  const size_t Q = std::stoull(argv[4]);
  const int reps = argc > 5 ? std::atoi(argv[5]) : 7;
  Rng r(17);
  std::vector<u64> keys(U);
  for (auto& k : keys) k = r.next();
  const size_t P = 8;  // пул разных потоков запросов
  std::vector<std::vector<u64>> qs(P);
  for (auto& q : qs) {
    q.resize(Q);
    for (auto& x : q) x = (r.unit() < p) ? keys[r.below(U)] : r.next();  // «чужой» ключ: случайный 64-битный
  }
  std::vector<double> t;
  u64 sink = 0;
  auto measure = [&](auto&& fn) {
    for (int rep = 0; rep < reps + 1; ++rep) {
      const auto& q = qs[rep % P];
      double t0 = now_ns();
      sink += fn(q);
      double t1 = now_ns();
      if (rep) t.push_back((t1 - t0) / (double)Q);
    }
  };
  if (kind == "uset") {
    std::unordered_set<u64> s; s.reserve(U); for (u64 k : keys) s.insert(k);
    measure([&](const std::vector<u64>& q) { return run_set(s, q); });
#ifndef NO_FLAT
  } else if (kind == "flat") {
    absl::flat_hash_set<u64> s; s.reserve(U); for (u64 k : keys) s.insert(k);
    measure([&](const std::vector<u64>& q) { return run_set(s, q); });
#endif
  } else if (kind == "lower_bound") {
    std::vector<u64> sorted(keys); std::sort(sorted.begin(), sorted.end());
    measure([&](const std::vector<u64>& q) { return run_lb(sorted, q); });
  } else { fprintf(stderr, "unknown kind\n"); return 2; }
  std::sort(t.begin(), t.end());
  printf("%s,%s,%zu,%.2f,%zu,%.2f,%.2f,%.2f,%llu\n", toolchain().c_str(), kind.c_str(), U, p, Q, t[t.size() / 2], t.front(), t.back(), (unsigned long long)(sink & 1));
  return 0;
}
