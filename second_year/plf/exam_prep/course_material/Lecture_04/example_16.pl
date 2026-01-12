% The three house problem
% 1. The englishman lives in the first house on the left
% 2. On the right of the house with the wolf the owner smokes Lucky Strike
% 3. The spaniard smokes kent
% 4. The russian has a horse
%
% Who smokes LM? Who owns the dog?

solve(N, A, T) :-
    candidates(N, A, T),
    restrictions(N, A, T).
candidates(N, A, T) :-
    perm([eng, spa, russian], N),
    perm([caine, wolf, horse], A),
    perm([lm, kent, ls],T).
restrictions(N, A, T) :-
    aux(N, A, T, eng ,_ , _, 1),
    aux(N, A, T, _, wolf, _, Nr),
    right(Nr, M),
    aux(N, A, T, _, _, ls, M),
    aux(N, A, T, spa, _, kent, _),
    aux(N, A, T, russian, horse, _, _).

right(I,J) :- J is I+1.

aux([N1 ,_ ,_], [A1, _, _], [T1, _, _], N1, A1, T1, 1).
aux([_, N2, _], [_, A2, _], [_, T2,_], N2, A2, T2, 2).
aux([_, _, N3], [_, _, A3], [_, _, T3], N3, A3, T3, 3).

insert(E, L, [E|L]).
insert(E, [H|L], [ H|T]) :- insert(E,L,T).

perm([], []).
perm([H|T], L):-perm(T, P),insert(H, P, L).