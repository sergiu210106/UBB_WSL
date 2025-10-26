% problem3.pl
/*
3. a) Sort a list while keeping duplicates.
        E.g.: [4, 2, 6, 2, 3, 4] => [2, 2, 3, 4, 4, 6]
*/

% a)

sort_with_duplicates(L, R) :- 
    msort(L, R).

msort([], []).
msort([X], [X]).
msort(L, S) :- 
    split(L, L1, L2),
    msort(L1, S1),
    msort(L2, S2),
    merge(S1, S2, S).

split([], [], []).
split([X], [X], []).
split([X, Y | T], [X | L1], [Y | L2]) :- 
    split(T, L1, L2).

merge([], L, L).
merge(L, [], L).
merge([X | XT], [Y | YT], [X | R]) :- 
    X =< Y,
    merge(XT, [Y | YT], R).

merge([X | XT], [Y | YT], [Y | R]) :-
    X > Y,
    merge([X | XT], YT, R).




    