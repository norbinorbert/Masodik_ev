{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
{-# HLINT ignore "Use camelCase" #-}
{-# HLINT ignore "Use foldl" #-}
{-# OPTIONS_GHC -Wno-missing-methods #-}
import Data.Char (toLower)
import Distribution.Compat.Prelude (isUpper)
{-# HLINT ignore "Use foldr" #-}
--1. Írjunk egy kódoló algoritmust, ami egy string-et kódol, az alábbi módon.
-- -kiszűrjük a szóközöket
-- -kisbetűsítünk
-- -egy m széles négyszöget alkotunk a szövegből
--pl. "Alma a Fa aLatt" m=5 ->
--"almaa"
--"faala"
--"tt   "
-- -majd, oszloponként olvassuk vissza a négyzet tartalmát:
--"aftlatmaalaa"
-- -végül, c méretű darabokra osztjuk ezt a szöveget, szóközökkel elválasztva:
--c=5 esetén, az eredmény: "aftla tmaal aa"
megold::String -> Int -> Int -> String
megold szoveg m c = feloszt (visszaolvas (kodol (atalakit szoveg) m) m 0) c 0

--kiszedi a szokozoket es kisbetusit
atalakit :: String -> String
atalakit [] = []
atalakit (e:es)
   | e == ' ' = atalakit es
   | otherwise = toLower e:atalakit es

--m széles négyszöget alkot a szövegből
kodol :: String -> Int -> [String]
kodol [] _ = []
kodol szoveg m = take m szoveg : kodol (drop m szoveg) m

--oszloponként olvassa vissza a négyzet tartalmát
visszaolvas:: [String] -> Int -> Int -> String
visszaolvas tomb m oszlop_index
   | m == oszlop_index = []
   | otherwise = oszlop tomb oszlop_index ++ visszaolvas tomb m (oszlop_index+1) 

--n-edik oszlopot olvassa be
oszlop:: [String] -> Int -> String
oszlop [] _ = []
oszlop (e:es) oszlop_index
   | nth e oszlop_index 0 == ' ' = oszlop es oszlop_index
   | otherwise = nth e oszlop_index 0 : oszlop es oszlop_index

--String n-edik indexen levo karaktert adja meg
nth:: String -> Int -> Int -> Char
nth [] _ _ = ' '
nth (e:es) index szam
   | index == szam = e
   | otherwise = nth es index (szam + 1)

--c méretű darabokra osztja a szöveget, szóközökkel elválasztva
feloszt::String -> Int -> Int -> String
feloszt [] _ _ = []
feloszt (e:es) c szam
   | c == szam = ' ':feloszt (e:es) c 0
   | otherwise = e:feloszt es c (szam + 1)

--2. Modellezzük a régi - nyomógombos - mobilt, ahol egy üzenetet úgy írtunk, hogy minden betűhöz egyszer vagy többször nyomtunk meg adott gombot.
--Az alábbiakban a gombokat adjuk meg, asszociálva a gomb kimenetével ha egyszer, kétszer ... van megnyomva (nevezzük oldPhone kódolásnak):
--1 - "1"
--2 - "aábc2"
--3 - "deéf3"
--4 - "ghií4"
--5 - "jkl5"
--6 - "mnoóöő6"
--7 - "pqrs7"
--8 - "tuúüűv8"
--9 - "wxyz9"
--0 - "+ 0"
-- * - MOD_C
-- # - ".,#"
--A forráskódban a gombokhoz tartozó karaktereket csak a következő formátumban lehet megadni: ["1", "aábc2", "deéf3", "ghií4", ..., "+ 0", ".,#"] 
--(A * karakter hozzáadása a listához opcionális)
--A fenti kódolásnál a nagybetűket a "*" módosítóval tudjuk elérni, melyet az illető szám kódja előtt nyomunk meg. 
--Például az "Alma" leírásának a szekvenciája: "*255562" -> [('*',1),('2',1),('5',3),('6',1),('2',1)]
--Feladat:
--a. Adjuk meg a függvényt, mely egy mondatra - Sztring-re - megmondja, hogy ábrázolható-e az oldPhone kódolásban. Például a "Lehel! 2+4=6" nem ábrázolható.
karakterek :: [String]
karakterek = ["1", "aábc2", "deéf3", "ghií4", "jkl5", "mnoóöő6", "pqrs7", "tuúüűv8", "wxyz9", "+ 0", ".,#"]

--fo fuggveny
abrazolhato:: String -> Bool
abrazolhato [] = True
abrazolhato (e:es) = tartalmaz karakterek (toLower e) && abrazolhato es

--megnezi ha a felsorolas valamely Stringjeben megtalalhato a karakter
tartalmaz::[String] -> Char -> Bool
tartalmaz [] _ = False
tartalmaz (e:es) karakter = substring e karakter || tartalmaz es karakter

--megnezi ha a megadott Stringben megtalalhato a karakter
substring::String -> Char -> Bool
substring [] _ = False
substring (e:es) karakter
   | e == karakter = True
   | otherwise = substring es karakter

--b. Határozzuk meg egy mondat oldPhone kódját.
oldPhone :: String -> String
oldPhone string
   | abrazolhato string = kodolas string
   | otherwise = error "Nem lehet abrazolni"

--kisbetusit es felepiti a stringet
kodolas::String -> String
kodolas [] = []
kodolas (e:es)
   | isUpper e = '*':keresIndex karakterek (toLower e) 1 ++ kodolas es
   | otherwise = keresIndex karakterek e 1 ++ kodolas es

--megkeresi, hogy a felsorolas melyik stringjeben talalhato a megadott karakter, majd felepiti a neki megfelelo sorozatot
keresIndex:: [String] -> Char -> Int -> String
keresIndex (e:es) karakter index
   | substring e karakter = beir e karakter (last e)
   | otherwise = keresIndex es karakter (index + 1)

--felepiti a karakternek megfelelo sorozatot
beir:: String -> Char -> Char -> String
beir (e:es) karakter gomb
   | e == karakter = [gomb]
   | otherwise = last es : beir es karakter gomb

--3. Az until függvény használatával számítsuk ki a Haskell valós precizitását a kettes számrendszerben. 
--A precizitás a kettőnek az a legnagyobb negatív hatványa, mely kettővel osztva nullát eredményez.
precizitas::Int
precizitas = until feltetel (+1) 0
feltetel::(Integral t) => t -> Bool
feltetel x = 1/(2^x) == 0

--4. Az until függvény használatával határozzuk meg egy pozitív szám természetes alapú logaritmusának - ln(y)-nek - az értékét. 
--Használjuk a következő sorbafejtést:
--ln(1+x) = - sum_{k,1,inf} (-x)^k/k
--Írjuk úgy a kódot, hogy minél hatékonyabb legyen a függvény. 
--Alakítsuk át a divergens sorozatokat a ln(y)=-ln(1/y)összefüggéssel (amely akkor kell, ha |x|>=1).
ln::Double -> Double
ln y
   | y == 1.0 = 0
   | abs x >= 1 = -ln (1/y)
   | otherwise = - (fst (until (feltetel2 x) (muvelet x) (-x, 2)))
 where x = y - 1
       kovetkezo k = ((-x)^k) / fromInteger k

feltetel2::Double -> (Double, Integer) -> Bool
feltetel2 x (elozo, k) = abs kovetkezo <= 1e-10
 where
   kovetkezo = ((-x)^k) / fromInteger k

muvelet::Double -> (Double, Integer) -> (Double, Integer)
muvelet x (elozo, k) = (elozo + kovetkezo, k+1)
 where 
   kovetkezo = ((-x)^k) / fromInteger k
   
--5. A cumul_op függvény implementálása: 
--Írjunk függvényt, mely egy listából és egy operátorból azt a listát állítja elő, 
--mely egy pozíciójának a k-adik eleme a bemenő lista első k elemének az op szerinti összetevése. 
--Példa: 
--cumul_op (+) [2,4,3,4,3] -> [2,6,9,13,16] 
--cumul_op (++) ["a","l","m","a"]) -> ["a","al","alm","alma"] 
--Nem használható foldl/r vagy scanl/r.
cumul_op::(t -> t -> t) -> [t] -> [t]
cumul_op op (e:es) = e:cumul_op_seged op es e

cumul_op_seged::(t -> t -> t) -> [t] -> t -> [t]
cumul_op_seged _ [] _ = []
cumul_op_seged op (e:es) elozo = a:cumul_op_seged op es a
   where a = op elozo e

--6. A következőkben a fákat rendezett keresési fáknak tekintjük: 
--a nódusban található elem mindig nagyobb, mint a bal oldali fa összes eleme és kisebb a jobb oldali fa összes eleménél.
--Írjuk meg a következő függvényeket:
--A beszur függvényt, mely egy bináris fába szúr be egy elemet.
--A listából függvényt, egy számlistát alakít át bináris fává.
--A torol függvényt, mely egy bináris fából egy elemet töröl. Használjuk a MayBe típust a hibakezelésre.
data BinFa a =
   Nodus (BinFa a) a (BinFa a)
   | Level deriving (Show, Eq)

beszur::(Ord t) => BinFa t -> t -> BinFa t
beszur Level elem = Nodus Level elem Level
beszur (Nodus balfa ertek jobbfa) elem
   | elem < ertek = Nodus (beszur balfa elem) ertek jobbfa
   | elem > ertek = Nodus balfa ertek (beszur jobbfa elem)

listabol::(Ord t) => [t] -> BinFa t
listabol lista = listabolSeged lista Level

listabolSeged::(Ord t) => [t] -> BinFa t -> BinFa t
listabolSeged [] fa = fa
listabolSeged (e:es) fa = listabolSeged es (beszur fa e)

torol::(Ord t) => BinFa t -> t -> Maybe (BinFa t)
--Levelbol nem lehet torolni
torol Level _ = Nothing

--bal vagy jobb oldali fabol torlunk amig nem talaljuk meg a megfelelo csomopontot
torol (Nodus balfa ertek jobbfa) elem
   | elem < ertek = (\ujBal -> Nodus ujBal ertek jobbfa) <$> torol balfa elem
   | elem > ertek = Nodus balfa ertek <$> torol jobbfa elem

--egyszeru torles, ha az egyik reszfa ures
torol (Nodus balfa ertek jobbfa) _
   | balfa == Level = Just jobbfa
   | jobbfa == Level = Just balfa

--jobb oldali reszfaban minimumot keresunk, felhozzuk a jelenlegi pozicioba, majd feljebb hozzuk egy szinttel a jobb oldali reszfat
torol (Nodus balfa ertek jobbfa) _ = Nodus balfa minErtek <$> ujJobb
 where ujJobb = torol jobbfa minErtek
       minErtek = keresMin jobbfa
       keresMin (Nodus balfa ertek _)
         | balfa == Level = ertek
         | otherwise = keresMin balfa

--7. A komplex számok a+i.b alakúak, ahol a a valós része, b az imaginárius része a számnak, az i meg a -1 négyzetgyöke. 
--Definiáljuk a C komplex szám adattípust. Írjuk meg a show, az aritmetikai műveleteknek (+,-,*,/,abs) a Haskell kódját.
data C = C Double Double

--komplex szam kiirasa
instance Show C where
   show::C -> String
   show (C a b)
      | a == 0 && b /= 0 = show b ++ "*i"
      | b > 0 = show a ++ "+" ++ show b ++ "*i"
      | b < 0 = show a ++ show b ++ "*i"
      | b == 0 = show a

--osszeadas, kivonas, szorzas es abszolut ertek
instance Num C where
   (+) :: C -> C -> C
   (C a b) + (C c d) = C (a+c) (b+d)
   (-) :: C -> C -> C
   (C a b) - (C c d) = C (a-c) (b-d)
   (*) :: C -> C -> C
   (C a b) * (C c d) = C (a*c - b*d) (a*d + b*c)
   abs :: C -> C
   abs (C a b) = C (sqrt (a^2+b^2)) 0

--osztas
instance Fractional C where
   (/) :: C -> C -> C
   (C a b) / (C c d) = C ((a*c + b*d)/(c^2 + d^2)) ((b*c - a*d)/(c^2 + d^2))
