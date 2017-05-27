(ns aoc.challenge.c03-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c03 :refer :all]))

(fact "parse-triangles"
      (parse-triangles "10 10 10\n2 2 2\n 11     11  11 ") =>
      '((10 10 10)
        (2  2  2 )
        (11 11 11)))

(fact "valid-triangle"
      (valid-triangle? '(5 10 25)) => false
      (valid-triangle? '(5 10 14)) => true)

(fact "rotate-and-split"
      (rotate-and-split '((101 301 501) (102 302 502) (103 303 503) (201 401 601) (202 402 602) (203 403 603))) =>
      '((501 502 503) (601 602 603) (301 302 303) (401 402 403) (101 102 103) (201 202 203)))
