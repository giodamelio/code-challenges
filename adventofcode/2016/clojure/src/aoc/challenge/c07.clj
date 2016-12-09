(ns aoc.challenge.c07
  (:require [clojure.string :as str]))

(defn parse-ipv7 [input]
  "Parse an IPv7 address into its supernet and hypernet parts"
  {:hypernet (map last (re-seq #"\[([a-z]+)\]" input))
   :supernet (re-seq #"[a-z]+(?![^\[]*\])" input)})

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
  (let [{hypernet :hypernet
         supernet :supernet} (parse-ipv7 input)]
    (boolean
     (and
      ;; Check if there are any abba's inside square brackets
      (every? (complement contains-abba?) hypernet)
      ;; Check if there is an abba outside a bracket group
      (some true? (map contains-abba? supernet))))))

(defn answer-part-1 [input]
  (->> (str/split input #"\n")
       (map ipv7-supports-tls?)
       (filter true?)
       (count)))
