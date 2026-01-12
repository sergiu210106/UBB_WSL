
color(red).
color(blue).
color(orange).

:-dynamic used/1.



find_all(X, P, L):-call(P, X), not(used(X)), assert(used(X)), find_all(_, P, L1), L=[X|L1], retract(used(X)).
find_all(_,_,[]).

find(X,P,L):-call(P,X), \+ used(X) -> assert(used(X)), find(_,P,L1), L=[X|L1], retract(used(X)); L=[].