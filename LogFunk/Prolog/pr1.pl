%sajat append fuggveny
append2([], L, L).

append2([H|T], L2, [H|T2]):-
    append2(T, L2, T2).

%elso feladat-----------------------------------------

osszeg2([], Acc, Acc).

osszeg2([H | T], Acc, Osszeg):-
    Acc2 is Acc + H,
    osszeg2(T, Acc2, Osszeg).

%kiszamitja az L lista elemeinek osszeget
osszeg(L, Osszeg):-
    osszeg2(L, 0, Osszeg).

%masodik feladat--------------------------------------

% a sokszoroz fuggveny a H bemeno parametert K-szor beteszi egy uj
% listaba
sokszoroz(1, H, [H]):-
    !.

sokszoroz(K, H, [H | T]):-
    K>1,
    K1 is K-1,
    sokszoroz(K1, H, T).

kszor(_, [], []):-!.

% a lista minden elemet sokszorozza(K-szor), majd append fuggveny
% segitsegevel egybe illetszi a reszlistakat
kszor(K, [H|T1], Eredmeny):-
    sokszoroz(K, H, SokH),
    append2(SokH, L2, Eredmeny),
    kszor(K, T1, L2).

%harmadik feladat-------------------------------------

%generalja a szamok listajat A-tol B-ig
szam_lista([A], A, A):-!.

szam_lista([A|T], A, B):-
    A=<B,
    A1 is A+1,
    szam_lista(T, A1, B).


%negyedik feladat-------------------------------------

%megfordit egy listat
inverz([],[]):-!.

inverz(L, Er):-
    inverz(L, [], Er).

inverz([], L, L):-!.

inverz([H|T], Uj, Er):-
    inverz(T, [H|Uj], Er).

%otodik feladat---------------------------------------

%az L listabol torli minden K. elemet
torolk([], _, []).

torolk(L, K, Er):-
    torolk(L, K, 1, Er).

torolk([], _, _, []).

torolk([_H|T], K, K, T2):-
    torolk(T, K, 1, T2),
    !.

torolk([H|T], K, Index, [H|T2]):-
    Index2 is Index + 1,
    torolk(T, K, Index2, T2).

%hatodik feladat---------------------------------------

% listat kompakt alakba hoz: minden egymas utani atomot helyettesiti egy
% ketelemu listaval, melyben az atom es a szamossaga van. Ha a szamossag
% 1, akkor csak az atom jelenik meg
kompakt([],[]).

kompakt([H|T], L2):-
    kompakt(T, H, 1, L2).

%ket leallasi feltetel, hogy a lista vegek is listak maradjanak
kompakt([], Elozo, Szam, [T2]):-
    fej_kompakt(Elozo, Szam, T2),
    !.

kompakt([H|T], H, Szam, L2):-
    Szam2 is Szam + 1,
    kompakt(T, H, Szam2, L2),
    !.

kompakt([H|T], Elozo, Szam, [H2|T2]):-
    H \= Elozo,
    fej_kompakt(Elozo, Szam, H2),
    kompakt(T, H, 1, T2).

%a H2 egy lista lesz
fej_kompakt(Elozo, 1, Elozo):-!.

fej_kompakt(Elozo, Szam, [Elozo, Szam]):-!.

%hetedik feladat----------------------------------------

% vegig probalja az osszes lehetseges kombinaciot, amig megoldast talal
% a SEND + MORE = MONEY egyenletre, ahol minden betu kulonbozo szamot
% kodol
megold(S, E, N, D, M, O, R, Y):-
    select(S, [0, 1, 2, 3, 4, 5, 6, 7, 8, 9], M1),
    S \= 0,
    select(E, M1, M2),
    select(N, M2, M3),
    select(D, M3, M4),
    select(M, M4, M5),
    M \= 0,
    select(O, M5, M6),
    select(R, M6, M7),
    select(Y, M7, _),
    SEND is 1000*S + 100*E + 10*N + D,
    MORE is 1000*M + 100*O + 10*R + E,
    MONEY is 10000*M + 1000*O + 100*N + 10*E + Y,
    Eredmeny is SEND + MORE,
    MONEY = Eredmeny,
    !.

%nyolcadik feladat--------------------------------------

%megnezi, ha ket filmet ugyanabban az evben rendeztek
azonos_ev(Film1, Film2):-
    movie(Film1, X),
    movie(Film2, X).

%megnezi, ha a Film regibb a megadott Evnel
regebbi(Film, Ev):-
    movie(Film, X),
    X < Ev.

%megnezi, ha a ferfi szinesz szerepel-e ket filmben
ketto_f(Szinesz):-
    actor(Film1, Szinesz, _),
    actor(Film2, Szinesz, _),
    Film1 \=Film2.

%megnezi, ha a noi szinesz szerepel-e ket filmben
ketto_n(Szinesz):-
    actress(Film1, Szinesz, _),
    actress(Film2, Szinesz, _),
    Film1 \=Film2.

% a parameternek atadja azokat a szineszeket, amelyek csak 1 filmben
% szerepelnek
egyetlen_filmben(Szinesz):-
    (actor(_, Szinesz, _), \+ketto_f(Szinesz));
    (actress(_, Szinesz, _), \+ketto_n(Szinesz)).



