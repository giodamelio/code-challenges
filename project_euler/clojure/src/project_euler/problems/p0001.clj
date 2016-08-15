(ns project-euler.problems.p0001)

(defn seq-divisible-by-3-or-5
  "Returns a lazy sequence of evey natural number evenly divisible by 3 or 5"
  []
  (filter #(or (= (rem % 3) 0) (= (rem % 5) 0)) (range)))

(def answer (reduce + (take-while #(< % 1000) (seq-divisible-by-3-or-5))))
