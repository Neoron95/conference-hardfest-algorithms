// HashBench — те же замеры, что на Xeon (CI) и Mac, но на iPhone.
// Каждая программа замера — обычный C++ main (переименован флагом -Dmain=…); её stdout
// перенаправляется в CSV в Documents/results/<метка>/. Три режима QoS: userInitiated (P-ядра),
// utility и background (на iPhone — E-ядра). Счётчиков процессора на iOS нет — только время.
#import <UIKit/UIKit.h>
#include <fcntl.h>
#include <sys/sysctl.h>
#include <unistd.h>
#include <atomic>
#include <functional>
#include <string>
#include <vector>

int dedup_main(int, char**);
int probe_main(int, char**);
int mlp_main(int, char**);
int sortfam_main(int, char**);
int alloc_main(int, char**);
typedef int (*MainFn)(int, char**);

static NSString* SysctlString(const char* name) {
  size_t len = 0;
  if (sysctlbyname(name, NULL, &len, NULL, 0) != 0 || len == 0) return @"";
  std::string buf(len, '\0');
  if (sysctlbyname(name, buf.data(), &len, NULL, 0) != 0) return @"";
  return [NSString stringWithUTF8String:buf.c_str()];
}

static long long SysctlInt(const char* name) {
  long long v = 0;
  size_t len = sizeof(v);
  if (sysctlbyname(name, &v, &len, NULL, 0) != 0) return -1;
  return v;  // 4-байтные ключи ложатся в младшие байты (little-endian)
}

static NSString* ThermalName() {
  switch (NSProcessInfo.processInfo.thermalState) {
    case NSProcessInfoThermalStateNominal: return @"nominal";
    case NSProcessInfoThermalStateFair: return @"fair";
    case NSProcessInfoThermalStateSerious: return @"serious";
    case NSProcessInfoThermalStateCritical: return @"critical";
  }
  return @"?";
}

static std::string S(size_t n) { return std::to_string(n); }

// ---------------------------------------------------------------- прогон

struct Bench {
  std::string dir, label;
  std::function<void(NSString*)> log;
  std::atomic<bool>* stop = nullptr;
  int failures = 0;

  std::string path(const std::string& f) const { return dir + "/" + f; }
  bool exists(const std::string& f) const { return access(path(f).c_str(), F_OK) == 0; }

  void append(const std::string& f, const std::string& line) const {
    FILE* fp = fopen(path(f).c_str(), "a");
    if (fp) { fputs(line.c_str(), fp); fclose(fp); }
  }

  // Вызвать main программы с аргументами; stdout → файл f, stderr → stderr.log.
  int call(MainFn fn, const std::string& f, const std::vector<std::string>& args) {
    std::vector<std::string> a{"bench"};
    a.insert(a.end(), args.begin(), args.end());
    std::vector<char*> argv;
    for (auto& s : a) argv.push_back(const_cast<char*>(s.c_str()));
    argv.push_back(nullptr);
    fflush(stdout);
    fflush(stderr);
    int fo = open(path(f).c_str(), O_WRONLY | O_CREAT | O_APPEND, 0644);
    int fe = open(path("stderr.log").c_str(), O_WRONLY | O_CREAT | O_APPEND, 0644);
    int so = dup(1), se = dup(2);
    dup2(fo, 1);
    dup2(fe, 2);
    int rc = fn((int)a.size(), argv.data());
    fflush(stdout);
    fflush(stderr);
    dup2(so, 1);
    dup2(se, 2);
    close(so); close(se); close(fo); close(fe);
    return rc;
  }

  // Перегрев: ждём, пока телефон остынет (до 5 минут), иначе P-ядра сбросят частоту.
  void waitCool() {
    for (int i = 0; i < 20 && !*stop; ++i) {
      if (NSProcessInfo.processInfo.thermalState < NSProcessInfoThermalStateSerious) return;
      log([NSString stringWithFormat:@"перегрев (%@) — пауза 15 с", ThermalName()]);
      sleep(15);
    }
  }

  void step(const std::string& what) {
    UIDevice* d = UIDevice.currentDevice;
    NSString* line = [NSString stringWithFormat:@"[%@] thermal=%@ battery=%.0f%% %s\n",
                      [NSDateFormatter localizedStringFromDate:[NSDate date] dateStyle:NSDateFormatterNoStyle
                                                     timeStyle:NSDateFormatterMediumStyle],
                      ThermalName(), d.batteryLevel * 100.0, what.c_str()];
    append("run.log", line.UTF8String);
    log([NSString stringWithUTF8String:what.c_str()]);
  }

  void dedup(const std::string& exp, const std::string& qos, std::vector<std::string> args) {
    if (*stop) return;
    const std::string f = exp + ".csv";
    if (!exists(f)) call(dedup_main, f, {"--header"});
    waitCool();
    std::string shown;
    for (auto& s : args) shown += " " + s;
    step(exp + " " + qos + shown);
    std::vector<std::string> a{"--exp", exp, "--session", label + "/" + qos, "--qos", qos, "--blocks", "7"};
    a.insert(a.end(), args.begin(), args.end());
    if (call(dedup_main, f, a) != 0) { ++failures; step("FAILED " + exp); }
  }

  void prog(MainFn fn, const std::string& name, std::vector<std::string> args) {
    if (*stop) return;
    waitCool();
    std::string shown;
    for (auto& s : args) shown += " " + s;
    step(name + shown);
    if (call(fn, name + ".csv", args) != 0) { ++failures; step("FAILED " + name); }
  }

  void phases(const std::string& qos, size_t n, size_t u) {
    if (*stop) return;
    if (!exists("E11_phases.csv"))
      append("E11_phases.csv", "session,toolchain,set,N,U,insert_ns_el,unload_ns_el,dtor_ns_el,total_ns_el\n");
    waitCool();
    step("phases " + qos + " U=" + S(u));
    call(dedup_main, "E11_phases.csv", {"--phases", "--n", S(n), "--u", S(u), "--session", label + "/" + qos, "--qos", qos});
  }

  // Память телефона: пул входов меньше, чем на Mac/Xeon (64), для больших N — иначе jetsam.
  static std::vector<std::string> pool(size_t n) {
    return {"--pool", n <= (256u << 10) ? "64" : n <= (1u << 20) ? "16" : "8"};
  }
  void curve(const std::string& exp, const std::string& qos, size_t n, size_t u) {
    auto a = std::vector<std::string>{"--n", S(n), "--u", S(u), "--algs", "sort,uset,radix,flat"};
    auto p = pool(n);
    a.insert(a.end(), p.begin(), p.end());
    dedup(exp, qos, a);
  }

  void plan(const std::string& qos) {
    const size_t M = 1u << 20;
    const bool fast = qos == "ui";
    prog(probe_main, "probe", {"--qos", qos});
    curve("E1", qos, M, M);
    // Карта победителей: U = N/2 (E2), U = N (E2U), U = N/10 (E2D)
    std::vector<size_t> sizes = fast ? std::vector<size_t>{16, 64, 256, 1024, 4096, 16384, 65536, 131072, 262144,
                                                           524288, M, 2 * M, 4 * M}
                                     : std::vector<size_t>{1024, 16384, 65536, 262144, 524288, M, 2 * M, 4 * M};
    if (qos == "background") sizes = {16384, 65536, 262144, 524288, M};
    for (size_t n : sizes) {
      curve("E2", qos, n, n / 2);
      if (n >= 1024) curve("E2U", qos, n, n);
      if (n >= 1024) curve("E2D", qos, n, n / 10);
    }
    phases(qos, M, M);
    phases(qos, M, M / 2);
    prog(alloc_main, "alloc", {"--qos", qos, "--n", S(M), "--u", S(M)});
    prog(mlp_main, "mlp", {"--qos", qos});
    prog(sortfam_main, "sortfam", {"--qos", qos});
    dedup("E8", qos, {"--keys", "e8", "--nlocal", S(M), "--n", S(M + 65536), "--pool", "16",
                      "--algs", "sort,uset,radix,flat,merge_inplace,merge_union"});
    for (const char* o : {"random", "runs", "sorted"})
      dedup("E4", qos, {"--n", S(M), "--u", S(M / 2), "--order", o, "--pool", "16"});
    if (!fast) return;
    dedup("E3", qos, {"--n", S(M), "--u", "1", "--variant", "all_equal", "--pool", "16"});
    for (const char* f : {"0.01", "0.1", "0.5", "1"})
      dedup("E3", qos, {"--n", S(M), "--ufrac", f, "--variant", std::string("ufrac_") + f, "--pool", "16"});
    const std::vector<std::string> e5{"--n", "1024", "--u", "512", "--algs", "sort", "--work", S(M), "--blocks", "9"};
    auto e5v = [&](const char* p, const char* b, const char* v) {
      auto a = e5;
      a.insert(a.end(), {"--pool", p, "--batch", b, "--variant", v});
      dedup("E5", qos, a);
    };
    e5v("1", "1", "a_one_array_restored");
    e5v("1", "64", "b_64_identical_copies");
    e5v("64", "64", "c_64_different");
    for (const char* p : {"2", "4", "8", "16"}) e5v(p, "1", (std::string("f_") + p + "_different_one_buffer").c_str());
  }
};

// ---------------------------------------------------------------- экран

@interface ViewController : UIViewController
@end

@implementation ViewController {
  UITextView* _log;
  UILabel* _status;
  NSMutableArray<UIButton*>* _buttons;
  NSString* _dir;
  NSDate* _start;
  NSTimer* _timer;
  BOOL _running;
  std::atomic<bool> _stop;
}

- (UIButton*)button:(NSString*)title action:(SEL)sel {
  UIButtonConfiguration* cfg = [UIButtonConfiguration filledButtonConfiguration];
  cfg.title = title;
  UIButton* b = [UIButton buttonWithConfiguration:cfg primaryAction:nil];
  [b addTarget:self action:sel forControlEvents:UIControlEventTouchUpInside];
  [_buttons addObject:b];
  return b;
}

- (void)viewDidLoad {
  [super viewDidLoad];
  self.view.backgroundColor = UIColor.systemBackgroundColor;
  _buttons = [NSMutableArray array];
  _stop = false;
  UILabel* title = [UILabel new];
  title.text = @"HashBench: sort против хеша";
  title.font = [UIFont boldSystemFontOfSize:22];
  _status = [UILabel new];
  _status.numberOfLines = 0;
  _status.font = [UIFont monospacedDigitSystemFontOfSize:14 weight:UIFontWeightRegular];
  _status.text = @"Перед стартом: заряд ≥ 80 %, кабель отключён, авиарежим, энергосбережение выключено.";
  UIStackView* row1 = [[UIStackView alloc] initWithArrangedSubviews:@[
    [self button:@"Всё подряд" action:@selector(runAll)],
    [self button:@"Стоп" action:@selector(stopRun)],
  ]];
  UIStackView* row2 = [[UIStackView alloc] initWithArrangedSubviews:@[
    [self button:@"ui" action:@selector(runUI)],
    [self button:@"utility" action:@selector(runUtility)],
    [self button:@"background" action:@selector(runBackground)],
  ]];
  for (UIStackView* r in @[ row1, row2 ]) { r.spacing = 8; r.distribution = UIStackViewDistributionFillEqually; }
  UIButton* share = [self button:@"Поделиться результатами" action:@selector(share:)];
  _log = [UITextView new];
  _log.editable = NO;
  _log.font = [UIFont monospacedSystemFontOfSize:11 weight:UIFontWeightRegular];
  _log.backgroundColor = UIColor.secondarySystemBackgroundColor;
  UIStackView* stack = [[UIStackView alloc] initWithArrangedSubviews:@[ title, _status, row1, row2, share, _log ]];
  stack.axis = UILayoutConstraintAxisVertical;
  stack.spacing = 10;
  stack.translatesAutoresizingMaskIntoConstraints = NO;
  [self.view addSubview:stack];
  UILayoutGuide* g = self.view.safeAreaLayoutGuide;
  [NSLayoutConstraint activateConstraints:@[
    [stack.leadingAnchor constraintEqualToAnchor:g.leadingAnchor constant:16],
    [stack.trailingAnchor constraintEqualToAnchor:g.trailingAnchor constant:-16],
    [stack.topAnchor constraintEqualToAnchor:g.topAnchor constant:12],
    [stack.bottomAnchor constraintEqualToAnchor:g.bottomAnchor constant:-12],
  ]];
  UIDevice.currentDevice.batteryMonitoringEnabled = YES;
  [self appendLog:[NSString stringWithFormat:@"%@, iOS %@, %@", SysctlString("hw.machine"),
                   UIDevice.currentDevice.systemVersion, ThermalName()]];
}

- (void)appendLog:(NSString*)s {
  _log.text = [_log.text stringByAppendingFormat:@"%@\n", s];
  [_log scrollRangeToVisible:NSMakeRange(_log.text.length, 0)];
}

- (void)runAll { [self start:@[ @"ui", @"utility", @"background" ]]; }
- (void)runUI { [self start:@[ @"ui" ]]; }
- (void)runUtility { [self start:@[ @"utility" ]]; }
- (void)runBackground { [self start:@[ @"background" ]]; }
- (void)stopRun {
  if (_running) { _stop = true; [self appendLog:@"остановка после текущего шага…"]; }
}

- (NSString*)makeDir {
  NSDateFormatter* f = [NSDateFormatter new];
  f.dateFormat = @"yyyyMMdd-HHmm";
  NSString* label = [NSString stringWithFormat:@"iphone-%@", [f stringFromDate:[NSDate date]]];
  NSString* docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSString* dir = [[docs stringByAppendingPathComponent:@"results"] stringByAppendingPathComponent:label];
  [NSFileManager.defaultManager createDirectoryAtPath:dir withIntermediateDirectories:YES attributes:nil error:nil];
  return dir;
}

- (void)writeEnv:(Bench&)b {
  UIDevice* d = UIDevice.currentDevice;
  NSMutableString* s = [NSMutableString string];
  [s appendFormat:@"date: %@\nlabel: %s\n", [NSDate date], b.label.c_str()];
  [s appendFormat:@"hw.machine: %@\niOS: %@\n", SysctlString("hw.machine"), d.systemVersion];
  for (const char* k : {"hw.ncpu", "hw.perflevel0.physicalcpu", "hw.perflevel1.physicalcpu", "hw.perflevel0.l2cachesize",
                        "hw.perflevel1.l2cachesize", "hw.l1dcachesize", "hw.cachelinesize", "hw.memsize", "hw.pagesize"})
    [s appendFormat:@"%s: %lld\n", k, SysctlInt(k)];
  [s appendFormat:@"thermal: %@\nlowPowerMode: %d\nbattery: %.0f%% state=%ld\n", ThermalName(),
                  NSProcessInfo.processInfo.lowPowerModeEnabled, d.batteryLevel * 100.0, (long)d.batteryState];
  b.append("env.txt", s.UTF8String);
  b.call(dedup_main, "env.txt", {"--info"});
}

- (void)start:(NSArray<NSString*>*)qoses {
  if (_running) return;
  _running = YES;
  _stop = false;
  _dir = [self makeDir];
  _start = [NSDate date];
  UIApplication.sharedApplication.idleTimerDisabled = YES;  // экран не гаснет — иначе приложение уснёт
  [self appendLog:[NSString stringWithFormat:@"старт: %@ → %@", [qoses componentsJoinedByString:@", "], _dir.lastPathComponent]];
  __weak ViewController* weakSelf = self;
  _timer = [NSTimer scheduledTimerWithTimeInterval:1 repeats:YES block:^(NSTimer* t) {
    ViewController* vc = weakSelf;
    if (!vc) return;
    int sec = (int)-[vc->_start timeIntervalSinceNow];
    vc->_status.text = [NSString stringWithFormat:@"идёт %d:%02d · %@ · не блокируйте экран", sec / 60, sec % 60, ThermalName()];
  }];
  NSString* dir = _dir;
  std::atomic<bool>* stop = &_stop;
  NSThread* worker = [[NSThread alloc] initWithBlock:^{
    Bench b;
    b.dir = dir.UTF8String;
    b.label = dir.lastPathComponent.UTF8String;
    b.stop = stop;
    b.log = [weakSelf](NSString* m) { dispatch_async(dispatch_get_main_queue(), ^{ [weakSelf appendLog:m]; }); };
    Bench* bp = &b;  // блок копирует C++-объекты как const — передаём указатель
    dispatch_sync(dispatch_get_main_queue(), ^{ [weakSelf writeEnv:*bp]; });
    for (NSString* q in qoses) b.plan(q.UTF8String);
    int fails = b.failures;
    BOOL stopped = stop->load();
    dispatch_async(dispatch_get_main_queue(), ^{
      ViewController* vc = weakSelf;
      if (!vc) return;
      [vc->_timer invalidate];
      vc->_running = NO;
      UIApplication.sharedApplication.idleTimerDisabled = NO;
      int sec = (int)-[vc->_start timeIntervalSinceNow];
      vc->_status.text = [NSString stringWithFormat:@"%@ за %d:%02d, ошибок: %d. Нажмите «Поделиться».",
                                                    stopped ? @"остановлено" : @"готово", sec / 60, sec % 60, fails];
      [vc appendLog:vc->_status.text];
    });
  }];
  worker.stackSize = 16 << 20;
  worker.qualityOfService = NSQualityOfServiceUserInitiated;
  [worker start];
}

- (void)share:(UIButton*)sender {
  NSString* docs = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
  NSURL* results = [NSURL fileURLWithPath:[docs stringByAppendingPathComponent:@"results"] isDirectory:YES];
  // Папку results целиком — одним zip (NSFileCoordinator умеет запаковывать каталог для отправки).
  __block NSURL* zip = nil;
  NSError* err = nil;
  [[[NSFileCoordinator alloc] initWithFilePresenter:nil]
      coordinateReadingItemAtURL:results options:NSFileCoordinatorReadingForUploading error:&err
      byAccessor:^(NSURL* tmp) {
        NSURL* dst = [NSFileManager.defaultManager.temporaryDirectory URLByAppendingPathComponent:@"hashbench-results.zip"];
        [NSFileManager.defaultManager removeItemAtURL:dst error:nil];
        if ([NSFileManager.defaultManager copyItemAtURL:tmp toURL:dst error:nil]) zip = dst;
      }];
  if (!zip) { [self appendLog:[NSString stringWithFormat:@"не удалось упаковать: %@", err]]; return; }
  UIActivityViewController* av = [[UIActivityViewController alloc] initWithActivityItems:@[ zip ] applicationActivities:nil];
  av.popoverPresentationController.sourceView = sender;
  [self presentViewController:av animated:YES completion:nil];
}
@end

// ---------------------------------------------------------------- приложение

@interface SceneDelegate : UIResponder <UIWindowSceneDelegate>
@property(strong, nonatomic) UIWindow* window;
@end

@implementation SceneDelegate
- (void)scene:(UIScene*)scene willConnectToSession:(UISceneSession*)session options:(UISceneConnectionOptions*)options {
  self.window = [[UIWindow alloc] initWithWindowScene:(UIWindowScene*)scene];
  self.window.rootViewController = [ViewController new];
  [self.window makeKeyAndVisible];
}
@end

@interface AppDelegate : UIResponder <UIApplicationDelegate>
@end

@implementation AppDelegate
- (BOOL)application:(UIApplication*)application didFinishLaunchingWithOptions:(NSDictionary*)options {
  return YES;
}
@end

int main(int argc, char* argv[]) {
  @autoreleasepool {
    return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
  }
}
