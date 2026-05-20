# 🥜 Testicles

**Testicles** — the Zeta-native benchmark suite that packs a punch.

Statistics-driven microbenchmarking with no external runtime and no useless ceremony.

| Test                        | Result      |
|-----------------------------|-------------|
| Does it compile?            | ✅          |
| Are the numbers real?       | ✅          |
| Is it pure Zeta?            | ✅‍⬛           |
| Will it stack up?           | You bet 🫡 |

## 🔬 What's in the Package?

Testicles gives you the tools to measure what matters:

| Module          | What it does                                           |
|-----------------|--------------------------------------------------------|
| `timing.z`      | Nanosecond-precision walls — see how fast it really is |
| `runner.z`      | Warm-up, iterate, sample — the workout you need        |
| `statistics.z`  | Mean, median, std dev, percentiles — the full package  |
| `comparison.z`  | A/B your code — because one testicle is never enough   |
| `report::text`  | Pretty tables so everyone can admire your numbers      |

## 🧪 Usage

```zeta
use testicles;

fn bench_something() {
    let mut sum: i64 = 0;
    let mut i: i64 = 0;
    while i < 1000 {
        sum += i * i;
        i += 1;
    }
    _ = sum;
}

fn main() {
    testicles::bench_group("my first workout", [
        testicles::bench_function("square sum 1000", bench_something),
    ]);
}
```

## 📊 The Nuts and Bolts

### Warm-up

Every benchmark gets a warm-up phase — because nobody performs cold. 🥶

```
  bench_name ... ⏳ warming up... ✅
```

### Measurement

100 samples collected per benchmark, with automatic iteration count estimation to fill the minimum measurement window (100ms default). No guesswork — just hard numbers.

### Statistics

We calculate:

| Stat            | What it measures                       | Emoji        |
|-----------------|----------------------------------------|--------------|
| Mean            | Average time per iteration             | ⚖️           |
| Std Dev         | How consistent your code is            | 🎯           |
| CV              | Normalized variation (ratio brain)     | 📐           |
| Median          | The middle of the pack                 | 🎪           |
| P95 / P99       | Tail latency — the squeaky wheels      | 🐌           |
| Slope           | Drift over run — is it getting slower? | 📈           |

## 🧪 Example Output

```
testicles demo benchmarks
-------------------------
  sum 1000 squares ... ⏱

  Benchmark                          Mean      Std Dev       CV     Median  Throughput
  --------------------------------------------------------------------------------
  sum 1000 squares               123.45 ns    12.34 ns    10.0%   120.00 ns    8.1 M/s
  fill 1024 array                456.78 ns    45.67 ns    10.0%   450.00 ns    2.2 M/s
  concat 100 strings              89.01 us     8.90 us    10.0%    88.00 us   11.2 K/s
  modulo 10000                     5.67 us     0.57 us    10.0%     5.50 us  176.4 K/s
```

## 🏋️ Why "Testicles"?

Because real benchmarks have **balls**. 💪

We named it for what it does — it tests your code's **ticks** (timing) and gives you the **cles** (cycles). Also, it's a great conversation starter at parties:

> "What's your testicles look like?"
> "Solid 99th percentile, two standard deviations under the mean."

## 🚀 Quick Start

```bash
# Clone
git clone https://github.com/murphsicles/testicles.git
cd testicles

# Run the example
zetac tests/example.z

# Bench your own code
zetac src/testicles.z
```

## 🔨 API Reference

### `testicles::bench_function(name: string, func: fn()) -> Benchmark`

Wraps a function into a benchmark ready for group evaluation. The `name` is what shows up in your report tables — make it descriptive, make it proud.

### `testicles::bench_group(name: string, benches: []Benchmark)`

Runs a full benchmark suite, prints a formatted summary. Groups are the main event — gather your benchmarks, run them together, compare like-for-like.

### `runner::run_benchmark(name: string, body: fn()) -> BenchResults`

The low-level entry. Returns raw sample data for custom analysis.

### `runner::analyze(results: BenchResults) -> Analysis`

Turns raw timing data into statistically meaningful results: mean, std dev, median, percentiles, slope, and more.

### `statistics::comparison(old: Analysis, new: Analysis) -> Comparison`

Compare two runs head-to-head. Detect statistically significant changes. Know if your "optimization" actually made things worse (we've all been there 🫣).

## 🔄 Comparison Detection

When you have two runs of the same benchmark:

```zeta
use comparison;

let comparison_result = comparison::compare("my bench", old_analysis, new_analysis);
```

If the difference exceeds 3× the pooled standard error, it's flagged as significant:

| Direction   | Meaning                          | Emoji     |
|-------------|----------------------------------|-----------|
| `improved`  | Your change actually helped      | ✅ faster |
| `regressed` | You made it worse — congrats 🎉  | 🐢 slower |
| `unchanged` | Noise. Try harder next time.     | ➡ same   |

## 📋 License

MIT — because benchmarks should be free, just like your hot takes.

---

*Built for the Zeta ecosystem by [murphsicles](https://github.com/murphsicles).*
