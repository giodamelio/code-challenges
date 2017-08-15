(ns aoc.challenge.c09-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c09 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "find-markers"
      (find-markers "(1x2)") =>
      '({:length 1
         :count  2
         :start  0
         :end    5
         :text   "(1x2)"})

      (find-markers "AA(9x666)AA") =>
      '({:length 9
         :count  666
         :start  2
         :end    9
         :text   "(9x666)"})

      (find-markers "AAAA") =>
      nil)

(fact "replace-in-string"
      (replace-in-string "12345" 1 2 "bbb") => "1bbb45"
      (replace-in-string "12345" 1 2 nil) => "145")

(future-fact "answer-part-1"
      (answer-part-1 (load-input)) => 42)

(future-fact "answer-part-2"
      (answer-part-2 (load-input)) => 42)
