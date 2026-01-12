member(E,[E|_]).
member(E,[_|L]):-member(E,L).

member2(E,[E|_]):-!.
member2(E,[_|L]):-member2(E,L).

member3(E,[_|L]):-member3(E,L).
member3(E,[E|_]).

% ?- member3(E,[1,2,3]).