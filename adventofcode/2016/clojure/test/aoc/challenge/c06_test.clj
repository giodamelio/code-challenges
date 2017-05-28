(ns aoc.challenge.c06-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c06 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "parse-input"
      (parse-input "aaa\nbbb\nccc") =>
      ["aaa" "bbb" "ccc"])

(fact "answer-part-1"
      (answer-part-1 (load-input)) => "dzqckwsd")

(fact "answer-part-2"
      (answer-part-2 (load-input)) => "lragovly")
