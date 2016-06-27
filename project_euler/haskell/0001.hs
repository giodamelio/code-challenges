multipleOf3Or5 :: (Integral a) => a -> Bool
multipleOf3Or5 num
    | num `mod` 3 == 0  = True
    | num `mod` 5 == 0  = True
    | otherwise         = False

main :: IO ()
main = putStrLn $ show $ sum [x | x <- [1 .. 1000 - 1], multipleOf3Or5 x]
