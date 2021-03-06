(ns aoc.challenge.c02
  (:require [clojure.string :as str]
            [clojure.walk :as w]))

;; TODO: find a better way to do this
(defn go-normal [number direction]
  "Move a direction from a key and return the new key on a normal keypad"
  (case direction
    :U (case number
         1 1, 2 2, 3 3, 4 1, 5 2, 6 3, 7 4, 8 5, 9 6)
    :D (case number
         1 4, 2 5, 3 6, 4 7, 5 8, 6 9, 7 7, 8 8, 9 9)
    :L (case number
         1 1, 2 1, 3 2, 4 4, 5 4, 6 5, 7 7, 8 7, 9 8)
    :R (case number
         1 2, 2 3, 3 3, 4 5, 5 6, 6 6, 7 8, 8 9, 9 9)))

(defn go-weird [number direction]
  "Move a direction from a key and return the new key on a weird keypad"
  (case direction
    :U (case number
         1 1, 2 2, 3 1, 4 4, 5 5, 6 2, 7 3, 8 4, 9 9, "A" 6, "B" 7, "C" 8, "D" "B")
    :D (case number
         1 3, 2 6, 3 7, 4 8, 5 5, 6 "A", 7 "B", 8 "C", 9 9, "A" "A", "B" "D", "C" "C", "D" "D")
    :L (case number
         1 1, 2 2, 3 2, 4 3, 5 5, 6 5, 7 6, 8 7, 9 8, "A" "A", "B" "A", "C" "B", "D" "D")
    :R (case number
         1 1, 2 3, 3 4, 4 4, 5 6, 6 7, 7 8, 8 9, 9 9, "A" "B", "B" "C", "C" "C", "D" "D")))

(defn parse-paths [input]
  "Parse input in to vector of paths"
  (->> (str/split input #"\n")
       (map #(str/split %1 #""))
       (w/prewalk #(if (string? %) (keyword %) %))))

(defn walk-path [starting-number path goer]
  "Walk the path from a starting point to the ending point"
  (reduce #(goer %1 %2) starting-number path))

(defn walk-paths [starting-number paths goer]
  "Walk a vector of paths converting to a number"
  (rest (reduce #(conj %1 (walk-path (last %1) %2 goer))
                [starting-number]
                paths)))

(defn answer-part-1 [input]
  (walk-paths 5 (parse-paths input) go-normal))

(defn answer-part-2 [input]
  (walk-paths 5 (parse-paths input) go-weird))
