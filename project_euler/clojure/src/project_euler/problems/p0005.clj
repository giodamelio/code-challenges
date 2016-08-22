(ns project-euler.problems.p0005
  (:require [project-euler.math :as math]))

(defn divisible-by-range?
  "Check if a number is evenly divisible by a range of numbers"
  [number limit]
  (every? #(= (rem number %) 0) (range 1 limit)))

(def answer (first (filter #(divisible-by-range? % 20) (rest (range)))))
