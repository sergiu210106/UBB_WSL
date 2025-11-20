%  Given a list of distinct integers, find all sublists resempling a mountain, i.e., the sublists
% starts with an ascending sequence followed by a descending sequence. E.g., (10 16 27 18
% 14 7).

% subset 
subset([], []).
subset([H | T], [H | R]) :- subset(T, R).
subset([H | T], R) :- subset(T, R).

% mountain()
maux([_], 1).
maux([H1, H2 | T], 0) :-
    H1 =< H2,
    maux([H2 | T], 0),!.
maux([H1, H2 | T], 0) :- 
    H1 > H2,
    maux([H2 | T], 1).

maux([H1, H2 | T], 1) :- 
    H1 > H2,
    maux([H2 | T], 1),!.

mountain([H1, H2 | T]) :-
    H1 < H2,
    maux([H2 | T], 0).


% solve 
solve(L, S) :- 
    subset(L, S),
    mountain(S).
