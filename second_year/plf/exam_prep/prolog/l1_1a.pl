% a) Write a predicate that returns the difference of two sets

% Base case
set_difference([], _, []).

% if the head is in the second list skip, else add it
set_difference([H | T], L2, R):-
    member(H, L2),
    !,
    set_difference(T, L2, R).

set_difference([H | T], L2, [H | R]) :-
    set_difference(T, L2, R).

