(ns aoc.challenge.c01-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c01 :refer :all]
            [aoc.util :refer [load-input]]))

(def example-input "+1\n-2\n+3\n+1")

(fact "parse-input"
       (parse-input "+10\n-20\n+22222") => [10 -20 22222])

(fact "cycled-freqs"
      (take 5 (cycled-freqs [1 -1])) => [1 0 1 0 1])

(facts "answer-part-1"
      (answer-part-1 example-input) => 3
      (answer-part-1 (load-input)) => 497)

(facts "answer-part-2"
      (answer-part-2 example-input) => 2
      (answer-part-2 (load-input)) => 558)
