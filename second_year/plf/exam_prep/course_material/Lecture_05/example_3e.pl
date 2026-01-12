% no tail recursion
f(N) :-
    write(N),
    nl,
    NN is N + 1,
    check(NN),
    f(NN).
check(Z) :- Z >= 0.
check(Z) :- Z < 0.