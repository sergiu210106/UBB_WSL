% (b) Starting from a list of integers and sublists on integers, sort each sublist while eliminating duplicates. E.g.:[1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] ⇒[1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].

split([], [], []).
split([E], [E], []).
split([X, Y | T], [X | L1], [Y | L2]) :- 
    split(T, L1, L2).

merge(L, [], L) :- !.
merge([], L, L) :- !.

merge([H1 | T1], [H2 | T2], [H1 | R]) :- 
    H1 < H2,
    merge(T1, [H2 | T2], R).

merge([H1 | T1], [H2 | T2], [H1 | R]) :-
    H1 =:= H2, 
    merge(T1, T2, R).

merge([H1 | T1], [H2 | T2], [H2 | R]) :- 
    H1 > H2,
    merge([H1 | T1], T2, R).

sort_no_dups([], []).
sort_no_dups(L, R) :-
    split(L, L1, L2),
    sort_no_dups(L1, S1),
    sort_no_dups(L2, S2),
    merge(S1, S2, R).

solve([], []).
solve([H | T], [H1 | R]) :- 
    is_list(H),
    !,
    sort_no_dups(H, H1),
    solve(T, R).
solve([H | T], [H | R]) :- 
    atom(H),
    solve(T, R).