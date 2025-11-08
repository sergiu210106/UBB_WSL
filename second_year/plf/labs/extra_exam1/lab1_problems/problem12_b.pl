/* 
(b) Construct the sublist (lm, ..., ln) of the list (l1, ..., lk).
*/

% cut_list(L, M, N, R) 
cut_list([], _, _, []) :- !.
cut_list(_, _, 0, []) :- !.
cut_list([], M, N, []) :- 
    M > N, !.
cut_list([H | T], 1, N, [H | R]) :-
    N > 0,
    N1 is N - 1,
    cut_list(T, 1, N1, R).

cut_list([_ | T], M, N, R) :- 
    M > 1,
    M1 is M - 1,
    N1 is N - 1,
    cut_list(T, M1, N1, R).

