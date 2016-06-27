import Mathlib

main :: IO ()
main = putStrLn $ show $ maximum $ [x*y | x <- [1 .. 999], y <- [1 .. 999], isPalindrome (x * y)]
