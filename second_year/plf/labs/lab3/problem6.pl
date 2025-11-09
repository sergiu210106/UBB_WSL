% 6. Find all lists of N correctly closed pairs of paratheses. E.g., n=4 (()) si ()()

% generate
generate(0, 0, R, R).

generate(Open, Closed, Acc, R) :- 
    Open > 0,
    Open1 is Open - 1,
    generate(Open1, Closed, ['(' | Acc], R).

generate(Open, Closed, Acc, R) :-
    Closed > Open,
    Closed1 is Closed - 1,
    generate(Open, Closed1, [')' | Acc], R).

% reverse function
my_reverse(L, R) :-
    my_reverse_acc(L, [], R).

my_reverse_acc([], Acc, Acc).
my_reverse_acc([H | T], Acc, R) :- 
    my_reverse_acc(T, [H | Acc], R).


% main
parentheses(N, R) :-
    generate(N, N, [], R1),
    my_reverse(R1, R).


