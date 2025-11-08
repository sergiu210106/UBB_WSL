% Given two natural numbers n (n > 2) and v (v > 0), write predicate that
% determines the permutations of the elements 1, 2...., n with the property
% that any two consecutive elements have the difference in absolute value
% greater than or equal to v.

cand(N, N).
cand(N, I) :-
    N>1,
    N1 is N-1,
    cand(N1,I).

isMember(X,[X|_]).
isMember(X,[_|T]):-isMember(X,T).

perm(N, V, L) :-
    cand(N, I),
    perm_aux(N, V, L, 1, [I]).

perm_aux(N, _, Col, N, Col) :- !.
perm_aux(N, V, L, Lg, [H|T]) :-
    cand(N, I),
    abs(H-I)>=V,
    \+ isMember(I, [H|T]),
    Lg1 is Lg+1,
    perm_aux(N, V, L, Lg1, [I|[H|T]]).