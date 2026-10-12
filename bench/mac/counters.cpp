// counters.cpp — аппаратные счётчики M2 для слайдов work / pace / speculation / sortfamily (нужен sudo).
// Алгоритмы и входы — ровно те же, что в dedup_bench.cpp (файл подключается целиком).
// На каждый элемент входа: такты, команды, ветвления, ошибки предсказателя, промахи L1D, промахи TLB.
// Промахов L2 на Apple счётчиком не посчитать — такого события в базе kpep нет.
//   sudo ./counters [--qos ui|background] [--reps R] → CSV в stdout
#define main dedup_bench_main
#include "../dedup_bench.cpp"
#undef main
#include "../deep/sort/pdqsort.h"
#include "kperf.h"

static void sort_only_std(Vec& v, const Ctx&) { std::sort(v.begin(), v.end()); }
static void sort_only_pdqbl(Vec& v, const Ctx&) { pdqsort_branchless(v.begin(), v.end()); }
// Своя лямбда вместо std::less: pdqsort берёт вариант с ветвлениями — для цены ошибки предсказателя.
static void sort_only_pdqbranchy(Vec& v, const Ctx&) {
  pdqsort(v.begin(), v.end(), [](u64 x, u64 y) { return x < y; });
}

int main(int argc, char** argv) {
  std::string qos = "ui";
  int reps = 5;
  for (int i = 1; i + 1 < argc; ++i) {
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
