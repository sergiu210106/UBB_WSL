% mergesort.pl
% Predicate to merge two sorted lists
merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], [H1|R]) :-
    H1 =< H2,
    merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,
    merge([H1|T1], T2, R).

% Predicate to split a list into two halves
split([], [], []).
split([X], [X], []).
split([X,Y|T], [X|L1], [Y|L2]) :-
    split(T, L1, L2).

% Predicate to perform merge sort
mergesort([], []).
mergesort([X], [X]).
mergesort(L, Sorted) :-
    split(L, L1, L2),
    mergesort(L1, S1),
    mergesort(L2, S2),
    merge(S1, S2, Sorted).
