sumOfSquares :: (Integral a) => a -> a
sumOfSquares limit = sum [x^2 | x <- [1..limit]]

squareOfSums :: (Integral a) => a -> a
squareOfSums limit = (sum [1..limit]) ^ 2

main :: IO ()
main = putStrLn $ show $ (squareOfSums 100) - (sumOfSquares 100)
