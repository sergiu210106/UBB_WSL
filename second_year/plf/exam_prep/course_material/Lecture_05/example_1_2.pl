% Find the maximum of a list

max([E],E).
max([H|T],Y):-
    f(T,X),
    H>=X,
    !,
    Y=H.
max([_|T],X):- f(T,X).

% Using auxiliary predicate to avoid recursive call
max2([E],E).
max2([H|T],Y):-
    max2(T,X), aux(H, X, Y).
aux(H, X, Y) :-
    H>=X,
    !,
    Y=H.
aux(_, X, X).