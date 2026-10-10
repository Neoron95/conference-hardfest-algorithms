// micro.cpp — паспорт ядра для отчёта isa.md: частота (цепочка imul, 3 такта),
// латентность/пропускная способность div r64 (как в libstdc++ _M_bucket_index),
// and r64 (маска libc++), штраф за непредсказуемое ветвление (как в разбиении
// quicksort) и цена зависимого чтения из L1.
//   g++ -O2 micro.cpp -o build/micro && taskset -c 2 build/micro
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <vector>
static double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}
static double ghz = 0;
template <class F> static double best_ns(F f, int reps = 5) {
  double best = 1e30;
  for (int i = 0; i < reps; ++i) { double t0 = now_ns(); f(); best = std::min(best, now_ns() - t0); }
  return best;
}
int main() {
  const long it = 20000000;
  // частота: 8 зависимых imul = 24 такта на итерацию
  double ns = best_ns([&] { uint64_t x = 3, m = 5; for (long i = 0; i < it; i++) asm volatile("imul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0\n\timul %1,%0" : "+r"(x) : "r"(m)); });
  ghz = it * 24.0 / ns; printf("freq_ghz,%.2f\n", ghz);
  auto cyc = [&](double ns_total, double n) { return ns_total / n * ghz; };
  // div r64 латентность: цепочка зависимых div (dividend = результат), делитель — простое 1056323
  {
    uint64_t d = 1056323; volatile uint64_t vd = d;
    double t = best_ns([&] { uint64_t a = 0xffffffffffffffffULL, q = 0, r = 0; uint64_t dd = vd; for (long i = 0; i < it / 4; i++) { asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a), "=&d"(r) : "r"(dd)); a = a + r + 0x123456789ULL; (void)q; } });
    printf("div_r64_latency_cycles(dividend~2^64, divisor=1056323),%.1f\n", cyc(t, it / 4));
    // малый делимый (хеш < 2^32): быстрее?
    t = best_ns([&] { uint64_t a = 0xfffffffULL, r = 0; uint64_t dd = vd; for (long i = 0; i < it / 4; i++) { asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a), "=&d"(r) : "r"(dd)); a = (a + r) & 0xfffffffULL; } });
    printf("div_r64_latency_cycles(dividend<2^28),%.1f\n", cyc(t, it / 4));
    // пропускная способность: 4 независимых div
    t = best_ns([&] { uint64_t a0 = 1, a1 = 2, a2 = 3, a3 = 4, r0, r1, r2, r3; uint64_t dd = vd; for (long i = 0; i < it / 4; i++) { asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a0), "=&d"(r0) : "r"(dd)); asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a1), "=&d"(r1) : "r"(dd)); asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a2), "=&d"(r2) : "r"(dd)); asm volatile("xor %%edx,%%edx\n\tdivq %2" : "+a"(a3), "=&d"(r3) : "r"(dd)); a0 += 0x9e3779b97f4a7c15ULL; a1 += 0x9e3779b97f4a7c15ULL; a2 += 0x9e3779b97f4a7c15ULL; a3 += 0x9e3779b97f4a7c15ULL; } });
    printf("div_r64_throughput_cycles_per_div(4 independent),%.1f\n", cyc(t, it));
  }
  // and r64 (маска): цепочка and+add
  { double t = best_ns([&] { uint64_t a = 0xffffffffffffffffULL, m = (1ull << 20) - 1; for (long i = 0; i < it; i++) asm volatile("and %1,%0\n\tadd $7,%0" : "+r"(a) : "r"(m)); }); printf("and+add_latency_cycles,%.1f\n", cyc(t, it)); }
  // штраф за непредсказуемое ветвление: массив случайных бит в L1, настоящее условное
  // ветвление в inline asm (компилятор иначе делает cmov)
  {
    const size_t n = 4096; std::vector<uint8_t> bits(n), ones(n, 1);
    uint64_t s = 1; for (auto& b : bits) { s ^= s << 13; s ^= s >> 7; s ^= s << 17; b = s & 1; }
    auto run = [&](std::vector<uint8_t>& v) { uint64_t acc = 0; for (long r = 0; r < it / n; r++) for (size_t i = 0; i < n; i++) { uint64_t b = v[i]; asm volatile("test %1,%1\n\tjz 1f\n\tadd %2,%0\n\tjmp 2f\n1:\txor %2,%0\n2:" : "+r"(acc) : "r"(b), "r"((uint64_t)i)); } return acc; };
    volatile uint64_t sink;
    double t_pred = best_ns([&] { sink = run(ones); }), t_rand = best_ns([&] { sink = run(bits); });
    printf("branch_predictable_cycles_per_iter,%.1f\n", cyc(t_pred, it));
    printf("branch_random_cycles_per_iter,%.1f\n", cyc(t_rand, it));
    printf("mispredict_penalty_cycles_est(=(rand-pred)/0.5),%.1f\n", (cyc(t_rand, it) - cyc(t_pred, it)) / 0.5);
  }
  // зависимое чтение L1 (цепочка указателей в 4 КБ)
  { const size_t n = 512; std::vector<uint64_t> a(n); for (size_t i = 0; i < n; i++) a[i] = (i * 7 + 1) % n; double t = best_ns([&] { uint64_t p = 0; for (long i = 0; i < it; i++) p = a[p]; sink_ptr: (void)p; asm volatile("" :: "r"(p)); }); printf("L1_load_latency_cycles,%.1f\n", cyc(t, it)); }
}
