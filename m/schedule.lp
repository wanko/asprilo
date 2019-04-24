%%%%%%%%%%%%%%%%%%%%%
%% Schedule robots %%
%%%%%%%%%%%%%%%%%%%%%
% movement
&diff{ 0-(R,N) } <= 0 :- start(R,N).
&diff{ (R,N)-0 } <= 0 :- start(R,N).
&diff{ (R,N)-(R,N') } <= -1 :- move(R,N,N').
% collision
{ seq(R,R',N) } :- R<R', visit(R,N), visit(R',N).
seq(R',R,N) :- R<R', visit(R,N), visit(R',N), not seq(R,R',N).
:- sink(N), not move(R,N,_), seq(R,R',N).
:- seq(R,R',N), move(R,N,N'), move(R',N',N), not seq(R,R',N').
&diff { (R,N')-(R',N) } <= 0 :- seq(R,R',N), move(R,N,N').

