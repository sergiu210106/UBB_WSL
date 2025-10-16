/*
6. (a) Write a predicate that removes from a list all elements that are 
repeated (e.g., l=[1,2,1,4,1,3,4] ⇒ l=[2,3]).
*/

counter(_, [], 0).

counter(H, [H | T], N) :-
    counter(H, T, N1),
    N is N1 + 1.

counter(X, [H | T], N) :- 
    H \= X,
    counter(X, T, N).

helper([], _, []).

helper([H | T], OriginalList, [H | ResultTail]) :-
    counter(H, OriginalList, N),
    N == 1,
    helper(T, OriginalList, ResultTail).

helper([H | T], OriginalList, Result) :-
    counter(H, OriginalList, N),
    N > 1,
    helper(T, OriginalList, Result).

remove_repeated(List, Result) :-
    helper(List, List, Result). 

