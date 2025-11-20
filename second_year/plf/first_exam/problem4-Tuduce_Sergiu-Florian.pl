% Let N be a natural number with distinct digits. Find all numbers with the property that their digits are valley-shaped that can be formed using the digits of N.
% PROBLEM 4
digits(0, []) :- !.
digits(N, [X | L]) :- 
    X is N mod 10,
    N1 is N div 10,
    digits(N1, L).

valley_flag([_], 1).

valley_flag([H1, H2 | T], 0) :-
    H1 > H2,
    valley_flag([H2 | T], 0),!.
valley_flag([H1, H2 | T], 0) :-
    H1 < H2,
    valley_flag([H2 | T], 1), !.
valley_flag([H1, H2 | T], 1) :- 
    H1 < H2,
    valley_flag([H2 | T], 1),!.

valley([H1, H2 | T]) :-     
    H1 > H2,
    valley_flag([H2 | T], 0).

select(X, [X | T], T).
select(X, [Y | T], [Y | R]) :- select(X, T, R).

permutation([], []).
permutation(L, [X | P]) :-
    select(X, L, R),
    permutation(R, P).

solve(N, S) :-
    digits(N, Digits),
    permutation(Digits, S),
    valley(S).