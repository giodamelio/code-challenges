(ns aoc.challenge.c03
  (:require [clojure.string :as str]))

(defn parse-int [string]
  "Only necessary because you can't nest anonymous functions"
  (Integer/parseInt string))

(defn parse-triangles [input]
  "Parse a a bunch of triangles"
  (->> (str/split input #"\n")
       (map #(str/split %1 #" "))
       (map #(filter not-empty %1))
       (map #(map parse-int %1))))

(defn valid-triangle? [[a b c]]
  "Test if a triangle is valid"
  (and (> (+ a b) c)
       (> (+ b c) a)
       (> (+ a c) b)))

(defn answer-part-1 [input]
  (->> (parse-triangles input)
       (filter valid-triangle?)
       (count)))
