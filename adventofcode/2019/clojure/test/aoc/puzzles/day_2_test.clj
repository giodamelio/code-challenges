(ns aoc.puzzles.day-2-test
  (:require [clojure.test :refer :all]
            [testit.core :refer :all]
            [aoc.test-utils :refer :all]
            [aoc.puzzles.day-2 :as p]))

(deftest parse
  (facts
    (p/parse "10,10,10") => [10 10 10]))

(deftest get-arguments
  (facts
    (p/get-arguments 0 [1 1 0 0 99]) => [1 0 0]
    (p/get-arguments 1 [1 1 0 0 99]) => [0 0 99]
    (p/get-arguments 0 [99]) => []))

(deftest step
  (facts
    ;; Unknown opcode
    (p/step [-1]) =throws=> java.lang.AssertionError
    ;; Addition (11 + 100 == 111)
    (p/step [1 5 6 0 99 11 100]) => [4 [111 5 6 0 99 11 100]]
    ;; Multiplication
    (p/step [2 5 6 0 99 5 5]) => [4 [25 5 6 0 99 5 5]]))

(deftest run
  ;; Some example programs
  (facts
    (p/run [1 9 10 3 2 3 11 0 99 30 40 50]) => [3500 9 10 70 2 3 11 0 99 30 40 50]
    (p/run [1 0 0 0 99]) => [2 0 0 0 99]
    (p/run [2 3 0 3 99]) => [2 3 0 6 99]
    (p/run [2 4 4 5 99 0]) => [2 4 4 5 99 9801]
    (p/run [1 1 1 4 99 5 6 0 99]) => [30 1 1 4 2 5 6 0 99]))

(deftest all-noun-verb-combos
  (fact (count p/all-noun-verb-combos) => 10000))

(deftest part-1
  (part-1-assertion))

(deftest part-2
  (part-2-assertion))
