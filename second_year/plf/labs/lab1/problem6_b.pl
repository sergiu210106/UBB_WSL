/*
(b) Remove all occurrences of the maximum element from a list of integers.
*/

remove_all(_, [], []).

remove_all(E, [H | T], [H | R]) :-
    H \= E,
    remove_all(E, T, R).


remove_all(H, [H | T], R) :- 
    remove_all(H, T, R).

max_element([], 0).
max_element([E], E).

max_element([H | T], R) :-
    max_element(T, R1),
    H > R1,
    R is H.

max_element([H | T], R) :-
    max_element(T, R1),
    H =< R1,
    R is R1.

remove_max_occurences([], []).
remove_max_occurences(L, R) :-
    max_element(L, M),
    remove_all(M, L, R).
