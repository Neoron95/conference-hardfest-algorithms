// isa_bench.cpp — харнесс для подсчёта инструкций (callgrind) и времени по фазам
// четырёх алгоритмов дедупликации (см. ../../dedup_bench.cpp — генератор тот же).
//
// Каждая фаза — отдельная extern "C" noinline-функция phase_*: под callgrind
// запускается с --toggle-collect='phase_*', и Ir считается включительно
// (вместе с malloc/free/operator new).
//
// Режимы:
//   isa_bench --alg sort|uset|flat|radix|merge --n N --u U [--reserve R] [--calls K]
//   Печатает CSV: alg,phase,N,U,ns_el (медиана по K вызовам; при K=1 — один вызов).
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <string>
#include <unordered_set>
#include <vector>

#include "absl/container/flat_hash_set.h"
#include <valgrind/callgrind.h>

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
static void shuffle(std::vector<T>& a, SplitMix64& r) {
  for (size_t i = a.size(); i > 1; --i) std::swap(a[i - 1], a[r.below(i)]);
}

// Как в dedup_bench: U различных случайных 64-битных ключей, всего N, перемешано.
static Vec make_input(size_t N, size_t U, size_t idx) {
  SplitMix64 r(mix64(17 * 0x100000001b3ULL ^ mix64(idx + 1) ^ (N << 1) ^ (U << 33)));
  Vec keys(U);
  for (auto& k : keys) k = r.next();
  std::vector<uint32_t> cnt(U, 1);
  for (size_t i = U; i < N; ++i) cnt[r.below(U)]++;
  Vec v;
  v.reserve(N);
  for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
  shuffle(v, r);
  return v;
}
// E8: nlocal отсортированных уникальных + дельта nd (половина — повторы).
static Vec make_e8(size_t N, size_t nlocal, size_t idx) {
  SplitMix64 r(mix64(17 * 0x100000001b3ULL ^ mix64(idx + 1) ^ (N << 1)));
  const size_t nl = nlocal, nd = N - nl, ud = nd ? std::max<size_t>(1, nd / 2) : 0;
  Vec L(nl);
  for (auto& x : L) x = r.next();
  std::sort(L.begin(), L.end());
  L.erase(std::unique(L.begin(), L.end()), L.end());
  Vec dk;
  dk.reserve(ud);
  const size_t from_local = ud / 2;
  const size_t start = r.below(L.size()), step = r.next() | 1;
  for (size_t k = 0; k < from_local; ++k) dk.push_back(L[(start + k * step) % L.size()]);
  while (dk.size() < ud) dk.push_back(r.next());
  Vec D(dk);
  while (D.size() < nd) D.push_back(dk[r.below(ud)]);
  shuffle(D, r);
  Vec v(L);
  v.insert(v.end(), D.begin(), D.end());
  return v;
}

#define NOINLINE __attribute__((noinline))
using USet = std::unordered_set<u64>;
using FSet = absl::flat_hash_set<u64>;

extern "C" {
NOINLINE void phase_sort(Vec* v) { std::sort(v->begin(), v->end()); }
NOINLINE void phase_unique(Vec* v) { v->erase(std::unique(v->begin(), v->end()), v->end()); }

NOINLINE USet* phase_uset_insert(const Vec* v, size_t reserve_n) {
  USet* s = new USet;
  s->reserve(reserve_n);
  for (u64 x : *v) s->insert(x);
  return s;
}
NOINLINE void phase_uset_assign(Vec* v, USet* s) { v->assign(s->begin(), s->end()); }
NOINLINE void phase_uset_dtor(USet* s) { delete s; }

NOINLINE FSet* phase_flat_insert(const Vec* v, size_t reserve_n) {
  FSet* s = new FSet;
  s->reserve(reserve_n);
  for (u64 x : *v) s->insert(x);
  return s;
}
NOINLINE void phase_flat_assign(Vec* v, FSet* s) { v->assign(s->begin(), s->end()); }
NOINLINE void phase_flat_dtor(FSet* s) { delete s; }

// radix: счёт (один проход, 8 гистограмм) и рассеивание (до 8 проходов)
NOINLINE void phase_radix_count(const Vec* v, uint32_t (*cnt)[256]) {
  for (int b = 0; b < 8; ++b) std::memset(cnt[b], 0, 256 * sizeof(uint32_t));
  for (u64 x : *v)
    for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
}
NOINLINE void phase_radix_scatter(Vec* v, u64* buf, uint32_t (*cnt)[256]) {
  const size_t n = v->size();
  u64* src = v->data();
  u64* dst = buf;
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;
    size_t off[256];
    size_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v->data()) std::memcpy(v->data(), src, n * sizeof(u64));
}

// слияние (E8): sort(дельта) + unique + inplace_merge + unique
NOINLINE void phase_merge_sortdelta(Vec* v, size_t nlocal) {
  auto mid = v->begin() + nlocal;
  std::sort(mid, v->end());
  v->erase(std::unique(mid, v->end()), v->end());
}
NOINLINE void phase_merge_inplace(Vec* v, size_t nlocal) {
  std::inplace_merge(v->begin(), v->begin() + nlocal, v->end());
  v->erase(std::unique(v->begin(), v->end()), v->end());
}
}  // extern "C"

static double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

struct Timings { std::vector<std::vector<double>> t; };

static Vec reference(const Vec& in) {
  Vec r(in);
  std::sort(r.begin(), r.end());
  r.erase(std::unique(r.begin(), r.end()), r.end());
  return r;
}

int main(int argc, char** argv) {
  std::string alg = "sort";
  size_t N = 1u << 20, U = 1u << 20, reserve_n = 0, calls = 1, nlocal = 0;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    auto val = [&]() -> std::string { return argv[++i]; };
    if (a == "--alg") alg = val();
    else if (a == "--n") N = std::stoull(val());
    else if (a == "--u") U = std::stoull(val());
    else if (a == "--reserve") reserve_n = std::stoull(val());
    else if (a == "--calls") calls = std::stoull(val());
    else if (a == "--nlocal") nlocal = std::stoull(val());
    else { fprintf(stderr, "bad arg %s\n", a.c_str()); return 2; }
  }
  if (reserve_n == 0) reserve_n = N;
  const size_t P = std::min<size_t>(calls, 4);  // разных входов
  std::vector<Vec> pool(P), refs(P);
  for (size_t i = 0; i < P; ++i) {
    pool[i] = (alg == "merge") ? make_e8(N, nlocal, i) : make_input(N, U, i);
    refs[i] = reference(pool[i]);
  }
  const char* phases[4] = {nullptr, nullptr, nullptr, nullptr};
  int np = 0;
  if (alg == "sort") { phases[0] = "sort"; phases[1] = "unique"; np = 2; }
  else if (alg == "uset" || alg == "flat") { phases[0] = "insert"; phases[1] = "assign"; phases[2] = "dtor"; np = 3; }
  else if (alg == "radix") { phases[0] = "count"; phases[1] = "scatter"; phases[2] = "unique"; np = 3; }
  else if (alg == "merge") { phases[0] = "sortdelta"; phases[1] = "inplace_merge"; np = 2; }
  else { fprintf(stderr, "unknown alg\n"); return 2; }
  std::vector<std::vector<double>> t(np);
  Vec w;
  w.reserve(N);
  std::unique_ptr<u64[]> buf(new u64[N]);
  uint32_t cnt[8][256];
  for (size_t c = 0; c < calls; ++c) {
    const Vec& in = pool[c % P];
    w.assign(in.begin(), in.end());
    double ts[5];
    // под callgrind (--collect-atstart=no): считаем все вызовы, кроме первого (прогрев кучи)
    if (c == 1 || calls == 1) CALLGRIND_TOGGLE_COLLECT;
    if (alg == "sort") {
      ts[0] = now_ns(); phase_sort(&w); ts[1] = now_ns(); phase_unique(&w); ts[2] = now_ns();
    } else if (alg == "uset") {
      ts[0] = now_ns(); USet* s = phase_uset_insert(&w, reserve_n); ts[1] = now_ns();
      phase_uset_assign(&w, s); ts[2] = now_ns(); phase_uset_dtor(s); ts[3] = now_ns();
    } else if (alg == "flat") {
      ts[0] = now_ns(); FSet* s = phase_flat_insert(&w, reserve_n); ts[1] = now_ns();
      phase_flat_assign(&w, s); ts[2] = now_ns(); phase_flat_dtor(s); ts[3] = now_ns();
    } else if (alg == "radix") {
      ts[0] = now_ns(); phase_radix_count(&w, cnt); ts[1] = now_ns();
      phase_radix_scatter(&w, buf.get(), cnt); ts[2] = now_ns(); phase_unique(&w); ts[3] = now_ns();
    } else {
      ts[0] = now_ns(); phase_merge_sortdelta(&w, nlocal); ts[1] = now_ns();
      phase_merge_inplace(&w, nlocal); ts[2] = now_ns();
    }
    if (c + 1 == calls) CALLGRIND_TOGGLE_COLLECT;
    for (int p = 0; p < np; ++p) t[p].push_back((ts[p + 1] - ts[p]) / (double)N);
    // проверка
    Vec out = w;
    std::sort(out.begin(), out.end());
    if (out != refs[c % P]) { fprintf(stderr, "WRONG RESULT %s\n", alg.c_str()); return 3; }
  }
  for (int p = 0; p < np; ++p) {
    std::vector<double> s = t[p];
    if (s.size() > 1) s.erase(s.begin());  // первый вызов — прогрев
    std::sort(s.begin(), s.end());
    printf("%s,%s,%zu,%zu,%.2f\n", alg.c_str(), phases[p], N, U, s[s.size() / 2]);
  }
  return 0;
}
