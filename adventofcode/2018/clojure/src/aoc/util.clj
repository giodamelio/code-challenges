(ns aoc.util
  (:require [clojure.string :as str]))

(defn parse-int
  "Parse a string to an int"
  [string]
  (Integer/parseInt (re-find #"\A[-+]?\d+" string)))

(defn load-input
  "Loads the input file for a problem into a string"
  []
  (as-> *ns* n
    (ns-name n)
    (name n)
    (re-find #"\d+" n)
    (str "inputs/" n ".txt")
    (slurp n)))
