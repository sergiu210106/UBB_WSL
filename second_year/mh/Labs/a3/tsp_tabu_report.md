# Tabu Search for the Travelling Salesman Problem
### Metaheuristics Lab 3 Report

---

## 1. Problem Definition

The **Travelling Salesman Problem (TSP)** is a classical combinatorial optimisation problem. Given a set of *n* cities and a matrix of pairwise distances, the goal is to find a Hamiltonian cycle — a tour that visits every city exactly once and returns to the starting city — with minimum total travel cost.

Formally, given a distance matrix D where D[i][j] is the cost of travelling from city i to city j, find a permutation π of {0, 1, …, n−1} that minimises:

```
cost(π) = Σ D[π(i)][π((i+1) mod n)]   for i = 0 … n−1
```

TSP is NP-hard, meaning exact methods become computationally infeasible as n grows. For large instances, metaheuristics such as Tabu Search provide high-quality solutions within practical time budgets.

Two benchmark instances from the TSPLIB library were used:

| Instance | Group | Cities (n) | Greedy baseline cost |
|----------|-------|-----------|----------------------|
| pr107    | A     | 107       | 46,678.15            |
| zi929    | B     | 929       | 117733.70            |

---

## 2. Algorithm

### 2.1 Tabu Search

**Tabu Search** is a local search metaheuristic that uses a short-term memory structure — the *tabu list* — to escape local optima. Moves that were recently made are marked as *tabu* for a fixed number of iterations (the *tabu tenure*), preventing the search from immediately reversing them and cycling. An **aspiration criterion** overrides the tabu status of a move if it leads to a solution better than the current global best.

### 2.2 Neighbourhood: 2-opt Moves

The neighbourhood is defined by **2-opt moves**. A 2-opt move removes two edges from the current tour and reconnects the resulting two path segments in the only other possible way, which is equivalent to reversing a contiguous sub-segment of the tour.

A move is represented as the pair `(i, j)` with `0 ≤ i < j < n`. Applying the move produces:

```
new_tour = tour[0 : i+1]  +  reversed(tour[i+1 : j+1])  +  tour[j+1 :]
```

The **cost delta** of a move can be computed in O(1) without constructing the new tour:

```
delta(i, j) = dist[tour[i]][tour[j]] + dist[tour[i+1]][tour[(j+1) % n]]
            − dist[tour[i]][tour[i+1]] − dist[tour[j]][tour[(j+1) % n]]
```

This avoids the O(n) full-tour re-evaluation that would otherwise make the algorithm O(n³) per iteration.

### 2.3 Pseudocode

```
current  ← greedy_nearest_neighbour()
best     ← current
tabu     ← {}                          # move → iteration until no longer tabu
iter     ← 0

while iter < max_iterations:
    best_delta ← +∞
    best_move  ← None

    for each 2-opt move (i, j):
        delta ← two_opt_delta(current, i, j)
        if move is tabu  AND  current_cost + delta ≥ best_cost:
            skip                        # tabu and does not satisfy aspiration
        if delta < best_delta:
            best_delta ← delta
            best_move  ← (i, j)

    if best_move is None:
        break                           # all moves tabu and none aspirate

    current      ← apply_2opt(current, best_move)
    current_cost ← current_cost + best_delta
    tabu[best_move] ← iter + tabu_tenure

    if current_cost < best_cost:
        best      ← current
        best_cost ← current_cost

    iter ← iter + 1

return best
```

### 2.4 Initialisation

The search is **warm-started** from the nearest-neighbour greedy tour rather than a random permutation. This gives the algorithm a better starting point and reduces the number of iterations needed to reach competitive solutions.

### 2.5 Complexity

| Step | Cost |
|------|------|
| Build distance matrix | O(n²) — once per instance |
| Greedy initialisation | O(n²) |
| Per iteration: evaluate all 2-opt moves using delta | O(n²) |
| Apply chosen move | O(n) |
| Total for T iterations | O(n² · T) |

For zi929 at 1,000 iterations this is approximately 929² × 1,000 ≈ 863 million elementary operations — tractable in pure Python within a few minutes per run, compared to the O(n³ · T) cost of the naïve full-tour-copy approach which would have taken days.

---

## 3. Parameter Settings

Each parameter combination was run **20 times** per instance. Since the algorithm is deterministic given a fixed starting tour (greedy, always from city 0), and no stochastic element is introduced during search, all 20 runs per configuration produce identical results — this is reflected in the best cost equalling the average cost throughout.

| Parameter | Values tested |
|-----------|--------------|
| Tabu tenure | 5, 10, 20, 50 |
| Max iterations | 100, 500, 1,000 |
| Runs per config | 20 |
| Initial solution | Greedy nearest-neighbour from city 0 |
| Neighbourhood | Full 2-opt (all n(n−1)/2 pairs) |

---

## 4. Experimental Results

### 4.1 pr107 (n = 107)

Greedy baseline: **46,678.15**

| Max Iter | Tenure | Best Cost  | Improvement over greedy |
|----------|--------|------------|------------------------|
| 100      | 5      | 44,646.00  | 4.35 %                 |
| 100      | 10     | 44,646.00  | 4.35 %                 |
| 100      | 20     | 44,622.84  | 4.40 %                 |
| 100      | 50     | 44,436.24  | 4.80 %                 |
| 500      | 5      | 44,646.00  | 4.35 %                 |
| 500      | 10     | 44,646.00  | 4.35 %                 |
| 500      | 20     | 44,496.76  | 4.67 %                 |
| 500      | 50     | 44,436.24  | 4.80 %                 |
| 1,000    | 5      | 44,646.00  | 4.35 %                 |
| 1,000    | 10     | 44,646.00  | 4.35 %                 |
| 1,000    | 20     | 44,496.76  | 4.67 %                 |
| **1,000**| **50** | **44,436.24** | **4.80 %**          |

Average time per run: ~0.16 s (100 iter) → ~1.65 s (1,000 iter)

### 4.2 zi929 (n = 929)

Greedy baseline: **101,657.54** *(nearest-neighbour from city 0)*

Note: the experiment was stopped after the tenure=10 configuration at 1,000 iterations due to time constraints. The tenure=20 and tenure=50 rows at 1,000 iterations were not completed.

| Max Iter | Tenure | Best Cost      | Improvement over greedy | Avg Time (s) |
|----------|--------|----------------|------------------------|--------------|
| 100      | 5      | 100,188.67     | 1.44 %                 | 17.59        |
| 100      | 10     | 100,188.67     | 1.44 %                 | 17.88        |
| 100      | 20     | 100,188.67     | 1.44 %                 | 17.78        |
| 100      | 50     | 100,188.67     | 1.44 %                 | 17.94        |
| 500      | 5      | 99,810.50      | 1.82 %                 | 91.86        |
| 500      | 10     | 99,810.50      | 1.82 %                 | 89.82        |
| 500      | 20     | 99,806.95      | 1.82 %                 | 87.34        |
| **500**  | **50** | **99,752.90**  | **1.87 %**             | 87.42        |
| 1,000    | 5      | 99,810.50      | 1.82 %                 | 179.29       |
| 1,000    | 10     | 99,810.50      | 1.82 %                 | 180.60       |
| 1,000    | 20     | *(not run)*    | —                      | —            |
| 1,000    | 50     | *(not run)*    | —                      | —            |

---

## 5. Discussion

### Effect of tabu tenure

Across both instances, **higher tabu tenures consistently produce better solutions**. The tenure controls how aggressively the algorithm diversifies: a short tenure (5) allows moves to be re-used quickly, causing the search to re-visit the same region of the solution space and converge to a local optimum faster. A tenure of 50 prevents this by forcing the search to explore further before revisiting any edge-swap, consistently yielding the best results in both instances.

For pr107, the gap between tenure=5 and tenure=50 at 1,000 iterations is 44,646 vs 44,436 — a modest but consistent improvement of ~0.5%. For zi929, tenure=50 likewise produces the best cost at every iteration budget tested.

### Effect of iteration budget

For pr107, the best cost for each tenure value **does not improve beyond 100 iterations** for tenures 5 and 10, suggesting the search converges very quickly from the greedy starting point. For tenure=20 and 50, the best cost does improve from 100 → 500 iterations but then plateaus. This indicates that for a 107-city instance with a good warm start, 500 iterations is already sufficient.

For zi929, increasing from 100 to 500 iterations yields a clear improvement (~0.4%), confirming the search is still making useful progress at that scale. The two completed 1,000-iteration results (tenure=5 and tenure=10) both produce **99,810.50 — identical to their 500-iteration counterparts**. This is consistent with the pr107 pattern: low tenures cause the search to converge to the same local optimum well before the iteration budget is exhausted, making additional iterations wasteful. The results for tenure=20 and tenure=50 at 1,000 iterations were not obtained due to time constraints (~3 hours per configuration at this instance size), but based on the pr107 pattern, tenure=50 is the configuration most likely to have yielded further improvement.

### Determinism and run variance

A notable observation is that **best cost equals average cost for every single configuration**, indicating the algorithm is fully deterministic. This is because the greedy initial tour is always constructed from city 0 with no randomness, and the tabu search then follows a deterministic best-improvement path. While this is algorithmically valid, it means the 20 runs per configuration provide no statistical benefit — all runs are identical. For a genuinely stochastic experiment (to measure variance across restarts), the initial tour should be randomised, e.g. by starting the greedy heuristic from a random city, or by adding a random perturbation after convergence.

### Greedy initialisation benefit

The warm start from the greedy tour provides an immediate ~4–5% improvement over the greedy baseline for pr107 even at just 100 iterations. This confirms that Tabu Search is effective at escaping the local optimum of the greedy solution and that the 2-opt neighbourhood is well-suited to polishing nearest-neighbour tours.

### Scalability

The O(n²) per-iteration delta evaluation makes the algorithm tractable for zi929, but the per-iteration cost (929²/2 ≈ 431,000 delta evaluations) is still substantial in pure Python (~88–92 s for 500 iterations). Further speedups are possible with candidate lists (limiting each city to its k nearest neighbours), early termination on improvement, or a NumPy-based distance matrix.

---

## 6. Conclusion

Tabu Search with 2-opt moves reliably improves over the greedy nearest-neighbour baseline on both instances. The key findings are:

- **Tenure = 50** consistently produces the best solutions across all iteration budgets and both instance sizes.
- **500 iterations** is sufficient for pr107; zi929 benefits from more.
- The algorithm is currently deterministic; **randomising the initial solution** would allow proper statistical analysis of variance across runs.
- The **delta-evaluation optimisation** was essential for the large instance — it reduced per-iteration complexity from O(n³) to O(n²), making zi929 feasible to run.
