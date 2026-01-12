g([H|_],E,[E,H]).
g([_|T],E,P):-
    g(T,E,P).

f([H|T],P):-
    g(T,H,P).
f([_|T],P):-
    f(T,P).

solutions(_, N) :-
  solution(Q, N),
  (cache(Qs) -> retractall(cache(_)) ; Qs = []),
  assert(cache([Q|Qs])),
  fail.
solutions(Qs, _) :-
  retract(cache(Qs)).