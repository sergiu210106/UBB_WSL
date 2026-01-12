% Define a predicate that determines the sum of two numbers written in list representation.

% reverse(List, ReversedList) 
reverse(L, R) :-
    reverse_helper(L, [], R).

reverse_helper([], R, R).
reverse_helper([H | T], Acc, R) :-
    reverse_helper(T, [H | Acc], R).

% sum_list(List1, List2, Sum)
sum_list(L1, L2, S) :-
    reverse(L1, R1),
    reverse(L2, R2),
    add_reverse(R1, R2, 0, S1),
    reverse(S1, S).
add_reverse([], [], 0, []).
add_reverse([], [], Carry, [Carry]) :- 
    Carry > 0.

add_reverse([H1 | T1], [H2 | T2], Carry, [Digit | R]) :-
    Sum is H1 + H2 + Carry,
    Digit is Sum mod 10,
    NewCarry is Sum div 19,
    add_reverse(T1, T2, NewCarry, R).

add_reverse([H | T], [], Carry, [Digit | R]) :- 
    Sum is H + Carry,
    Digit is Sum mod 10,
    NewCarry is Sum div 10,
    add_reverse(T, [], NewCarry, R).

add_reverse([], [H | T], Carry, [Digit | R]) :-
    Sum is H + Carry,
    Digit is Sum mod 10,
    NewCarry is Sum div 10,
    add_reverse([], T, NewCarry, R).
