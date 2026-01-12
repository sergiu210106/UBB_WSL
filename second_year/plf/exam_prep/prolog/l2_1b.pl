% Starting from a list consisting of integers and lists of digits, compute the sum of all numbers represented as sublists. E.g.: [1,[2,3],4,5,[6,7,9],10,11,[1,2,0],6] => [8,2,2].
?- consult('l2_1a.pl').

sum_sublists(L, R) :- 
    sum_sublists_helper(L, [], R). 

sum_sublists_helper([], Acc, Acc).
sum_sublists_helper([H | T], Acc, R) :- 
    is_list(H),
    sum_list(Acc, H, NewAcc),
    sum_sublists_helper(T, NewAcc, R).
