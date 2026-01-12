%  Write a predicate that determines the least common multiple of the elements of a list of integers.
gcd(A, 0, A) :- !.
gcd(A, B, R) :-
    Rest is A mod B,
    gcd(B, Rest, R).

lcm(A, B, R) :- 
    gcd(A, B, (A*B) // R).

lcm_list([H], H) :- !.
lcm_list([H | T], R) :-
    lcm_list(T, R1),
    lcm(H, R1, R).