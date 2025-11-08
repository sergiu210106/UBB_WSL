% Give a set of non-zero natural numbers represented in the form of a Lists.
% Determine all possibilities for writing a given number N in the form of a sum
% of items in the list.

cand([E|_],E).
cand([_|T],E):-cand(T,E).

sol(L, N, Rez) :-
    cand(L, E),
    E =< N,
    sol_aux(L, N, Rez, [E], E).
sol_aux(_, N, Rez, Rez, N):-!.
sol_aux(L, N, Rez, [H | Col], S) :-
    cand(L, E),
    E < H,
    S1 is S+E,
    S1 =< N,
    sol_aux(L, N, Rez, [E | [H | Col]], S1).