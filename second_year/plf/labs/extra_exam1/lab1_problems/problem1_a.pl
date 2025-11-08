/*
1.(a) Write a predicate that returns the difference of two sets.
*/

% member function
% member(E, L) -> is E a member of L
member(E, [E | _]).
member(E, [_ | T]) :- 
    member(E, T).

% difference function 
% difference (L1, L2, R) -> L1 \ L2 is put in R
difference([], _, []).
difference([H | T], L2, R) :-
    member(H, L2),
    !,
    difference(T, L2, R).
difference([H | T], L2, [H | R]) :- 
    difference(T, L2, R).

