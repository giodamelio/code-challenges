(ns aoc.challenge.c01
  (:require [clojure.string :as str]
            [aoc.util :refer :all]))

(defn parse-input [input]
  (->> input
       (str/split-lines)
       (map parse-int)))

(defn cycled-freqs [input]
  (reductions + (cycle input)))

(defn answer-part-1 [input]
  (reduce + (parse-input input)))

(defn answer-part-2 [input]
  (loop [freqs (cycled-freqs (parse-input input))
         freqs-visited #{}]
    (let [current-freq (first freqs)]
      (if (contains? freqs-visited current-freq)
        current-freq
        (recur (rest freqs) (conj freqs-visited current-freq))))))
