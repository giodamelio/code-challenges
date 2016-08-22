(ns project-euler.problems.p0004
  (:require [project-euler.math :as math]))

(def answer (apply max (filter math/palindrome?
                               (for [x (range 100 999)
                                     y (range 100 999)]
                                    (* x y)))))
