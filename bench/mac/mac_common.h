// mac_common.h — общие помощники для замеров на Apple Silicon (M2 Pro): таймер, хеш,
// QoS (на какой тип ядер просимся), медиана. Собирается и на Linux — для проверки.
#pragma once
#include <algorithm>
#include <chrono>
#include <cstdint>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <string>
#include <vector>
#if defined(__APPLE__)
#include <pthread.h>
#include <pthread/qos.h>
#endif

static inline double now_ns() {
  return std::chrono::duration<double, std::nano>(std::chrono::steady_clock::now().time_since_epoch()).count();
}

// финализатор splitmix64 — биекция, годится и как хеш, и как генератор ключей
static inline uint64_t mix64(uint64_t z) {
  z += 0x9e3779b97f4a7c15ULL;
  z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9ULL;
  z = (z ^ (z >> 27)) * 0x94d049bb133111ebULL;
  return z ^ (z >> 31);
}

static inline double median(std::vector<double> v) {
  std::sort(v.begin(), v.end());
  size_t n = v.size();
  return n % 2 ? v[n / 2] : 0.5 * (v[n / 2 - 1] + v[n / 2]);
}

// QoS текущего потока: ui (userInitiated, P-ядра), utility, background (E-ядра на macOS), default.
// Возвращает имя, под которым реально работаем (для CSV).
static inline std::string set_qos(const std::string& q) {
#if defined(__APPLE__)
  qos_class_t c = QOS_CLASS_USER_INITIATED;
  if (q == "utility") c = QOS_CLASS_UTILITY;
  else if (q == "background") c = QOS_CLASS_BACKGROUND;
  else if (q == "default") c = QOS_CLASS_DEFAULT;
  else if (q == "interactive") c = QOS_CLASS_USER_INTERACTIVE;
  if (pthread_set_qos_class_self_np(c, 0) != 0) fprintf(stderr, "warning: QoS %s не выставлен\n", q.c_str());
  return q;
#else
  (void)q;
  return "n/a";
#endif
}

// Значение --qos из argv (по умолчанию ui); остальные аргументы не трогаем.
static inline std::string qos_from_args(int argc, char** argv) {
  for (int i = 1; i + 1 < argc; ++i)
    if (std::string(argv[i]) == "--qos") return argv[i + 1];
  return "ui";
}

// Память под рабочий набор: выровнена на 16 КиБ (страница macOS), уже тронута (вне таймера).
static inline void* alloc_touched(size_t bytes) {
  const size_t align = 16384;
  size_t sz = (bytes + align - 1) / align * align;
  void* p = nullptr;
  if (posix_memalign(&p, align, sz) != 0) { perror("posix_memalign"); exit(1); }
  memset(p, 0, sz);
  return p;
}
