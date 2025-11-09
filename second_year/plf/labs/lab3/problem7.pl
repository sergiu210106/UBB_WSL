% Find all arangements of size K of a list. E.g., [2,3,4] K=2 ⇒ [[2,3], [3,2], [2,4], [4,2], [3,4],
% [4,3]], not necesarily in this order

% select an element from a list and keep the rest
my_select(H, [H | T], T).
my_select(X, [H | T], [H | R]) :- my_select(X, T, R).

% arangements 
arangements(_, 0, []).
arangements(L, K, [X | R]) :-
    K > 0,
    my_select(X, L, R1),
    K1 is K - 1,
    arangements(R1, K1, R).
