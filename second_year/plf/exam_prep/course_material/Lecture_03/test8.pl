det(L,E,LR):- det_aux(L,E,LR, 1).
det_aux([],_,[],_).
det_aux([E|T],E,[P|LR],P):-
    !,
    P1 is P+1,
    det_aux(T,E,LR,P1).
det_aux([_|T],E,LR,P):-
    P1 is P+1,
    det_aux(T,E,LR,P1).









det1(L,E,LR):-det_aux1(L,E,LR,1).
det_aux1([],_,[],_).
det_aux1([H|T],E,LR,P):-
    P1 is P+1,
    det_aux1(T,E,L,P1),
    prel(H,E,P,L,LR).
prel(E,E,P,L,[P|L]):-!.
prel(_,_,_,L,L).