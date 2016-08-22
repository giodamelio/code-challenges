(ns project-euler.math)

; A lazy sequence of fibonacci numbers
(def fibonacci-sequence
  (map first (iterate (fn [[a b]] [b (+' a b)]) [0 1])))
