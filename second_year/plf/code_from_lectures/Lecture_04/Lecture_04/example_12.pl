% Given a list of distinct integers, produce all sorted sublists with at least two elements

quick_sort(List,Sorted):-q_sort(List,[],Sorted).
q_sort([],Acc,Acc).
q_sort([H|T],Acc,Sorted):-
    pivoting(H,T,L1,L2),
    q_sort(L1,Acc,Sorted1),q_sort(L2,[H|Sorted1],Sorted).

pivoting(_,[],[],[]).
pivoting(P,[H|T], L1, L2):- P < H, pivoting(P,T,SL1,L2), L1=[H|SL1].
pivoting(P,[H|T], L1, L2):- P >= H, pivoting(P,T,L1,SL2), L2=[H|SL2].

longerThan(_,C,R):-R >= C.
longerThan([_|T],C,R):-R1 is R+1, longerThan(T,C,R1).
longerThan2(L):-longerThan(L,2,0).

ascSubsets(L,R):- quick_sort(L,SL), ascSubsetsSorted(SL,R), longerThan2(R).
ascSubsetsSorted([],[]).
ascSubsetsSorted([H|T],[H|R]):-ascSubsetsSorted(T,R).
ascSubsetsSorted([_|T],R):-ascSubsetsSorted(T,R).


test(S):-ascSubsets([2,1,3],S).