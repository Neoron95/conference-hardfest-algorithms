// branch_bench.cpp — ветвления по данным и предсказатель: sort / uset / flat / radix.
//
// Два режима:
//   --mode time  (по умолчанию): нс/эл, как в E5 dedup_bench: P разных входов (--pool),
//                K буферов, подготовленных до таймера (--batch), вход восстанавливается
//                вне таймера; медиана по блокам.
//   --mode cg    : для valgrind --tool=callgrind --collect-atstart=no --branch-sim=yes:
//                C вызовов (--calls) по кругу по P разным входам, счётчики собираются
//                ТОЛЬКО внутри вызова алгоритма (CALLGRIND_TOGGLE_COLLECT), восстановление
//                входа и проверка результата — вне сбора.
//
// Алгоритмы: sort (std::sort, компаратор по умолчанию — в libc++ тело живёт в libc++.so),
//            sortless (std::sort с std::less<u64>() — в libc++ инстанцируется из заголовков,
//            нужен для построчной атрибуции с -g), sortonly (без unique), unique (только
//            std::unique: смысл имеет на --order sorted), uset, flat, radix — те же тела,
//            что в ../../dedup_bench.cpp.
//
// Сборка: ./build.sh. Запуск: ./run_time.sh, ./run_cg.sh.
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <functional>
#include <memory>
#include <string>
#include <unordered_set>
#include <vector>

#ifndef NO_FLAT
#include "absl/container/flat_hash_set.h"
#endif
#include <valgrind/callgrind.h>

using u64 = uint64_t;
using Vec = std::vector<u64>;

// ---------------------------------------------------------------- генератор
struct Rng {  // splitmix64
  u64 s;
  explicit Rng(u64 seed) : s(seed) {}
  u64 next() {
    u64 z = (s += 0x9e3779b97f4a7c15ULL);
    z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
    z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
    return z ^ (z >> 31);
  }
  size_t below(size_t n) { return (size_t)(((unsigned __int128)next() * n) >> 64); }
};

template <class T>
static void shuffle(std::vector<T>& v, Rng& r) {
  for (size_t i = v.size(); i > 1; --i) std::swap(v[i - 1], v[r.below(i)]);
}

enum class Order { Random, Sorted, Runs };

struct Config {
  std::string mode = "time";
  std::vector<std::string> algs = {"sort", "uset", "radix", "flat"};
  size_t N = 1024, U = 512;
  Order order = Order::Random;
  size_t pool = 64;    // P разных входов
  size_t batch = 0;    // K буферов до таймера; 0 = clamp(65536/N, 1, 64)
  size_t calls = 16;   // режим cg: число вызовов
  size_t work = 1 << 20;  // режим time: элементов на блок
  int blocks = 7, warmup = 1;
  u64 seed = 17;
  std::string variant = "-", session = "-";
};

static Vec make_input(const Config& c, size_t idx) {
  Rng r(c.seed * 0x9e3779b97f4a7c15ULL + idx * 7919 + 1);
  const size_t U = c.U, N = c.N;
  Vec keys(U);
  for (size_t i = 0; i < U; ++i) keys[i] = r.next();  // 64-битные случайные; splitmix — биекция по состоянию
  std::vector<uint32_t> cnt(U, 1);
  for (size_t i = U; i < N; ++i) cnt[r.below(U)]++;
  Vec v;
  v.reserve(N);
  for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
  if (c.order == Order::Random) shuffle(v, r);
  else if (c.order == Order::Sorted) std::sort(v.begin(), v.end());
  // Runs: серии одинаковых, ключи в случайном порядке (как сгенерировано)
  return v;
}

// ---------------------------------------------------------------- алгоритмы
static void alg_sort(Vec& v) {
  std::sort(v.begin(), v.end());
  v.erase(std::unique(v.begin(), v.end()), v.end());
}
static void alg_sortless(Vec& v) {
  std::sort(v.begin(), v.end(), std::less<u64>());
  v.erase(std::unique(v.begin(), v.end()), v.end());
}
static void alg_sortonly(Vec& v) { std::sort(v.begin(), v.end()); }
static void alg_unique(Vec& v) { v.erase(std::unique(v.begin(), v.end()), v.end()); }

static void alg_uset(Vec& v) {
  std::unordered_set<u64> s;
  s.reserve(v.size());
  for (u64 x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}
#ifndef NO_FLAT
static void alg_flat(Vec& v) {
  absl::flat_hash_set<u64> s;
  s.reserve(v.size());
  for (u64 x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}
#endif
static void alg_radix(Vec& v) {
  const size_t n = v.size();
  if (n < 2) return;
  std::unique_ptr<u64[]> buf(new u64[n]);
  uint32_t cnt[8][256] = {};
  for (u64 x : v)
    for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
  u64* src = v.data();
  u64* dst = buf.get();
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;
    size_t off[256];
    size_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v.data()) std::memcpy(v.data(), src, n * sizeof(u64));
  v.erase(std::unique(v.begin(), v.end()), v.end());
}

struct Alg { const char* name; void (*fn)(Vec&); bool sorted_out; bool needs_sorted_in; };
static const Alg kAlgs[] = {
    {"sort", alg_sort, true, false},     {"sortless", alg_sortless, true, false},
    {"sortonly", alg_sortonly, true, false}, {"unique", alg_unique, true, true},
    {"uset", alg_uset, false, false},    {"radix", alg_radix, true, false},
#ifndef NO_FLAT
    {"flat", alg_flat, false, false},
#endif
};
static const Alg* find_alg(const std::string& n) {
  for (const Alg& a : kAlgs) if (n == a.name) return &a;
  return nullptr;
}

static Vec reference(const Vec& in) {
  Vec r(in);
  std::sort(r.begin(), r.end());
  r.erase(std::unique(r.begin(), r.end()), r.end());
  return r;
}
static bool check(const Alg& a, Vec out, const Vec& ref) {
  if (a.name == std::string("sortonly")) { out.erase(std::unique(out.begin(), out.end()), out.end()); }
  if (!a.sorted_out) std::sort(out.begin(), out.end());
  return out == ref;
}

static double now_ns() {
  return (double)std::chrono::duration_cast<std::chrono::nanoseconds>(
             std::chrono::steady_clock::now().time_since_epoch()).count();
}

static std::string toolchain() {
#if defined(_LIBCPP_VERSION)
  return "clang" + std::to_string(__clang_major__) + "-libc++";
#elif defined(__clang__)
  return "clang" + std::to_string(__clang_major__) + "-libstdc++";
#else
  return "gcc" + std::to_string(__GNUC__) + "-libstdc++";
#endif
}
static const char* order_name(Order o) { return o == Order::Random ? "random" : o == Order::Sorted ? "sorted" : "runs"; }

static int selftest() {
  int bad = 0;
  for (size_t N : {0, 1, 2, 3, 5, 16, 17, 24, 25, 100, 1000, 70000})
    for (size_t U : {1, 2, 7, 1000}) {
      if (U > N && N) continue;
      for (Order o : {Order::Random, Order::Sorted, Order::Runs}) {
        Config c; c.N = N; c.U = N ? std::min(U, N) : 0; c.order = o;
        Vec in = N ? make_input(c, 3) : Vec{};
        Vec ref = reference(in);
        for (const Alg& a : kAlgs) {
          if (a.needs_sorted_in && o != Order::Sorted) continue;
          Vec w(in);
          a.fn(w);
          if (!check(a, w, ref)) { fprintf(stderr, "SELFTEST FAIL %s N=%zu U=%zu %s\n", a.name, N, c.U, order_name(o)); ++bad; }
        }
      }
    }
  { Vec e = {0, UINT64_MAX, UINT64_MAX, 0, 5}; Vec ref = reference(e);
    for (const Alg& a : kAlgs) { if (a.needs_sorted_in) continue; Vec w(e); a.fn(w); if (!check(a, w, ref)) { fprintf(stderr, "SELFTEST FAIL edge %s\n", a.name); ++bad; } } }
  fprintf(stderr, "selftest %s: %s\n", toolchain().c_str(), bad ? "FAIL" : "ok");
  return bad ? 2 : 0;
}

int main(int argc, char** argv) {
  Config c;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    auto val = [&]() -> std::string { if (i + 1 >= argc) { fprintf(stderr, "missing value for %s\n", a.c_str()); exit(2); } return argv[++i]; };
    if (a == "--selftest") return selftest();
    else if (a == "--info") { printf("%s\n", toolchain().c_str()); return 0; }
    else if (a == "--header") { printf("mode,session,toolchain,variant,alg,order,N,U,pool,batch,calls,elements,ns_per_el_med,min,max,blocks\n"); return 0; }
    else if (a == "--mode") c.mode = val();
    else if (a == "--algs") { c.algs.clear(); std::string s = val(); size_t p; while ((p = s.find(',')) != std::string::npos) { c.algs.push_back(s.substr(0, p)); s.erase(0, p + 1); } c.algs.push_back(s); }
    else if (a == "--n") c.N = std::stoull(val());
    else if (a == "--u") c.U = std::stoull(val());
    else if (a == "--order") { std::string s = val(); c.order = s == "sorted" ? Order::Sorted : s == "runs" ? Order::Runs : Order::Random; }
    else if (a == "--pool") c.pool = std::stoull(val());
    else if (a == "--batch") c.batch = std::stoull(val());
    else if (a == "--calls") c.calls = std::stoull(val());
    else if (a == "--work") c.work = std::stoull(val());
    else if (a == "--blocks") c.blocks = std::stoi(val());
    else if (a == "--warmup") c.warmup = std::stoi(val());
    else if (a == "--seed") c.seed = std::stoull(val());
    else if (a == "--variant") c.variant = val();
    else if (a == "--session") c.session = val();
    else { fprintf(stderr, "unknown arg %s\n", a.c_str()); return 2; }
  }
  if (c.U > c.N) c.U = c.N;
  std::vector<const Alg*> algs;
  for (auto& n : c.algs) { const Alg* a = find_alg(n); if (!a) { fprintf(stderr, "unknown alg %s\n", n.c_str()); return 2; } algs.push_back(a); }

  const size_t P = c.pool;
  std::vector<Vec> pool(P), refs(P);
  for (size_t i = 0; i < P; ++i) { pool[i] = make_input(c, i); refs[i] = reference(pool[i]); }
  const std::string tc = toolchain();

  if (c.mode == "cg") {
    // Один алгоритм на процесс: счётчики callgrind относятся ко всему процессу.
    if (algs.size() != 1) { fprintf(stderr, "--mode cg: ровно один алгоритм (--algs)\n"); return 2; }
    const Alg& a = *algs[0];
    Vec work; work.reserve(c.N);
    for (size_t k = 0; k < c.calls; ++k) {
      const size_t id = k % P;
      work.assign(pool[id].begin(), pool[id].end());
      CALLGRIND_TOGGLE_COLLECT;
      a.fn(work);
      CALLGRIND_TOGGLE_COLLECT;
      if (!check(a, work, refs[id])) { fprintf(stderr, "WRONG RESULT %s\n", a.name); return 2; }
    }
    printf("cg,%s,%s,%s,%s,%s,%zu,%zu,%zu,0,%zu,%zu,,,,\n", c.session.c_str(), tc.c_str(), c.variant.c_str(), a.name,
           order_name(c.order), c.N, c.U, P, c.calls, c.calls * c.N);
    return 0;
  }

  // ---- режим time (как E5 в dedup_bench)
  size_t K = c.batch;
  if (K == 0) K = std::clamp<size_t>((size_t)65536 / std::max<size_t>(c.N, 1), 1, 64);
  const size_t reps = std::max<size_t>(1, (c.work + K * c.N - 1) / (K * c.N));
  std::vector<Vec> work(K);
  for (auto& w : work) w.reserve(c.N);
  const size_t A = algs.size();
  std::vector<std::vector<double>> per_block(A);
  std::vector<size_t> ids(K);
  size_t cursor = 0;
  for (int blk = 0; blk < c.warmup + c.blocks; ++blk) {
    std::vector<double> ns(A, 0.0), el(A, 0.0);
    for (size_t rep = 0; rep < reps; ++rep) {
      for (size_t k = 0; k < K; ++k) ids[k] = (cursor + k) % P;
      cursor += K;
      for (size_t j = 0; j < A; ++j) {
        const size_t ai = (rep + (size_t)blk + j) % A;
        for (size_t k = 0; k < K; ++k) work[k].assign(pool[ids[k]].begin(), pool[ids[k]].end());
        const double t0 = now_ns();
        for (size_t k = 0; k < K; ++k) algs[ai]->fn(work[k]);
        const double t1 = now_ns();
        ns[ai] += t1 - t0;
        for (size_t k = 0; k < K; ++k) {
          el[ai] += (double)pool[ids[k]].size();
          if (!check(*algs[ai], work[k], refs[ids[k]])) { fprintf(stderr, "WRONG RESULT %s\n", algs[ai]->name); return 2; }
        }
      }
    }
    if (blk >= c.warmup) for (size_t ai = 0; ai < A; ++ai) per_block[ai].push_back(ns[ai] / el[ai]);
  }
  for (size_t ai = 0; ai < A; ++ai) {
    std::vector<double> s = per_block[ai];
    std::sort(s.begin(), s.end());
    const size_t m = s.size();
    const double med = (m % 2) ? s[m / 2] : 0.5 * (s[m / 2 - 1] + s[m / 2]);
    printf("time,%s,%s,%s,%s,%s,%zu,%zu,%zu,%zu,%zu,%zu,%.3f,%.3f,%.3f,%d\n", c.session.c_str(), tc.c_str(), c.variant.c_str(),
           algs[ai]->name, order_name(c.order), c.N, c.U, P, K, reps * K, reps * K * c.N, med, s.front(), s.back(), c.blocks);
    fflush(stdout);
  }
  return 0;
}
