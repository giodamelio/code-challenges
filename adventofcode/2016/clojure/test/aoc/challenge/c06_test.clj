(ns aoc.challenge.c06-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c06 :refer :all]))

(fact "parse-input"
      (parse-input "aaa\nbbb\nccc") =>
      ["aaa" "bbb" "ccc"])
