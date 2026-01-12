% Write a predicate that transforms a list into a set, preserving the order of first appearance. Example: [1,2,3,1,2] is transformed into [1,2,3].

preserve(L, R) :-
    helper(L, [], R).
helper([], _, []).
helper([H | T], Acc, R):- 
    member(H, Acc),
    !,
    helper(T, Acc, R).
helper([H | T], Acc, [H | R]) :-
    helper(T, [H | Acc], R).
