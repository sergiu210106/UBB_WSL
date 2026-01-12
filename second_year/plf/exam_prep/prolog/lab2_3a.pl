% Sort a list while eliminating duplicates. E.g.: [4 2 6 2 3 4] => [2 3 4 6]
sort_unique(L, R) :- 
    merge_sort(L, R).

merge_sort([], []) :- !.
merge_sort([X], [X]) :- !.

merge_sort(L, R) :-
    split(L, L1, L2),
    merge_sort(L1, S1),
    merge_sort(L2, S2),
    merge(S1, S2, R).

split([], [], []).
split([X], [], [X]). 
split([X, Y | T], [X | L1], [Y | L2]) :- 
    split(T, L1, L2).

merge(L, [], L) :- !.
merge([], L, L) :- !.
merge([H1 | T1], [H2 | T2], [H1 | R]) :- 
    H1 < H2,
    merge(T1, [H2 | T2], R).

merge([H1 | T1], [H2 | T2], [H2 | R]) :- 
    H1 > H2,
    merge([H1 | T1], T2, R).

merge([H1 | T1], [H2 | T2], [H1 | R]) :- 
    H1 =:= H2,
    merge(T1, T2, R).
    

