%2. Given an integer N, find all ways to express the number as a sum of distinct primes.
% generate all subsets of a list
subset([], []).
subset([_| T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

% sum of all elements in a list 
sum_list([], 0).
sum_list([H | T], R) :- 
    sum_list(T, R1),
    R is R1 + H.

% prime 
prime(2).
prime(N) :- 
    N > 2,
    \+ has_factor(N, 2).
has_factor(N, F) :- 
    N mod F =:= 0.
has_factor(N, F) :- 
    F * F < N,
    F1 is F + 1,
    has_factor(N, F1).

% between 
between(L, H, L) :- L =< H.
between(L, H, X) :-
    L < H,
    L1 is L + 1,
    between(L1, H, X).

% collect all primes between 2 and N 
primes_up_to(N, L) :- 
    collect_primes(2, N, L).

collect_primes(Current, N, []) :-
    Current > N, !.
collect_primes(Current, N, [Current | R]) :- 
    Current <= N, 
    prime(Current), !, 
    Next is Current + 1,
    collect_primes(Next, N, R).

collect_primes(Current, N, R) :- 
    Current <= N,
    \+ prime(Current), 
    Next is Current + 1,
    collect_primes(Next, N, R).
 
% combine 
prime_sum(N, Subset) :- 
    primes_up_to(N, Primes),
    subset(Primes, S),
    sum_list(S, RS),
    RS is N.