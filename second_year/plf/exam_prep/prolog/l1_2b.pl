% (b) Write a predicate that adds a given value v after the 1st, 2nd, 4th, 8th, ... element of a list.

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