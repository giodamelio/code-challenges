(ns aoc.util
  (:require [clojure.string :as str]))

(defn parse-int
  "Parse a string to an int"
  [string]
  (Integer/parseInt (re-find #"\A[-+]?\d+" string)))

(defn- get-capture-groups
  "List the capture groups in a regex"
  [re]
  (->> re
       (.pattern)
       (.toString)
       (re-seq #"\(\?<([a-zA-Z][a-zA-Z0-9]*)")
       (map second)))

(defn re-find-named-groups
  "Return a map of name capture groups from a regex"
  [re string]
  (let [matcher (re-matcher re string)
        groups (get-capture-groups matcher)]
    (if (.find matcher)
      (loop [[first & rest] groups
             output {}]
        (if (nil? first)
          output
          (recur rest
                 (assoc output
                        (keyword first)
                        (.group matcher first)))))
      {})))

(defn load-input
  "Loads the input file for a problem into a string"
  []
  (as-> *ns* n
    (ns-name n)
    (name n)
    (re-find #"\d+" n)
    (str "inputs/" n ".txt")
    (slurp n)))
