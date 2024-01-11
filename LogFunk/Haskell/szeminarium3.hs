{-# OPTIONS_GHC -Wno-unrecognised-pragmas #-}
import Data.List (group, permutations)
{-# HLINT ignore "Use concatMap" #-}
{-# HLINT ignore "Use foldl" #-}
{-# HLINT ignore "Use concat" #-}
--reverse lista
reverseList:: [t] -> [t]
reverseList lista = reverseListSeged lista []

reverseListSeged:: [t] -> [t] -> [t]
reverseListSeged [] acc = acc
reverseListSeged (x:xs) acc = reverseListSeged xs (x:acc)

reverseListFold:: [t] -> [t]
reverseListFold = foldl (flip (:)) []

--decode compressed lista
decodeRle::[(a, Int)] -> [a]
decodeRle [] = []
decodeRle ((karakter, szam):tail)
    | szam > 1 = karakter:decodeRle ((karakter, szam-1):tail)
    | otherwise = karakter:decodeRle tail

decodeReplicateConcat:: [(a, Int)] -> [a]
decodeReplicateConcat lista = concat $ map (\(karakter,szam) -> replicate szam karakter) lista

decodeReplicateConcat2:: [(a, Int)] -> [a]
decodeReplicateConcat2 = concat . map (\(karakter,szam) -> replicate szam karakter)

decodeReplicateConcat3:: [(a, Int)] -> [a]
decodeReplicateConcat3 lista = foldl (++) [] $ map (\(karakter,szam) -> replicate szam karakter) lista

--torol duplicate
compress::(Eq t) => [t] -> [t]
compress [] = []
compress [x] = [x]
compress (x1:x2:xs)
    | x1 /= x2 = x1:compress (x2:xs)
    | otherwise = compress (x2:xs)

compressGroup:: (Eq t) => [t] -> [t]
compressGroup lista = map head $ group lista

compressGroup2 :: (Eq t) => [t] -> [t]
compressGroup2 = map head . group

--8 kiralyno problema
general:: Int -> Int -> [[Int]]
general 0 _ = [[]]
general m n = [ x:eredmeny | x <- [1..n], eredmeny <- general (m-1) n]

testQueens::[Int] -> Bool
testQueens [] = True
testQueens (x:xs)
    | x `elem` xs = False
    | otherwise = diagQueens x xs && testQueens xs
        where
            diagQueens x xs = all (\(index,szam) -> abs (x-szam) /= index) $ zip [1..] xs

queens :: Int -> [[Int]]
queens n = filter testQueens $ general n n