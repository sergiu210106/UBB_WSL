concatenate([],L,L).
concatenate([H|L1],L2,[H|L3]):-concatenate(L1,L2,L3).