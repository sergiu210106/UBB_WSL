
% Write a predicate that produces all subsets os size k of a list

comb(_, 0, []).
comb([H|_], 1, [H]).
comb([H|T], K, [H|C]) :-
    K > 1,
    K1 is K-1,
    comb(T, K1, C).
comb([_|T], K, C) :-
    comb(T, K, C).

allcomb(L):-
    length(L, N),
    between(0, N, K),
    comb(L, K, R),
    write(R),
    nl,
    fail.

arr(_, _, 0, []).

arr(Rest, All, 1, [H|Rest]) :-
    member(H, All),
    \+ member(H, Rest).

arr(Rest, All, K, Result) :-
    K > 1,
    member(H, All),
    \+ member(H, Rest),
    K1 is K-1,
    arr([H|Rest], All, K1, Result).

arr(L, K, Result) :-
    arr([], L, K, Result).

allarr(L):-
    length(L, N),
    between(0, N, K),
    arr(L, K, R),
    write(R),
    nl,
    fail.