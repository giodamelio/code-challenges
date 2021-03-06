(ns aoc.puzzles.day-1
  (:require [clojure.string :as str]))

(defn parse
  "Parse the input into a vector of numbers"
  [input]
  (->> input
       ;; Split it into lines
       str/split-lines
       ;; Convert each line to a number
       (map read-string)))

(defn calculate-fuel
  "Calculate the fuel needed to launch a module"
  [mass]
  (-> mass
      (/ 3)
      int ;; Round down
      (- 2)))

(defn calculate-fuel-recursive
  "Calculate the fuel needed to launch a module. Recursivly calculate the fuel need to launch the fuel as well"
  [mass]
  (loop [fuel (calculate-fuel mass)
         total fuel]
    (let [the-fuels-fuel (calculate-fuel fuel)]
      (if (>= 0 the-fuels-fuel)
        total
        (recur the-fuels-fuel (+ total the-fuels-fuel))))))

(defn part-1
  "Calculates the fuel requement of each module from the input and sums them"
  [input]
  (->> input
       ;; Calculate the fuel requirement
       (map calculate-fuel)
       ;; Add them up
       (reduce +)))

(defn part-2
  "Calculates the fuel requement of each module (with it's fuel included) from the input and sums them"
  [input]
  (->> input
       ;; Calculate the fuel requirement
       (map calculate-fuel-recursive)
       ;; Add them up
       (reduce +)))
