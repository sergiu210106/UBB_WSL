% 10. Given a list of distinct integers a1, ...an, find all sublists wohs sum is divisible by n.
% subset
subset([], []).
subset([_ | T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

% sum 
sum([], 0).
sum([H | T], R) :- 
    sum(T, R1),
    R is R1 + H.

% checksum 
checksum(L, N) :-
    sum(L, S),
    S mod N =:= 0.

% length
length([], 0).
length([H | T], N) :-
    N > 0,
    length(T, N1),
    N is N1 + 1.

% solve 
solve(L, S) :-
    length(L, N),
    subset(L, S),
    checksum(S, N).