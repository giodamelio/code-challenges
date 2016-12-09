(ns aoc.challenge.c06
  (:require [clojure.string :as str]))

(defn parse-input [input]
  "Parse the input"
  (str/split input #"\n"))

(defn matrix-rotate [matrix]
  "Do a right matrix rotate"
  (apply map list matrix))

(defn answer-part-1 [input]
  (->> input
       (parse-input)
       (matrix-rotate)
       (map frequencies)
       (map vec)
       (map #(sort-by last > %1))
       (map (comp first first))
       (apply str)))

(defn answer-part-2 [input]
  (->> input
       (parse-input)
       (matrix-rotate)
       (map frequencies)
       (map vec)
       (map #(sort-by last < %1))
       (map (comp first first))
       (apply str)))
