kevin_spacey_filmjei(Film, Ev):-
    movie(Film, Ev),
    actor(Film, kevin_spacey, _).

%ures lista, leallasi feltetel
duplaz([], []).

%duplaz(L1, L2):-
%    L1 = [H | T1],
%    %kovetkezo ket sor sorrendje mindegy, a compiler megoldja magatol
%    L2 = [H, H | T2],
%    duplaz(T1, T2).

%rovidebb verzio, forditva is mukodik
duplaz([H|T1], [H, H | T2]):-
    duplaz(T1, T2).



%Labor%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
deriv(A+B, Da+Db).

szabaly(X+0, X).

%egymas melletti dolgokra foleg (pl: 2+3+X, de nem muszaj 2+X+3)
egyszerusites(X, Y):-
    szabaly(X, Xe),
    X \= Xe,
    !,
    egyszerusites(Xe, Y).

eyszerusites(X, X).

%node(5,null,null) = node(E,Bal,Jobb)












