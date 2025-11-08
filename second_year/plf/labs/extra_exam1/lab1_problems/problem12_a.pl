/*
    Write a predicate that substitutes an element in a list with another.
*/ 
% modify (L, A, B, R)
modify([], _, _, []).
modify([A | T], A, B, [B | R]) :-
    !,
    modify(T, A, B, R).
modify([H | T], A, B, [H | R]) :-
    modify(T, A, B, R).