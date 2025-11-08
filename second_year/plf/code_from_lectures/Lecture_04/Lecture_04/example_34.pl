% write a predicate that produces all permutations of a list

insert(E, L, [E|L]).
insert(E, [H|T], [H|Rez]):-insert(E, T, Rez).

elim(E, L, [E|L]).
elim(E, [A|L], [A|X]):-elim(E, L, X).

perm([], []).

% perm([E|T], P) :-perm(T, L), insert(E, L, P).

% perm(L, [H|T]) :-elim(H, Z, L), perm(Z, T).

% perm(L, [H|T]) :-insert(H, Z, L), perm(Z, T).

perm([E|T], P) :-perm(T, L),elim(E, L, P).


test(P):-perm([1, 2, 3], P).