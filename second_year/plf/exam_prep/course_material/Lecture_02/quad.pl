
solve(A,B,C) :-
    D is B*B-4*A*C,
    respond(A,B,D),
    nl.
respond(_,_,D) :-
    D<0,
    write("There are no solutions").
respond(A,B,D) :-
    D=:=0,
    X is -B/(2*A),
    write("x = "), write(X).
respond(A,B,D) :-
    D>0,
    SqrtD is sqrt(D),
    X1 is (-B-SqrtD)/(2*A),
    X2 is (-B+SqrtD)/(2*A),
    write("x1 = "), write(X1), write(" x2 = "), write(X2).
goal1 :- solve(1,2,0).
goal2 :- read(X), read(Y), read(Z), solve(X,Y,Z).

backward([],[]).
backward([H,T],L):- backward(T,T1), L = [T1,H].