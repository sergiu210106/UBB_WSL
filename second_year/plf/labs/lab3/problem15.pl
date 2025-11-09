% Given a pozitive number, find all ways of expressing that number as a sum of consecutive
% natural numbers.

between(L, H, L) :- L =< H.
between(L, H, X):
    L < H,
    L1 is L + 1,
    between(L1, H, X).

find_sum(_,0,[]).
find_sum(Current, Target, [Current | T]) :- 
    Target > 0,
    NewTarget is Target - Current,
    Next is Current + 1,
    find_sum(Next, NewTarget, T).


consecutive_sum(N, L) :- 
    MaxStart is N div 2,
    between(1, MaxStart, Start),
    find_sum(Start, N, L).

consecutive_sum([N], N).

