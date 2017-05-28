(ns aoc.challenge.c02-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c02 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "go"
      (fact "normal"
            (fact "up"
                  (go-normal 5 :U) => 2
                  (go-normal 3 :U) => 3)
            (fact "down"
                  (go-normal 5 :D) => 8
                  (go-normal 7 :D) => 7)
            (fact "left"
                  (go-normal 5 :L) => 4
                  (go-normal 4 :L) => 4)
            (fact "right"
                  (go-normal 5 :R) => 6
                  (go-normal 3 :R) => 3))
      (fact "weird"
            (fact "up"
                  (go-weird 5 :U) => 5
                  (go-weird 3 :U) => 1)
            (fact "down"
                  (go-weird 5 :D) => 5
                  (go-weird 7 :D) => "B")
            (fact "left"
                  (go-weird 5 :L) => 5
                  (go-weird 4 :L) => 3)
            (fact "right"
                  (go-weird 5 :R) => 6
                  (go-weird 3 :R) => 4)))

(fact "parse-paths"
      (parse-paths "UDU\nRLUL\nDDLR") =>
      [[:U :D :U]
       [:R :L :U :L]
       [:D :D :L :R]])

(fact "walk-path"
    (walk-path 5 [:U :L :L] go-normal) => 1
    (walk-path 1 [:R :R :D :D :D] go-normal) => 9
    (walk-path 9 [:L :U :R :D :L] go-normal) => 8
    (walk-path 8 [:U :U :U :U :D] go-normal) => 5)

(fact "walk-paths"
      (walk-paths 5 '([:U :L :L]
                      [:R :R :D :D :D]
                      [:L :U :R :D :L]
                      [:U :U :U :U :D]) go-normal) =>
      '(1 9 8 5))

(fact "answer-part-1"
      (answer-part-1 (load-input)) => '(8 4 4 5 2))

(fact "answer-part-2"
      (answer-part-2 (load-input)) => '("D" 6 5 "C" 3))
