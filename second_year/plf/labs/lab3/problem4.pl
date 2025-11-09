% 4. Given two natural numbers, n and m, find all possible ways of aranging the numbers
% between 1 and n such that the absolute difference between two adjacent numbers is m.

% generate all numbers between 1 and n in a list
range(0, []) :- !.
range(N, L) :- 
    N > 0,
    N1 is N - 1,
    range(N1, L1),
    append(L1, [N], L).

% select an element from the list
select(X, [X | T], T).
select(X, [Y | T], [Y | R]) :- select(X, T, R).

% permutation -> generate all arangements 
permutation([], []).
permutation(L, [X | P]) :-
    select(X, L, R),
    permutation(R, P).

% check all consecutive elements are at a difference of m  
check([], _).
check([_], _).
check([X , Y | T], M) :-
    D is X - Y,
    D * D =:= M * M,
    check([Y | T], M).

% solve
solve(N, M, R) :- 
    range(N, L),
    permutation(L, R),
    check(R, M).

