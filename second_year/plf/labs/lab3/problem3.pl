% 3. Given a list a1, ..., an, find all strictly increasing sublists.
% subset 
subset([], []).
subset([H | T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

% check if a list is strictly increasing 
strictly_increasing([]).
strictly_increasing([_]).
strictly_increasing([H1, H2 | T]) :- 
    H1 < H2,
    strictly_increasing([H2 | T]).

% combine 
increasing_sublist(L, R) :- 
    subset(L, R),
    strictly_increasing(R).

    