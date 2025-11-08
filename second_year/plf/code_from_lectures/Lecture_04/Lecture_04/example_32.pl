% write a predicate that inserts a value on all positions of a list

insert(E, L, [E|L]).
insert(E, [H|T], [H|Rez]):-insert(E, T, Rez).

test(L):-insert(1, [2, 3], L).