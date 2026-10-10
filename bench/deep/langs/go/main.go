// main.go — «одна строчка» в Go: slices.Sort+slices.Compact против map[uint64]struct{}.
// Вход: N = 2^20 64-битных id (splitmix64, seed 17). В таймере — вся операция.
// Варианты:
//   sort_compact   slices.Sort (pdqsort) + slices.Compact
//   map_sized      make(map[uint64]struct{}, n) + вставки + выгрузка в []uint64
//   map_unsized    make(map[uint64]struct{}) без подсказки размера
//   map_keys_sorted map_sized + slices.Sort результата (контракт «отсортированный выход»)
// Собрать дважды: обычно (Swiss table, Go 1.24) и GOEXPERIMENT=noswissmap (старые бакеты).
// Печатает CSV: scenario,variant,ms_median,ns_per_elem,alloc_MB_per_call,mallocs_per_call
package main

import (
	"fmt"
	"math/rand/v2"
	"os"
	"runtime"
	"slices"
	"sort"
	"strconv"
)

func mix64(z uint64) uint64 {
	z = (z ^ (z >> 30)) * 0xbf58476d1ce4e5b9
	z = (z ^ (z >> 27)) * 0x94d049bb133111eb
	return z ^ (z >> 31)
}

func makeInput(n, u int, sorted bool) []uint64 {
	var s uint64 = 17
	keys := make([]uint64, u)
	for i := range keys {
		s += 0x9e3779b97f4a7c15
		keys[i] = mix64(s)
	}
	a := make([]uint64, n)
	copy(a, keys)
	r := rand.New(rand.NewPCG(17, 17))
	for i := u; i < n; i++ {
		a[i] = keys[r.IntN(u)]
	}
	if sorted {
		slices.Sort(a)
	} else {
		r.Shuffle(n, func(i, j int) { a[i], a[j] = a[j], a[i] })
	}
	return a
}

func sortCompact(a []uint64) int {
	slices.Sort(a)
	return len(slices.Compact(a))
}

func viaMap(a []uint64, sized bool) []uint64 {
	var m map[uint64]struct{}
	if sized {
		m = make(map[uint64]struct{}, len(a))
	} else {
		m = make(map[uint64]struct{})
	}
	for _, x := range a {
		m[x] = struct{}{}
	}
	out := make([]uint64, 0, len(m))
	for k := range m {
		out = append(out, k)
	}
	return out
}

func main() {
	n := 1 << 20
	reps, warm := 7, 3
	if len(os.Args) > 1 {
		n, _ = strconv.Atoi(os.Args[1])
	}
	fmt.Println("scenario,variant,ms_median,ns_per_elem,alloc_MB_per_call,mallocs_per_call")
	type alg struct {
		name string
		f    func([]uint64) int
	}
	algs := []alg{
		{"sort_compact", sortCompact},
		{"map_sized", func(a []uint64) int { return len(viaMap(a, true)) }},
		{"map_unsized", func(a []uint64) int { return len(viaMap(a, false)) }},
		{"map_keys_sorted", func(a []uint64) int { o := viaMap(a, true); slices.Sort(o); return len(o) }},
	}
	scen := []struct {
		name   string
		u      int
		sorted bool
	}{{"U=N random", n, false}, {"U=N sorted", n, true}, {"U=1% random", max(1, n/100), false}}
	for _, sc := range scen {
		input := makeInput(n, sc.u, sc.sorted)
		buf := make([]uint64, n)
		for _, al := range algs {
			ts := make([]float64, 0, reps)
			var allocMB, mallocs float64
			for r := 0; r < warm+reps; r++ {
				copy(buf, input)
				runtime.GC()
				var m0, m1 runtime.MemStats
				runtime.ReadMemStats(&m0)
				t0 := nanotime()
				cnt := al.f(buf)
				t1 := nanotime()
				runtime.ReadMemStats(&m1)
				if cnt != sc.u {
					panic(fmt.Sprintf("%s: %d != %d", al.name, cnt, sc.u))
				}
				if r >= warm {
					ts = append(ts, float64(t1-t0)/1e6)
					allocMB = float64(m1.TotalAlloc-m0.TotalAlloc) / 1048576
					mallocs = float64(m1.Mallocs - m0.Mallocs)
				}
			}
			sort.Float64s(ts)
			med := ts[len(ts)/2]
			fmt.Printf("%s,%s,%.2f,%.1f,%.1f,%.0f\n", sc.name, al.name, med, med*1e6/float64(n), allocMB, mallocs)
		}
	}
	fmt.Printf("# %s %s/%s GOEXPERIMENT=%q\n", runtime.Version(), runtime.GOOS, runtime.GOARCH, os.Getenv("GOEXPERIMENT"))
}
