#include "../input.lp".
sink(N) :- ordered(order(O),A), shelved(S,A), robot(R), position(S,N,0).
start(R,N) :- position(robot(R),N,0), robot(R).
direction((X,Y)) :- X=-1..1, Y=-1..1, |X+Y|=1.
nextto((X,Y),(X',Y'),(X+X',Y+Y')) :- position((X,Y)), direction((X',Y')), position((X+X',Y+Y')). 

#show init/2.
#show nextto/3.
