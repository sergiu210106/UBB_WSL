% quicksort.pl
% Predicate to partition a list into two lists based on a pivot
partition([], _, [], []).
partition([H|T], Pivot, [H|L1], L2) :-
    H =< Pivot,
    partition(T, Pivot, L1, L2).
partition([H|T], Pivot, L1, [H|L2]) :-
    H > Pivot,
    partition(T, Pivot, L1, L2).

% Predicate to concatenate two lists
concat([], L, L).
concat([H|T], L, [H|R]) :-
    concat(T, L, R).

% Predicate to perform quicksort
quicksort([], []).
quicksort([H|T], Sorted) :-
    partition(T, H, L1, L2),
    quicksort(L1, S1),
    quicksort(L2, S2),
    concat(S1, [H|S2], Sorted).
