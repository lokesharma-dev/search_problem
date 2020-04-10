%%%%%%%%%%%%%%Comments%%%%%%%%%%%
% We hereby could find the solution for first level, by using all
% constraints present in the map (water and lily pads) and on top of
% that using cartesian coordinates (X,Y).


init_state_lpads(frog, p(0,0),[p(1,0),p(1,1),p(1,2),p(2,2),p(3,2),p(4,2),p(4,1),p(4,0),p(5,0),p(2,-1),p(3,-1)]).

%constraints
c(0,1,water).
c(0,2,water).
c(0,3,water).
c(1,3,water).
c(2,3,water).
c(3,3,water).
c(4,3,water).
c(5,3,water).
c(5,2,water).
c(5,1,water).
c(5,-1,water).
c(4,-1,water).
c(3,-2,water).
c(2,-2,water).
c(1,-1,water).
c(0,-1,water).
c(2,1,water).
c(3,1,water).
c(2,0,water).
c(3,0,water).

c(1,5,water).
c(1,4,water).
c(2,5,water).
c(2,4,water).
c(3,5,water).
c(3,4,water).
c(4,5,water).
c(4,4,water).
c(5,5,water).
c(5,4,water).

c(-2,2,water).
c(-2,1,water).
c(-2,0,water).
c(-1,2,water).
c(-1,1,water).
c(-1,0,water).

c(1,-2,water).
c(1,-3,water).
c(2,-3,water).
c(2,-4,water).
c(3,-3,water).
c(3,-4,water).
c(4,-2,water).
c(4,-3,water).
c(5,-2,water).
c(5,-3,water).
c(6,2,water).
c(7,2,water).
c(6,1,water).
c(7,1,water).
c(6,0,water).
c(7,0,water).
c(8,0,water).

c(-3,0,water).
c(0,-2,water).
c(0,-3,water).

% Table of moves, allowing moviments just upwards, downwards and not
% diagonal.

move(  p( _, _ ), up1    ).
move(  p( _, _ ), up2    ).
move(  p( _, _ ), up3    ).

move(  p( _, _ ), down1  ).
move(  p( _, _ ), down2 ).
move(  p( _, _ ), down3  ).

move(  p( _, _ ), left1  ).
move(  p( _, _ ), left2  ).
move(  p( _, _ ), left3  ).

move( p( _, _ ), right1 ).
move( p( _, _ ), right2 ).
move( p( _, _ ), right3 ).

%state update available

% UP1
update(  p(X, Y), up1, p(X, Y_new)  ) :-
	Y_new is Y + 1.
% UP2
update(  p(X, Y), up2, p(X, Y_new)  ) :-
	Y_new is Y + 2.
% UP3
update(  p(X, Y), up3, p(X, Y_new)  ) :-
	Y_new is Y + 3.

% DOWN1
update(  p(X,Y), down1, p(X, Y_new) ) :-
	Y_new is Y - 1.

% DOWN2
update(  p(X,Y), down2, p(X, Y_new) ) :-
	Y_new is Y - 2.

% DOWN3
update(  p(X,Y), down3, p(X, Y_new) ) :-
	Y_new is Y - 3.

% LEFT1
update(  p(X,Y), left1, p(X_new, Y)  ) :-
	X_new is X - 1.
% LEFT2
update(  p(X,Y), left2, p(X_new, Y)  ) :-
	X_new is X - 2.
% LEFT3
update(  p(X,Y), left3, p(X_new, Y)  ) :-
	X_new is X - 3.

% RIGHT1
update(  p(X,Y), right1, p(X_new, Y)  ) :-
X_new is X + 1.
% RIGHT2
update(  p(X,Y), right2, p(X_new, Y)  ) :-
X_new is X + 2.
% RIGHT3
update(  p(X,Y), right3, p(X_new, Y)  ) :-
X_new is X + 3.

%checks whether a state is feasible or not

feasible(  p(X,Y) ) :-
	%X >= 0,
    %Y >= 0,
\+ c(X,Y,water).

%problem solving

solve_pads(_, _, _, [H|T],[]):- write(eureca),nl,write(T),!.

solve_pads(Problem, State, History, [Move|Moves],NotVisited) :-
	move(State, Move),
	update(State, Move, NewState),
	feasible(NewState),
	\+ member(NewState, History),%ckeck if is visited
        %print(NewState),
        del(NewState,NotVisited,List),
				solve_pads(Problem, NewState, [NewState|History], Moves,List). %not visited yet

solve_problem(Problem, Solution) :-
	init_state_lpads(Problem, Initial,NoVisited),
        solve_pads(Problem, Initial, [Initial], Solution,NoVisited).

% Auxiliar%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
del(X,[X|Tail],Tail).
del(X,[Head|Tail],[Head|NewTail]):-
    del(X,Tail,NewTail).
