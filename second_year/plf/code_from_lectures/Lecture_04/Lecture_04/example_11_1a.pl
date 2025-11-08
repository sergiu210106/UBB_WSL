% write a predicate that produces all sublists with more than two elements that sum to a value from a given list


combSum([H|_], H, [H]).
combSum([H|T], S,[H|C]) :-
    S1 is S-H,
    S1>0,
    combSum(T, S1, C).
combSum([_|T], S, C) :-
    combSum(T, S, C).

allCombSum(L, S, LC) :- findall(C, combSum(L, S, C), LC).

test(LC):-allCombSum([3, 2, 7, 5, 1, 6], 9, LC).