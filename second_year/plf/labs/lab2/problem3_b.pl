% problem3_b.pl 
/*
3.  b) Starting from a list of integers and sublists on integes, sort each sublist while eliminating duplicates. 
        E.g.: [1, 2, [4, 1, 4], 3, 6, [7, 10, 1, 3, 9], 5, [1, 1, 1], 7] -> [1, 2, [1, 4], 3, 6, [1, 3, 7, 9, 10], 5, [1], 7].
*/

solve([], []).
solve([H | T], [H | R]) :- 
    \+ is_list(H),
    solve(T, R).
solve([H | T], [S | R]) :- 
    is_list(H),
    process_list(H, S),
    solve(T, R).

process_list(L, R) :-
    msort(L, R1),
    remove_duplicates(R1, R).

msort([], []) :- !.
msort([X], [X]) :- !.
msort(L, S) :- 
    split(L, L1, L2),
    msort(L1, S1),
    msort(L2, S2),
    merge(S1, S2, S).

split([], [], []).
split([X], [X], []).
split([X, Y | T], [X | L1], [Y | L2]) :- 
    split(T, L1, L2).

merge([], L, L) :- !.
merge(L, [], L).
merge([X | XT], [Y | YT], [X | R]) :- 
    X =< Y,
    merge(XT, [Y | YT], R).

merge([X | XT], [Y | YT], [Y | R]) :-
    X > Y,
    merge([X | XT], YT, R).

remove_duplicates([], []).
remove_duplicates([X], [X]).
remove_duplicates([X, X | T], R) :-
    remove_duplicates([X | T], R).

remove_duplicates([X, Y | T], [X | R]) :-
    X \= Y,
    remove_duplicates([Y | T], R).


is_list([]).
is_list([_ | T]) :- 
    is_list(T).