function [] = Lab1_1(kezdoertek, ismetlesek_szama, oszlopok_szama)

%random szamok generalasa
[sorozat, ~] = URNG2(kezdoertek, ismetlesek_szama);

%hisztogram letrehozasa
[gyakorisag, oszlopok] = hist(sorozat, oszlopok_szama);

%hisztogram abrazolasa
bar(oszlopok, gyakorisag);

