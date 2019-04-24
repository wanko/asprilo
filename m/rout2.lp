%%%%%%%%%%%%%%%%%%
%% Route robots %%
%%%%%%%%%%%%%%%%%%

1{ sink(R,N) : robot(R) }1 :- sink(N).
1{ sink(R,N) : sink(N)  }1 :- robot(R).
{ move(R,N,N') : nextto(N,_,N') }1 :- robot(R), position(N).
{ move(R,N,N') : nextto(N,_,N') }1 :- robot(R), position(N').

:- sink(R,N), not move(R,_,N).
:- sink(R,N), move(R,N,_).

visit(R,N)  :- start(R,N).
visit(R,N') :- visit(R,N), move(R,N,N').
%:- move(R,N,_), not visit(R,N).
:- move(R,_,N'), not visit(R,N').

#show move/3.
