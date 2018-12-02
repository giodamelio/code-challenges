(ns aoc.challenge.c01-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c01 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "answer-part-1"
      (answer-part-1 (load-input)) => 10)
