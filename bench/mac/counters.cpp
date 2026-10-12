// counters.cpp — аппаратные счётчики M2 для слайдов work / pace / speculation / sortfamily (нужен sudo).
// Алгоритмы и входы — ровно те же, что в dedup_bench.cpp (файл подключается целиком).
// На каждый элемент входа: такты, команды, ветвления, ошибки предсказателя, промахи L1D, промахи TLB.
// Промахов L2 на Apple счётчиком не посчитать — такого события в базе kpep нет.
//   sudo ./counters [--qos ui|background] [--reps R] → CSV в stdout
//   sudo ./counters --phases [--qos ...]  → те же счётчики по фазам хеш-таблиц (вставки / выгрузка / деструктор)
//     для std::unordered_set, той же таблицы на pmr-буфере (без malloc и free на узел) и flat_hash_set.
#define main dedup_bench_main
#include "../dedup_bench.cpp"
#undef main
#include "../deep/sort/pdqsort.h"
#include "kperf.h"
#include <memory_resource>

static void sort_only_std(Vec& v, const Ctx&) { std::sort(v.begin(), v.end()); }
static void sort_only_pdqbl(Vec& v, const Ctx&) { pdqsort_branchless(v.begin(), v.end()); }
// Своя лямбда вместо std::less: pdqsort берёт вариант с ветвлениями — для цены ошибки предсказателя.
static void sort_only_pdqbranchy(Vec& v, const Ctx&) {
  pdqsort(v.begin(), v.end(), [](u64 x, u64 y) { return x < y; });
}

// Счётчики по фазам одного вызова, как --phases в dedup_bench: reserve + вставки, выгрузка, деструктор.
template <class MakeSet>
static void phase_counts(const kperf::Counters& pc, const std::string& qos, const char* name, const Config& c,
                         const std::vector<Vec>& inputs, MakeSet make) {
  const size_t m = pc.names().size();
  const char* phase_names[3] = {"insert", "unload", "dtor"};
  std::vector<double> ns[3];
  std::vector<std::vector<double>> per[3];
  for (auto& p : per) p.resize(m);
  std::vector<std::byte> arena(c.U * 64 + c.N * 16 + (1u << 20));  // узлы + ячейки, как в alloc.cpp
  for (size_t r = 0; r < inputs.size(); ++r) {  // r = 0 — прогрев
    Vec w = inputs[r];
    std::pmr::monotonic_buffer_resource mr(arena.data(), arena.size(), std::pmr::new_delete_resource());
    std::vector<int64_t> k[4];
    double t[4];
    {
      k[0] = pc.read(); t[0] = now_ns();
      auto s = make(&mr);
      s.reserve(w.size());
      for (u64 x : w) s.insert(x);
      t[1] = now_ns(); k[1] = pc.read();
      w.assign(s.begin(), s.end());
      t[2] = now_ns(); k[2] = pc.read();
    }
    t[3] = now_ns(); k[3] = pc.read();
    if (w.size() != c.U) { fprintf(stderr, "%s: %zu unique, expected %zu\n", name, w.size(), c.U); exit(2); }
    if (r == 0) continue;
    for (int ph = 0; ph < 3; ++ph) {
      ns[ph].push_back((t[ph + 1] - t[ph]) / c.N);
      for (size_t i = 0; i < m; ++i)
        per[ph][i].push_back(k[ph][i] < 0 ? -1.0 : (double)(k[ph + 1][i] - k[ph][i]) / c.N);
    }
  }
  auto med = [](std::vector<double> v) { std::sort(v.begin(), v.end()); return v[v.size() / 2]; };
  for (int ph = 0; ph < 3; ++ph) {
    printf("phases,%s,%s,%zu,%zu,%s,%.2f", qos.c_str(), name, c.N, c.U, phase_names[ph], med(ns[ph]));
    for (size_t i = 0; i < m; ++i) printf(",%.3f", med(per[ph][i]));
    printf("\n");
  }
  fflush(stdout);
}

int main(int argc, char** argv) {
  std::string qos = "ui";
  int reps = 5;
  bool phases_mode = false;
  for (int i = 1; i < argc; ++i) {
    if (std::string(argv[i]) == "--phases") phases_mode = true;
    if (i + 1 >= argc) continue;
    if (std::string(argv[i]) == "--qos") qos = argv[i + 1];
    if (std::string(argv[i]) == "--reps") reps = std::max(1, atoi(argv[i + 1]));
  }
  apply_qos(qos);
  kperf::Counters pc;
  std::string err;
  const std::vector<std::vector<std::string>> events = {
      {"FIXED_CYCLES", "CORE_ACTIVE_CYCLE"},
      {"FIXED_INSTRUCTIONS", "INST_ALL"},
      {"INST_BRANCH"},
      {"BRANCH_MISPRED_NONSPEC"},
      {"BRANCH_COND_MISPRED_NONSPEC"},
      {"L1D_CACHE_MISS_LD_NONSPEC", "L1D_CACHE_MISS_LD"},
      {"L1D_TLB_MISS"},
  };
  if (!pc.init(events, err)) { fprintf(stderr, "counters: %s\n", err.c_str()); return 3; }
  fprintf(stderr, "events:");
  for (auto& n : pc.names()) fprintf(stderr, " [%s]", n.empty() ? "нет" : n.c_str());
  fprintf(stderr, "\n");

  if (phases_mode) {
    printf("exp,qos,set,N,U,phase,ns_el,cycles_el,instr_el,branches_el,br_mispred_el,"
           "br_cond_mispred_el,l1d_ld_miss_el,dtlb_miss_el\n");
    for (size_t U : {size_t(1) << 20, size_t(1) << 19}) {
      Config c;
      c.N = 1u << 20; c.U = U;
      std::vector<Vec> inputs;
      for (int r = 0; r <= reps; ++r) inputs.push_back(make_input(c, (size_t)r));
      for (int round = 0; round < 2; ++round) {  // два круга, чтобы чередовать
        phase_counts(pc, qos, "uset", c, inputs, [](std::pmr::memory_resource*) { return std::unordered_set<u64>(); });
        phase_counts(pc, qos, "uset_pmr", c, inputs,
                     [](std::pmr::memory_resource* mr) { return std::pmr::unordered_set<u64>(mr); });
        phase_counts(pc, qos, "flat", c, inputs, [](std::pmr::memory_resource*) { return absl::flat_hash_set<u64>(); });
      }
    }
    return 0;
  }

  struct Case { size_t N, U; Order order; };
  const Case cases[] = {
      {1u << 20, 1u << 20, Order::Random},   // первый замер: все разные
      {1u << 20, 1u << 19, Order::Random},   // половина разных
      {1u << 19, 1u << 18, Order::Random},   // 512K, половина разных (кривая, E-ядро)
      {1u << 20, 1u << 19, Order::Sorted},   // уже отсортированный вход
  };
  struct A { const char* name; AlgFn fn; };
  const A algs[] = {{"sort", alg_sort},           {"uset", alg_uset},
                    {"flat", alg_flat},           {"radix", alg_radix},
                    {"sort_only_std", sort_only_std}, {"sort_only_pdqbl", sort_only_pdqbl},
                    {"sort_only_pdqbranchy", sort_only_pdqbranchy}};
  printf("exp,qos,alg,N,U,order,ns_el,cycles_el,instr_el,branches_el,br_mispred_el,"
         "br_cond_mispred_el,l1d_ld_miss_el,dtlb_miss_el\n");
  for (auto& cs : cases) {
    Config c;
    c.N = cs.N; c.U = cs.U; c.order = cs.order;
    std::vector<Vec> inputs;
    for (int r = 0; r <= reps; ++r) inputs.push_back(make_input(c, (size_t)r));
    for (auto& a : algs) {
      const size_t m = pc.names().size();
      std::vector<std::vector<double>> per(m);
      std::vector<double> ns;
      for (int r = 0; r <= reps; ++r) {  // r = 0 — прогрев, не записываем
        Vec w = inputs[(size_t)r];
        auto c0 = pc.read();
        double t0 = now_ns();
        a.fn(w, Ctx{});
        double t1 = now_ns();
        auto c1 = pc.read();
        if (r == 0) continue;
        ns.push_back((t1 - t0) / cs.N);
        for (size_t i = 0; i < m; ++i)
          per[i].push_back(c0[i] < 0 ? -1.0 : (double)(c1[i] - c0[i]) / cs.N);
      }
      auto med = [](std::vector<double> v) { std::sort(v.begin(), v.end()); return v[v.size() / 2]; };
      printf("counters,%s,%s,%zu,%zu,%s,%.2f", qos.c_str(), a.name, cs.N, cs.U, order_name(cs.order), med(ns));
      for (size_t i = 0; i < m; ++i) printf(",%.3f", med(per[i]));
      printf("\n");
      fflush(stdout);
    }
  }
  return 0;
}
