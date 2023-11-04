%L-ben visszaadja a listat
%findall(Diak, jegy(Diak, _, _, _), L).

%L-ben visszaadja a listat, ha le vannak kotve a valtozok
%kotes nelkul csoportosit
%setof(Diak, Tantargy^Honap^Jegy^jegy(Diak,Tantargy,Honap,Jegy), L).

% nem szuri ki a duplikatokat
%Ha minden le van kotve akkor gyakorlatilag findall
%bagof(Diak, Tantargy^Honap^Jegy^jegy(Diak,Tantargy,Honap,Jegy), L).

%osszes logfunk jegy, Diak-Jegy formatumban
p1(L):-
    findall(Diak-Jegy, jegy(Diak, logfunk, _, Jegy), L).

%osszes jegy, tantargyankent csoportositva, Diak-Jegy formatum
p2(L, Tantargy):-
    bagof(Diak-Jegy, Diak^Jegy^Honap^jegy(Diak, Tantargy, Honap, Jegy), L).

% azok a diakok akik kaptak jegyet adott tantargybol, tantargy szerint
% csoportositva
p3(L, Tantargy):-
    setof(Diak, Diak^Jegy^Honap^jegy(Diak, Tantargy, Honap, Jegy), L).

% Diak szerint csoportositva, azok a tantargyak amikbol kaptak
% 8-nal nagyobb jegyet
p4(L, Diak):-
    setof(Tantargy, (Honap^Jegy^jegy(Diak, Tantargy, Honap, Jegy), Jegy>8), L).

% egy listaban a honapok es a hozza tartozo jegyek (pl:
% [okt-[lehel/logfunk/10],...]
p5(L):-
    findall(Honap-T, (bagof(Diak/Tantargy/Jegy, jegy(Diak, Tantargy, Honap, Jegy), T)), L).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
replace_elem([], _, _, _, []).

replace_elem([H|T], 0, New, H, [New|T]):-
    !.

replace_elem([H|T], Index, New, OldElem, [H|T2]):-
    Index2 is Index - 1,
    replace_elem(T, Index2, New, OldElem, T2).


%puzzle([0,2,1,3], Steps) -->> Steps = [down, right]
%puzzle([1,2,3,0,4,6,7,5,8], Steps) -->> Steps = [right, down, right]
general(0, []):-!.

general(N, L):-
    general(N, 1, L).

general(N, N, [0]):-!.

general(N, K, [K|T]):-
    K1 is K + 1,
    general(N, K1, T).

puzzle(L, Steps):-
    length(L, Negyzet),
    N is ceil(sqrt(Negyzet)),
    general(Negyzet, Cel).

lepes(Old, jobb, New, N):-
    nth0(Index, Old, 0),
    Index mod N < N-1,
    Index1 is Index + 1,
    replace_elem(Old, Index1, 0, OldElem ,New1),
    replace_elem(New1, Index, OldElem, _, New).

lepes(Old, bal, New, N):-
    nth0(Index, Old, 0),
    (Index mod N) > 0,
    Index1 is Index - 1,
    replace_elem(Old, Index1, 0, OldElem ,New1),
    replace_elem(New1, Index, OldElem, _, New).

lepes(Old, fel, New, N):-
    nth0(Index, Old, 0),
    Index >= N,
    Index1 is Index - N,
    replace_elem(Old, Index1, 0, OldElem ,New1),
    replace_elem(New1, Index, OldElem, _, New).

lepes(Old, le, New, N):-
    nth0(Index, Old, 0),
    Index < N*(N - 1),
    Index1 is Index + N,
    replace_elem(Old, Index1, 0, OldElem ,New1),
    replace_elem(New1, Index, OldElem, _, New).













