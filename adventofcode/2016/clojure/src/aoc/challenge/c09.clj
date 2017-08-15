(ns aoc.challenge.c09
  (:require [clojure.string :as str]
            [aoc.util :as util]))

(def re #"\((?<length>\d+)x(?<count>\d+)\)")
(defn find-markers
  "Find all the markers in a string"
  [string]
  (let [matcher (re-matcher re string)]
    ((fn step []
       (when (.find matcher)
         (cons {:start (.start matcher)
                :end (.end matcher)
                :text (.group matcher)
                :length (util/parse-int (.group matcher "length"))
                :count (util/parse-int (.group matcher "count"))}
               (lazy-seq (step))))))))

(defn replace-in-string
  "Replace a subsection of a string with another string"
  [input-string start-index end-index replacement]
  (let [before (subs input-string 0 start-index)
        after (subs input-string (inc end-index) (count input-string))]
        (str before replacement after)))

(defn expand-markers
  "Take a string and a list of markers and expand them"
  [string markers]
  (loop [markers markers
         offset  0
         string  string]
    string
    (if (empty? markers)
      string
      (let [marker    (first markers)
            start     (- (:start marker) offset)
            end       (- (:end marker) offset)
            to-repeat (subs string end (+ end (:length marker)))
            repeated  (apply str (repeat (:count marker) to-repeat))]
        (recur (rest markers)
               (+ offset (count repeated))
               (replace-in-string string
                                  start
                                  end
                                  repeated))))))

(defn answer-part-1 [input]
  42)

(defn answer-part-2 [input]
  42)
