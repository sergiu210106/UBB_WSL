% Given a graph of n countries on a map where the nodes a the countries and te edges
% represent that the two countries are neigbours. Find all ways to color n countries with m
% colors where no two neighbouring countries share a color.

map_coloring(Countries, Neighbours, Colors, Colorings) :-
    findall(Assignment, (assign_colors(Countries, Colors, Assignment), valid(Assignment, Neighbours)), Colorings).
assign_colors([], _, []).
assign_colors([C | CT], Colors, [(C, Color) | R]) :-
    member(Color, Colors),
    assign_colors(CT, Colors, R).

valid(_, []).
valid(Assignment, [(A, B) | R]) :-
    \+ same_color(A, B, Assignment).
    valid(Assignment, R).
same_color(A, B, Assignment) :-
    member((A, Color), Assignment),
    member((B, Color), Assignment).
