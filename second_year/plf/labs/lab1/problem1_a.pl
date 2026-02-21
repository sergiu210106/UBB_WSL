/* 
a) Write a predicate that returns the difference of two sets
*/

member([E | _], E) :- !.
member([_ | T], E) :- member(T, E).

diff([], _, []).
diff([H | T1], Y, [H | R]) :-
    \+ member(Y, H), !,
     diff(T1, Y, R).
diff([_ | T1], Y, R) :- 
    diff(T1, Y, R).
