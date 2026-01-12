pushfront([],E,[E]).
pushfront(L,E,[E|L]).

pushback([],E,[E]).
pushback([H|T],E,[H|R]):-pushback(T,E,R).

pushback2([],E,[E]).
pushback2([H|T],E,R):-pushback(T,E,L), R=[H|L].