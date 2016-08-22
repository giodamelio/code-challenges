(ns project-euler.problems.p0003
  (:require [project-euler.math :as math]))

(def answer (apply max (math/prime-factors 600851475143)))
