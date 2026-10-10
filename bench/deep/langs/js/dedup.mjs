// dedup.mjs — «одна строчка» в JS (V8): new Set(ids) против sort.
// Ловушка 64-битных id: Number хранит целые точно только до 2^53, а Smi в V8 —
// только до 2^31 (Node без pointer compression). Поэтому входы трёх видов:
//   num53  — Number из 53 бит (splitmix64 >> 11): HeapNumber-объекты, точные
//   smi31  — Number из 31 бита: Smi, хранятся прямо в массиве
//   big64  — BigInt из 64 бит: объекты в куче, точные
//   str64  — строка (hex) из 64 бит: как часто делают с id в JSON
// Варианты: Set, Array.from(new Set()), sort с компаратором + проход, typed-array sort,
// Array.prototype.sort() БЕЗ компаратора (строковое сравнение — вторая ловушка).
// CSV: scenario,input,variant,ms_median,ns_per_elem
const N = parseInt(process.argv[2] || String(1 << 20));
const REPS = 7, WARM = 3;

function splitmix(seed, n) {
  const out = new BigUint64Array(n);
  let s = BigInt(seed);
  const M = (1n << 64n) - 1n;
  for (let i = 0; i < n; i++) {
    s = (s + 0x9e3779b97f4a7c15n) & M;
    let z = s;
    z = ((z ^ (z >> 30n)) * 0xbf58476d1ce4e5b9n) & M;
    z = ((z ^ (z >> 27n)) * 0x94d049bb133111ebn) & M;
    out[i] = z ^ (z >> 31n);
  }
  return out;
}
function makeIdx(n, u, sorted) {
  // индексы ключей: u различных, остальные — повторы; перемешать или отсортировать по значению потом
  const idx = new Uint32Array(n);
  for (let i = 0; i < u; i++) idx[i] = i;
  let st = 12345;
  const rnd = () => { st = (st * 1103515245 + 12345) & 0x7fffffff; return st; };
  for (let i = u; i < n; i++) idx[i] = rnd() % u;
  if (!sorted) for (let i = n - 1; i > 0; i--) { const j = rnd() % (i + 1); const t = idx[i]; idx[i] = idx[j]; idx[j] = t; }
  return idx;
}
function bench(scen, input, name, fn, expected) {
  const ts = [];
  for (let r = 0; r < WARM + REPS; r++) {
    const t0 = process.hrtime.bigint();
    const cnt = fn();
    const t1 = process.hrtime.bigint();
    if (cnt !== expected) throw new Error(`${name}: ${cnt} != ${expected}`);
    if (r >= WARM) ts.push(Number(t1 - t0) / 1e6);
  }
  ts.sort((a, b) => a - b);
  const med = ts[ts.length >> 1];
  console.log(`${scen},${input},${name},${med.toFixed(2)},${(med * 1e6 / N).toFixed(1)}`);
}
function uniqSortedPass(a) { let w = 0; for (let i = 0; i < a.length; i++) if (i === 0 || a[i] !== a[i - 1]) a[w++] = a[i]; return w; }

console.log("scenario,input,variant,ms_median,ns_per_elem");
const keys64 = splitmix(17, N);
for (const [scen, u, sorted] of [["U=N random", N, false], ["U=N sorted", N, true], ["U=1% random", Math.max(1, N / 100 | 0), false]]) {
  const idx = makeIdx(N, u, sorted);
  // num53: Number (точно, HeapNumber), smi31, big64, str64
  const inputs = {
    num53: Array.from(idx, i => Number(keys64[i] >> 11n)),
    smi31: Array.from(idx, i => Number(keys64[i] >> 33n)),
    big64: Array.from(idx, i => keys64[i]),
    str64: Array.from(idx, i => keys64[i].toString(16)),
  };
  if (sorted) for (const k of Object.keys(inputs)) inputs[k].sort(k === 'str64' ? undefined : (a, b) => (a < b ? -1 : a > b ? 1 : 0));
  for (const [iname, arr] of Object.entries(inputs)) {
    const expected = u;
    bench(scen, iname, "set", () => new Set(arr).size, expected);
    bench(scen, iname, "array_from_set", () => Array.from(new Set(arr)).length, expected);
    if (iname !== 'str64') {
      bench(scen, iname, "sort_cmp_unique", () => { const a = arr.slice(); a.sort((x, y) => (x < y ? -1 : x > y ? 1 : 0)); return uniqSortedPass(a); }, expected);
    }
    bench(scen, iname, "sort_default_unique", () => { const a = arr.slice(); a.sort(); return uniqSortedPass(a); }, iname === 'str64' || iname === 'smi31' || iname === 'num53' ? (() => { const a = arr.slice(); a.sort(); return uniqSortedPass(a); })() : expected);
    if (iname === 'num53' || iname === 'smi31') {
      bench(scen, iname, "float64array_sort", () => { const a = Float64Array.from(arr); a.sort(); return uniqSortedPass(a); }, expected);
    }
    if (iname === 'big64') {
      bench(scen, iname, "biguint64array_sort", () => { const a = BigUint64Array.from(arr); a.sort(); return uniqSortedPass(a); }, expected);
    }
  }
}
console.log(`# node ${process.version} v8 ${process.versions.v8}`);
