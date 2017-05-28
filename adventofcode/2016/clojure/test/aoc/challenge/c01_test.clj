(ns aoc.challenge.c01-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c01 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "manhatten-distance"
      (manhatten-distance [0 0] [2 2]) => 4)

(fact "parse-path"
      (parse-path "R22, R9, L33") => [[:R 22] [:R 9] [:L 33]]
      (parse-path "R22,R9,L33") => [[:R 22] [:R 9] [:L 33]])

(fact "turn"
      (fact "turn right"
            (turn :N :R) => :E
            (turn :E :R) => :S
            (turn :S :R) => :W
            (turn :W :R) => :N)
      (fact "turn left"
            (turn :N :L) => :W
            (turn :E :L) => :N
            (turn :S :L) => :E
            (turn :W :L) => :S))

(fact "go"
      (fact "north"
            (go :N [0 0]) => [0 1])
      (fact "east"
            (go :E [0 0]) => [1 0])
      (fact "south"
            (go :S [0 0]) => [0 -1])
      (fact "west"
            (go :W [0 0]) => [-1 0]))

(fact "directions-to-path"
      (fact "calculates path correctly"
            (directions-to-path (parse-path "R2, R2, R2")) =>
            {:facing :W
             :path '([0 0] [1 0] [2 0] [2 -1] [2 -2] [1 -2] [0 -2])}))

(fact "find-first-duplicate"
    (find-first-duplicate [1 2 3 2 3]) => 2)

(fact "answer-part-1"
      (answer-part-1 (load-input)) => 146)

(fact "answer-part-2"
      (answer-part-2 (load-input)) => 131)

