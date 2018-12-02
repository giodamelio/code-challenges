(ns aoc.util)

(defn load-input
  "Loads the input file for a problem into a string"
  []
  (as-> *ns* n
    (ns-name n)
    (name n)
    (re-find #"\d+" n)
    (str "inputs/" n ".txt")
    (slurp n)))
