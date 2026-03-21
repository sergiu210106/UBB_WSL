# Assignment A4 – Simulated Annealing for the Knapsack Problem
**Course:** Metaheuristics  
**Lab:** 4  

---

## 1. Problem Definition

The **0/1 Knapsack Problem** is a classic combinatorial optimisation problem defined as follows:

- Given a set of *n* items, where each item *i* has a **weight** *w_i* and a **value** *v_i*, and a knapsack with a maximum **capacity** *W*,
- Find a binary selection vector **x** ∈ {0, 1}ⁿ that **maximises** the total value:

$$\text{maximise} \sum_{i=1}^{n} v_i \cdot x_i \quad \text{subject to} \quad \sum_{i=1}^{n} w_i \cdot x_i \leq W$$

A solution is encoded as a binary list of length *n*, where *x_i* = 1 means item *i* is included in the knapsack and *x_i* = 0 means it is excluded.

**Infeasibility penalty:** if a solution exceeds the capacity constraint, its fitness is set to 0, making it always dominated by any feasible solution.

Two problem instances were used:

| Instance | Items (n) | File |
|---|---|---|
| Small | 20 | `knapsack-20.txt` |
| Large | 200 | `knapsack-200.txt` |

---

## 2. Algorithm – Simulated Annealing

**Simulated Annealing (SA)** is a probabilistic local search metaheuristic inspired by the physical process of slowly cooling a heated material to reach a low-energy state. It extends hill climbing by occasionally accepting worsening moves with a probability that decreases as the temperature *T* lowers, allowing the search to escape local optima.

### 2.1 Pseudocode

```
t = 0
initialise T = T0
c = random_solution()
evaluate c
best = c

repeat                              ← outer loop (one temperature level)
    repeat                          ← inner loop (INNER_ITERS trials at current T)
        x = random_neighbour(c)     ← single random bit-flip
        if eval(x) > eval(c):
            c ← x                   ← always accept improvement
        else if random[0,1) < exp((eval(x) − eval(c)) / T):
            c ← x                   ← accept worsening move with Boltzmann probability
        if eval(c) > eval(best):
            best ← c
    until (inner termination condition)
    T ← g(T, t)                     ← apply cooling schedule
    t ← t + 1
until (T < T_min) OR (t ≥ max_outer_iters)

return best
```

### 2.2 Neighbourhood

The neighbourhood for the knapsack problem is defined by a **single random bit-flip**: one randomly selected position in the binary solution vector is toggled (0 → 1 or 1 → 0). This generates one neighbour per inner iteration in O(1) time.

### 2.3 Cooling Schedules

Three cooling schedules were implemented, as specified in the lab:

| Schedule | Formula | Notes |
|---|---|---|
| **Geometric** | T(k+1) = α · T(k) | α ∈ (0, 1), close to 1 for slow cooling |
| **Logarithmic** | T(k+1) = T(k) / log(k+1) | Very slow theoretical drop; bounded by `max_outer_iters` in practice |
| **Linear** | T(k+1) = T(k) / k | Fast initial drop; bounded by `max_outer_iters` in practice |

### 2.4 Halting Criteria

Two stopping conditions are applied simultaneously (as per lab specification):
1. **Temperature threshold:** stop when T < T_min = 0.1
2. **Iteration cap:** stop when outer iterations reach `max_outer_iters` = 5000 (prevents logarithmic/linear schedules from running indefinitely)

---

## 3. Parameter Settings

| Parameter | Value | Rationale |
|---|---|---|
| Initial temperature T0 | 10,000 | High enough to accept almost any move at the start |
| Minimum temperature T_min | 0.1 | Low enough that acceptance probability is negligible |
| Inner iterations | 50 | Sufficient exploration per temperature level |
| Max outer iterations (cap) | 5,000 | Hard safety cap for non-geometric schedules |
| α (geometric, slow) | 0.999 | ~9,210 steps to reach T_min from T0 – capped at 5,000 |
| α (geometric, medium) | 0.99 | ~1,146 outer iterations to reach T_min |
| α (geometric, fast) | 0.95 | ~225 outer iterations to reach T_min |
| Runs per configuration | 30 | Sufficient for statistically meaningful averages |

---

## 4. Results

### 4.1 Raw Results Table

| Instance | Cooling | Best Value | Avg Value | Std Dev | Avg Time (s) | Outer Iters |
|---|---|---|---|---|---|---|
| knapsack-20 | alpha=0.999 | 787 | 786.67 | 1.16 | 0.5193 | 5000 |
| knapsack-20 | alpha=0.99 | 787 | 785.30 | 3.55 | 0.1183 | 1146 |
| knapsack-20 | alpha=0.95 | 787 | 782.60 | 5.64 | 0.0232 | 225 |
| knapsack-20 | log-cooling | 787 | 782.87 | 5.16 | 0.5220 | 5000 |
| knapsack-20 | linear-cooling | **787** | **787.00** | **0.00** | 0.5235 | 5000 |
| knapsack-200 | alpha=0.999 | **98,657** | **98,165** | 241.62 | 2.7883 | 5000 |
| knapsack-200 | alpha=0.99 | 97,912 | 97,613 | 188.25 | 0.6276 | 1146 |
| knapsack-200 | alpha=0.95 | 98,344 | 97,116 | 433.26 | 0.1255 | 225 |
| knapsack-200 | log-cooling | 98,352 | 98,019 | 127.19 | 2.8120 | 5000 |
| knapsack-200 | linear-cooling | 97,916 | 97,255 | 411.74 | 2.7830 | 5000 |

### 4.2 Best Value by Configuration (knapsack-20)

```
alpha=0.999     ████████████████████████████████████████  787   avg=786.67  σ=1.16
alpha=0.99      ████████████████████████████████████████  787   avg=785.30  σ=3.55
alpha=0.95      ████████████████████████████████████████  787   avg=782.60  σ=5.64
log-cooling     ████████████████████████████████████████  787   avg=782.87  σ=5.16
linear-cooling  ████████████████████████████████████████  787   avg=787.00  σ=0.00
```

### 4.3 Best Value by Configuration (knapsack-200)

```
alpha=0.999     ██████████████████████████████████████████  98,657   avg=98,165  σ=242
alpha=0.99      █████████████████████████████████████████   97,912   avg=97,613  σ=188
alpha=0.95      █████████████████████████████████████████   98,344   avg=97,116  σ=433
log-cooling     █████████████████████████████████████████   98,352   avg=98,019  σ=127
linear-cooling  █████████████████████████████████████████   97,916   avg=97,255  σ=412
```

---

## 5. Discussion

### 5.1 Effect of instance size

For **knapsack-20**, all five configurations find the best known value of 787. The small search space (2²⁰ ≈ 1 million solutions) means that even the fastest cooling schedules explore enough of the landscape to reach the optimum. The differences lie in consistency: slower schedules achieve lower standard deviation and higher average values, confirming that thoroughness matters even on easy instances.

For **knapsack-200**, the search space is 2²⁰⁰ — astronomically larger — and the differences between configurations become much more pronounced. No configuration consistently reached the same best value across all 30 runs, as evidenced by non-zero standard deviations throughout.

### 5.2 Effect of cooling schedule

**Geometric α=0.999** achieved the highest best value (98,657) on knapsack-200 and the highest average (98,165). Being the slowest geometric schedule, it explores the most states before committing to a region, yielding the best overall quality at the cost of the longest runtime among geometric variants. For the small instance it was nearly perfect (avg 786.67 out of 787).

**Geometric α=0.99** offered a strong balance between quality and speed — completing in about 0.12 s (knapsack-20) and 0.63 s (knapsack-200), roughly 4–5× faster than the 5,000-iteration schedules. Its average quality was slightly below α=0.999 but competitive, making it the most practical choice for repeated use.

**Geometric α=0.95** cooled too quickly. Despite hitting 787 and 98,344 as best values (likely from lucky random starts), it had the highest standard deviation on knapsack-200 (433), indicating high run-to-run variance and a tendency to get trapped in local optima early. It is not a reliable configuration.

**Logarithmic cooling** performed surprisingly well on knapsack-200, achieving the second-lowest standard deviation (127.19) and a competitive average of 98,019. This can be attributed to the very slow temperature drop — after 5,000 outer iterations the temperature is still relatively high (T ≈ 10,000 / log(5,002) ≈ 1,160), meaning the algorithm maintains high acceptance probability throughout and behaves more like a diversified random walk than a focused local search. On the small instance this randomness was sufficient; on the large instance it consistently found good (but not best) solutions.

**Linear cooling** showed a curious split: on knapsack-20 it achieved a perfect average of 787.00 with zero standard deviation across all 30 runs, suggesting it systematically reached the global optimum every time. On knapsack-200, however, it was among the weakest configurations (avg 97,255, σ=412). The linear schedule drops temperature faster than logarithmic in the later stages, which seems to hurt on complex instances while still being thorough enough for the trivial 20-item case.

### 5.3 Quality vs. runtime trade-off

| Configuration | Quality (n=200) | Speed | Verdict |
|---|---|---|---|
| alpha=0.999 | ★★★★★ | ★★☆☆☆ | Best quality, slowest |
| alpha=0.99 | ★★★★☆ | ★★★★☆ | Best overall trade-off |
| alpha=0.95 | ★★★☆☆ | ★★★★★ | Unreliable, too fast |
| log-cooling | ★★★★☆ | ★★☆☆☆ | Good but slow, high randomness |
| linear-cooling | ★★★☆☆ | ★★☆☆☆ | Slow and inconsistent on large instances |

### 5.4 Conclusions

1. **Geometric cooling with α=0.99 is the recommended default** — it delivers near-optimal quality in a fraction of the time of slower schedules, with acceptable variance.
2. **α=0.999 is the best choice when quality is the sole priority** and runtime is not a constraint.
3. **Logarithmic and linear schedules require a hard iteration cap** to be usable in practice, as neither schedule reaches T_min=0.1 within a reasonable number of steps. With a 5,000-iteration cap they perform comparably to geometric schedules but without the principled convergence guarantees.
4. **Instance size is the dominant factor** in difficulty: configurations that trivially solve knapsack-20 show significant quality variance on knapsack-200, highlighting the exponential growth of the search space with *n*.
5. Simulated Annealing consistently outperforms random search due to its principled balance between exploration (high-T acceptance of worsening moves) and exploitation (low-T hill climbing), making it well-suited to the knapsack problem.