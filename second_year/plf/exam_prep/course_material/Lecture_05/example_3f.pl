% tail recursion
f(N) :-
    N>= 0,
    !,
    write(N),
    nl,
    NN = N + 1,
    f(NN).
f(N) :-
    N < 0,
    write("N is negative.").