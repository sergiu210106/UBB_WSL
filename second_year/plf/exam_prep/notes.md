# Prolog
## Lab 1

### Problem 1
#### a) Write a predicate that returns the difference of two sets
```prolog
% Base case
set_difference([], _, []).

% if the head is in the second list skip, else add it
set_difference([H | T], L2, R):-
    member(H, L2),
    !,
    set_difference(T, L2, R).

set_difference([H | T], L2, [H | R]) :-
    set_difference(T, L2, R).
```

#### (b) Write a predicate that adds the value 1 after every even element in a list.

```prolog
% Base case
add_one([], []).

% if the number is even, add one after it, else skip
add_one([H | T], [H, 1 | R]) :-
    H mod 2 =:= 0,
    !,
    add_one(T, R).

add_one([H | T], [H | R]):-
    add_one(T, R).
```

### Problem 2
#### (a)  Write a predicate that determines the least common multiple of the elements of a list of integers.
```prolog
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
```

#### (b) Write a predicate that adds a given value v after the 1st, 2nd, 4th, 8th, ... element of a list.

```prolog
% power2(N) -> true if N is a power of 2
power2(1).
power2(X) :- 
    X mod 2 =:= 0,
    X1 is X div 2,
    power2(X1).

% add V after each index power of 2
add_v(L, V, R) :-
    add_v_helper(L, V, 1, R).

add_v_helper([], _, _, []).
add_v_helper([H | T], V, I, [H, V | R]) :-
    power2(I),
    !,
    I1 is I + 1,
    add_v_helper(T, V, I1, R).
add_v_helper([H | T], V, I, [H | R]) :-
    I1 is I + 1,
    add_v_helper(T, V, I1, R).
```

### Problem 3
#### (a) Write a predicate that transforms a list into a set, preserving the order of first appearance. Example: [1,2,3,1,2] is transformed into [1,2,3].
```prolog
preserve(L, R) :-
    helper(L, [], R).
helper([], _, []).
helper([H | T], Acc, R):- 
    member(H, Acc),
    !,
    helper(T, Acc, R).
helper([H | T], Acc, [H | R]) :-
    helper(T, [H | Acc], R).

```

#### (b) Write a predicate that decomposes a list of numbers into a list of the form [list-of-even-numbers, list-of-odd-numbers] (i.e., a list with two elements, each being a list of integers), and also returns the number of even and odd elements.
```prolog
split(L, [L1, L2], CE, CO)  :-
    split_helper(L, L1, L2, CE, CO).

% split_helper(L, L1, L2, CE, CO)

split_helper([], [], [], 0, 0).
split_helper([H | T], [H | L1], L2, CE1, CO) :-
    H mod 2 =:= 0,
    !,
    split_helper(T, L1, L2, CE, CO),
    CE1 is CE + 1.

split_helper([H | T], L1, [H | L2], CE, CO1) :-
    split_helper(T, L1, L2, CE, CO),
    CO1 is CO + 1.
```

### Problem 4
#### (a) Write a predicate that substitutes an element in a list with another list.
```prolog
% subs(List, Element, SubsList, Result)
subs([], _, _, []).
subs([E | T], E, SL, R) :-
    !,
    subs(T, E, SL, R1),
    append(SL, R1, R).

subs([H | T], E, SL, [H | R]) :- 
    subs(T, E, SL, R).
```

#### (b) Remove the element at the n-th position of a linear list.
```prolog
% remove_nth(List, N, Result)
remove_nth(L, N, R) :-
    helper(L, 1, N, R).

% helper(List, I, N, Result)
helper([], _, _, []).

helper([_ | T], N, N, R) :-
    !,
    I1 is N + 1,
    helper(T, I1, N, R).

helper([H | T], I, N, [H | R]) :-
    I1 is I + 1,
    helper(T, I1, N, R).
```

### Problem 5

#### (a) Write a predicate that deletes all occurrences of a certain atom from a list.

```prolog
remove_all([], _, []).
remove_all([E | T], E, R) :- 
    !,
    remove_all(T, E, R).
remove_all([H | T], E, [H | R]) :-
    remove_all(T, E, R).
```

#### (b) Define a predicate that, from a list of atoms, produces a list of pairs (atom n), where atom appears n times in the initial list. For example: numar([1, 2, 1, 2, 1, 3, 1], X) will produce X = [[1, 4], [2, 2], [3, 1]].
```prolog
numar([], []).
numar([H | T], [[H, C] | R]) :- 
    count_occurrences([H | T], H, C),
    remove_all([H | T], H, L1),
    numar(L1, R).

count_occurrences([], _, 0).
count_occurrences([E | T], E, R) :- 
    !,
    count_occurrences(T, E, R1),
    R is R1 + 1.
count_occurrences([_ | T], E, R) :- 
    count_occurrences(T, E, R).

remove_all([], _, []).
remove_all([E | T], E, R) :-
    !,
    remove_all(T, E, R).
remove_all([H | T], E, [H | R]) :- 
    remove_all(T, E, R).
```

## Lab 2
### Problem 1
#### (a) Define a predicate that determines the sum of two numbers written in list representation.

```prolog
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
```
#### (b) Starting from a list consisting of integers and lists of digits, compute the sum of all numbers represented as sublists. E.g.: [1,[2,3],4,5,[6,7,9],10,11,[1,2,0],6] => [8,2,2].
```prolog
?- consult('l2_1a.pl').

sum_sublists(L, R) :- 
    sum_sublists_helper(L, [], R). 

sum_sublists_helper([], Acc, Acc).
sum_sublists_helper([H | T], Acc, R) :- 
    is_list(H),
    sum_list(Acc, H, NewAcc),
    sum_sublists_helper(T, NewAcc, R).
```

### Problem 3
#### (a) Sort a list while eliminating duplicates. E.g.: [4 2 6 2 3 4] => [2 3 4 6]