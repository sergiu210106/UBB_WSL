% 9. Given a value N, find all permutations of N elements knowing that for any value i, 2 ≤
% i ≤ n, there exists j, 1 ≤ j ≤ i, such that |p(i) − p(j)| = 1.



% get 1-n in a list 
% range(N, L)

range(0, []).
range(N, L) :- 
    N > 0,
    N1 is N - 1,
    range(N1, L1),
    append(L1, [N], L).

select(X, [X | T], T).
select(X, [Y | T], [Y | R]) :- select(X, T, R).

permutation([], []).
permutation(L, [X | R]) :- 
    select(X, L, R1),
    permutation(R1, R).

% adjacent
adjacent(X, Y) :- 
    D is X - Y,
    D * D =:= 1.
% check if X has adjacent in a list 
has_adjacent(_, []) :- fail.
has_adjacent(X, [Y | _]) :- 
    adjacent(X, Y), !.
has_adjacent(X, [_ | T]) :-
    has_adjacent(X, T).
% check constraint 
check_constraint([_]) :- !. 
check_constraint(L) :- 
    check_constraint_acc(L, []).
check_constraint_acc([], _).
check_constraint_acc([H | T], Acc) :-
    has_adjacent(H, Acc),
    check_constraint_acc(T, [H | Acc]).

% main 
find_valid_permutations(N, P) :- 
    range(N, L),
    permutation(L, P),
    check_constraint(P).
