// main.rs — «одна строчка» в Rust: sort_unstable+dedup против HashSet<u64>.
// Вход: N = 2^20 64-битных id (splitmix64, seed 17). В таймере — вся операция.
// Варианты:
//   sort_unstable_dedup  ipnsort (Rust ≥ 1.81) + Vec::dedup
//   sort_stable_dedup    driftsort (стабильный) + dedup
//   hashset_sip          HashSet<u64> с хешером по умолчанию (SipHash-1-3, случайный сид), with_capacity
//   hashset_sip_nocap    то же без with_capacity
//   hashset_mul          та же hashbrown-таблица, но хешер = умножение на константу (как fastutil)
//   hashset_identity     хешер-тождество (как std::hash в C++)
// Печатает CSV: scenario,variant,ms_median,ns_per_elem
use std::collections::HashSet;
use std::hash::{BuildHasher, Hasher};
use std::time::Instant;

fn mix64(mut z: u64) -> u64 {
    z = (z ^ (z >> 30)).wrapping_mul(0xbf58476d1ce4e5b9);
    z = (z ^ (z >> 27)).wrapping_mul(0x94d049bb133111eb);
    z ^ (z >> 31)
}
struct Sm(u64);
impl Sm {
    fn next(&mut self) -> u64 { self.0 = self.0.wrapping_add(0x9e3779b97f4a7c15); mix64(self.0) }
    fn below(&mut self, n: u64) -> u64 { ((self.next() as u128 * n as u128) >> 64) as u64 }
}
fn make_input(n: usize, u: usize, sorted: bool) -> Vec<u64> {
    let mut r = Sm(17);
    let keys: Vec<u64> = (0..u).map(|_| r.next()).collect();
    let mut a = keys.clone();
    while a.len() < n { let k = keys[r.below(u as u64) as usize]; a.push(k); }
    if sorted { a.sort_unstable(); } else {
        for i in (1..n).rev() { let j = r.below(i as u64 + 1) as usize; a.swap(i, j); }
    }
    a
}

#[derive(Default, Clone)]
struct MulHasher(u64);
impl Hasher for MulHasher {
    fn finish(&self) -> u64 { self.0 }
    fn write(&mut self, _b: &[u8]) { unreachable!() }
    fn write_u64(&mut self, x: u64) {
        // fastutil HashCommon.mix: умножение на золотое сечение + сдвиг
        let h = x.wrapping_mul(0x9E3779B97F4A7C15);
        self.0 = h ^ (h >> 32);
    }
}
#[derive(Default, Clone)]
struct MulBuild;
impl BuildHasher for MulBuild { type Hasher = MulHasher; fn build_hasher(&self) -> MulHasher { MulHasher(0) } }

#[derive(Default, Clone)]
struct IdHasher(u64);
impl Hasher for IdHasher {
    fn finish(&self) -> u64 { self.0 }
    fn write(&mut self, _b: &[u8]) { unreachable!() }
    fn write_u64(&mut self, x: u64) { self.0 = x; }
}
#[derive(Default, Clone)]
struct IdBuild;
impl BuildHasher for IdBuild { type Hasher = IdHasher; fn build_hasher(&self) -> IdHasher { IdHasher(0) } }

fn via_set<B: BuildHasher + Default>(a: &[u64], cap: bool) -> Vec<u64> {
    let mut s: HashSet<u64, B> = if cap { HashSet::with_capacity_and_hasher(a.len(), B::default()) } else { HashSet::with_hasher(B::default()) };
    for &x in a { s.insert(x); }
    s.into_iter().collect()
}

fn main() {
    let args: Vec<String> = std::env::args().collect();
    let n: usize = args.get(1).map(|s| s.parse().unwrap()).unwrap_or(1 << 20);
    let reps = 7; let warm = 3;
    println!("scenario,variant,ms_median,ns_per_elem");
    let algs: Vec<(&str, Box<dyn Fn(&mut Vec<u64>) -> usize>)> = vec![
        ("sort_unstable_dedup", Box::new(|a| { a.sort_unstable(); a.dedup(); a.len() })),
        ("sort_stable_dedup", Box::new(|a| { a.sort(); a.dedup(); a.len() })),
        ("hashset_sip", Box::new(|a| via_set::<std::hash::RandomState>(a, true).len())),
        ("hashset_sip_nocap", Box::new(|a| via_set::<std::hash::RandomState>(a, false).len())),
        ("hashset_mul", Box::new(|a| via_set::<MulBuild>(a, true).len())),
        ("hashset_identity", Box::new(|a| via_set::<IdBuild>(a, true).len())),
    ];
    let scen = [("U=N random", n, false), ("U=N sorted", n, true), ("U=1% random", (n / 100).max(1), false)];
    for (name, u, sorted) in scen {
        let input = make_input(n, u, sorted);
        let mut buf = vec![0u64; n];
        for (an, f) in &algs {
            let mut ts = Vec::new();
            for r in 0..warm + reps {
                buf.copy_from_slice(&input);
                let t0 = Instant::now();
                let cnt = f(&mut buf);
                let dt = t0.elapsed().as_secs_f64() * 1e3;
                assert_eq!(cnt, u, "{an}");
                if r >= warm { ts.push(dt); }
            }
            ts.sort_by(|a, b| a.partial_cmp(b).unwrap());
            let med = ts[ts.len() / 2];
            println!("{name},{an},{med:.2},{:.1}", med * 1e6 / n as f64);
        }
    }
    eprintln!("# rustc {}", option_env!("RUSTC_VERSION").unwrap_or("?"));
}
