maux([_],1).
maux([H1,H2|T],0):-
    H1=<H2,
    maux([H2|T],0),!.
maux([H1,H2|T],0):-
    H1>H2,
    maux([H2|T],1),!.
maux([H1,H2|T],1):-
    H1>H2,
    maux([H2|T],1),!.

mountain([H1,H2|T]):-
    H1=<H2,
    maux([H2|T],0),!.

ex([],0).
ex([H|T],S):-
    is_list(H),
    mountain(H),!,
    ex(T,S1),
    S is S1+1.
ex([_|T],S):-ex(T,S).
% ex([H|T],S):-is_list(H),not(mountain(H)),ex(T,S).
% ex([H|T],S):-not(is_list(H)),ex(T,S).