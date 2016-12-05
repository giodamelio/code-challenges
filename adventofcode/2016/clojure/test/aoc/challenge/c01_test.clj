(ns aoc.challenge.c01-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c01 :refer :all]))

(fact "manhatten-distance"
      (manhatten-distance [0 0] [2 2]) => 4)

(fact "parse-path"
      (parse-path "R22, R9, L33") => [[:R 22] [:R 9] [:L 33]]
      (parse-path "R22,R9,L33") => [[:R 22] [:R 9] [:L 33]])

(fact "turn-test"
      (fact "turn right"
            (turn :N :R) => :E
            (turn :S :R) => :W)
      (fact "turn left"
            (turn :S :L) => :E
            (turn :N :L) => :W))

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
