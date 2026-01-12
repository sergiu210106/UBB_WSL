reverse([],L,L).
reverse([H|T],Acc,R):- reverse(T,[H|Acc],R).

reverse(L,R):- reverse(L,[],R).