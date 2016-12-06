(ns aoc.challenge.c03-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c03 :refer :all]))

(fact "parse-int"
      (parse-int "10") => 10
      (parse-int "a") => (throws NumberFormatException))

(fact "parse-triangles"
      (parse-triangles "10 10 10\n2 2 2\n 11     11  11 ") =>
      '((10 10 10)
        (2  2  2 )
        (11 11 11)))

(fact "valid-triangle"
      (valid-triangle? '(5 10 25)) => false
      (valid-triangle? '(5 10 14)) => true)
