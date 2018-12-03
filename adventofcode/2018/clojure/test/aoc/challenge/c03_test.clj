(ns aoc.challenge.c03-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c03 :refer :all]
            [aoc.util :refer [load-input]]))

(def example-input "#1 @ 1,3: 4x4\n#2 @ 3,1: 4x4\n#3 @ 5,5: 2x2")

(facts "parse-claim"
       (parse-claim "#1 @ 1,3: 4x4") => {:id 1
                                         :x 3
                                         :y 1
                                         :width 4
                                         :height 4})

(facts "build-grid"
       (build-grid 2 3) => [['() '()]
                            ['() '()]
                            ['() '()]])

(facts "add-claim-to-grid"
       (add-claim-to-grid (build-grid 5 5) {:id 1 :x 1 :y 1 :width 3 :height 3}) =>
       [['() '() '() '() '()]
        ['() '(1) '(1) '(1) '()]
        ['() '(1) '(1) '(1) '()]
        ['() '(1) '(1) '(1) '()]
        ['() '() '() '() '()]])

(facts "add-claim-to-grid"
       (add-claim-to-grid (build-grid 5 5) {:id 1 :x 1 :y 1 :width 3 :height 3}) =>
       [['() '() '() '() '()]
        ['() '(1) '(1) '(1) '()]
        ['() '(1) '(1) '(1) '()]
        ['() '(1) '(1) '(1) '()]
        ['() '() '() '() '()]]
       (add-claim-to-grid (build-grid 5 5) {:id 1 :x 0 :y 0 :width 3 :height 3}) =>
        [['(1) '(1) '(1) '( ) '()]
         ['(1) '(1) '(1) '( ) '()]
         ['(1) '(1) '(1) '( ) '()]
         ['( ) '( ) '( ) '( ) '()]
         ['( ) '( ) '( ) '( ) '()]]
       ;; Add multiple claims to a grid
       (-> (build-grid 5 5)
         (add-claim-to-grid {:id 1 :x 2 :y 2 :width 3 :height 3})
         (add-claim-to-grid {:id 2 :x 0 :y 0 :width 3 :height 3})) =>
          [['(2) '(2) '(2) '( ) '()]
           ['(2) '(2) '(2) '( ) '()]
           ['(2) '(2) '(2 1) '(1) '(1)]
           ['( ) '( ) '(1) '(1) '(1)]
           ['( ) '( ) '(1) '(1) '(1)]])

(facts "answer-part-1"
       (answer-part-1 example-input :width 8 :height 8) => 4)
       ;; (answer-part-1 (load-input)) => 4)

(facts "answer-part-2"
       (answer-part-2 example-input :width 8 :height 8) => 3
       (answer-part-2 (load-input)) => 3)
