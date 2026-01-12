% Write a predicate that decomposes a list of numbers into a list of the form [list-of-even-numbers, list-of-odd-numbers] (i.e., a list with two elements, each being a list of integers), and also returns the number of even and odd elements.

split(L, [L1, L2], CE, CO)  :-
    split_helper(L, L1, L2, CE, CO).

% split_helper(L, L1, L2, CE, CO)

split_helper([], [], [], 0, 0).
split_helper([H | T], [H | L1], L2, CE1, CO) :-
    H mod 2 =:= 0,
    !,
    split_helper(T, L1, L2, CE, CO),
    CE1 is CE + 1.

split_helper([H | T], L1, [H | L2], CE, CO1) :-
    split_helper(T, L1, L2, CE, CO),
    CO1 is CO + 1.