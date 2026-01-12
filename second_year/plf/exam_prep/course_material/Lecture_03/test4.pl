q(1).
q(2).
q(3):-!.
q(0).
p:-q(I),I<3,write(I),nl,fail.
