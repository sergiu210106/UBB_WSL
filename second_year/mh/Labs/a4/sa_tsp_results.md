# Simulated Annealing for TSP – Results

## Configuration
- **Instances:** pr107 (n=107, group A), zi929 (n=929, group B)
- **T0:** 10000.0  |  **T_min:** 0.1  |  **Inner iters:** 100
- **Runs per configuration:** 5
- **Cooling schedules tested:** geometric (alpha=0.999/0.99/0.95), log, linear

## Results

| Instance   | Cooling      | Best Cost    | Avg Cost     | Avg Time (s)  | Outer Iters  |
|---|---|---|---|---|---|
| pr107      | alpha=0.999  | 44491.08     | 44701.54     | 1.6145        | 11508        |
| pr107      | alpha=0.99   | 44947.90     | 45193.54     | 0.1597        | 1146         |
| pr107      | alpha=0.95   | 46026.49     | 47612.23     | 0.0326        | 225          |
| pr107      | greedy       | 46678.15     | 46678.15     | 0.0000        | 0            |
| zi929      | alpha=0.999  | 113979.02    | 116352.18    | 3.8828        | 11508        |
| zi929      | alpha=0.99   | 116403.60    | 118702.41    | 0.4898        | 1146         |
| zi929      | alpha=0.95   | 112984.00    | 118930.79    | 0.1530        | 225          |
| zi929      | greedy       | 117733.70    | 117733.70    | 0.0000        | 0            |
