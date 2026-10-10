// listvec.cpp — опыт Страуструпа (GoingNative 2012 / FAQ «Are lists evil?»):
// N случайных чисел вставляются в последовательность так, чтобы она оставалась
// отсортированной; затем элементы удаляются по одному в случайной позиции.
// Сравниваем std::list (линейный поиск по узлам + O(1) вставка) и std::vector
// (линейный поиск по массиву + сдвиг хвоста memmove), плюс vector с бинарным
// поиском (lower_bound) — «честная» версия, которой в опыте Страуструпа нет.
// Вывод: CSV  variant,N,insert_ms,erase_ms,total_ms,ns_per_insert,ns_per_erase
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <list>
#include <string>
#include <vector>

using u64 = uint64_t;
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
using Clock = std::chrono::steady_clock;
static double ms(Clock::time_point a, Clock::time_point b) {
  return std::chrono::duration<double, std::milli>(b - a).count();
}

// Значения — 32-битные, как у Страуструпа (int); контейнер хранит int.
struct Res { double ins, era; };

static Res run_list(const std::vector<int>& keys, const std::vector<size_t>& erase_pos) {
  std::list<int> l;
  auto t0 = Clock::now();
  for (int k : keys) {
    auto it = l.begin();
    while (it != l.end() && *it < k) ++it;  // линейный поиск по узлам
    l.insert(it, k);                        // O(1): новый узел
  }
  auto t1 = Clock::now();
  for (size_t p : erase_pos) {
    auto it = l.begin();
    std::advance(it, p);                    // снова прыжки по узлам
    l.erase(it);
  }
  auto t2 = Clock::now();
  if (!l.empty()) std::abort();
  return {ms(t0, t1), ms(t1, t2)};
}

static Res run_vec_linear(const std::vector<int>& keys, const std::vector<size_t>& erase_pos) {
  std::vector<int> v;  // без reserve — как «наивный» вариант
  auto t0 = Clock::now();
  for (int k : keys) {
    auto it = v.begin();
    while (it != v.end() && *it < k) ++it;  // линейный поиск по массиву
    v.insert(it, k);                        // сдвиг хвоста (memmove)
  }
  auto t1 = Clock::now();
  for (size_t p : erase_pos) v.erase(v.begin() + p);  // сдвиг хвоста
  auto t2 = Clock::now();
  if (!v.empty()) std::abort();
  return {ms(t0, t1), ms(t1, t2)};
}

static Res run_vec_binary(const std::vector<int>& keys, const std::vector<size_t>& erase_pos) {
  std::vector<int> v;
  auto t0 = Clock::now();
  for (int k : keys) v.insert(std::lower_bound(v.begin(), v.end(), k), k);
  auto t1 = Clock::now();
  for (size_t p : erase_pos) v.erase(v.begin() + p);
  auto t2 = Clock::now();
  if (!v.empty()) std::abort();
  return {ms(t0, t1), ms(t1, t2)};
}

int main(int argc, char** argv) {
  std::vector<size_t> Ns = {1000, 10000, 100000};
  if (argc > 1) { Ns.clear(); for (int i = 1; i < argc; ++i) Ns.push_back(std::strtoull(argv[i], nullptr, 10)); }
  std::printf("variant,N,insert_ms,erase_ms,total_ms,ns_per_insert,ns_per_erase\n");
  for (size_t N : Ns) {
    SplitMix64 r{17 ^ (N * 0x9e3779b97f4a7c15ULL)};
    std::vector<int> keys(N);
    for (auto& k : keys) k = (int)(r.next() >> 33);  // 31-битные положительные
    std::vector<size_t> erase_pos(N);
    for (size_t i = 0; i < N; ++i) erase_pos[i] = (size_t)r.below(N - i);  // позиция в текущей длине
    struct V { const char* name; Res (*f)(const std::vector<int>&, const std::vector<size_t>&); };
    V vs[] = {{"list_linear", run_list}, {"vector_linear", run_vec_linear}, {"vector_binary", run_vec_binary}};
    for (auto& v : vs) {
      // маленькие N повторяем несколько раз, берём минимум
      int reps = N <= 1000 ? 20 : (N <= 10000 ? 5 : 1);
      Res best{1e300, 1e300};
      for (int i = 0; i < reps; ++i) {
        Res x = v.f(keys, erase_pos);
        if (x.ins + x.era < best.ins + best.era) best = x;
      }
      std::printf("%s,%zu,%.3f,%.3f,%.3f,%.1f,%.1f\n", v.name, N, best.ins, best.era, best.ins + best.era,
                  best.ins * 1e6 / N, best.era * 1e6 / N);
      std::fflush(stdout);
    }
  }
}
