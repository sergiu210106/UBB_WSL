% 14. Find all sublists that sum up to S of a list. E.g., [1,2,3,4,5,6,10] si S=10 ⇒ [[1,2,3,4],
% [1,4,5], [2,3,5], [4,6], [10]] not necesarily in that order.
subset([], []).
subset([_ | T], R) :- subset(T, R).
subset([H | T], [H | R]) :- subset(T, R).

sum([], 0).
sum([H | T], S) :-
    sum(T, S1),
    S is S1 + H.

solve(L, S, R) :- 
    subset(L, R),
    sum(R, S).
