// thrash.cpp — фоновая нагрузка на заданном vCPU: бесконечный memset по 8 МБ (L2 + часть L3).
#include <cstring>
#include <cstdlib>
#include <sched.h>
#include <pthread.h>
int main(int argc, char** argv) {
  cpu_set_t cs; CPU_ZERO(&cs); CPU_SET(atoi(argv[1]), &cs); pthread_setaffinity_np(pthread_self(), sizeof cs, &cs);
  size_t n = (argc > 2 ? atoi(argv[2]) : 8) << 20; char* b = (char*)malloc(n);
  for (unsigned k = 0;; ++k) memset(b, k, n);
}
