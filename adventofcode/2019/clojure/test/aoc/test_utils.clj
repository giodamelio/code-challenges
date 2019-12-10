(ns aoc.test-utils
  (:require [clojure.test :refer :all]
            [clojure.string :as str]))

(defn get-puzzle-number
  "Gets the puzzle number from a namespace"
  [input-namespace]
  (->> input-namespace
       str
       (re-find #"day-(\d+)(-test)?$")
       second))

(defn get-puzzle-file
  "Get a file from the data directory for this file"
  [filename input-namespace]
  (let [puzzle-number (get-puzzle-number input-namespace)]
    (-> (str "data/" puzzle-number "/" filename)
        clojure.java.io/resource
        slurp
        str/trim)))

(defmacro part-1-assertion
  "Create an assertion for part one of a puzzle based on file input and the current namespace"
  [& extra-args]
  `(is (= (str (p/part-1 (p/parse (get-puzzle-file "input" *ns*)) ~@extra-args))
          (get-puzzle-file "answer_1" *ns*))
       "answer 1 is incorrect"))

(defmacro part-2-assertion
  "Create an assertion for part two of a puzzle based on file input and the current namespace"
  [& extra-args]
  `(is (= (str (p/part-2 (p/parse (get-puzzle-file "input" *ns*)) ~@extra-args))
          (get-puzzle-file "answer_2" *ns*))
       "answer 2 is incorrect"))
