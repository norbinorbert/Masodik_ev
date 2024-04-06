%Boda Norbert, 521, bnim2219

%[(L, Maradek), [(1, old), (3, old), (6, old), (8, old), (12, old)]]
%L = jelenlegi oldal
%bal oldal = 0
%jobb oldal = 1

%megoldas, ha mindenki atkerult a jobb oldalra
megoldas([(1, _), [(1, 1), (3, 1), (6, 1), (8, 1), (12, 1)]]).

%az allapot akkor jo, ha meg van olaj
oke_allapot([(_, M), _]):-
    M >= 0.

%balrol jobbra atmegy 2 ember
lep([(0, M), Emberek], [(1, UjM), [(Egy, 1), (Ketto, 1) | R2]]):-
    select((Egy, 0), Emberek, R1),
    select((Ketto, 0), R1, R2),
    UjM is M - max(Egy, Ketto).

%jobbrol balra megy 1 ember
lep([(1, M), Emberek], [(0, UjM), [(Egy, 0) | R]]):-
    select((Egy, 1), Emberek, R),
    UjM is M - Egy.

%megkeresi az osszes lehetseges utat es kiirja oket
utak():-
    Start = [(0, 30), [(1, 0), (3, 0), (6, 0), (8, 0), (12, 0)]],
    setof(CelLista, Start^ut2(Start, [Start], CelLista), Eredmenyek),
    kiir(Eredmenyek).

%kiir minden eredmenyt egy kulon sorba
kiir([]).
kiir([H|T]):-
    writeln(H),
    kiir(T).

%ha van egy megoldas, akkor azt idorendi sorrendbe teszi
ut2(Allapot, Acc, CelLista):-
    megoldas(Allapot),
    reverse(Acc, CelLista).

ut2(Allapot, Acc, CelLista):-
    lep(Allapot, UjAllapot),
    oke_allapot(UjAllapot),
    UjAllapot = [H|T],
    %minden sikeres lepes utan rendezi a parokat, hogy ket megoldas ne jelenjen meg ketszer
    T = [Tm],
    sort(Tm, T2),
    \+(member([H|[T2]], Acc)),
    ut2([H|[T2]], [[H|[T2]] | Acc], CelLista).






