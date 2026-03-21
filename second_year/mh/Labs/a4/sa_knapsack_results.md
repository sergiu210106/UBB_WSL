# Simulated Annealing – Knapsack Results

## Configuration
- **T0:** 10000.0  |  **T_min:** 0.1  |  **Inner iters:** 50  |  **Max outer iters (cap):** 5000
- **Runs per configuration:** 30
- **Cooling schedules:** geometric (α=0.999/0.99/0.95), log, linear

## Results

| Instance        | Cooling          | Best Value  | Avg Value   | Std Dev   | Avg Time (s)  | Outer Iters  |
|---|---|---|---|---|---|---|
| knapsack-20     | alpha=0.999      | 787         | 786.67      | 1.16      | 0.5193        | 5000         |
| knapsack-20     | alpha=0.99       | 787         | 785.30      | 3.55      | 0.1183        | 1146         |
| knapsack-20     | alpha=0.95       | 787         | 782.60      | 5.64      | 0.0232        | 225          |
| knapsack-20     | log-cooling      | 787         | 782.87      | 5.16      | 0.5220        | 5000         |
| knapsack-20     | linear-cooling   | 787         | 787.00      | 0.00      | 0.5235        | 5000         |
| knapsack-200    | alpha=0.999      | 98657       | 98165.13    | 241.62    | 2.7883        | 5000         |
| knapsack-200    | alpha=0.99       | 97912       | 97612.73    | 188.25    | 0.6276        | 1146         |
| knapsack-200    | alpha=0.95       | 98344       | 97116.07    | 433.26    | 0.1255        | 225          |
| knapsack-200    | log-cooling      | 98352       | 98019.27    | 127.19    | 2.8120        | 5000         |
| knapsack-200    | linear-cooling   | 97916       | 97255.27    | 411.74    | 2.7830        | 5000         |
