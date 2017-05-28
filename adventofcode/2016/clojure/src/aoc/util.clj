(ns aoc.util
  (:require [clojure.string :as str]))

(defn parse-int
  "Parse a string to an int"
  [string]
  (Integer/parseInt (str/replace string #"\D" "")))

(defn transpose
  "Transpose a matix of lists"
  [matrix]
  (apply map list matrix))

(defn transpose-vector
  "Transpost a matrix of vectors"
  [matrix]
  (vec (apply map vector matrix)))

(defn load-input
  "Loads the input file for a problem into a string"
  []
  (as-> *ns* n
    (ns-name n)
    (name n)
    (re-find #"\d+" n)
    (str "inputs/" n ".txt")
    (slurp n)))
