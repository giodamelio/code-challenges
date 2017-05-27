(ns aoc.challenge.c06
  (:require [clojure.string :as str]
            [aoc.util :as util]))

(defn parse-input [input]
  "Parse the input"
  (str/split input #"\n"))

(defn answer-part-1 [input]
  (->> input
       (parse-input)
       (util/transpose)
       (map frequencies)
       (map vec)
       (map #(sort-by last > %1))
       (map (comp first first))
       (apply str)))

(defn answer-part-2 [input]
  (->> input
       (parse-input)
       (util/transpose)
       (map frequencies)
       (map vec)
       (map #(sort-by last < %1))
       (map (comp first first))
       (apply str)))
