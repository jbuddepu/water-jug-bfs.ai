% Capacities of jugs
capacity(12,8,3,5).

% Goal state
goal((6,6,0,0)).

% Move: Fill a jug
move((A,B,C,D),(12,B,C,D),fill_jug1).
move((A,B,C,D),(A,8,C,D),fill_jug2).
move((A,B,C,D),(A,B,3,D),fill_jug3).
move((A,B,C,D),(A,B,C,5),fill_jug4).

% Move: Empty a jug
move((A,B,C,D),(0,B,C,D),empty_jug1).
move((A,B,C,D),(A,0,C,D),empty_jug2).
move((A,B,C,D),(A,B,0,D),empty_jug3).
move((A,B,C,D),(A,B,C,0),empty_jug4).

% Pour Jug1 -> Jug2
move((A,B,C,D),(A1,B1,C,D),pour_1_to_2) :-
    capacity(_,MaxB,_,_),
    Transfer is min(A, MaxB-B),
    A1 is A-Transfer,
    B1 is B+Transfer.

% Pour Jug2 -> Jug1
move((A,B,C,D),(A1,B1,C,D),pour_2_to_1) :-
    capacity(MaxA,_,_,_),
    Transfer is min(B, MaxA-A),
    B1 is B-Transfer,
    A1 is A+Transfer.

% Pour Jug1 -> Jug3
move((A,B,C,D),(A1,B,C1,D),pour_1_to_3) :-
    capacity(_,_,MaxC,_),
    Transfer is min(A, MaxC-C),
    A1 is A-Transfer,
    C1 is C+Transfer.

% Pour Jug1 -> Jug4
move((A,B,C,D),(A1,B,C,D1),pour_1_to_4) :-
    capacity(_,_,_,MaxD),
    Transfer is min(A, MaxD-D),
    A1 is A-Transfer,
    D1 is D+Transfer.

% BFS Search
solve :-
    bfs([(0,0,0,0)], [], Path),
    write('Solution Path: '), nl,
    print_path(Path).

bfs([State|_], _, [State]) :-
    goal(State).

bfs([State|Rest], Visited, [State|Path]) :-
    findall(Next,
        (move(State, Next, _),
         \+ member(Next, Visited)),
        Children),
    append(Rest, Children, Queue),
    bfs(Queue, [State|Visited], Path).

print_path([]).
print_path([H|T]) :-
    write(H), nl,
    print_path(T).
