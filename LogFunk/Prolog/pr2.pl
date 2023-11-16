derivalas(X+Y, E):-
    egyszerusit(X, EX),
    egyszerusit(Y, EY),
    derivalas(EX, Dx),
    derivalas(EY, Dy),
    egyszerusit(Dx, DX),
    egyszerusit(Dy, DY),
    egyszerusit(DX+DY, E).

derivalas(X-Y, E):-
    egyszerusit(X,EX),
    egyszerusit(Y,EY),
    derivalas(EX, Dx),
    derivalas(EY, Dy),
    egyszerusit(Dx, DX),
    egyszerusit(Dy, DY),
    egyszerusit(DX-DY, E).

derivalas(X*Y, E):-
    egyszerusit(X,EX),
    egyszerusit(Y,EY),
    derivalas(EX, Dx),
    derivalas(EY, Dy),
    egyszerusit(Dx, DX),
    egyszerusit(Dy, DY),
    egyszerusit(DX*Y, DXY),
    egyszerusit(DY*X, DYX),
    egyszerusit(DXY+DYX, E).

derivalas(X/Y, E):-
    egyszerusit(X, EX),
    egyszerusit(Y, EY),
    derivalas(EX, Dx),
    derivalas(EY, Dy),
    egyszerusit(Dx, DX),
    egyszerusit(Dy, DY),
    egyszerusit(DX*Y, DXY),
    egyszerusit(DY*X, DYX),
    egyszerusit(Y^2, Nevezo),
    egyszerusit(DXY-DYX, Szamlalo),
    egyszerusit(Szamlalo/Nevezo,E).

derivalas(x^X, E):-
    egyszerusit(X, EX),
    egyszerusit(X-1, EX1),
    egyszerusit(EX*x^EX1, E).

derivalas(log(X), E):-
    egyszerusit(X,EX),
    derivalas(EX, Dx),
    egyszerusit(Dx, DX),
    egyszerusit(DX/EX, E).

derivalas(sin(X), E):-
    egyszerusit(X, EX),
    derivalas(EX, Dx),
    egyszerusit(Dx, DX),
    egyszerusit(cos(EX)*DX, E).

derivalas(cos(X), E):-
    egyszerusit(X,EX),
    derivalas(EX, Dx),
    egyszerusit(Dx, DX),
    egyszerusit(-sin(EX)*DX, E).

derivalas(tg(X), E):-
    egyszerusit(X, EX),
    derivalas(EX, Dx),
    egyszerusit(Dx,DX),
    egyszerusit(DX/cos(EX)^2, E).

derivalas(ctg(X), E):-
    egyszerusit(X, EX),
    derivalas(EX, Dx),
    egyszerusit(Dx,DX),
    egyszerusit(-DX/sin(EX)^2, E).

derivalas(Szam^x, E):-
    egyszerusit(Szam,ESzam),
    egyszerusit(ESzam^x + log(ESzam), E).

derivalas(x, 1):-!.

derivalas(Szam, 0):-
    egyszerusit(Szam, ESzam),
    number(ESzam),
    !.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
egyszerusit(x^X*x, x^XE):-
    egyszerusit(X+1, XE),!.
egyszerusit(x*x^X, x^XE):-
    egyszerusit(X+1, XE),!.
egyszerusit(X*x*x, L):-
    egyszerusit(X, XE),
    egyszerusit(XE*x^2, L),!.
egyszerusit(x^X*x^X2, x^X3):-
    XO = X+X2,
    egyszerusit(XO, X3),!.
egyszerusit(Y*x^X*x^X2, EY*x^X3):-
    XO = X+X2,
    egyszerusit(XO, X3),
    egyszerusit(Y,EY),!.
egyszerusit(X*x*X2*x, XE*x^2):-
    egyszerusit(X*X2, XE),!.
egyszerusit((x^X)^X2, x^XE):-
    egyszerusit(X*X2, XE),!.

egyszerusit(x^1, x).
egyszerusit(x*x, x^2).
egyszerusit(x*X, L):-
    egyszerusit(X*x, L),!.

egyszerusit(x+x, 2*x).
egyszerusit(X*x+X2*x, L*x):-
    egyszerusit(X+X2,L),!.

egyszerusit(A+0, L):-
    A \= A+0,
    egyszerusit(A, L),!.
egyszerusit(0+A, L):-
    A \= 0+A,
    egyszerusit(A, L),!.

egyszerusit(A/1, L):-
    A \= A/1,
    egyszerusit(A, L),!.
egyszerusit(A/A, 1).

egyszerusit(0-A, -L):-
    egyszerusit(A, L),!.

egyszerusit(0*_, 0).
egyszerusit(_*0, 0).

egyszerusit(A*1, L):-
    A \= A*1,
    egyszerusit(A, L),!.
egyszerusit(1*A, L):-
    A \= 1*A,
    egyszerusit(A, L),!.

egyszerusit(A+B, L):-
    number(A),
    number(B),
    L is A+B.

egyszerusit(A+B, L):-
    egyszerusit(A, EA),
    egyszerusit(B, EB),
    (A \= EA; B \= EB),
    egyszerusit(EA+EB,L),!.

egyszerusit(A-B, L):-
    number(A),
    number(B),
    L is A-B.

egyszerusit(A-B, L):-
    egyszerusit(A, EA),
    egyszerusit(B, EB),
    (A \= EA; B \= EB),
    egyszerusit(EA-EB, L),!.

egyszerusit(A*B, L):-
    number(A),
    number(B),
    L is A*B.

egyszerusit(A*B, L):-
    egyszerusit(A, EA),
    egyszerusit(B, EB),
    (A \= EA; B \= EB),
    egyszerusit(EA*EB, L),!.

egyszerusit(A/B, L):-
    number(A),
    number(B),
    L is A/B.

egyszerusit(A/B, L):-
    egyszerusit(A, EA),
    egyszerusit(B, EB),
    (A \= EA; B \= EB),
    egyszerusit(EA/EB, L),!.

egyszerusit(A*B*C, A*C*B).
egyszerusit(A*(B*C), L):-
    egyszerusit(A*B*C, L),!.
egyszerusit((A*B)*C, L):-
    egyszerusit(A*B*C, L),!.

egyszerusit(A+B+C, A+C+B).
egyszerusit(A+(B+C), L):-
    egyszerusit(A+B+C, L),!.
egyszerusit((A+B)+C, L):-
    egyszerusit(A+B+C, L),!.


egyszerusit(A, A).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

lsort(L, SL):-
    cserel(L, Acc), %elemeket cserel az L listaban, Acc az eredemeny
    !, %ha ugyanarra a parameterekre lesz meghivva akkor nem dolgoz tovabb
    lsort(Acc, SL). %rendezi az uj listat

lsort(L, L).

%megcsereli A es B listat, ha B rovidebb
cserel([A,B|T], [B,A|T]):-
    length(A, Alen),
    length(B, Blen),
    Blen<Alen.

cserel([A|T], [A|T1]):-
    cserel(T, T1).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% megnezi ha A es B joPartnerek, tehat tobb, mint 1 filmben jatszodtak
% egyutt
joPartner(A, B):-
    actor(Film1, A, _),
    actor(Film1, B, _),
    A \= B,
    actor(Film2, A, _),
    actor(Film2, B, _),
    Film1 \= Film2.

joPartner(A, B):-
    actress(Film1, A, _),
    actress(Film1, B, _),
    A \= B,
    actress(Film2, A, _),
    actress(Film2, B, _),
    Film1 \= Film2.

joPartner(A, B):-
    actor(Film1, A, _),
    actress(Film1, B, _),
    A \= B,
    actor(Film2, A, _),
    actress(Film2, B, _),
    Film1 \= Film2.

joPartner(A, B):-
    actress(Film1, A, _),
    actor(Film1, B, _),
    A \= B,
    actress(Film2, A, _),
    actor(Film2, B, _),
    Film1 \= Film2.


%megmondja, hogy hany kulonbozo film szerepel a tudasbazisban

filmek_szama(LenA):-
    setof(X, Ev^movie(X,Ev), L),
    length(L, LenA).

%hosszusagok csokkeno sorrendjebe rendez
lsort2(L, SL):-
    cserel2(L, Acc), %elemeket cserel az L listaban, Acc az eredemeny
    !, %ha ugyanarra a parameterekre lesz meghivva akkor nem dolgoz tovabb
    lsort2(Acc, SL). %rendezi az uj listat

lsort2(L, L).

%megcsereli A es B listat, ha A rovidebb
cserel2([A,B|T], [B,A|T]):-
    length(A, Alen),
    length(B, Blen),
    Blen>Alen.

cserel2([A|T], [A|T1]):-
    cserel2(T, T1).

%megkeresi a favorit szineszeket
favorit(L):-
    elso_25(Lista),
    beir(Lista, L).

% kiirja a [Szinesz | Szinesz jo partnerei] alaku listabol a Szineszt
beir([],[]):-!.

beir([[H|_]|T], [H|T2]):-
    beir(T, T2).

%megkeresi az elso 25 [Szinesz | Szinesz jo partnerei] alaku listat
elso_25(Lista):-
     setof(A, szineszek(A), L2),
     setof(B, szinesznok(B), L3),
     append(L2, L3, L4),
     lsort2(L4, Rendezett),
     findall(Elem,(nth0(Index, Rendezett, Elem), Index<25), Lista).

%listat keszit, alakja: [Szinesz | Szinesz jo partnerei]
szineszek([A|T]):-
    actor(_, A, _),
    setof(B, A^joPartner(A, B), T).

szinesznok([A|T]):-
    actress(_, A, _),
    setof(B, A^joPartner(A, B), T).


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%binaris fa leveleinek szama
binaris_levelek(null, 1):-!. %ures fanak 1 levele van

binaris_levelek(node(_, B, C), Osszeg):-
    binaris_levelek(B, Osszeg2),
    binaris_levelek(C, Osszeg3),
    Osszeg is Osszeg2 + Osszeg3. %nem ures reszfak leveleinek osszege

%preorder bejaras
preorder(node(A,B,C)):-
    preorder(A),
    preorder(B),
    preorder(C),
    !.

preorder(Elem):-
    write(Elem),
    write(' ').

%inorder bejaras
inorder(node(A,B,C)):-
    inorder(B),
    inorder(A),
    inorder(C),
    !.

inorder(Elem):-
    write(Elem),
    write(' ').


%postorder bejaras
postorder(node(A,B,C)):-
    postorder(B),
    postorder(C),
    postorder(A),
    !.

postorder(Elem):-
    write(Elem),
    write(' ').

















