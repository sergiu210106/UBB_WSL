% 8. A sports bet player wants to bet on 4 soccer matches. The bets can be 1,X,2. Find all
% bes knowing that the last bet can’t be 2 and there can be no more than two X bets.

bet('1').
bet('2').
bet('X').

% my_reverse
my_reverse(L, R) :-
    my_reverse_acc(L, [], R).
my_reverse_acc([], Acc, Acc).
my_reverse_acc([H | T], Acc, R) :-
    my_reverse_acc(T, [H | Acc], R).

% last element from a list 
last([X], X).
last([H | T], R) :- last(T, R).

% last_not_two
last_not_two(B) :- 
    last(B, E),
    E \= '2'.

% count_x -> number of appearances in list 
count_x([], _,  0).
count_x([X | T], X, R) :- 
    count_x(T, X, R1),
    R is R1 + 1.
count_x([H | T], X, R) :-
    H \= X,
    count_x(T, X, R).

% valid 
valid(B) :-
    last_not_two(B),
    count_x(B, 'X', C),
    C =< 2.

% make_bets (N, Acc, R)
make_bets(0, Acc, R) :- 
    my_reverse(Acc, R),
    valid(R).
make_bets(N, Acc, R) :- 
    N > 0,
    bet(B),
    N1 is N - 1,
    make_bets(N1, [B | Acc], R).

% main
bets(R) :- 
    make_bets(4, [], R).