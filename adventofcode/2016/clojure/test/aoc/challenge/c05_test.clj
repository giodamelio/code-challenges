(ns aoc.challenge.c05-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c05 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "answer-part-1" :slow
      (answer-part-1 (load-input)) => "587572df")
