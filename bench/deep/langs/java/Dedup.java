// Dedup.java — «одна строчка» на JVM: Arrays.sort(long[]) против HashSet<Long>.
// Вход: N = 2^20 64-битных id (splitmix64, seed 17). В таймере — вся операция:
// копия входа делается ДО таймера; результат — long[] уникальных.
// Варианты:
//   sort_unique     Arrays.sort(long[]) + проход по соседям + Arrays.copyOf
//   hashset         new HashSet<Long>(cap) + add в цикле + выгрузка в long[]
//   hashset_nocap   то же без начальной ёмкости
//   linkedhashset   LinkedHashSet<Long> (как Kotlin distinct())
//   stream_distinct LongStream.of(a).distinct().toArray()  (боксит внутри)
//   sorted_boxed    Long[] (boxed) + Arrays.sort(Object[]) = TimSort над объектами
// Печатает CSV: scenario,variant,ms_median,ns_per_elem,alloc_MB_per_call
import java.util.*;
import java.util.stream.*;
import java.lang.management.*;

public class Dedup {
    static long mix64(long z) {
        z = (z ^ (z >>> 30)) * 0xbf58476d1ce4e5b9L;
        z = (z ^ (z >>> 27)) * 0x94d049bb133111ebL;
        return z ^ (z >>> 31);
    }
    static long[] make(int n, int u, boolean sorted) {
        long s = 17; long[] keys = new long[u];
        for (int i = 0; i < u; i++) keys[i] = mix64(s += 0x9e3779b97f4a7c15L);
        long[] a = new long[n];
        System.arraycopy(keys, 0, a, 0, u);
        SplittableRandom r = new SplittableRandom(17);
        for (int i = u; i < n; i++) a[i] = keys[r.nextInt(u)];
        if (sorted) Arrays.sort(a);
        else for (int i = n - 1; i > 0; i--) { int j = r.nextInt(i + 1); long t = a[i]; a[i] = a[j]; a[j] = t; }
        return a;
    }
    static int sortUnique(long[] a) {
        Arrays.sort(a);
        int w = 0;
        for (int i = 0; i < a.length; i++) if (i == 0 || a[i] != a[i - 1]) a[w++] = a[i];
        return w;
    }
    static long[] hashSet(long[] a, boolean cap) {
        HashSet<Long> s = cap ? new HashSet<>((int) (a.length / 0.75f) + 1) : new HashSet<>();
        for (long x : a) s.add(x);              // боксинг Long.valueOf на каждый id
        long[] out = new long[s.size()]; int i = 0;
        for (long x : s) out[i++] = x;          // распаковка
        return out;
    }
    static long[] linkedHashSet(long[] a) {
        LinkedHashSet<Long> s = new LinkedHashSet<>((int) (a.length / 0.75f) + 1);
        for (long x : a) s.add(x);
        long[] out = new long[s.size()]; int i = 0;
        for (long x : s) out[i++] = x;
        return out;
    }
    static int sortedBoxed(long[] a) {
        Long[] b = new Long[a.length];
        for (int i = 0; i < a.length; i++) b[i] = a[i];
        Arrays.sort(b);                          // ComparableTimSort над Long[]
        int w = 0;
        for (int i = 0; i < b.length; i++) if (i == 0 || !b[i].equals(b[i - 1])) a[w++] = b[i];
        return w;
    }
    interface Alg { int run(long[] a); }
    public static void main(String[] args) {
        int N = args.length > 0 ? Integer.parseInt(args[0]) : 1 << 20;
        int REPS = args.length > 1 ? Integer.parseInt(args[1]) : 7, WARM = 3;
        com.sun.management.ThreadMXBean tm = (com.sun.management.ThreadMXBean) ManagementFactory.getThreadMXBean();
        System.out.println("scenario,variant,ms_median,ns_per_elem,alloc_MB_per_call");
        String[][] scen = {{"U=N random", "" + N, "0"}, {"U=N sorted", "" + N, "1"}, {"U=1% random", "" + Math.max(1, N / 100), "0"}};
        for (String[] sc : scen) {
            int U = Integer.parseInt(sc[1]); boolean sorted = sc[2].equals("1");
            long[] input = make(N, U, sorted);
            long[] buf = new long[N];
            LinkedHashMap<String, Alg> algs = new LinkedHashMap<>();
            algs.put("sort_unique", a -> sortUnique(a));
            algs.put("hashset", a -> hashSet(a, true).length);
            algs.put("hashset_nocap", a -> hashSet(a, false).length);
            algs.put("linkedhashset", a -> linkedHashSet(a).length);
            algs.put("stream_distinct", a -> LongStream.of(a).distinct().toArray().length);
            algs.put("sorted_boxed", a -> sortedBoxed(a));
            for (var e : algs.entrySet()) {
                double[] ts = new double[REPS]; double allocMB = 0;
                for (int r = 0; r < WARM + REPS; r++) {
                    System.arraycopy(input, 0, buf, 0, N);
                    System.gc();
                    long b0 = tm.getCurrentThreadAllocatedBytes();
                    long t0 = System.nanoTime();
                    int cnt = e.getValue().run(buf);
                    long t1 = System.nanoTime();
                    long b1 = tm.getCurrentThreadAllocatedBytes();
                    if (cnt != U) throw new IllegalStateException(e.getKey() + ": " + cnt + " != " + U);
                    if (r >= WARM) { ts[r - WARM] = (t1 - t0) / 1e6; allocMB = (b1 - b0) / 1048576.0; }
                }
                Arrays.sort(ts);
                double med = ts[REPS / 2];
                System.out.printf(Locale.ROOT, "%s,%s,%.2f,%.1f,%.1f%n", sc[0], e.getKey(), med, med * 1e6 / N, allocMB);
            }
        }
        System.out.println("# " + System.getProperty("java.vm.name") + " " + System.getProperty("java.version")
            + " " + ManagementFactory.getGarbageCollectorMXBeans().stream().map(g -> g.getName()).collect(Collectors.joining("/")));
    }
}
