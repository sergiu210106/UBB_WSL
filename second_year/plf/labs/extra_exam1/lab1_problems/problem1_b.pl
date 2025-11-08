/*
(b) Write a predicate that adds the value 1 after every even element in a list.
*/
% add_even(L, R) 
add_even([], []).
add_even([H | T], [H | R]) :-
    H mod 2 =:= 1,
    !,
    add_even(T, R).

add_even([H | T], [H, 1 | R]) :- 
    add_even(T, R).
