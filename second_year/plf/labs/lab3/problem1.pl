%1. Given N 2D coordinates, find all colinear subsets.
% choose n elements from a list
subset(0, _, []).
subset(N, [H | T], [H | R]) :- 
    N > 0,
    N1 is N - 1,
    subset(N1, T, R).
subset(N, [_|T], R) :- 
    N > 0,
    subset(N, T, R).

% check if three points are colinear 
colinear((X1, Y1), (X2, Y2), (X3, Y3)) :- 
    (Y2-Y1) * (X3 - X2) - (X2 - X1) * (Y3 - Y2) is 0.

% check if all points in a subset are colinear
all_colinear([_, _]).
all_colinear([A,B,C | R]) :- 
    colinear(A,B,C),
    all_colinear([B,C | R]).

% generates all values between L and H
between(L, H, L) :- L =< H.
between(L, H, X) :-
    L < H,
    L1 is L + 1,
    between(L1, H, X).

% returns the length of a list
length([], 0).
length([H|T], R) :-
    length(T,R1),
    R is R1+1.


% find all colinear subsets 
colinear_subsets(Points, Subset) :- 
    length(Points, N),
    between(3,N,K),
    subset(N, Points, Subset),
    all_colinear(Subset).
