(ns aoc.challenge.c01
  (:require [clojure.string :as str]))

(defn manhatten-distance [[x1 y1] [x2 y2]]
  "Calculate the manhatten distance between two points"
  (+ (Math/abs (- x2 x1)) (Math/abs (- y2 y1))))

(defn parse-path [path]
  "Parse a path of directions"
  (->> (str/split path #",")
       (map str/trim)
       (reduce
        #(conj %1 [((comp keyword str first) %2)
                   (Integer/parseInt
                    (str/join (rest %2)))]) [])))

(defn turn [facing direction]
  "Take the direction we are facing and the direction we want to turn and return the direction we are facing after the turn"
  (case direction
    :R (case facing
         :N :E
         :E :S
         :S :W
         :W :N)
    :L (case facing
         :N :W
         :W :S
         :S :E
         :E :N)))

(defn go [direction [x y]]
  "Calculate the next coords in a certin direction"
  (case direction
    :N [x (inc y)]
    :E [(inc x) y]
    :S [x (dec y)]
    :W [(dec x) y]))

(defn go-n [location direction distance]
  "Create a path of coords a certin distance in a certin direction"
  (rest (take (inc distance) (iterate (partial go direction) location))))

(defn directions-to-path [directions]
  "follow a set of right and left turns and convert it into a path of coordinates"
  (reduce (fn [acc [direction distance]]
            (let [path (:path acc)
                  facing (:facing acc)
                  new-facing (turn facing direction)]
              (-> acc
               ;; Set the direction we are facing
               (assoc :facing new-facing)
               ;; Add points between the current location and the new location to the path
               (update :path concat (go-n (last path) new-facing distance)))))
          { :facing :N :path [[0 0]] } directions))

(defn find-first-duplicate [directions]
  "Find the first repeat element in a collection"
  (reduce (fn [acc val] (if (contains? acc val)
                          (reduced val)
                          (conj acc val))) #{} directions))

(defn answer-part-1 [input]
  (manhatten-distance [0 0] (last (:path (directions-to-path (parse-path input))))))

(defn answer-part-2 [input]
  (manhatten-distance [0 0] (find-first-duplicate (:path (directions-to-path (parse-path input))))))
