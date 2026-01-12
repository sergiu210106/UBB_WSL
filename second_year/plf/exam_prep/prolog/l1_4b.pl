% Remove the element at the n-th position of a linear list.

% remove_nth(List, N, Result)
remove_nth(L, N, R) :-
    helper(L, 1, N, R).

% helper(List, I, N, Result)
helper([], _, _, []).

helper([_ | T], N, N, R) :-
    !,
    I1 is N + 1,
    helper(T, I1, N, R).

helper([H | T], I, N, [H | R]) :-
    I1 is I + 1,
    helper(T, I1, N, R).
