insert(E,L,[E|L]).
insert(E,[H|T],[H|R]) :-
    insert(E,T,R).

remove(E,[E|T],T).
remove(E,[H|T],[H|R]) :-
    remove(E,T,R).

permutation([],[]).
permutation(L,[H|R]) :-
    remove(H,L,L1),
    permutation(L1,R).

permutation2([],[]).
permutation2(L,[H|R]) :-
    insert(H,Z,L),
    permutation2(Z,R).

permutation3([],[]).
permutation3([E|T], P) :-
    permutation3(T, P1),
    remove(E, P, P1).