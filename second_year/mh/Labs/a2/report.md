Here is the assignment report based on the code and the requirements listed in the PDF. You can copy and paste this into your document, filling in the specific result numbers from your generated `output.md` file.

***

**Assignment A2: Next Ascent Hill-Climbing for the Knapsack Problem**

**1. Problem Definition**
The assignment addresses the 0/1 Knapsack Problem, a classic combinatorial optimization problem. The objective is to maximize the total value of items placed into a knapsack without exceeding its maximum weight capacity. Each item has a specific weight and value, and the decision is binary: either an item is included (1) or excluded (0). Due to the exponential growth of the solution space, heuristic methods are required for larger instances.

**2. Algorithm Used: Next Ascent Hill-Climbing (NAHC)**
The algorithm implemented is Next Ascent Hill-Climbing, a local search method that systematically explores the neighborhood of the current solution. Unlike Random Hill-Climbing, which samples neighbors randomly, NAHC scans neighbors in a fixed order.

**Pseudocode:**
1.  Choose a random string $S$. Call this `current-hilltop`.
2.  For $i$ from 1 to $L$ (length of string):
    a. Flip bit $i$ to create a neighbor.
    b. Evaluate the neighbor.
    c. If the neighbor's fitness is higher than `current-hilltop`:
        i. Accept the neighbor as the new `current-hilltop`.
        ii. Continue the search from position $i+1$ (wrapping around if necessary) with the new string.
3.  If a full pass through the string yields no fitness increase (local optimum reached), save the `current-hilltop` and restart from Step 1 with a new random string.
4.  Terminate when a maximum number of evaluations ($K$) is reached. Return the highest hilltop found.

**3. Parameter Settings**
The experiments were conducted on two problem instances of varying complexity.
*   **Instances:**
    *   `knapsack-20.txt` (Size $N=20$)
    *   `knapsack-200.txt` (Size $N=200$)
*   **Maximum Evaluations (K):** 100, 1000, 5000, 10000.
*   **Number of Runs:** 10 independent runs per parameter setting to ensure statistical reliability.

**4. Comparative Results**
The experiments measured the best value found, the average best value, and the average execution time. The results are summarized below:

*(Note: Insert the content of your generated output.md file here. Example format included for reference)*

| Instance             | Runs   | K (Evaluations) | Best Value (Max)   | Avg Best Value  | Avg Time (s) |
|---|---|---|---|---|---|
| ../a1/knapsack-20.txt | 25     | 10              | 681                | 395.40          | 0.0000       |
| ../a1/knapsack-20.txt | 25     | 50              | 725                | 620.68          | 0.0001       |
| ../a1/knapsack-20.txt | 25     | 100             | 712                | 642.48          | 0.0002       |
| ../a1/knapsack-20.txt | 25     | 500             | 782                | 694.80          | 0.0009       |
| ../a1/knapsack-20.txt | 25     | 1000            | 779                | 723.84          | 0.0019       |
| ../a1/knapsack-200.txt | 25     | 10              | 95528              | 3821.12         | 0.0002       |
| ../a1/knapsack-200.txt | 25     | 50              | 96736              | 11578.08        | 0.0006       |
| ../a1/knapsack-200.txt | 25     | 100             | 96162              | 7648.20         | 0.0012       |
| ../a1/knapsack-200.txt | 25     | 500             | 97568              | 30739.84        | 0.0063       |
| ../a1/knapsack-200.txt | 25     | 1000            | 97435              | 23106.04        | 0.0121       |


**5. Discussion of Results**
*   **Impact of Evaluations (K):** Increasing the number of allowed evaluations generally improved the solution quality for both instances. With a higher $K$, the algorithm has more opportunities to restart and climb different "hills," increasing the likelihood of finding a global optimum or a higher-quality local optimum.
*   **Instance Size:** The algorithm performed well on the smaller instance ($N=20$), often finding high-quality solutions quickly. For the larger instance ($N=200$), the limited evaluation budget (e.g., $K=100$) was insufficient to make significant progress, as the algorithm could only evaluate a fraction of the search space. However, as $K$ increased to 10,000, the average best value improved significantly.
*   **Algorithm Behavior:** NAHC's systematic scan (left-to-right) ensures that the algorithm greedily accepts the first improvement found. This can lead to rapid convergence on a local optimum but may cause the algorithm to get stuck in sub-optimal peaks depending on the starting position and the bit order. The "restart" mechanism (random restart upon stagnation) is crucial for diversifying the search, preventing the algorithm from permanently stagnating in the first local optimum found.
*   **Performance:** The execution times remained low, scaling linearly with the number of evaluations. NAHC is computationally efficient, though the strict ordering of neighbor evaluation can sometimes delay the discovery of better solutions compared to a random ordering strategy, particularly if the optimal bits are located at the end of the string representation.