
% Überstzung der spezifizierten Instanzen
node(X, Y) :- init(object(node, _), value(at, (X, Y))).
robot(R) :- init(object(robot, R), value(at, (_, _))).
shelf(X, Y, N) :- init(object(shelf,N),value(at,(X,Y))).
station(X, Y, N) :- init(object(pickingStation,N),value(at,(X,Y))).
product(N, S) :- init(object(product,N),value(on,(S,_))), shelf(X, Y, S).
highway(X, Y) :- init(object(highway,_),value(at,(X,Y))).
start(X, Y, R) :- init(object(robot, R), value(at, (X, Y))).
%order(P, S, N) :- init(object(order, N), value(line, (P, A))), init(object(order, N), value(pickingStation, S)).
% bei erneutem solven (weil weg blockiert war) muss festgelegt werden was bereits erledigt wurde
#external pickup(0).
#external deliver(0).
#external block(X, Y) : node(X, Y).

time(1..30).

pos(X, Y, 0, R) :- start(X, Y, R).
dir(1, 0). dir(-1,0). dir(0, 1). dir(0, -1).
pos(X+DX, Y+DY, T, R) :- pos(X, Y, T-1, R), move(DX, DY, T, R), robot(R).


{move(X, Y, T, R) : dir(X, Y)} <= 1 :- pos(PX, PY, T-1, R), node(PX, PY), time(T), not action(T, R), robot(R).

pos(X, Y, T, R) :- pos(X, Y, T-1, R), node(X, Y), time(T), action(T, R), robot(R).

{move(X, Y, T, R) : dir(X, Y)} <= 1 :- pos(PX, PY, T-1, R), node(PX, PY), time(T), action(T-1, R), robot(R).


action(T, R) :- {pickup(T, R); deliver(T, R); putdown(T, R)} = 1, time(T), robot(R).

:- pos(X, Y, _, _), block(X, Y).
:- pos(X, Y, _, _), not node(X, Y).
:- pos(X, Y, T, R), shelf(X, Y, _), not goal(X, Y, 1, R), time(T). % zu t=0 darf roboter auf feld mit shelf stehen
:- pos(X, Y, _, R), station(X, Y, N), not goal(X, Y, 2, R).
:- move(X, Y, T, R), move(-X, -Y, T-1, R), time(T).

pickup(T, R) :- pos(X, Y, T-1, R), goal(X, Y, 1, R), not putdown(T, R), not pickup(T-1, R), not putdown(T-1, R), not carries(T-1, R), robot(R).
:- not pickup(_, R), robot(R).

carries(T, R) :- pickup(T, R).
carries(T, R) :- carries(T-1, R), not putdown(T, R), time(T).

deliver(T, R) :- pos(X, Y, T-1, R), goal(X, Y, 2, R), pickup(T2, R), T > T2, not deliver(T-1, R), robot(R).
:- not deliver(_, R), robot(R).
putdown(T, R) :- pos(X, Y, T-1, R), goal(X, Y, 3, R), deliver(T2, R), T > T2, carries(T-1, R).
:- not putdown(_, R), robot(R).

#minimize{1,T : move(X, Y, T, R)}.

{goal(X, Y, 1, R) : shelf(X, Y, N), product(P, N)} = 1 :- order(P, _, R), robot(R).
goal(X, Y, 2, R) :- order(P, S, R), station(X, Y, S).
goal(X, Y, 3, R) :- goal(X, Y, 1, R).

#show move/4.
#show pos/4.

#show pickup/2.
#show deliver/2.
#show putdown/2.
#show carries/2.

