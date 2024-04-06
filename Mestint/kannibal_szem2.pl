%Baki Roland, Boda Norbert, Boros Antal, Dacz Krisztian
megoldas((3, 3, _Cs)).
megold(Lepes):-
    setof(Lista, Lepes^megold2(Lepes, [Lepes], Lista), Eredm),
    kiir(Eredm).

kiir([]).
kiir([H|T]):-
    write(H),nl,
    kiir(T).

megold2(Lepes, Lista, Eredm):-
    megoldas(Lepes),
    reverse(Lista, Eredm).
megold2((K,M,Cs), Lista, Eredm):-
    lep((K,M,Cs), UjLepes),
    oke(UjLepes),
    \+member(UjLepes, Lista),
    megold2(UjLepes, [UjLepes|Lista], Eredm).

lep((K,M,Cs), (UjK, UjM, UjCs)):-
    UjCs is -Cs,
    between(0, 2, TK),
    between(0, 2, TM),
    TM + TK < 3,
    TM + TK > 0,
    UjK is K + TK * Cs,
    UjK >= 0,
    UjK < 4,
    UjM is M + TM * Cs,
    UjM >= 0,
    UjM < 4.

oke((_K, 0, _Cs)):-!.
oke((_K, 3, _Cs)):-!.
oke((A, A, _Cs)).








