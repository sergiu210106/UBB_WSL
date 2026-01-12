% Define a predicate that, from a list of atoms, produces a list of pairs (atom n), where atom appears n times in the initial list. For example: numar([1, 2, 1, 2, 1, 3, 1], X) will produce X = [[1, 4], [2, 2], [3, 1]].

numar([], []).
numar([H | T], [[H, C] | R]) :- 
    count_occurrences([H | T], H, C),
    remove_all([H | T], H, L1),
    numar(L1, R).

count_occurrences([], _, 0).
count_occurrences([E | T], E, R) :- 
    !,
    count_occurrences(T, E, R1),
    R is R1 + 1.
count_occurrences([_ | T], E, R) :- 
    count_occurrences(T, E, R).

remove_all([], _, []).
remove_all([E | T], E, R) :-
    !,
    remove_all(T, E, R).
remove_all([H | T], E, [H | R]) :- 
    remove_all(T, E, R).