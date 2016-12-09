(ns aoc.challenge.c07
  (:require [clojure.string :as str]))

(defn is-abba? [input]
  "Check if a string is an abba(ie a four char palindrome that is not all the same char"
  (and (= input (str/reverse input))
       (= (count input) 4)
       (not= (count (frequencies input)) 1)))

(defn contains-abba? [input]
  "Check if a string contains an abba"
  (boolean
   (->> input
        (partition 4 1)
        ;; Convert to strings
        (map #(apply str %1))
        ;; Check if any of the substrings have abba's in them
        (some is-abba?))))

(defn ipv7-supports-tls? [input]
  "Check if an IPv7 ip supports tls"
  (boolean
   (and
    ;; Check if there are any abba's inside square brackets
    (->> input
         ;; Find square bracket groups
         (re-seq #"\[([a-z]+)\]")
         ;; Get just the inside strings
         (map last)
         ;; Make sure none of them contain abba's
         (every? (complement contains-abba?)))
    ;; Check if there is an abba outside a bracket group
    (->> input
         ;; Get just the text outside the square brackets
         (re-seq #"[a-z]+(?![^\[]*\])")
         ;; Check if any of the strings contain an abba
         (map contains-abba?)
         (some true?)))))

(defn answer-part-1 [input]
  (->> (str/split input #"\n")
       (map ipv7-supports-tls?)
       (filter true?)
       (count)))
