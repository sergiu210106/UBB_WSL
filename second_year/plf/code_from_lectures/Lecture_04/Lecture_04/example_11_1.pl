% write a predicate that produces all sublists with more than two elements that sum to a value from a given list

combSum([H|_], 1, H, [H]).
combSum([H|T], K, S,[H|C]) :-
    K>1,
    S1 is S-H,
    S1>0,K1 is K-1,
    combSum(T, K1, S1, C).
combSum([_|T], K, S, C) :-
    combSum(T, K, S, C).

allCombSum(L, K, S, LC) :- findall(C, combSum(L, K, S, C), LC).

test(LC):-allCombSum([3, 2, 7, 5, 1, 6], 2, 9, LC).