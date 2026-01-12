% merge.pl
% Predicate to merge two sorted lists into a single sorted list

merge([], L, L).
merge(L, [], L).
merge([H1|T1], [H2|T2], [H1|R]) :-
    H1 =< H2,
    merge(T1, [H2|T2], R).
merge([H1|T1], [H2|T2], [H2|R]) :-
    H1 > H2,
    merge([H1|T1], T2, R).
