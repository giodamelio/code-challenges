module Mathlib
( fibSeq
, primeFactors
, isPalindrome
, greatestCommonDivisor
, leastCommonMultiple
, primes
) where

fibSeq :: (Integral a) => [a]
fibSeq = 1 : 1 : zipWith (+) fibSeq (tail fibSeq)

primeFactors :: (Integral a) => a -> [a]
primeFactors 0 = []
primeFactors num =
  case factors of
    [] -> [num]
    _  -> factors ++ primeFactors (num `div` (head factors))
  where factors = take 1 $ filter (\x -> (num `mod` x) == 0) [2 .. num-1]

isPalindrome :: (Integral a, Show a) => a -> Bool
isPalindrome num =
    let string = show num
    in string == (reverse string)

greatestCommonDivisor :: (Integral a) => a -> a -> a
greatestCommonDivisor a 0 = abs a
greatestCommonDivisor a b = greatestCommonDivisor b (a `mod` b)

leastCommonMultiple :: (Integral a) => a -> a -> a
leastCommonMultiple a b = (a * b) `div` (greatestCommonDivisor a b)

primes :: (Integral a) => [a]
primes = sieve [2..]
  where sieve (p:xs) = p : sieve [x | x <- xs, x `mod` p > 0]
