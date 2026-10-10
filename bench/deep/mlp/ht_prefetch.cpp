// ht_prefetch.cpp — вставка N случайных uint64 в хеш-таблицы: что даёт программный префетч
// и из чего складывается цена узловой таблицы (зависимая цепочка против malloc).
//   open   — своя открытая адресация (линейное зондирование, 2N слотов, 0 = пусто)
//   chain  — своя цепочечная таблица (N ячеек, узел 16 Б) с узлами из malloc или из арены (bump)
//   uset   — std::unordered_set<uint64_t> с reserve(N) (ориентир)
//   absl   — absl::flat_hash_set<uint64_t> с reserve(N) (ориентир; собирается с -DHAVE_ABSL)
// Варианты: plain · pf<D> (префетч слота/ячейки для ключа i+D) · batch16 (16 хешей+префетчей, потом 16 вставок)
// Таймер — только вставки (без выделения таблицы и без деструктора): нс на ключ, медиана 5 повторов.
//   g++ -O3 -std=c++20 ht_prefetch.cpp -o build/ht_prefetch && taskset -c 2 build/ht_prefetch N
#include "common.h"
#include <unordered_set>
#ifdef HAVE_ABSL
#include "absl/container/flat_hash_set.h"
#endif

static uint64_t sink;

// ---------- открытая адресация ----------
struct Open {
  uint64_t* slots; size_t mask; int shift;
  explicit Open(size_t n_slots) : mask(n_slots - 1) { shift = 64 - __builtin_ctzll(n_slots); slots = (uint64_t*)alloc_pages(n_slots * 8, true); }
  inline size_t h(uint64_t k) const { return mix64(k) >> shift; }
  inline void insert_at(size_t i, uint64_t k) {
    for (;; i = (i + 1) & mask) {
      uint64_t s = slots[i];
      if (s == 0) { slots[i] = k; return; }
      if (s == k) return;
    }
  }
  inline void insert(uint64_t k) { insert_at(h(k), k); }
  void clear(size_t n_slots) { memset(slots, 0, n_slots * 8); }
};

// ---------- цепочки ----------
struct Node { uint64_t key; Node* next; };
struct Chain {
  Node** buckets; size_t mask; Node* arena; size_t arena_pos; bool use_arena;
  Chain(size_t n_buckets, size_t n_keys, bool arena_) : mask(n_buckets - 1), arena_pos(0), use_arena(arena_) {
    buckets = (Node**)alloc_pages(n_buckets * 8, true);
    arena = use_arena ? (Node*)alloc_pages(n_keys * sizeof(Node), true) : nullptr;
  }
  inline size_t h(uint64_t k) const { return mix64(k) & mask; }
  inline Node* alloc() { return use_arena ? &arena[arena_pos++] : (Node*)malloc(sizeof(Node)); }
  inline void insert_at(size_t b, uint64_t k) {
    Node* head = buckets[b];
    for (Node* p = head; p; p = p->next) if (p->key == k) return;  // зависимый обход цепочки
    Node* n = alloc(); n->key = k; n->next = head; buckets[b] = n;   // malloc — после обхода, как в libstdc++/libc++
  }
  inline void insert(uint64_t k) { insert_at(h(k), k); }
  void clear(size_t n_buckets) {
    if (!use_arena) for (size_t b = 0; b < n_buckets; ++b) for (Node* p = buckets[b]; p;) { Node* q = p->next; free(p); p = q; }
    memset(buckets, 0, n_buckets * 8); arena_pos = 0;
  }
};

template <class T, int D>
static void insert_pf(T& t, const uint64_t* keys, size_t n) {
  for (size_t i = 0; i < n; ++i) {
    if (i + D < n) __builtin_prefetch(&t.slots_or_buckets()[t.h(keys[i + D])], 1, 3);
    t.insert(keys[i]);
  }
}
template <class T>
static void insert_batch16(T& t, const uint64_t* keys, size_t n) {
  size_t i = 0;
  for (; i + 16 <= n; i += 16) {
    size_t hs[16];
    for (int j = 0; j < 16; ++j) { hs[j] = t.h(keys[i + j]); __builtin_prefetch(&t.slots_or_buckets()[hs[j]], 1, 3); }
    for (int j = 0; j < 16; ++j) t.insert_at(hs[j], keys[i + j]);
  }
  for (; i < n; ++i) t.insert(keys[i]);
}
struct OpenW : Open { using Open::Open; uint64_t* slots_or_buckets() { return slots; } };
struct ChainW : Chain { using Chain::Chain; Node** slots_or_buckets() { return buckets; } };

int main(int argc, char** argv) {
  const size_t N = argc > 1 ? (size_t)atol(argv[1]) : (1u << 20);
  const int REPS = 5;
  std::vector<uint64_t> keys(N);
  for (size_t i = 0; i < N; ++i) keys[i] = mix64(i + 1000003);  // различны по построению, случайные биты
  { uint64_t r = 42; for (size_t i = N - 1; i > 0; --i) { r = mix64(r); std::swap(keys[i], keys[r % (i + 1)]); } }
  printf("table,variant,N,ns_per_insert,reps\n");
  auto report = [&](const char* table, const char* variant, std::vector<double>& v) {
    std::string s; for (double x : v) { char b[32]; snprintf(b, 32, "%.1f ", x); s += b; }
    printf("%s,%s,%zu,%.1f,%s\n", table, variant, N, median(v), s.c_str()); fflush(stdout);
  };
  const size_t slots = 2 * N;  // заполнение 50%, как у absl после reserve(N) при N = 2^k
  // --- открытая адресация ---
  {
    OpenW t(slots);
    auto timeit = [&](const char* name, auto fn) {
      std::vector<double> v;
      for (int r = 0; r < REPS; ++r) { t.clear(slots); double t0 = now_ns(); fn(); v.push_back((now_ns() - t0) / N); }
      report("open", name, v); sink += t.slots[t.h(keys[0])];
    };
    timeit("plain", [&] { for (size_t i = 0; i < N; ++i) t.insert(keys[i]); });
    timeit("pf4", [&] { insert_pf<OpenW, 4>(t, keys.data(), N); });
    timeit("pf8", [&] { insert_pf<OpenW, 8>(t, keys.data(), N); });
    timeit("pf16", [&] { insert_pf<OpenW, 16>(t, keys.data(), N); });
    timeit("pf32", [&] { insert_pf<OpenW, 32>(t, keys.data(), N); });
    timeit("batch16", [&] { insert_batch16(t, keys.data(), N); });
    // поиск (чистые независимые чтения): все ключи есть
    std::vector<uint64_t> q(keys); { uint64_t r = 7; for (size_t i = N - 1; i > 0; --i) { r = mix64(r); std::swap(q[i], q[r % (i + 1)]); } }
    t.clear(slots); for (size_t i = 0; i < N; ++i) t.insert(keys[i]);
    auto find = [&](uint64_t k) { for (size_t i = t.h(k);; i = (i + 1) & t.mask) { uint64_t s = t.slots[i]; if (s == k) return 1; if (s == 0) return 0; } };
    std::vector<double> v;
    for (int r = 0; r < REPS; ++r) { uint64_t c = 0; double t0 = now_ns(); for (size_t i = 0; i < N; ++i) c += find(q[i]); v.push_back((now_ns() - t0) / N); sink += c; }
    report("open", "find_plain", v); v.clear();
    for (int r = 0; r < REPS; ++r) { uint64_t c = 0; double t0 = now_ns(); for (size_t i = 0; i < N; ++i) { if (i + 16 < N) __builtin_prefetch(&t.slots[t.h(q[i + 16])]); c += find(q[i]); } v.push_back((now_ns() - t0) / N); sink += c; }
    report("open", "find_pf16", v);
  }
  // --- цепочки: malloc против арены, с префетчем ячейки и без ---
  for (int arena = 0; arena < 2; ++arena) {
    ChainW t(N, N, arena == 1);
    const char* tn = arena ? "chain_arena" : "chain_malloc";
    auto timeit = [&](const char* name, auto fn) {
      std::vector<double> v;
      for (int r = 0; r < REPS; ++r) { t.clear(N); double t0 = now_ns(); fn(); v.push_back((now_ns() - t0) / N); }
      report(tn, name, v); sink += (uint64_t)t.buckets[t.h(keys[0])];
    };
    timeit("plain", [&] { for (size_t i = 0; i < N; ++i) t.insert(keys[i]); });
    timeit("pf16", [&] { insert_pf<ChainW, 16>(t, keys.data(), N); });
    timeit("batch16", [&] { insert_batch16(t, keys.data(), N); });
    t.clear(N);
  }
  // --- ориентиры ---
  {
    std::vector<double> v;
    for (int r = 0; r < REPS; ++r) {
      std::unordered_set<uint64_t> s; s.reserve(N);
      double t0 = now_ns(); for (size_t i = 0; i < N; ++i) s.insert(keys[i]); v.push_back((now_ns() - t0) / N);
      sink += s.size();
    }
    report("std_unordered_set", "plain(reserve N)", v);
  }
#ifdef HAVE_ABSL
  {
    std::vector<double> v;
    for (int r = 0; r < REPS; ++r) {
      absl::flat_hash_set<uint64_t> s; s.reserve(N);
      double t0 = now_ns(); for (size_t i = 0; i < N; ++i) s.insert(keys[i]); v.push_back((now_ns() - t0) / N);
      sink += s.size();
    }
    report("absl_flat_hash_set", "plain(reserve N)", v);
    v.clear();
    for (int r = 0; r < REPS; ++r) {
      absl::flat_hash_set<uint64_t> s; s.reserve(N);
      double t0 = now_ns();
      for (size_t i = 0; i < N; ++i) { if (i + 16 < N) s.prefetch(keys[i + 16]); s.insert(keys[i]); }
      v.push_back((now_ns() - t0) / N); sink += s.size();
    }
    report("absl_flat_hash_set", "pf16(set.prefetch)", v);
  }
#endif
  fprintf(stderr, "sink=%llu anon_huge_kb=%ld\n", (unsigned long long)sink, anon_huge_kb());
}
