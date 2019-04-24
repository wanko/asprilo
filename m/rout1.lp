%%%%%%%%%%%%%%%%%%
%% Route robots %%
%%%%%%%%%%%%%%%%%%
visit(R,N) :- start(R,N).
{ move(R,N,N') : nextto(N,_,N')}1 :- visit(R,N).
visit(R,N) :- move(R,_,N).
:- sink(N), not 1#count{ 1,R : move(R,_,N), not move(R,N,_)}1.

#show move/3.
