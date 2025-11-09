% 5. Find all size N sublists of a list. E.g., [2,3,4] N=2 ⇒ [[2,3],[2,4],[3,4]]

% subset 
subset([], []).
subset([_ | T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

% length
my_length([], 0).
my_length([H | T], N) :- 
    my_length(T, N1),
    N is N1 + 1.

% solve 
solve(L, N, R) :- 
    subset(L, R),
    my_length(R, N).