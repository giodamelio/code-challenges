(ns aoc.challenge.c06-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c06 :refer :all]))

(fact "parse-input"
      (parse-input "aaa\nbbb\nccc") =>
      ["aaa" "bbb" "ccc"])

(fact "matrix-rotate"
      (matrix-rotate [[0 0 0] [1 1 1] [2 2 2] [3 3 3]]) =>
      '((0 1 2 3) (0 1 2 3) (0 1 2 3)))
