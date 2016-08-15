(ns project-euler.problems.p0001)

(defn seq-divisible-by
  "Returns a lazy sequence of evey natural number evenly divisible by one or more numbers"
  [& nums]
  (letfn [(divisible-by [n d] (zero? (rem n d)))]
    (filter #(some (partial divisible-by %) nums) (range))))

(def answer (reduce + (take-while #(< % 1000) (seq-divisible-by 3 5))))
