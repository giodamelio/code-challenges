(ns aoc.challenge.c02
  (:require [clojure.string :as str]
            [aoc.util :refer :all]))

(defn parse-input [input]
  (->> input
       (str/split-lines)))

(defn letter-frequencies [id]
  (->> (str/split id #"")
       (map keyword)
       (frequencies)))

(defn has-n-duplicates [n freqs]
  (contains? (set (vals freqs)) n))

(defn count-duplicates-of-n [freqs n]
  (->> freqs
       (map (partial has-n-duplicates n))
       (filter true?)
       (count)))

(defn letter-diff [word-a word-b]
  (->> (map vector word-a word-b)
       ;; Check the two letters in the vector (e.g. [\a \a]) are the same
       (map (fn [[a b]] (= a b)))
       (map not)))

(defn different-by-letters [word-a word-b]
  (->> (letter-diff word-a word-b)
    (filter true?)
    (count)))

(defn shared-letters [word-a word-b]
  ;; Combine one word with the diff of the two words
  (->> (map vector word-a (letter-diff word-a word-b))
    ;; Get just the letters that are the same between the two words
    (filter #(false? (second %1)))
    ;; Put the word back togather
    (map first)
    (str/join)))

(defn answer-part-1 [input]
  (let [;; Get the frequencies of letters for each word
        freqs (->> input
                   (parse-input)
                   (map letter-frequencies))
        ;; The counts of double letter and triple letter duplicates
        double-duplicates (count-duplicates-of-n freqs 2)
        triple-duplicates (count-duplicates-of-n freqs 3)]
    (* double-duplicates triple-duplicates)))

;; TODO: This is not actually perfect, if the different char was the first char
;; then the sort would not work
(defn answer-part-2 [input]
  (as-> input n
       (parse-input n)
       (sort n)
       ;; Split the words up into pairs
       (partition 2 1 n)
       ;; Make a map of the count charecter diff to each pair of words
       (group-by #(apply different-by-letters %1) n)
       ;; Get the pair of words that has only one different letter
       (get-in n [1 0])
       (shared-letters (first n) (second n))))
