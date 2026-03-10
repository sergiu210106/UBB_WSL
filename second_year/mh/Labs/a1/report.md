## Assignment A1 Report

### 1. Problem Definition
The problem tackled in this assignment is the 0/1 Knapsack Problem. We are given $n$ objects, where each object has a specific value ($v_i$) and a weight ($w_i$)[cite: 25]. The objective is to select a subset of these objects to maximize the total value without exceeding the knapsack's maximum weight capacity $W$. 

Mathematically, the objective is to maximize $\sum_{i=1}^{n}v_{i}x_{i}$ subject to the constraint $\sum_{i=1}^{n}w_{i}x_{i}\le W$[cite: 27, 28, 29]. The variable $x_i \in \{0, 1\}$ acts as a binary decision variable, where $x_i = 1$ means object $i$ is selected, and $x_i = 0$ means it is not selected.

### 2. Algorithm Used
**Name:** Random Search

**Steps/Pseudocode:**
1. Initialize `best_solution`, `best_value` = -1, and `best_weight` = 0.
2. Repeat the following $k$ times:
   a. Generate a random binary string of length $n$ (representing a candidate solution).
   b. Evaluate the candidate solution by summing the weights and values of the selected items.
   c. If the total weight exceeds the knapsack capacity $W$, assign a value of 0 (invalid solution).
   d. If the valid candidate's value is greater than `best_value`, update `best_solution`, `best_value`, and `best_weight`.
3. Return the `best_solution` found after $k$ iterations.
*(Note: To ensure statistical reliability, this entire process is enclosed in an outer loop that executes `num_runs` independent times).*

### 3. Parameter Setting
* **Problem Instances tested:** Sizes $N = 20$ and $N = 200$.
* **Values of $k$ (Iterations per run):** $[10, 100, 1000, 10000, 50000]$
* **Number of independent runs:** $10$.

### 4. Comparative Results
*Below are the aggregated results of the experiments saved from the output file:*

| Instance             | K        | Best Value   | Weight     | Time (s)   |
|---|---|---|---|---|
| knapsack-20.txt      | 10       | 670          | 508        | 0.0001 |
| knapsack-20.txt      | 100      | 670          | 510        | 0.0008 |
| knapsack-20.txt      | 1000     | 716          | 516        | 0.0087 |
| knapsack-20.txt      | 10000    | 767          | 518        | 0.0844 |
| knapsack-20.txt      | 50000    | 782          | 521        | 0.4264 |
| knapsack-200.txt     | 10       | 0            | 136493     | 0.0008 |
| knapsack-200.txt     | 100      | 91804        | 108604     | 0.0081 |
| knapsack-200.txt     | 1000     | 96356        | 111556     | 0.0811 |
| knapsack-200.txt     | 10000    | 96988        | 111988     | 0.8184 |
| knapsack-200.txt     | 50000    | 97122        | 112422     | 4.1292 |


### 5. Discussion of Results
Based on the experimental results above, we can observe the following trends:

* **Impact of $k$ on Solution Quality:** As the number of random evaluations ($k$) increases from $10$ to $50,000$, the best values found consistently improve for both instances. For the $N$ = $20$ instance, the best value rose from 670 to 782, while for the $N$ = $200$ instance, it improved significantly from $0$ to $97$,$122$. This demonstrates that sampling more of the search space yields better configurations, though the rate of improvement varies by instance size.
* **Impact of Instance Size:** For the smaller instance ($N$ = $20$), the algorithm finds a reasonable solution (value $670$) even with the lowest $k$ setting. Increasing k yields diminishing returns, with the value increasing roughly $16$ to $782$. However, for the larger instance ($N$ = $200$), the search space is exponentially larger ($2^{200}$). Consequently, random search struggles significantly at low sample rates; at $k$=$10$, the algorithm failed to find a feasible solution (Best Value = $0$, Weight > Capacity). While increasing $k$ to $50,000$ allowed the algorithm to find a valid solution with a value of $97,122$, the results suggest that purely random sampling is inefficient at navigating such a vast solution space compared to the smaller instance.
* **Computational Cost:** The time required to execute the algorithm scales linearly with k. For the N=200 instance, while $k$=$10$ took only $0.0008$ seconds, $k$=$50,000$ took $4.1292$ seconds.

In conclusion, while Random Search is trivial to implement, its purely blind exploration makes it highly inefficient for large-scale combinatorial problems like the $N$=$200$ knapsack instance, where it requires substantial computational effort to simply find a feasible solution.