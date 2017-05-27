(ns bob
  (require [clojure.string :as str]))

(defn response-for [input]
  (let [only-letters (str/replace input #"[^a-zA-Z]" "")]
    (cond
      ; Nothing
      (str/blank? input) "Fine. Be that way!"
      ; Yelling
      (and
       (pos? (count only-letters))
       (= (str/upper-case only-letters) only-letters)) "Whoa, chill out!"
      ; Question
      (= (last input) \?) "Sure."
      ; No other matches
      :else "Whatever.")))
  
