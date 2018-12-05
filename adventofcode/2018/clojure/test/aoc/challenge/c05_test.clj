(ns aoc.challenge.c05-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c05 :refer :all]
            [aoc.util :refer [load-input]]))

(def example-input "dabAcCaCBAcCcaDA\n")

(facts "remove-units"
       (remove-units \a "aAbB") => "bB")

(facts "answer-part-1"
       (answer-part-1 example-input) => 10)

(facts :slow
       (answer-part-1 (load-input)) => 10878)

(facts "answer-part-2"
       (answer-part-2 example-input) => 4)

(facts :slow
       (answer-part-2 (load-input)) => 6874)
