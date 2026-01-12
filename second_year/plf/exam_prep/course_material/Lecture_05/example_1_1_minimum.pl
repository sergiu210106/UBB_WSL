% Calculate the minimum of a list

minimum([A], A).
minimum([H|T], H) :-
    minimum(T, M),
    H =< M, !.
minimum([_|T], M) :-
    minimum(T, M).

% Using auxiliary predicate to avoid recursive call
minimum2([A], A).
minimum2([H|T], Rez) :-
    minimum2(T, M), aux(H, M, Rez).
aux(H, M, Rez) :-
    H =< M, !, Rez=H.
aux(_, M, M).

% compact solution speciffic to instance
minimum3([A], A).
minimum3([H|T], M) :-
    minimum3(T, M),
    H > M, !.
minimum3([H|_], H).