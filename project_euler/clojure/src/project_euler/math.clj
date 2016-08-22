(ns project-euler.math)

; A lazy sequence of fibonacci numbers
(def fibonacci-sequence
  (map first (iterate (fn [[a b]] [b (+' a b)]) [0 1])))

(defn prime-factors
  "Return the prime factors of a number"
  ([n] (prime-factors n 2))
  ([n candidate]
   (cond
     (<= n 1) ()
     (zero? (rem n candidate)) (cons candidate
                                     (lazy-seq (prime-factors (/ n candidate) candidate)))
     :else (recur n (inc candidate)))))
