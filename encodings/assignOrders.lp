% available(N,X,Y) :- init(object(shelf,N),value(at,_)).
% order(P,S,N) :- init(object(order,N),value(line,(P,_))), init(object(order,N),value(pickingStation,S)).
% robot(R)
% position(R, P)
% station(X,Y,S)
% product(P,N)


 {order(P,S,N,R) : order(P,S,N)} 1 :- robot(R).
 :- order(_, _, N, R), order(_, _, N, R2), R < R2.
 

 { chooseShelf(N,R) : available(N, _, _), product(P,N) } 1 :- order(P,_,_,R), robot(R).
:- chooseShelf(N, R1), chooseShelf(N, R2), R1 < R2.
%:- robot(R), not chooseShelf(_,R).

% The goals are the points the robot has to visit: the chosen shelf, the picking station and then a place to put the shelf back down
goal((X,Y),R,(1;3)) :- chooseShelf(N,R), available(N,X,Y).
goal((X,Y),R,2) :- order(_,S,_,R), station(X,Y,S), chooseShelf(N,R).

dist(D,R,1) :- position(R, (X,Y)), goal((CX,CY),R,1), D = |CX-X| + |CY-Y|.
dist(D,R,2) :- goal((X, Y), R, 1), goal((CX,CY),R,2), D = |CX-X| + |CY-Y|.
dist(D,R,3) :- goal((X, Y), R, 2), goal((CX,CY),R,3), D = |CX-X| + |CY-Y|.

distT(D,R) :- dist(D1,R,1), dist(D2,R,2), dist(D3,R,3), D = D1+D2+D3. 
distTT(D) :- #sum{DI, R : distT(DI, R)} = D.

% Try to give every robot an order, highest priority
#maximize{R@10, N : chooseShelf(N, R)}.

% Try to minimize the estimated path length, lower priority
#minimize{D@5 : distTT(D)}.


#show order/4.
#show goal/3.
#show chooseShelf/2.

