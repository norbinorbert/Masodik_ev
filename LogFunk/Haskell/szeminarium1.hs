--negyzetre emel
square :: Num a => a -> a
square x = x*x

add :: Num a => a -> a -> a
--osszead
add x y = x+y

--nagyobbat teriti vissza
max' :: Ord a => a -> a -> a
max' x y
    | x < y = y --feltetelek
    | otherwise = x

--Curry = fuggveny a kimeneti parameter
--novel 1-el
inc' :: Integer -> Integer
inc' = add 1

--relu x (0 es x kozott a maximum)
relu :: Integer -> Integer
relu = max 0

--Listak
--listak generalasa: [1..100], [1, 3..100], [100, 99..1]
--lista hossza
len' :: Num a1 => [a2] -> a1
len' [] = 0
len' (_:xs) = 1 + len' xs

--Lazy kiertekeles
--generalja a szamokat 1-tol vegtelenig
general = general' 1
    where general' x = x : general' (x+1)

--kiveszi a listanak az elso n elemet
take' 0 _ = []
take' n (x:xs) = x: take' (n-1) xs

--lista negyzetre emelese
squareL [] = []
squareL (x:xs) = square x : squareL xs

--lista novelese 1-el
incL [] = []
incL (x:xs) = inc' x : incL xs


--magasabbrendu fuggvenyek
--map
map' :: (t -> a) -> [t] -> [a]
map' _ [] = []
map' f (x:xs) = f x : map' f xs

squareM = map' square
incM = map' inc'

--filter
filter'::(a -> Bool) -> [a] -> [a]
filter' _ [] = []
filter' p (x:xs)
    | p x = x : filter' p xs
    | otherwise = filter' p xs

--qsort
qsort [] = []
-- ++ listak oszefuzese
qsort (x:xs) = qsort (filter (<x) xs) ++ [x] ++ qsort (filter (>=x) xs)

--head = lista elso eleme
head' (x:_) = x

--tail = elson kivul osszes elem
tail' (_:xs) = xs

--init = utolson kivul osszes elem
init' [x] = []
init' (x:xs) = x : init' xs

--last = lista utolso eleme
last' [x] = x
last' (_:xs) = last' xs