// alloc.cpp — сколько стоит аллокатор узлов (слайд alloc-split) на Mac.
//   uset_default — std::unordered_set со стандартным аллокатором (malloc на узел, free в деструкторе);
//   uset_pmr     — та же таблица, узлы из заранее выделенного буфера (std::pmr::monotonic_buffer_resource):
//                  ни одного malloc и free на узел;
//   flat         — absl::flat_hash_set: узлов нет совсем.
//   Вся операция, как в dedup_bench: reserve, вставки, выгрузка в вектор, деструктор. нс на элемент.
//   ./alloc [--qos ui] [--n N] [--u U] → CSV в stdout
#include "mac_common.h"
#include <memory_resource>
#include <unordered_set>
#include "absl/container/flat_hash_set.h"

using Vec = std::vector<uint64_t>;

static void uset_default(Vec& v) {
  std::unordered_set<uint64_t> s;
  s.reserve(v.size());
  for (uint64_t x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}
static void uset_pmr(Vec& v, std::pmr::memory_resource* mr) {
  std::pmr::unordered_set<uint64_t> s(mr);
  s.reserve(v.size());
  for (uint64_t x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}
static void flat(Vec& v) {
  absl::flat_hash_set<uint64_t> s;
  s.reserve(v.size());
  for (uint64_t x : v) s.insert(x);
  v.assign(s.begin(), s.end());
}

int main(int argc, char** argv) {
  std::string qos = set_qos(qos_from_args(argc, argv));
  size_t N = 1u << 20, U = N;
  for (int i = 1; i + 1 < argc; ++i) {
    if (std::string(argv[i]) == "--n") N = std::stoull(argv[i + 1]);
    if (std::string(argv[i]) == "--u") U = std::stoull(argv[i + 1]);
  }
  std::vector<Vec> inputs(16);
  for (size_t k = 0; k < inputs.size(); ++k) {
    inputs[k].resize(N);
    for (size_t i = 0; i < N; ++i) inputs[k][i] = mix64(k * 0x100000001b3ULL + (i % U));  // U разных
    for (size_t i = N - 1; i > 0; --i) std::swap(inputs[k][i], inputs[k][mix64(i ^ k) % (i + 1)]);
  }
  std::vector<std::byte> arena(U * 64 + N * 16 + (1u << 20));  // узлы + массив ячеек, с запасом
  printf("exp,qos,variant,N,U,median_ns_el,min_ns_el,max_ns_el\n");
  Vec w;
  for (int round = 0; round < 2; ++round)
    for (int var = 0; var < 3; ++var) {
      std::vector<double> t;
      for (size_t k = 0; k < inputs.size(); ++k) {
        w = inputs[k];
        std::pmr::monotonic_buffer_resource mr(arena.data(), arena.size(), std::pmr::new_delete_resource());
        double t0 = now_ns();
        if (var == 0) uset_default(w);
        else if (var == 1) uset_pmr(w, &mr);
        else flat(w);
        t.push_back((now_ns() - t0) / N);
        if (w.size() != U) { fprintf(stderr, "variant %d: %zu unique, expected %zu\n", var, w.size(), U); return 2; }
      }
      if (round == 1) {
        std::sort(t.begin(), t.end());
        const char* name = var == 0 ? "uset_default" : var == 1 ? "uset_pmr_monotonic" : "flat";
        printf("alloc,%s,%s,%zu,%zu,%.2f,%.2f,%.2f\n", qos.c_str(), name, N, U, median(t), t.front(), t.back());
        fflush(stdout);
      }
    }
  return 0;
}
