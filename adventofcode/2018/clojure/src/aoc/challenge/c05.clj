(ns aoc.challenge.c05
  (:use [com.rpl.specter])
  (:require [clojure.string :as str]
            [aoc.util :refer :all]))

(def the-regex #"(aA|Aa|bB|Bb|cC|Cc|dD|Dd|eE|Ee|fF|Ff|gG|Gg|hH|Hh|iI|Ii|jJ|Jj|kK|Kk|lL|Ll|mM|Mm|nN|Nn|oO|Oo|pP|Pp|qQ|Qq|rR|Rr|sS|Ss|tT|Tt|uU|Uu|vV|Vv|wW|Ww|xX|Xx|yY|Yy|zZ|Zz)")

(defn react [polymer]
  (loop [input polymer
         last input]
    (let [new (str/replace input the-regex "")]
      (if (= new last)
        last
        (recur new new)))))

(defn upper-case-char [char-in]
  (first (seq (str/upper-case char-in))))

(def alphabet '(\a \b \c \d \e \f \g \h \i \j \k \l \m \n \o \p \q \r \s \t \u \v \w \x \y \z))

(defn remove-units [unit polymer]
  (->> polymer
       (seq)
       (filter #(not= %1 unit))
       (filter #(not= %1 (upper-case-char unit)))
       (apply str)))

(defn answer-part-1 [input]
  (count (react (str/trim-newline input))))

(defn answer-part-2 [input]
  ;; Get a list of the input with each letter removed
  (->> ((apply juxt (map #(partial remove-units %1) alphabet)) (str/trim-newline input))
       (map react)
       (map count)
       (sort)
       (first)))
