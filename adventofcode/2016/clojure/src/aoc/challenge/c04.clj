(ns aoc.challenge.c04
  (:require [clojure.string :as str]))

(defn parse-room [string]
  "Parse a raw room string into its parts"
  (zipmap [:name :sector-id :checksum]
          (rest (re-find #"([a-z\-]+)\-(\d+)\[([a-z]{5})\]" string))))

;; TODO: better convert method
(defn letter-frequencies [name]
  "Get the letter frequencies from a room name"
  (->> (str/replace name #"-" "")
       (frequencies)
       (vec)
       ;; Convert to map of freq (letters) pairs
       (reduce (fn [acc [letter freq]]
                 (if (contains? acc val)
                   ;; If that freq does not exist yet create an empty vector for it
                   (assoc acc freq [])
                   ;; If a freq exists add the letter to its vector
                   (update acc freq conj letter))) {})
       ;; Sort the freq lists
       (reduce-kv #(assoc %1 %2 (sort %3)) {})))

(defn checksum-from-freqs [freqs]
  "Calculates the expected checksum from the letter frequencies"
  (->> freqs
       (vec)
       (sort-by first >)
       (map last)
       (flatten)
       (take 5)
       (apply str)))

(defn valid-room? [{name :name, checksum :checksum}]
  "Check if a room is valid"
  (= (checksum-from-freqs (letter-frequencies name)) checksum))

(defn answer-part-1 [input]
  (->> (str/split input #"\n")
       (map parse-room)
       (filter valid-room?)
       (map #(get %1 :sector-id))
       (map #(Integer/parseInt %1))
       (reduce +)))

(defn answer-part-2 [input]
  10)
