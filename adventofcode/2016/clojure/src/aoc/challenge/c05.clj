(ns aoc.challenge.c05
  (:require [clojure.string :as str]
            [digest :refer [md5]]))

(defn hashes [string]
  "A lazy infinite iterator of hashes"
  (->> (range)
       (map #(str string %1))
       (map md5)
       (filter #(= "00000" (subs %1 0 5)))))

(defn answer-part-1 [input]
  (->> (hashes input)
    (take 8)
    (map #(nth %1 5))
    (apply str)))
