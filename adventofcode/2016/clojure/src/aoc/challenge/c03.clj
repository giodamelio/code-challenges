(ns aoc.challenge.c03
  (:require [clojure.string :as str]
            [aoc.util :as util]))

(defn parse-triangles [input]
  "Parse a a bunch of triangles"
  (->> (str/split input #"\n")
       (map #(str/split %1 #" "))
       (map #(filter not-empty %1))
       (map #(map util/parse-int %1))))

(defn valid-triangle? [[a b c]]
  "Test if a triangle is valid"
  (and (> (+ a b) c)
       (> (+ b c) a)
       (> (+ a c) b)))

(defn rotate-and-split [triangles]
  "Do a right matrix rotate on the numbers, then split them back into groups of three"
  (->> triangles
       ;; Rotate to the right
       (util/transpose)
       ;; Split into chunks of three
       (reduce #(concat (partition 3 %2) %1) '())))

(defn answer-part-1 [input]
  (->> (parse-triangles input)
       (filter valid-triangle?)
       (count)))

(defn answer-part-2 [input]
  (->> (parse-triangles input)
       (rotate-and-split)
       (filter valid-triangle?)
       (count)))
