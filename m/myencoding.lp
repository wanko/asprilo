#include "../input.lp".
%%%%%%%%%%%%%%%
%Assign orders to robots %%
%%%%%%%%%%%%%%%
1 { cycle(T,U) : order(U), U != T } 1 :- order(T).
1 { cycle(T,U) : order(T), U != T } 1 :- order(U).

% make sure the cycle is connected
reach(M) :- M = #min { T : order(T) }.
reach(U) :- reach(T), cycle(T,U).
:- order(T), not reach(T).

% select a start point
1 { start(T) : order(T) } 1.

% obtain an order
assign(1,O) :- start(O).
assign(R+1,O') :- cycle(O,O'),assign(R,O),robot(R+1),not start(O').

%%%%%%%%%%%
%% Route robots %%
%%%%%%%%%%%
sink(R,X,Y) :- ordered(order(O),A), shelved(S,A), robot(R), position(S,(X,Y),0), assign(R,O).
visit(R,X,Y) :- position(  robot(R),(X,Y),0), robot(R).
direction((X,Y)) :- X=-1..1, Y=-1..1, |X+Y|=1.
nextto((X,Y),(X',Y'),(X+X',Y+Y')) :- position((X,Y)), direction((X',Y')), position((X+X',Y+Y')).
1{ move(R,(X,Y),(X',Y')) : nextto((X,Y),_,(X',Y'))}1 :- visit(R,X,Y), not sink(R,X,Y).
visit(R,X,Y) :- move(R,_,(X,Y)).
:- sink(R,X,Y), not visit(R,X,Y).

%%%%%%%%%%%%%
%% Schedule robots %%
%%%%%%%%%%%%%
% movement
&diff{ 0-(R,(X,Y)) } <= 0 :- position(  robot(R),(X,Y),0), robot(R).
&diff{ (R,(X,Y))-0 } <= 0 :- position(  robot(R),(X,Y),0), robot(R).
&diff{ (R,(X,Y))-(R,(X',Y')) } <= -1 :- move(R,(X,Y),(X',Y')).
% collision
{ seq(R,R',(X,Y)) } :- R<R', visit(R,X,Y), visit(R',X,Y).
seq(R',R,(X,Y)) :- R<R', visit(R,X,Y), visit(R',X,Y), not seq(R,R',(X,Y)).
&diff { (R,(X',Y'))-(R',(X,Y)) } <= 0 :- seq(R,R',(X,Y)), move(R,(X,Y),(X',Y')).
#show.
#show move/3.
#show init/2.
#show nextto/3.
#heuristic move(R,C,C'):robot(R), position(C), position(C').[1,false]
%#minimize{1,R,C,C':move(R,C,C'),robot(R), position(C), position(C')}.
