%2. Given an integer N, find all ways to express the number as a sum of distinct primes.
% generate all subsets of a list
subset([], []).
subset([H | T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

% prime 
prime(2).
prime(N) :-
    N > 2,
   \+  has_factor(N, 2).
has_factor(N, F) :-
    N mod F =:= 0, !.
has_factor(N, F) :- 
    F * F =< N, 
    F1 is F + 1,
    has_factor(N, F1).

% all primes <= N 
all_primes(0, []).
all_primes(N, [N | L]) :- 
    prime(N),
    !,
    N1 is N - 1,
    all_primes(N1, L).

all_primes(N, L) :-
    N1 is N - 1,
    all_primes(N1, L).

% sum 
sum([], 0).
sum([H | T], R) :-
    sum(T, R1),
    R is R1 + H.

% solve
solve(N, R) :- 
    all_primes(N, L),
    subset(L, Subset),
    sum(Subset, N).