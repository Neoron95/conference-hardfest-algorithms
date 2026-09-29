// dedup_bench.cpp — воспроизведение x86-серий доклада
// «O(n) проиграл O(n log n)» (HardFest 2026).
//
// Задача: вектор uint64_t с повторами -> уникальные значения в том же векторе,
// порядок любой. Вход можно портить.
//
// Методология (слайд contract):
//   * в таймере — вся операция: reserve, вставки, выгрузка в вектор, деструктор;
//   * свежая копия входа — вне таймера;
//   * после каждого вызова результат сортируется (вне таймера) и сравнивается
//     с эталоном sort+unique; ошибка -> exit(2);
//   * пул из P разных входов (по умолчанию 64), алгоритмы чередуются,
//     W прогревочных блоков отбрасываются, по блокам — медиана, min, max;
//   * нс/эл = время / N.
//
// Вывод: CSV в stdout, по строке на алгоритм (см. print_header()).

#include <algorithm>
#include <chrono>
#include <cinttypes>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <iterator>
#include <memory>
#include <string>
#include <unordered_set>
#include <vector>

#include "absl/container/flat_hash_set.h"

using u64 = uint64_t;
using Vec = std::vector<u64>;

// ---------------------------------------------------------------- генератор

static inline u64 mix64(u64 z) {  // финализатор splitmix64: биекция на u64
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

enum class Keys { Random, Dense, E8 };
enum class Order { Random, Runs, Sorted };

struct Config {
  std::string exp = "adhoc", session = "s0", variant = "-";
  size_t N = 1u << 20, U = 1u << 20;
  Keys keys = Keys::Random;
  Order order = Order::Random;
  std::vector<std::string> algs = {"sort", "uset", "radix", "flat"};
  int blocks = 7, warmup = 1;
  size_t work = 1u << 21;  // элементов на алгоритм за блок (минимум один вызов)
  size_t pool = 64;        // число разных входов
  size_t batch = 0;        // буферов, готовых до таймера; 0 = авто
  size_t nlocal = 1u << 20;  // E8: размер отсортированной локальной части
  u64 seed = 17;
};

// Один вход пула: U различных ключей, каждый >= 1 раза, всего N.
// Ключи Random — первые U выходов потока splitmix64 (различны по построению:
// mix64 — биекция), Dense — 1..U (как rowid SQLite).
static Vec make_input(const Config& c, size_t idx) {
  SplitMix64 r(mix64(c.seed * 0x100000001b3ULL ^ mix64(idx + 1) ^ (c.N << 1) ^ (c.U << 33)));
  if (c.keys == Keys::E8) {
    // Локальные: nlocal отсортированных уникальных. Дельта: N - nlocal элементов,
    // половина — повторы (U_d = n_d / 2); половина уникальных id дельты уже есть
    // в локальных (обновления), половина — новые.
    const size_t nl = c.nlocal, nd = c.N - nl, ud = nd ? std::max<size_t>(1, nd / 2) : 0;
    Vec L(nl);
    for (auto& x : L) x = r.next();
    std::sort(L.begin(), L.end());
    L.erase(std::unique(L.begin(), L.end()), L.end());  // на практике no-op
    Vec dk;
    dk.reserve(ud);
    const size_t from_local = ud / 2;
    const size_t start = r.below(L.size()), step = r.next() | 1;  // nl = 2^k -> шаги различны
    for (size_t k = 0; k < from_local; ++k) dk.push_back(L[(start + k * step) % L.size()]);
    while (dk.size() < ud) dk.push_back(r.next());
    Vec D(dk);
    while (D.size() < nd) D.push_back(dk[r.below(ud)]);
    shuffle(D, r);
    Vec v(L);
    v.insert(v.end(), D.begin(), D.end());
    return v;
  }
  const size_t U = c.U, N = c.N;
  Vec keys(U);
  for (size_t i = 0; i < U; ++i) keys[i] = (c.keys == Keys::Dense) ? (u64)(i + 1) : r.next();
  if (c.keys == Keys::Dense) shuffle(keys, r);
  std::vector<uint32_t> cnt(U, 1);
  for (size_t i = U; i < N; ++i) cnt[r.below(U)]++;
  Vec v;
  v.reserve(N);
  if (c.order == Order::Runs) {  // серии одинаковых: ключи в случайном порядке, копии подряд
    for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
    // порядок ключей уже случайный (случайные ключи / перемешанные dense)
  } else {
    for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
    if (c.order == Order::Random) shuffle(v, r);
    else std::sort(v.begin(), v.end());
  }
  return v;
}

// ---------------------------------------------------------------- алгоритмы

struct Ctx { size_t nlocal = 0; };

static void alg_sort(Vec& v, const Ctx&) {
  std::sort(v.begin(), v.end());
  v.erase(std::unique(v.begin(), v.end()), v.end());
}

static void alg_uset(Vec& v, const Ctx&) {
  std::unordered_set<u64> s;
  s.reserve(v.size());
  for (u64 x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}  // деструктор s — внутри таймера

static void alg_flat(Vec& v, const Ctx&) {
  absl::flat_hash_set<u64> s;
  s.reserve(v.size());
  for (u64 x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}

// LSD radix: 8 проходов по байту, счётчики 8x256 за один предварительный проход,
// проход пропускается, если все ключи в одной корзине; буфер на N; потом unique.
static void alg_radix(Vec& v, const Ctx&) {
  const size_t n = v.size();
  if (n < 2) return;
  std::unique_ptr<u64[]> buf(new u64[n]);  // без инициализации
  uint32_t cnt[8][256] = {};
  for (u64 x : v)
    for (int b = 0; b < 8; ++b) cnt[b][(x >> (8 * b)) & 0xff]++;
  u64* src = v.data();
  u64* dst = buf.get();
  for (int b = 0; b < 8; ++b) {
    const int sh = 8 * b;
    if (cnt[b][(src[0] >> sh) & 0xff] == n) continue;  // все в одной корзине
    size_t off[256];
    size_t sum = 0;
    for (int i = 0; i < 256; ++i) { off[i] = sum; sum += cnt[b][i]; }
    for (size_t i = 0; i < n; ++i) { u64 x = src[i]; dst[off[(x >> sh) & 0xff]++] = x; }
    std::swap(src, dst);
  }
  if (src != v.data()) std::memcpy(v.data(), src, n * sizeof(u64));
  v.erase(std::unique(v.begin(), v.end()), v.end());
}

// E8: v = L ++ D, где L = первые nlocal элементов, уже отсортированы и уникальны
// (это часть контракта: локальные id отдала SQLite по PK).
static void alg_merge_inplace(Vec& v, const Ctx& c) {
  auto mid = v.begin() + c.nlocal;
  std::sort(mid, v.end());
  v.erase(std::unique(mid, v.end()), v.end());
  std::inplace_merge(v.begin(), v.begin() + c.nlocal, v.end());
  v.erase(std::unique(v.begin(), v.end()), v.end());
}

static void alg_merge_union(Vec& v, const Ctx& c) {
  auto mid = v.begin() + c.nlocal;
  std::sort(mid, v.end());
  v.erase(std::unique(mid, v.end()), v.end());
  Vec out;
  out.reserve(v.size());
  std::set_union(v.begin(), v.begin() + c.nlocal, v.begin() + c.nlocal, v.end(),
                 std::back_inserter(out));
  v.swap(out);
}  // старый буфер v освобождается внутри таймера

using AlgFn = void (*)(Vec&, const Ctx&);
struct Alg { const char* name; AlgFn fn; };
static const Alg kAlgs[] = {
    {"sort", alg_sort},   {"uset", alg_uset},   {"radix", alg_radix},
    {"flat", alg_flat},   {"merge_inplace", alg_merge_inplace},
    {"merge_union", alg_merge_union},
};

static const Alg* find_alg(const std::string& n) {
  for (auto& a : kAlgs) if (n == a.name) return &a;
  return nullptr;
}

// ---------------------------------------------------------------- проверка

static Vec reference(const Vec& in) {
  Vec r(in);
  std::sort(r.begin(), r.end());
  r.erase(std::unique(r.begin(), r.end()), r.end());
  return r;
}

static bool check(Vec& out, const Vec& ref) {  // сравниваем множество, а не длину
  if (!std::is_sorted(out.begin(), out.end())) std::sort(out.begin(), out.end());
  return out == ref;
}

static int selftest() {
  std::vector<Vec> cases = {
      {}, {42}, {7, 7, 7, 7, 7}, {0, UINT64_MAX, 0, UINT64_MAX, 1},
      {UINT64_MAX}, {0}, {3, 1, 2}, {5, 4, 3, 2, 1, 1, 2, 3, 4, 5},
  };
  for (size_t n : {2u, 17u, 100u, 1000u, 4097u, 70000u}) {
    for (size_t u : {(size_t)1, n / 2 ? n / 2 : 1, n}) {
      for (Keys k : {Keys::Random, Keys::Dense}) {
        for (Order o : {Order::Random, Order::Runs, Order::Sorted}) {
          Config c; c.N = n; c.U = u; c.keys = k; c.order = o;
          cases.push_back(make_input(c, 0));
        }
      }
    }
  }
  int fails = 0;
  for (auto& in : cases) {
    const Vec ref = reference(in);
    for (auto& a : kAlgs) {
      if (a.fn == alg_merge_inplace || a.fn == alg_merge_union) continue;
      Vec w(in);
      a.fn(w, Ctx{});
      if (!check(w, ref)) { ++fails; fprintf(stderr, "SELFTEST FAIL %s n=%zu\n", a.name, in.size()); }
    }
  }
  // merge-варианты: вход = отсортированные уникальные L ++ произвольная D
  for (size_t nl : {0u, 1u, 1024u, 1u << 16}) {
    for (size_t nd : {0u, 1u, 2u, 1000u, 1u << 12}) {
      Config c; c.keys = Keys::E8; c.nlocal = nl; c.N = nl + nd;
      if (nl == 0 || (nl & (nl - 1))) {  // генератор E8 рассчитан на nl = 2^k >= 1
        SplitMix64 r(nl * 31 + nd);
        Vec L(nl); for (auto& x : L) x = r.next() % 5000;
        std::sort(L.begin(), L.end()); L.erase(std::unique(L.begin(), L.end()), L.end());
        Vec v(L); for (size_t i = 0; i < nd; ++i) v.push_back(r.next() % 5000);
        c.nlocal = L.size();
        cases.clear(); cases.push_back(v);
      } else {
        cases.clear(); cases.push_back(make_input(c, 3));
      }
      const Vec ref = reference(cases[0]);
      for (AlgFn f : {alg_merge_inplace, alg_merge_union}) {
        Vec w(cases[0]); Ctx cx; cx.nlocal = c.nlocal; f(w, cx);
        if (!check(w, ref)) { ++fails; fprintf(stderr, "SELFTEST FAIL merge nl=%zu nd=%zu\n", nl, nd); }
      }
    }
  }
  fprintf(stderr, "selftest: %s (%d fails)\n", fails ? "FAIL" : "OK", fails);
  return fails ? 1 : 0;
}

// ---------------------------------------------------------------- замер

static const char* toolchain() {
#if defined(__clang__)
#  if defined(_LIBCPP_VERSION)
  return "clang" __clang_version__ "/libc++";
#  else
  return "clang" __clang_version__ "/libstdc++";
#  endif
#else
  return "gcc" __VERSION__ "/libstdc++";
#endif
}

static std::string short_toolchain() {
#if defined(__clang__)
  std::string s = "clang" + std::to_string(__clang_major__);
#else
  std::string s = "gcc" + std::to_string(__GNUC__);
#endif
#if defined(_LIBCPP_VERSION)
  return s + "-libc++";
#else
  return s + "-libstdc++";
#endif
}

static void print_header() {
  printf("exp,session,toolchain,variant,alg,keys,order,N,U,pool,batch,calls_per_block,"
         "blocks,median_ns_el,min_ns_el,max_ns_el,spread_pct,blocks_ns_el\n");
}

static const char* keys_name(Keys k) { return k == Keys::Random ? "random64" : k == Keys::Dense ? "dense" : "e8"; }
static const char* order_name(Order o) { return o == Order::Random ? "random" : o == Order::Runs ? "runs" : "sorted"; }

static double now_ns() {
  return (double)std::chrono::duration_cast<std::chrono::nanoseconds>(
             std::chrono::steady_clock::now().time_since_epoch()).count();
}

static int run(const Config& c) {
  std::vector<const Alg*> algs;
  for (auto& n : c.algs) {
    const Alg* a = find_alg(n);
    if (!a) { fprintf(stderr, "unknown alg %s\n", n.c_str()); return 2; }
    algs.push_back(a);
  }
  const size_t N = c.N;
  size_t B = c.batch;
  if (B == 0) B = std::clamp<size_t>((size_t)65536 / std::max<size_t>(N, 1), 1, 64);
  const size_t reps = std::max<size_t>(1, (c.work + B * N - 1) / (B * N));
  const size_t P = c.pool;

  std::vector<Vec> pool(P), refs(P);  // генерация лениво, вне таймера
  auto get = [&](size_t i) -> const Vec& {
    if (pool[i].empty()) { pool[i] = make_input(c, i); refs[i] = reference(pool[i]); }
    return pool[i];
  };
  std::vector<Vec> work(B);
  for (auto& w : work) w.reserve(N);
  Ctx ctx; ctx.nlocal = (c.keys == Keys::E8) ? c.nlocal : 0;

  const size_t A = algs.size();
  std::vector<std::vector<double>> per_block(A);
  size_t cursor = 0;
  std::vector<size_t> ids(B);
  for (int blk = 0; blk < c.warmup + c.blocks; ++blk) {
    std::vector<double> ns(A, 0.0), el(A, 0.0);
    for (size_t rep = 0; rep < reps; ++rep) {
      for (size_t k = 0; k < B; ++k) ids[k] = (cursor + k) % P;
      cursor += B;
      for (size_t j = 0; j < A; ++j) {
        const size_t a = (rep + (size_t)blk + j) % A;  // чередование порядка
        for (size_t k = 0; k < B; ++k) { const Vec& in = get(ids[k]); work[k].assign(in.begin(), in.end()); }
        const double t0 = now_ns();
        for (size_t k = 0; k < B; ++k) algs[a]->fn(work[k], ctx);
        const double t1 = now_ns();
        ns[a] += t1 - t0;
        for (size_t k = 0; k < B; ++k) {
          el[a] += (double)pool[ids[k]].size();
          if (!check(work[k], refs[ids[k]])) {
            fprintf(stderr, "WRONG RESULT: alg=%s N=%zu U=%zu input=%zu\n", algs[a]->name, N, c.U, ids[k]);
            exit(2);
          }
        }
      }
    }
    if (blk >= c.warmup)
      for (size_t a = 0; a < A; ++a) per_block[a].push_back(ns[a] / el[a]);
  }
  for (size_t a = 0; a < A; ++a) {
    std::vector<double> s = per_block[a];
    std::sort(s.begin(), s.end());
    const size_t m = s.size();
    const double med = (m % 2) ? s[m / 2] : 0.5 * (s[m / 2 - 1] + s[m / 2]);
    std::string list;
    for (double x : per_block[a]) { char b[32]; snprintf(b, sizeof b, "%s%.3f", list.empty() ? "" : ";", x); list += b; }
    printf("%s,%s,%s,%s,%s,%s,%s,%zu,%zu,%zu,%zu,%zu,%d,%.3f,%.3f,%.3f,%.1f,%s\n",
           c.exp.c_str(), c.session.c_str(), short_toolchain().c_str(), c.variant.c_str(),
           algs[a]->name, keys_name(c.keys), order_name(c.order), N,
           c.keys == Keys::E8 ? (size_t)refs[0].size() : c.U, P, B, reps * B, c.blocks, med, s.front(),
           s.back(), 100.0 * (s.back() - s.front()) / med, list.c_str());
    fflush(stdout);
  }
  return 0;
}

// ---------------------------------------------------------------- CLI

static std::vector<std::string> split(const std::string& s) {
  std::vector<std::string> r;
  size_t p = 0;
  while (p <= s.size()) {
    size_t q = s.find(',', p);
    if (q == std::string::npos) q = s.size();
    if (q > p) r.push_back(s.substr(p, q - p));
    p = q + 1;
  }
  return r;
}

static void usage() {
  fprintf(stderr,
          "usage: dedup_bench [--header] [--selftest] [--info]\n"
          "  --exp NAME --session S --variant V   метки в CSV\n"
          "  --n N --u U | --ufrac F              размер и число уникальных (U=max(1,round(F*N)))\n"
          "  --keys random|dense|e8 --order random|runs|sorted --nlocal L (e8)\n"
          "  --algs sort,uset,radix,flat,merge_inplace,merge_union\n"
          "  --blocks B --warmup W --work ELEMS --pool P --batch K --seed S\n");
}

int main(int argc, char** argv) {
  Config c;
  bool ufrac = false;
  double frac = 1.0;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    auto val = [&]() -> std::string {
      if (i + 1 >= argc) { usage(); exit(2); }
      return argv[++i];
    };
    if (a == "--header") { print_header(); return 0; }
    else if (a == "--selftest") return selftest();
    else if (a == "--info") { printf("%s\n", toolchain()); return 0; }
    else if (a == "--exp") c.exp = val();
    else if (a == "--session") c.session = val();
    else if (a == "--variant") c.variant = val();
    else if (a == "--n") c.N = std::stoull(val());
    else if (a == "--u") c.U = std::stoull(val());
    else if (a == "--ufrac") { ufrac = true; frac = std::stod(val()); }
    else if (a == "--keys") { auto v = val(); c.keys = v == "dense" ? Keys::Dense : v == "e8" ? Keys::E8 : Keys::Random; }
    else if (a == "--order") { auto v = val(); c.order = v == "runs" ? Order::Runs : v == "sorted" ? Order::Sorted : Order::Random; }
    else if (a == "--nlocal") c.nlocal = std::stoull(val());
    else if (a == "--algs") c.algs = split(val());
    else if (a == "--blocks") c.blocks = std::stoi(val());
    else if (a == "--warmup") c.warmup = std::stoi(val());
    else if (a == "--work") c.work = std::stoull(val());
    else if (a == "--pool") c.pool = std::stoull(val());
    else if (a == "--batch") c.batch = std::stoull(val());
    else if (a == "--seed") c.seed = std::stoull(val());
    else { usage(); return 2; }
  }
  if (ufrac) c.U = std::max<size_t>(1, (size_t)(frac * (double)c.N + 0.5));
  if (c.keys != Keys::E8 && (c.U < 1 || c.U > c.N)) { fprintf(stderr, "need 1 <= U <= N\n"); return 2; }
  if (c.keys == Keys::E8 && c.nlocal >= c.N) { fprintf(stderr, "need nlocal < N\n"); return 2; }
  return run(c);
}
