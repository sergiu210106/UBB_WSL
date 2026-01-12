% write a predicate that produces all sublists with more than two elements that sum to a value from a given list


candidate(E,[E|_]).
candidate(E,[_|T]) :-
    candidate(E,T).

combSum(L, K, S, C) :-
    candidate(E, L),
    E =< S,
    combaux(L, K, S, C, 1, E, [E]).

combaux(_, K, S, C, K, S, C) :- !.
combaux(L, K, S, C, Lg, Sum, [H|T]) :-
    Lg<K,
    candidate(E, L),
    E<H,
    Sum1 is Sum+E,
    Sum1 =< S,
    Lg1 is Lg+1,
    combaux(L, K, S, C, Lg1, Sum1, [E|[H|T]]).


% combaux(L, K, S, C, Lg, Sum, [H|T]) :-
%     condition(L, K, S, Lg, Sum, H, E),
%     Lg1 is Lg+1,
%     Sum1 is Sum + E,
%     combaux(L, K, S, C, Lg1, Sum1, [E|[H|T]]).

% condition(L, K, S, Lg, Sum, H, E):-
%     Lg < K,
%     candidate(E,L),
%     E < H,
%     Sum1 is Sum + E,
%     Sum1 =< S.

allCombSum(L, K, S, LC) :- findall(C, combSum(L, K, S, C), LC).

test(LC):-allCombSum([3, 2, 7, 5, 1, 6], 2, 9, LC).