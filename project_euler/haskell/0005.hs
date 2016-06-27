import Mathlib

main :: IO ()
main = putStrLn $ show $ foldl (\acc x -> leastCommonMultiple acc x) 1 $ [x | x <- [1..20]]
