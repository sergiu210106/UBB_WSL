%  Write a predicate that substitutes an element in a list with another list.

% subs(List, Element, SubsList, Result)
subs([], _, _, []).
subs([E | T], E, SL, R) :-
    !,
    subs(T, E, SL, R1),
    append(SL, R1, R).

subs([H | T], E, SL, [H | R]) :- 
    subs(T, E, SL, R).
