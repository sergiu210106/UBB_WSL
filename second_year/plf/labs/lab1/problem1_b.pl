/*
(b) Write a predicate that adds the value 1 after every even element in a list.
*/

add_one([], []).
add_one([H | T], [H, 1 | R]) :-
    H mod 2 =:= 0, !,
    add_one(T, R).

add_one([H | T], [H | R]) :- add_one(T, R).