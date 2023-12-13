--1. Határozzuk meg az N-edik Fibonacci-számot.
fibo::(Ord t, Num t) => t -> t
fibo 0 = 1
fibo 1 = 1
fibo n = fiboSeged n 2 1 1

fiboSeged::(Ord t, Num t) => t -> t -> t -> t -> t
fiboSeged n k a b
    | n==k = a+b
    | otherwise = fiboSeged n (k+1) b (a+b)

--2. Határozzuk meg aFibonacci-számok (végtelen) listáját.
fiboVegtelen::(Num t) => [t]
fiboVegtelen = 1:1:fiboVegtelenSeged 1 1

fiboVegtelenSeged:: (Num t) => t -> t-> [t]
fiboVegtelenSeged a b = (a+b):fiboVegtelenSeged b (a+b)

--3. Írjunk függvényt, mely visszaadja egy lista két legnagyobb elemét (ne használjunk rendezést vagy listamódosítást igénylő műveleteket).
maxElemek::(Ord t) => [t] -> [t]
maxElemek [] = []
maxElemek [e] = [e]
maxElemek (a:b:tail)
    | a > b = maxElemekSeged a b tail
    | otherwise = maxElemekSeged b a tail

maxElemekSeged::(Ord t) => t -> t -> [t] -> [t]
maxElemekSeged a b [] = [a, b]
maxElemekSeged a b (h:t)
    | h>a = maxElemekSeged h a t
    | h>b = maxElemekSeged a h t
    | otherwise = maxElemekSeged a b t

--4. Írjunk függvényt, mely összefésül két listát. A két listáról feltételezzük, hogy rendezettek és legyen a kimenő lista is rendezett.
merge::(Ord t) => [t] -> [t] -> [t]
merge [] lista = lista
merge lista [] = lista
merge (h1:t1) (h2:t2)
    | h1 < h2 = h1:merge t1 (h2:t2)
    | h2 < h1 = h2:merge (h1:t1) t2
    | otherwise = h1:h2:merge t1 t2

--5. Írjunk függvényt, mely egy listáról meghatározza, hogy palindróma-e: a lista ugyanaz, mint a lista fordítottja (pl. a "lehel" igen, a "csato" nem).
pallindrom::(Ord t) => [t] -> Bool
pallindrom [] = True
pallindrom [elem] = True
pallindrom lista
    | head lista == last lista = pallindrom (init (tail lista))
    | otherwise = False

--6. Töröljük egy lista minden K-adik elemét.
torolk::(Ord t, Num t) => t -> [t2] -> [t2]
torolk = torolkSeged 1

torolkSeged::(Ord t, Num t) => t -> t -> [t2] -> [t2]
torolkSeged _n _k [] = []
torolkSeged n k (e:es)
    | n == k = torolkSeged 1 k es
    | otherwise = e : torolkSeged (n+1) k es

--7. Valósítsuk meg a "run-length encoding" algoritmust Haskell-ben: egy redundáns - sok egyforma elemet tartalmazó - 
--listát úgy alakítunk kompakt formába, hogy az ismétlődő elemek helyett egy párost tárolunk, ahol az első az elem, a második a multiplicitás.
--Például
--kompakt(["a","a","a","c","c","b"]) -> [("a",3),("c",2),("b",1)]
--Írjuk meg a kódokat úgy, hogy a listát csak egy alkalommal járjuk be.
kompakt::(Ord t, Num t2) => [t] -> [(t, t2)]
kompakt [] = []
kompakt (e:es) = kompaktSeged es e 1

kompaktSeged::(Ord t, Num t2) => [t] -> t -> t2 -> [(t, t2)]
kompaktSeged [] e n = [(e, n)]
kompaktSeged (e:es) e2 n
    | e == e2 = kompaktSeged es e2 (n+1)
    | e /= e2 = (e2, n):kompaktSeged es e 1

--8. Eratosztenész szitája egy módszer, mellyel az összes prím listáját létre lehet hozni.
--A módszer a következő: a [2,..] listával indulva, mindig prímnek tekintjük a lista fejét, 
--majd a szitát alkalmazzuk arra a listára, melyből kiszűrtük a lista fejének (először a kettőnek) a többszöröseit.
--Írjunk egy függvényt, mely kiszűri egy szám többszörösét egy listából
--kiszur.
--Írjuk meg a szitát, alkalmazva a kiszur függvényt.
--szita.
--Implementáljunk egy függvényt, mely a prímszámok közül kiválasztja az N-ediket
--valaszt.
kiszur::(Integral t) => [t] -> [t]
kiszur [] = []
kiszur (e:es) = e:kiszur (kiszurSeged e es)

kiszurSeged::(Integral t) => t -> [t] -> [t]
kiszurSeged _e [] = []
kiszurSeged e (e1:es)
    | mod e1 e == 0 = kiszurSeged e es
    | otherwise = e1:kiszurSeged e es

szita::(Integral t) => [t]
szita = kiszur [2..]

valaszt::(Integral t) => Int -> t
valaszt n = last (take n szita)

--9. Keressük meg bizonyos számok egyedi többszöröseinek összegét egészen  egy felső korlátig (azt kizárva).
--Pl. Ha felsoroljuk az összes 20 alatti természetes számot, amelyek 3 vagy 5 többszörösei, akkor 3, 5, 6, 9, 10, 12, 15 és 18-at kapunk.
--Ezeknek a többszöröseknek az összege 78.
--megold 20 [3, 5] == 78
megold::(Integral t) => t -> [t] -> t
megold n = megoldSeged [1..n-1]

megoldSeged::(Integral t) => [t] -> [t] -> t
megoldSeged [] _ = 0
megoldSeged (e:es) lista = osztja e lista + megoldSeged es lista

osztja::(Integral t) => t -> [t] -> t
osztja e [] = 0
osztja e (e1:es)
    | mod e e1 == 0 = e
    | otherwise = osztja e es
