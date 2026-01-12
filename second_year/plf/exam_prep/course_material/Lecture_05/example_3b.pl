% no tail recursion
f(N) :-
    write(N),
    nl,
    NN is N + 1,
    f(NN),
    nl.