// bw.cpp — полоса памяти потокового чтения/записи/копирования, 1 и T потоков, каждый на своём vCPU.
//   g++ -O3 -pthread bw.cpp -o build/bw && build/bw 1 && build/bw 4
#include <atomic>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <thread>
#include <vector>
#include <pthread.h>
#include <sched.h>

static double now_s() { return std::chrono::duration<double>(std::chrono::steady_clock::now().time_since_epoch()).count(); }
static const size_t MB = 1u << 20;

int main(int argc, char** argv) {
  int T = argc > 1 ? atoi(argv[1]) : 1;
  size_t mb = argc > 2 ? atoi(argv[2]) : 512;
  const size_t n = mb * MB / 8;
  std::vector<uint64_t*> src(T), dst(T);
  for (int t = 0; t < T; ++t) { src[t] = new uint64_t[n]; dst[t] = new uint64_t[n]; memset(src[t], 1, n * 8); memset(dst[t], 2, n * 8); }
  const char* names[] = {"read", "write", "copy"};
  for (int mode = 0; mode < 3; ++mode) {
    double best = 0;
    for (int rep = 0; rep < 3; ++rep) {
      std::atomic<int> go{0};
      std::vector<std::thread> th;
      std::vector<double> dur(T);
      std::vector<uint64_t> sink(T);
      for (int t = 0; t < T; ++t) th.emplace_back([&, t] {
        cpu_set_t cs; CPU_ZERO(&cs); CPU_SET(t % 4, &cs); pthread_setaffinity_np(pthread_self(), sizeof cs, &cs);
        uint64_t* s = src[t]; uint64_t* d = dst[t];
        while (!go.load()) {}
        double t0 = now_s();
        uint64_t acc0 = 0, acc1 = 0, acc2 = 0, acc3 = 0;
        if (mode == 0) { for (size_t i = 0; i + 4 <= n; i += 4) { acc0 += s[i]; acc1 += s[i + 1]; acc2 += s[i + 2]; acc3 += s[i + 3]; } }
        else if (mode == 1) { for (size_t i = 0; i < n; ++i) d[i] = i; }
        else { for (size_t i = 0; i < n; ++i) d[i] = s[i]; }
        dur[t] = now_s() - t0;
        sink[t] = acc0 + acc1 + acc2 + acc3 + d[n / 2];
      });
      go.store(1);
      for (auto& x : th) x.join();
      double maxd = 0; for (double d : dur) if (d > maxd) maxd = d;
      double bytes = (double)n * 8 * T * (mode == 2 ? 2 : 1);
      double gbs = bytes / maxd / 1e9;
      if (gbs > best) best = gbs;
      if (sink[0] == 42) printf("!");
    }
    printf("threads=%d,%s,%zu MB per thread,%.1f GB/s total,%.1f GB/s per thread\n", T, names[mode], mb, best, best / T);
  }
}
