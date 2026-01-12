% Write a predicate that deletes all occurrences of a certain atom from a list.

remove_all([], _, []).
remove_all([E | T], E, R) :- 
    !,
    remove_all(T, E, R).
remove_all([H | T], E, [H | R]) :-
    remove_all(T, E, R).