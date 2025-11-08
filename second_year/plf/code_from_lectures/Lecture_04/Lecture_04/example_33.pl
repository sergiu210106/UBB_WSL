% write a predicate that produces all sublists by eliminating a value from all positions of the list

elim(E, L, [E|L]).
elim(E, [A|L], [A|X]):-elim(E, L, X).

test(L):-elim(1, L, [1, 2, 1, 3, 1]).