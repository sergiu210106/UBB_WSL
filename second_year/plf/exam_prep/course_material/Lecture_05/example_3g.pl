% tail recursion due to using cut
f(N) :-
    write(N),
    nl,
    NN = N + 1,
    check(NN),
    !,
    f(NN).
check(Z) :- Z >= 0.
check(Z) :- Z < 0.