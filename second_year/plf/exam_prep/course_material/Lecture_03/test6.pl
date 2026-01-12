subset([],[]).
subset([_|T],S):-subset(T,S).
subset([H|T],[H|S]):-subset(T,S).

subsets(L,R):- findall(S,subset(L,S),R).