(ns aoc.challenge.c07
  (:require [clojure.string :as str]
            [clojure.set :as set]))

(defn parse-ipv7 [input]
  "Parse an IPv7 address into its supernet and hypernet parts"
  {:hypernet (map last (re-seq #"\[([a-z]+)\]" input))
   :supernet (re-seq #"[a-z]+(?![^\[]*\])" input)})

(defn is-abba? [input]
  "Check if a string is an abba(ie a four char palindrome that is not all the same char"
  (and (= input (str/reverse input))
       (= (count input) 4)
       (not= (count (frequencies input)) 1)))

(defn is-aba-or-bab? [input]
  "Check if a string contains an aba"
  (and (= input (str/reverse input))
       (= (count input) 3)
       (not= (count (frequencies input)) 1)))

(defn contains-abbas [input]
  "Return any abbas in a string"
  (->> input
       (partition 4 1)
       (map #(apply str %1))
       (filter is-abba?)))

(defn contains-abas-or-babs [input]
  "Return any aba's and bab's a string contains"
  (->> input
       (partition 3 1)
       (map #(apply str %1))
       (filter is-aba-or-bab?)))

(defn invert-aba-or-bab [input]
  "Given an aba or bab convert it to the other"
  (let [inside (nth input 1)
        outside (first input)]
    (str inside outside inside)))

(defn list-to-aba-set [input]
  "Convert a list of strings into a set of abas"
  (->> input
       (map contains-abas-or-babs)
       (filter not-empty)
       (flatten)
       (into #{})))

(defn ipv7-supports-tls? [input]
  "Check if an IPv7 ip supports tls"
  (let [{hypernet :hypernet
         supernet :supernet} (parse-ipv7 input)]
    (boolean
     (and
      ;; Check if there are any abba's inside square brackets
      (not (some #(> (count %1) 0)
                 (map contains-abbas hypernet)))
      ;; Check if there is an abba outside a bracket group
      (some #(> (count %1) 0)
            (map contains-abbas supernet))))))

(defn ipv7-supports-ssl? [input]
  "Check if an IPv7 address supports SSL"
  (let [{hypernet :hypernet
         supernet :supernet} (parse-ipv7 input)
        hypernet_babs (list-to-aba-set hypernet)
        supernet_abas (list-to-aba-set supernet)
        inverted_hypernet_babs (into #{} (map invert-aba-or-bab hypernet_babs))]
    (> (count (set/intersection supernet_abas inverted_hypernet_babs)) 0)))

(defn answer-part-1 [input]
  (->> (str/split input #"\n")
       (map ipv7-supports-tls?)
       (filter true?)
       (count)))

(defn answer-part-2 [input]
  (->> (str/split input #"\n")
       (map ipv7-supports-ssl?)
       (filter true?)
       (count)))
