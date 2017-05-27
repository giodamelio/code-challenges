(ns aoc.challenge.c08-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c08 :refer :all]))

(tabular
 (fact "rotate-vector" (rotate-vector ?input ?count) => ?output)
 ?input    ?count  ?output
 [1 2 3]   1       [3 1 2]
 [1 2 3]   3       [1 2 3]
 [1 2 3]   0       [1 2 3]
 [1 2 3]  -1       [1 2 3])

(fact "screen-create"
      (screen-create 5 5) => (five-of (five-of :.))
      (screen-create) => (six-of (n-of :. 50)))

(fact "screen-render"
      (screen-render (screen-create 5 5)) =>
      ".....\n.....\n.....\n.....\n.....")

(fact "screen-print"
      (with-out-str (screen-print (screen-create 5 5))) =>
      ".....\n.....\n.....\n.....\n.....\n")

(fact "screen-get"
      (screen-get 0 0 (screen-create 5 5)) => :.
      (screen-get 0 100 (screen-create 5 5)) => nil)

(fact "screen-set"
      (screen-set 1 0 :# (screen-create 3 3)) =>
      [[:. :# :.]
       [:. :. :.]
       [:. :. :.]]

      (screen-set 5 0 :# (screen-create 3 3)) =>
      [[:. :. :.]
       [:. :. :.]
       [:. :. :.]]

      (screen-set -10 0 :# (screen-create 3 3)) =>
      [[:. :. :.]
       [:. :. :.]
       [:. :. :.]])

(fact "screen-transform-rect"
      (screen-transform-rect 3 2 (screen-create 5 5)) =>
      [[:# :# :# :. :.]
       [:# :# :# :. :.]
       [:. :. :. :. :.]
       [:. :. :. :. :.]
       [:. :. :. :. :.]]

      (screen-transform-rect 0 0 (screen-create 3 3)) =>
      (three-of (three-of :.))

      (screen-transform-rect 10 10 (screen-create 3 3)) =>
      [[:# :# :#]
       [:# :# :#]
       [:# :# :#]])

(fact "screen-transform-rotate-row"
      (screen-transform-rotate-row 0 1 [[:# :. :.]
                                        [:# :. :.]
                                        [:# :. :.]]) =>
      [[:. :# :.]
       [:# :. :.]
       [:# :. :.]]

      (screen-transform-rotate-row 4 1 [[:# :. :.]
                                        [:# :. :.]
                                        [:# :. :.]]) =>
      [[:# :. :.]
       [:# :. :.]
       [:# :. :.]])

(fact "screen-transform-rotate-col"
      (screen-transform-rotate-col 0 2 [[:# :# :#]
                                        [:. :. :.]
                                        [:. :. :.]]) =>
      [[:. :# :#]
       [:. :. :.]
       [:# :. :.]]

      (screen-transform-rotate-col 4 1 [[:# :# :#]
                                        [:. :. :.]
                                        [:. :. :.]]) =>
      [[:# :# :#]
       [:. :. :.]
       [:. :. :.]])

(fact "parse-command"
      (parse-command "rect 50x10") => '(:rect 50 10)
      (parse-command "rotate column x=12 by 10") => '(:rotate-column 12 10)
      (parse-command "rotate row y=22 by 666") => '(:rotate-row 22 666))

(fact "apply-commands-to-screen"
      (apply-commands-to-screen
       (screen-create 3 3)
       ['(:rect 1 1)
        '(:rotate-row 0 1)
        '(:rotate-column 1 1)]) =>
      [[:. :. :.]
       [:. :# :.]
       [:. :. :.]])
                                

