(ns aoc.challenge.c03
  (:require [clojure.string :as str]
            [aoc.util :refer :all]))

(def claim-regex #"^#(?<id>\d+) @ (?<y>\d+),(?<x>\d+): (?<width>\d+)x(?<height>\d+)$")
(defn parse-claim [claim-text]
  (->> claim-text
       ;; Parse them numbers out with a regex
       (re-find-named-groups claim-regex)
       ;; Convert all the map values to integers
       (reduce-kv #(assoc %1 %2 (parse-int %3)) {})))

(defn parse-input [input]
  (->> input
       (str/split-lines)
       (map parse-claim)))

;; Build an empy grid of lists for the claims to go on
(defn build-grid [width height]
  (let [row (into (repeat width '()) [])]
    (repeat height row)))

(defn add-claim-to-grid [grid claim]
  (let [newgrid (to-array-2d grid)
        {:keys [id x y width height]} #spy/p claim]
      (doall (for [cy (range (count (first grid)))
                   cx (range (count grid))]
               (if (and (>= cx x) (< cx (+ x height)) (>= cy y) (< cy (+ y width)))
                 (aset newgrid cx cy (conj (aget newgrid cx cy) id)))))
      (into [] (map (partial into []) newgrid))))

(defn answer-part-1 [input & {:keys [width height] :or {width 1000 height 1000}}]
  (let [grid (build-grid width height)]
    (->> input
         (parse-input)
         (reduce (partial add-claim-to-grid) grid)
         ;; (map #(do (println %1) %1))
         (apply concat)
         ;; (map #(do (println %1) %1))
         (map count)
         ;; (map #(do (println %1) %1))
         (filter #(> %1 1))
         ;; (map #(do (println %1) %1))
         (count))))

(defn answer-part-2 [input & {:keys [width height] :or {width 1000 height 1000}}]
  (let [grid (build-grid width height)]
    (->> input
        (parse-input)
        (reduce (partial add-claim-to-grid) grid)
        ;; (map #(do (println %1) %1))
        (apply concat)
        (filter #(> (count %1) 0))
        (sort-by count)
        (reduce (fn [shares nums]
                  (if (> (count nums) 1)
                    (merge shares (zipmap nums (repeat true)))
                    (merge shares (zipmap nums (repeat false)))))
                {})
        (clojure.set/map-invert))))
