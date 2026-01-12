p(a, b).
p(b, c).
p(a, c).
p(a, d).
all(X, L) :- findall(Y, p(X, Y), L).

% ?-all(a,L).

my_findall(X,P,L):- P(X,Y)