(ns aoc.puzzles.day-1-test
  (:require [clojure.test :refer :all]
            [testit.core :refer :all]
            [aoc.test-utils :refer :all]
            [aoc.puzzles.day-1 :as p]))

(deftest parse
  (facts
    (p/parse "10\n10\n10") => [10 10 10]))

(deftest calculate-fuel
  (facts
    (p/calculate-fuel 12) => 2
    (p/calculate-fuel 14) => 2
    (p/calculate-fuel 1969) => 654
    (p/calculate-fuel 100756) => 33583))

(deftest calculate-fuel-recursive
  (facts
    (p/calculate-fuel-recursive 12) => 2
    (p/calculate-fuel-recursive 14) => 2
    (p/calculate-fuel-recursive 1969) => 966
    (p/calculate-fuel-recursive 100756) => 50346))

(deftest part-1
  (facts
    (p/part-1 [12 14 12]) => 6)
  (part-1-assertion))

(deftest part-2
  (facts
    (p/part-2 [1969 100756]) => 51312)
  (part-2-assertion))
