// kperf.h — аппаратные счётчики Apple Silicon из пользовательского процесса (нужен sudo).
// Приватные kperf.framework / kperfdata.framework подгружаются через dlopen; события выбираются
// по именам из базы kpep текущего процессора (FIXED_CYCLES, FIXED_INSTRUCTIONS, ...).
// Схема вызовов — как в открытом примере ibireme/kpc_demo.c и в apple_arm_events.h Лемира.
// На Linux и без прав root init() вернёт false с понятной ошибкой.
#pragma once
#include <dlfcn.h>
#include <cstdint>
#include <cstdio>
#include <string>
#include <vector>

namespace kperf {

using kpc_config_t = uint64_t;
constexpr uint32_t KPC_CLASS_FIXED_MASK = 1u << 0;
constexpr uint32_t KPC_CLASS_CONFIGURABLE_MASK = 1u << 1;
constexpr int KPC_MAX_COUNTERS = 32;
struct kpep_db;
struct kpep_config;
struct kpep_event;

struct Api {
  int (*kpc_set_counting)(uint32_t) = nullptr;
  int (*kpc_set_thread_counting)(uint32_t) = nullptr;
  int (*kpc_set_config)(uint32_t, kpc_config_t*) = nullptr;
  int (*kpc_get_thread_counters)(uint32_t, uint32_t, uint64_t*) = nullptr;
  int (*kpc_force_all_ctrs_set)(int) = nullptr;
  int (*kpc_force_all_ctrs_get)(int*) = nullptr;
  int (*kpep_config_create)(kpep_db*, kpep_config**) = nullptr;
  void (*kpep_config_free)(kpep_config*) = nullptr;
  int (*kpep_config_add_event)(kpep_config*, kpep_event**, uint32_t, uint32_t*) = nullptr;
  int (*kpep_config_force_counters)(kpep_config*) = nullptr;
  int (*kpep_config_kpc)(kpep_config*, kpc_config_t*, size_t) = nullptr;
  int (*kpep_config_kpc_classes)(kpep_config*, uint32_t*) = nullptr;
  int (*kpep_config_kpc_count)(kpep_config*, size_t*) = nullptr;
  int (*kpep_config_kpc_map)(kpep_config*, size_t*, size_t) = nullptr;
  int (*kpep_db_create)(const char*, kpep_db**) = nullptr;
  void (*kpep_db_free)(kpep_db*) = nullptr;
  int (*kpep_db_event)(kpep_db*, const char*, kpep_event**) = nullptr;
};

template <class F>
static bool sym(void* lib, const char* name, F& out, std::string& err) {
  out = reinterpret_cast<F>(dlsym(lib, name));
  if (!out) err += std::string("нет символа ") + name + "; ";
  return out != nullptr;
}

class Counters {
 public:
  // wanted: для каждого события — список имён-вариантов; берётся первое, известное базе kpep.
  bool init(const std::vector<std::vector<std::string>>& wanted, std::string& err) {
    void* kperf = dlopen("/System/Library/PrivateFrameworks/kperf.framework/kperf", RTLD_LAZY);
    void* kpdata = dlopen("/System/Library/PrivateFrameworks/kperfdata.framework/kperfdata", RTLD_LAZY);
    if (!kperf || !kpdata) { err = "kperf.framework не найден (это не macOS?)"; return false; }
    bool ok = true;
    ok &= sym(kperf, "kpc_set_counting", api_.kpc_set_counting, err);
    ok &= sym(kperf, "kpc_set_thread_counting", api_.kpc_set_thread_counting, err);
    ok &= sym(kperf, "kpc_set_config", api_.kpc_set_config, err);
    ok &= sym(kperf, "kpc_get_thread_counters", api_.kpc_get_thread_counters, err);
    ok &= sym(kperf, "kpc_force_all_ctrs_set", api_.kpc_force_all_ctrs_set, err);
    ok &= sym(kperf, "kpc_force_all_ctrs_get", api_.kpc_force_all_ctrs_get, err);
    ok &= sym(kpdata, "kpep_config_create", api_.kpep_config_create, err);
    ok &= sym(kpdata, "kpep_config_free", api_.kpep_config_free, err);
    ok &= sym(kpdata, "kpep_config_add_event", api_.kpep_config_add_event, err);
    ok &= sym(kpdata, "kpep_config_force_counters", api_.kpep_config_force_counters, err);
    ok &= sym(kpdata, "kpep_config_kpc", api_.kpep_config_kpc, err);
    ok &= sym(kpdata, "kpep_config_kpc_classes", api_.kpep_config_kpc_classes, err);
    ok &= sym(kpdata, "kpep_config_kpc_count", api_.kpep_config_kpc_count, err);
    ok &= sym(kpdata, "kpep_config_kpc_map", api_.kpep_config_kpc_map, err);
    ok &= sym(kpdata, "kpep_db_create", api_.kpep_db_create, err);
    ok &= sym(kpdata, "kpep_db_free", api_.kpep_db_free, err);
    ok &= sym(kpdata, "kpep_db_event", api_.kpep_db_event, err);
    if (!ok) return false;
    int force = 0;
    if (api_.kpc_force_all_ctrs_get(&force) != 0) { err = "нет прав: запустите через sudo"; return false; }
    kpep_db* db = nullptr;
    if (api_.kpep_db_create(nullptr, &db) != 0 || !db) { err = "kpep_db_create: база событий не загрузилась"; return false; }
    kpep_config* cfg = nullptr;
    if (api_.kpep_config_create(db, &cfg) != 0 || !cfg) { err = "kpep_config_create"; return false; }
    if (api_.kpep_config_force_counters(cfg) != 0) { err = "kpep_config_force_counters"; return false; }
    for (auto& alts : wanted) {
      std::string got;
      for (auto& name : alts) {
        kpep_event* ev = nullptr;
        if (api_.kpep_db_event(db, name.c_str(), &ev) == 0 && ev &&
            api_.kpep_config_add_event(cfg, &ev, 0, nullptr) == 0) { got = name; break; }
      }
      names_.push_back(got);  // пустое имя — событие недоступно, в CSV будет -1
    }
    size_t count = 0;
    if (api_.kpep_config_kpc_classes(cfg, &classes_) != 0 || api_.kpep_config_kpc_count(cfg, &count) != 0 ||
        api_.kpep_config_kpc_map(cfg, map_, sizeof(map_)) != 0 || api_.kpep_config_kpc(cfg, regs_, sizeof(regs_)) != 0) {
      err = "kpep_config_kpc*: не удалось разложить события по счётчикам";
      return false;
    }
    if (api_.kpc_force_all_ctrs_set(1) != 0) { err = "kpc_force_all_ctrs_set: нет прав (sudo)"; return false; }
    if ((classes_ & KPC_CLASS_CONFIGURABLE_MASK) && count && api_.kpc_set_config(classes_, regs_) != 0) {
      err = "kpc_set_config";
      return false;
    }
    if (api_.kpc_set_counting(classes_) != 0 || api_.kpc_set_thread_counting(classes_) != 0) {
      err = "kpc_set_counting";
      return false;
    }
    ready_ = true;
    return true;
  }
  // Текущие значения выбранных событий для этого потока (-1 — событие недоступно).
  std::vector<int64_t> read() const {
    std::vector<int64_t> out(names_.size(), -1);
    if (!ready_) return out;
    uint64_t buf[KPC_MAX_COUNTERS] = {};
    if (api_.kpc_get_thread_counters(0, KPC_MAX_COUNTERS, buf) != 0) return out;
    size_t slot = 0;
    for (size_t i = 0; i < names_.size(); ++i)
      if (!names_[i].empty()) out[i] = (int64_t)buf[map_[slot++]];
    return out;
  }
  const std::vector<std::string>& names() const { return names_; }
  ~Counters() {
    if (ready_) { api_.kpc_set_counting(0); api_.kpc_set_thread_counting(0); api_.kpc_force_all_ctrs_set(0); }
  }

 private:
  Api api_;
  std::vector<std::string> names_;
  uint32_t classes_ = 0;
  size_t map_[KPC_MAX_COUNTERS] = {};
  kpc_config_t regs_[KPC_MAX_COUNTERS] = {};
  bool ready_ = false;
};

}  // namespace kperf
