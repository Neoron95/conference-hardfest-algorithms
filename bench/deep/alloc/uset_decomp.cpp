// uset_decomp.cpp — декомпозиция времени std::unordered_set<uint64_t> по
// аллокаторам и фазам (вопрос qa.md C9: «пул-аллокатор или pmr?»).
//
// Варианты (--variant):
//   std    : std::allocator (malloc/free на каждый узел), как в dedup_bench;
//   leak   : malloc на каждый узел, free не вызывается (память течёт: каждый вызов —
//            свежие страницы из top кучи, page faults внутри таймера; деструктор = обход);
//   bump   : свой монотонный аллокатор на заранее выделенном и прогретом буфере,
//            узлы подряд в порядке вставки, deallocate — no-op;
//   pmr    : std::pmr::unordered_set + monotonic_buffer_resource на том же буфере
//            (upstream = null_memory_resource);
//   pool_seq : пул слотов узлов, раздаётся по порядку (контроль к bump);
//   pool_shuf: тот же пул, слоты розданы в случайном порядке — «разбросанные адреса»
//            без цены malloc;
//   node   : absl::node_hash_set (узлы через malloc, но Swiss-ячейки с метаданными);
//   flat   : absl::flat_hash_set (эталон).
// Фазы: reserve+вставки | выгрузка (--dump assign: v.assign(begin,end), два обхода;
//       --dump 1pass: один обход) | деструктор.
// Печатает call_index: 0 — первый вызов (холодная куча/буфер), дальше — медиана.
// Дополнительно (--addr): порядок адресов узлов при обходе: доля шагов |Δ| ≤ 64 Б,
// ≤ 4 КиБ, доля шагов назад, средний |Δ|.
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <memory>
#include <memory_resource>
#include <new>
#include <string>
#include <sys/mman.h>
#include <unordered_set>
#include <vector>

#include "absl/container/flat_hash_set.h"
#include "absl/container/node_hash_set.h"

using u64 = uint64_t;
using Vec = std::vector<u64>;

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
static inline u64 mix64(u64 z) {
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}
struct SplitMix64 {
  u64 s;
  u64 next() { return mix64(s += 0x9e3779b97f4a7c15ULL); }
  u64 below(u64 n) { return (u64)(((unsigned __int128)next() * n) >> 64); }
};
// Вход как в dedup_bench: U различных ключей (splitmix64), всего N, перемешано.
static Vec make_input(size_t N, size_t U, u64 seed, size_t idx) {
  SplitMix64 r{mix64(seed * 0x100000001b3ULL ^ mix64(idx + 1) ^ (N << 1) ^ (U << 33))};
  Vec keys(U);
  for (auto& k : keys) k = r.next();
  std::vector<uint32_t> cnt(U, 1);
  for (size_t i = U; i < N; ++i) cnt[r.below(U)]++;
  Vec v; v.reserve(N);
  for (size_t k = 0; k < U; ++k) v.insert(v.end(), cnt[k], keys[k]);
  for (size_t i = v.size(); i > 1; --i) std::swap(v[i - 1], v[r.below(i)]);
  return v;
}

// ------------------------------------------------------------ аллокаторы
// Общий буфер: выделен и прогрет один раз, живёт весь процесс.
struct Arena {
  char* base = nullptr; size_t cap = 0, off = 0;
  void init(size_t bytes) {
    cap = bytes;
    base = (char*)mmap(nullptr, cap, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
    if (base == MAP_FAILED) { perror("mmap"); exit(1); }
    std::memset(base, 0, cap);  // прогрев страниц
  }
  void reset() { off = 0; }
  void* alloc(size_t n, size_t align) {
    size_t o = (off + align - 1) & ~(align - 1);
    if (o + n > cap) { fprintf(stderr, "arena overflow\n"); exit(1); }
    off = o + n; return base + o;
  }
};
static Arena g_arena;

template <class T>
struct BumpAlloc {
  using value_type = T;
  BumpAlloc() = default;
  template <class U> BumpAlloc(const BumpAlloc<U>&) {}
  T* allocate(size_t n) { return (T*)g_arena.alloc(n * sizeof(T), alignof(T)); }  // как monotonic_buffer_resource: по alignof(T), узлы libc++ идут с шагом 24 Б, libstdc++ — 16 Б
  void deallocate(T*, size_t) {}
  template <class U> bool operator==(const BumpAlloc<U>&) const { return true; }
  template <class U> bool operator!=(const BumpAlloc<U>&) const { return false; }
};

// malloc без free
template <class T>
struct LeakAlloc {
  using value_type = T;
  LeakAlloc() = default;
  template <class U> LeakAlloc(const LeakAlloc<U>&) {}
  T* allocate(size_t n) { return (T*)::operator new(n * sizeof(T)); }
  void deallocate(T* p, size_t n) { if (n > 1) ::operator delete(p); }  // массив ячеек освобождаем, узлы — нет
  template <class U> bool operator==(const LeakAlloc<U>&) const { return true; }
  template <class U> bool operator!=(const LeakAlloc<U>&) const { return false; }
};

// Пул слотов фиксированного размера, розданных в заданном порядке (seq / shuffled).
struct SlotPool {
  size_t slot = 32, n = 0, next = 0; char* base = nullptr; std::vector<uint32_t> order;
  void init(size_t slots, size_t slot_bytes, bool shuffled, u64 seed) {
    slot = slot_bytes; n = slots;
    if (!base) {  // своя прогретая область, не пересекается с ареной bump/pmr
      base = (char*)mmap(nullptr, n * slot, PROT_READ | PROT_WRITE, MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
      if (base == MAP_FAILED) { perror("mmap"); exit(1); }
      std::memset(base, 0, n * slot);
    }
    order.resize(n);
    for (uint32_t i = 0; i < n; ++i) order[i] = i;
    if (shuffled) { SplitMix64 r{seed}; for (size_t i = n; i > 1; --i) std::swap(order[i - 1], order[r.below(i)]); }
  }
  void reset() { next = 0; }
  void* take(size_t bytes) {
    if (bytes > slot || next >= n) { fprintf(stderr, "pool overflow (%zu > %zu or %zu/%zu)\n", bytes, slot, next, n); exit(1); }
    return base + (size_t)order[next++] * slot;
  }
};
static SlotPool g_pool;

template <class T>
struct PoolAlloc {  // allocate(1) — узел из пула; allocate(n>1) — массив ячеек через malloc
  using value_type = T;
  PoolAlloc() = default;
  template <class U> PoolAlloc(const PoolAlloc<U>&) {}
  T* allocate(size_t n) { return n == 1 ? (T*)g_pool.take(sizeof(T)) : (T*)::operator new(n * sizeof(T)); }
  void deallocate(T* p, size_t n) { if (n > 1) ::operator delete(p); }
  template <class U> bool operator==(const PoolAlloc<U>&) const { return true; }
  template <class U> bool operator!=(const PoolAlloc<U>&) const { return false; }
};

// ------------------------------------------------------------ замер фаз
struct Phase { double ins, dump, dtor, total; long rss_peak; };

static Vec reference(const Vec& in) { Vec r(in); std::sort(r.begin(), r.end()); r.erase(std::unique(r.begin(), r.end()), r.end()); return r; }

template <class Set, class Make>
static Phase run_one(const Vec& in, const Vec& ref, Vec& w, bool onepass, Make make) {
  w.assign(in.begin(), in.end());
  double t0, t1, t2, t3; long rss_mid;
  {
    t0 = now_ns();
    Set s = make();
    s.reserve(w.size());
    for (u64 x : w) s.insert(x);
    t1 = now_ns();
    if (onepass) { size_t i = 0; for (u64 x : s) w[i++] = x; w.resize(i); }
    else w.assign(s.begin(), s.end());
    t2 = now_ns();
    rss_mid = rss_kb();
  }
  t3 = now_ns();
  { Vec chk(w); std::sort(chk.begin(), chk.end()); if (chk != ref) { fprintf(stderr, "WRONG RESULT\n"); exit(2); } }
  const double n = (double)in.size();
  return Phase{(t1 - t0) / n, (t2 - t1) / n - 0.0, (t3 - t2) / n, (t3 - t0) / n, rss_mid};
}

// Порядок адресов узлов при обходе: по итератору (узлы — это &*it минус смещение,
// но достаточно адреса значения: он внутри узла).
template <class Set>
static void addr_order(const Set& s, const char* label) {
  size_t steps = 0, le64 = 0, le4k = 0, desc = 0; double sum = 0; const char* prev = nullptr;
  for (auto it = s.begin(); it != s.end(); ++it) {
    const char* p = (const char*)std::addressof(*it);
    if (prev) { long d = p - prev; ++steps; long ad = d < 0 ? -d : d; if (ad <= 64) ++le64; if (ad <= 4096) ++le4k; if (d < 0) ++desc; sum += (double)ad; }
    prev = p;
  }
  printf("addr,%s,steps=%zu,frac_le64B=%.3f,frac_le4KiB=%.3f,frac_desc=%.3f,mean_abs_delta_KiB=%.1f\n",
         label, steps, (double)le64 / steps, (double)le4k / steps, (double)desc / steps, sum / steps / 1024.0);
}

static const char* lib() {
#if defined(_LIBCPP_VERSION)
  return "libc++";
#else
  return "libstdc++";
#endif
}

template <class Set, class Make>
static void series(const char* variant, const std::vector<Vec>& pool, const std::vector<Vec>& refs, size_t N, size_t U, int calls, bool onepass, bool addr, Make make, void (*reset)()) {
  Vec w; w.reserve(N);
  std::vector<Phase> ph;
  for (int c = 0; c < calls; ++c) {
    if (reset) reset();
    ph.push_back(run_one<Set>(pool[c % pool.size()], refs[c % pool.size()], w, onepass, make));
  }
  if (addr) {
    if (reset) reset();
    Set s = make(); s.reserve(N); for (u64 x : pool[0]) s.insert(x);
    char lbl[128]; snprintf(lbl, sizeof lbl, "%s,%s,N=%zu,U=%zu", lib(), variant, N, U);
    addr_order(s, lbl);
  }
  auto med = [&](auto get) { std::vector<double> v; for (size_t i = 1; i < ph.size(); ++i) v.push_back(get(ph[i])); std::sort(v.begin(), v.end()); return v.empty() ? 0.0 : v[v.size() / 2]; };
  auto mn = [&](auto get) { double m = 1e18; for (size_t i = 1; i < ph.size(); ++i) m = std::min(m, get(ph[i])); return m; };
  printf("%s,%s,%zu,%zu,%s,first,%.1f,%.1f,%.1f,%.1f,%ld\n", lib(), variant, N, U, onepass ? "1pass" : "assign",
         ph[0].ins, ph[0].dump, ph[0].dtor, ph[0].total, ph[0].rss_peak);
  printf("%s,%s,%zu,%zu,%s,median,%.1f,%.1f,%.1f,%.1f,%ld\n", lib(), variant, N, U, onepass ? "1pass" : "assign",
         med([](const Phase& p) { return p.ins; }), med([](const Phase& p) { return p.dump; }),
         med([](const Phase& p) { return p.dtor; }), med([](const Phase& p) { return p.total; }), ph.back().rss_peak);
  printf("%s,%s,%zu,%zu,%s,min,%.1f,%.1f,%.1f,%.1f,%ld\n", lib(), variant, N, U, onepass ? "1pass" : "assign",
         mn([](const Phase& p) { return p.ins; }), mn([](const Phase& p) { return p.dump; }),
         mn([](const Phase& p) { return p.dtor; }), mn([](const Phase& p) { return p.total; }), ph.back().rss_peak);
  fflush(stdout);
}

using StdSet = std::unordered_set<u64>;
using BumpSet = std::unordered_set<u64, std::hash<u64>, std::equal_to<u64>, BumpAlloc<u64>>;
using LeakSet = std::unordered_set<u64, std::hash<u64>, std::equal_to<u64>, LeakAlloc<u64>>;
using PoolSet = std::unordered_set<u64, std::hash<u64>, std::equal_to<u64>, PoolAlloc<u64>>;
using PmrSet = std::pmr::unordered_set<u64>;
using NodeSet = absl::node_hash_set<u64>;
using FlatSet = absl::flat_hash_set<u64>;

static std::pmr::monotonic_buffer_resource* g_mbr = nullptr;
alignas(std::pmr::monotonic_buffer_resource) static char g_mbr_storage[sizeof(std::pmr::monotonic_buffer_resource)];
static void pmr_reset() { if (g_mbr) { g_mbr->~monotonic_buffer_resource(); } g_arena.reset();
  g_mbr = new (g_mbr_storage) std::pmr::monotonic_buffer_resource(g_arena.base, g_arena.cap, std::pmr::null_memory_resource()); }
static void arena_reset() { g_arena.reset(); }
static void pool_reset() { g_pool.reset(); }

int main(int argc, char** argv) {
  size_t N = 1u << 20, U = 1u << 20; int calls = 9; bool onepass = false, addr = false;
  std::vector<std::string> variants = {"std", "bump", "pmr", "pool_seq", "pool_shuf", "leak", "node", "flat"};
  bool header = false;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    if (a == "--n") N = std::stoull(argv[++i]);
    else if (a == "--u") U = std::stoull(argv[++i]);
    else if (a == "--calls") calls = std::stoi(argv[++i]);
    else if (a == "--dump") onepass = std::string(argv[++i]) == "1pass";
    else if (a == "--addr") addr = true;
    else if (a == "--header") header = true;
    else if (a == "--variants") { variants.clear(); std::string s = argv[++i]; size_t p = 0; while (p <= s.size()) { size_t q = s.find(',', p); if (q == std::string::npos) q = s.size(); if (q > p) variants.push_back(s.substr(p, q - p)); p = q + 1; } }
    else { fprintf(stderr, "usage: uset_decomp [--n N] [--u U] [--calls K] [--dump assign|1pass] [--addr] [--variants a,b,c]\n"); return 2; }
  }
  if (header) { printf("lib,variant,N,U,dump,stat,insert_ns_el,dump_ns_el,dtor_ns_el,total_ns_el,rss_peak_kb\n"); return 0; }
  std::vector<Vec> pool(4);
  std::vector<Vec> refs(pool.size());
  for (size_t i = 0; i < pool.size(); ++i) { pool[i] = make_input(N, U, 17, i); refs[i] = reference(pool[i]); }
  // буфер: узлы (≤ 32 Б × U c запасом) + массив ячеек (8 Б × N, с запасом под простое) + запас
  const size_t node_bytes = 32;
  g_arena.init(node_bytes * U + 16 * N + (64u << 20));
  // узлы libstdc++ 16 Б / libc++ 24 Б; в пуле слот 32 Б — как чанк glibc
  bool pool_inited_shuf = false;
  for (auto& v : variants) {
    if (v == "std") series<StdSet>("std", pool, refs, N, U, calls, onepass, addr, [] { return StdSet(); }, nullptr);
    else if (v == "bump") series<BumpSet>("bump", pool, refs, N, U, calls, onepass, addr, [] { return BumpSet(); }, arena_reset);
    else if (v == "pmr") series<PmrSet>("pmr", pool, refs, N, U, calls, onepass, addr, [] { return PmrSet(g_mbr); }, pmr_reset);
    else if (v == "leak") series<LeakSet>("leak", pool, refs, N, U, std::min(calls, 6), onepass, addr, [] { return LeakSet(); }, nullptr);
    else if (v == "pool_seq") { g_pool.init(U, 32, false, 7); series<PoolSet>("pool_seq", pool, refs, N, U, calls, onepass, addr, [] { return PoolSet(); }, pool_reset); }
    else if (v == "pool_shuf") { g_pool.init(U, 32, true, 7); pool_inited_shuf = true; series<PoolSet>("pool_shuf", pool, refs, N, U, calls, onepass, addr, [] { return PoolSet(); }, pool_reset); }
    else if (v == "node") series<NodeSet>("node", pool, refs, N, U, calls, onepass, false, [] { return NodeSet(); }, nullptr);
    else if (v == "flat") series<FlatSet>("flat", pool, refs, N, U, calls, onepass, false, [] { return FlatSet(); }, nullptr);
    else { fprintf(stderr, "unknown variant %s\n", v.c_str()); return 2; }
  }
  (void)pool_inited_shuf;
  return 0;
}
