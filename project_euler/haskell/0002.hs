import Mathlib

main :: IO ()
main = putStrLn $ show $ sum $ filter even $ takeWhile (<4000000) $ fibSeq
