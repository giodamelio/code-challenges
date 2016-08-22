(ns project-euler.problems.p0002
  (:require [project-euler.math :as math]))

(def answer (reduce + (filter (partial even?)
                              (take-while #(< % 4000000)
                                          math/fibonacci-sequence))))
