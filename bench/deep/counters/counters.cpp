// counters.cpp — детерминированные счётчики (valgrind/callgrind) для алгоритмов
// из ../../dedup_bench.cpp. Алгоритмы и генератор входов берутся из того же
// файла (он включается целиком, main переименован), поэтому код, который
// считает callgrind, — ровно тот, что мерили в сериях E1–E11.
//
// Регион измерения — функция measured_call: callgrind запускается с
//   --instr-atstart=no --collect-atstart=no --toggle-collect=measured_call
// Инструментирование включается клиентским запросом перед копией входа
// (копия — вне региона, как в бенчмарке; она же греет кэш-симулятор), сбор
// счётчиков — только внутри вызова алгоритма.
//
// Режимы:
//   --mode single    один вызов алгоритма на одном входе (по умолчанию)
//   --mode learned_a K вызовов на одном буфере, вход восстанавливается (пул 1, батч 1)
//   --mode learned_b K одинаковых копий входа в K буферах               (пул 1, батч K)
//   --mode learned_c K разных входов в K буферах                        (пул K, батч K)
//   --mode compares  без callgrind: считает сравнения std::sort на элемент
// Алгоритмы: как в dedup_bench плюс uset_phased / flat_phased — та же
// операция, разбитая на три noinline-функции phase_insert / phase_dump /
// phase_dtor, чтобы callgrind_annotate --inclusive=yes разложил счётчики по фазам.

#define main dedup_bench_main
#include "../../dedup_bench.cpp"
#undef main

#include <valgrind/callgrind.h>

template <class Set>
__attribute__((noinline)) static void phase_insert(Set& s, const Vec& v) {
  s.reserve(v.size());
  for (u64 x : v) s.insert(x);
}
template <class Set>
__attribute__((noinline)) static void phase_dump(Set& s, Vec& v) {
  v.assign(s.begin(), s.end());
}
template <class Set>
__attribute__((noinline)) static void phase_dtor(std::unique_ptr<Set>& p) {
  p.reset();
}
template <class Set>
static void alg_phased(Vec& v, const Ctx&) {
  auto p = std::make_unique<Set>();
  phase_insert(*p, v);
  phase_dump(*p, v);
  phase_dtor(p);
}
static void alg_uset_phased(Vec& v, const Ctx& c) { alg_phased<std::unordered_set<u64>>(v, c); }
static void alg_flat_phased(Vec& v, const Ctx& c) { alg_phased<absl::flat_hash_set<u64>>(v, c); }

// Точка переключения сбора: имя без mangling, чтобы --toggle-collect=measured_call
extern "C" __attribute__((noinline)) void measured_call(AlgFn f, Vec* v, const Ctx* c) {
  f(*v, *c);
  asm volatile("" ::: "memory");
}

static AlgFn pick(const std::string& n) {
  if (n == "uset_phased") return alg_uset_phased;
  if (n == "flat_phased") return alg_flat_phased;
  const Alg* a = find_alg(n);
  if (!a) { fprintf(stderr, "unknown alg %s\n", n.c_str()); exit(2); }
  return a->fn;
}

static int count_compares(const Config& c) {
  Vec in = make_input(c, 0);
  unsigned long long cmp = 0;
  std::sort(in.begin(), in.end(), [&](u64 a, u64 b) { ++cmp; return a < b; });
  printf("compares_per_element=%.3f N=%zu U=%zu order=%s toolchain=%s\n",
         (double)cmp / (double)c.N, c.N, c.U, order_name(c.order), short_toolchain().c_str());
  return 0;
}

int main(int argc, char** argv) {
  Config c;
  std::string alg = "sort", mode = "single";
  size_t K = 64;
  for (int i = 1; i < argc; ++i) {
    std::string a = argv[i];
    auto val = [&]() -> std::string { if (i + 1 >= argc) exit(2); return argv[++i]; };
    if (a == "--alg") alg = val();
    else if (a == "--mode") mode = val();
    else if (a == "--calls") K = std::stoull(val());
    else if (a == "--n") c.N = std::stoull(val());
    else if (a == "--u") c.U = std::stoull(val());
    else if (a == "--keys") { auto v = val(); c.keys = v == "dense" ? Keys::Dense : v == "e8" ? Keys::E8 : Keys::Random; }
    else if (a == "--order") { auto v = val(); c.order = v == "runs" ? Order::Runs : v == "sorted" ? Order::Sorted : Order::Random; }
    else if (a == "--nlocal") c.nlocal = std::stoull(val());
    else if (a == "--seed") c.seed = std::stoull(val());
    else { fprintf(stderr, "bad arg %s\n", a.c_str()); return 2; }
  }
  if (mode == "compares") return count_compares(c);
  AlgFn f = pick(alg);
  Ctx ctx; ctx.nlocal = (c.keys == Keys::E8) ? c.nlocal : 0;

  const size_t P = (mode == "learned_c") ? K : 1;            // разных входов
  const size_t B = (mode == "single") ? 1 : (mode == "learned_a" ? 1 : K);  // буферов
  const size_t calls = (mode == "single") ? 1 : K;
  std::vector<Vec> pool(P), refs(P);
  for (size_t i = 0; i < P; ++i) { pool[i] = make_input(c, i); refs[i] = reference(pool[i]); }
  std::vector<Vec> work(B);
  for (auto& w : work) w.reserve(c.N);

  unsigned long long elements = 0;
  CALLGRIND_START_INSTRUMENTATION;
  for (size_t k = 0; k < calls; ++k) {
    const size_t pi = k % P, bi = k % B;
    work[bi].assign(pool[pi].begin(), pool[pi].end());  // копия входа — вне региона
    measured_call(f, &work[bi], &ctx);
    elements += pool[pi].size();
    if (!check(work[bi], refs[pi])) { fprintf(stderr, "WRONG RESULT alg=%s\n", alg.c_str()); return 2; }
  }
  CALLGRIND_STOP_INSTRUMENTATION;
  printf("alg=%s mode=%s toolchain=%s N=%zu U=%zu keys=%s order=%s calls=%zu elements=%llu\n",
         alg.c_str(), mode.c_str(), short_toolchain().c_str(), c.N,
         c.keys == Keys::E8 ? refs[0].size() : c.U, keys_name(c.keys), order_name(c.order), calls, elements);
  return 0;
}
