data Op = Plus | Mul deriving Eq
instance Show Op where
    show Plus = "+"
    show Mul = "*"

data Fa t = Const t | Var String | Expr Op (Fa t) (Fa t)
instance (Show t) => Show (Fa t) where
    show (Const x) = show x
    show (Var x) = x
    show (Expr op fa1 fa2) = "(" ++ show fa1 ++ show op ++ show fa2 ++ ")"

eval :: (Num a) => [(String, a)] -> Fa a -> a
eval _ (Const a) = a
eval lista (Var a) = case value lista a of
                        Just a -> a
                        Nothing -> error "Nem kapta meg a valtozot"
eval lista (Expr op fa1 fa2)
    | op == Plus = eval lista fa1 + eval lista fa2
    | op == Mul = eval lista fa1 * eval lista fa2

value :: (Num a) => [(String, a)] -> String -> Maybe a
value [] _ = Nothing
value ((x, fx):tail) y
    | x == y = Just fx
    | otherwise = value tail y

diff:: (Num a) => Fa a -> String -> Fa a
diff (Const _) x = Const 0
diff (Var a) x
    | a == x = Const 1
    | otherwise = Const 0
diff (Expr op fa1 fa2) x 
    | op == Plus = Expr op (diff fa1 x) (diff fa2 x)
    | op == Mul = Expr Plus (Expr Mul (diff fa1 x) fa2) (Expr Mul fa1 (diff fa2 x))