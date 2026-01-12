insert(E, nil, tree(E, nil, nil)).
insert(E, tree(Root, Left, Right),tree(Root, NewLeft, Right)) :-
    E =< Root,
    !,insert(E, Left, NewLeft).
insert(E, tree(Root, Left, Right), tree(Root, Left, NewRight)) :-
    insert(E, Right, NewRight).

inOrder(nil).
inOrder(tree(Root,Left,Right)) :-
    inOrder(Left),
    write(Root),
    nl,
    inOrder(Right).

makeTree([], nil).
makeTree([H|T], Tree) :-
    makeTree(T, Tree1),
    insert(H, Tree1, Tree).

treeSort(L) :-
    makeTree(L,Tree),
    inOrder(Tree).