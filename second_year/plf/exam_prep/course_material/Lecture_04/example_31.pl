% Write a predicate that produces all subsets os size k of a list

comb([H|_], 1, [H]).
comb([H|T], K, [H|C]) :-
    K > 1,
    K1 is K-1,
    comb(T, K1, C).
comb([_|T], K, C) :-
    comb(T, K, C).

test(C):-comb([1, 2, 3], 2, C).