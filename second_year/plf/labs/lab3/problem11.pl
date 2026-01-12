% 11. Find all sublists of length 2n + 1 containing 0, -1, or 1, such that a1 = 0, a2n+1 = 0 and
% |ai+1 − ai
% | ∈ {1, 2}

value(-1).
value(0).
value(1).

get_lists(1, [0]).
get_lists(N, [X|L]) :- 
    N > 0,
    value(X),
    N1 is N-1,
    get_lists(N1, L).

last([X], X) :- !.
last([H | T], X) :- last(T, X).

valid([_]).
valid([A, B | T]) :-
    D is A - B,
    (D =:= 1 ; D =:= 2 ; D =:= -1 ; D =:= -2),
    valid([B | T]).

solve(N, [0 | R]) :-
    N1 is 2*N,
    get_lists(N1, R),
    last(R, 0),
    valid(R).
