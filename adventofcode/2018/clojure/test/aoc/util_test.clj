(ns aoc.util-test
  (:require [midje.sweet :refer :all]
            [aoc.util :refer :all]))

(facts "parse-int"
       (parse-int "10") => 10
       (parse-int "+10") => 10
       (parse-int "-10") => -10)

(fact "get-capture-groups"
      (let [get-capture-groups #'aoc.util/get-capture-groups]
        (get-capture-groups #"(?<letter>[a-z]+) (?<number>\d+)") =>
        '("letter" "number")
        (get-capture-groups #"") =>
        '()))

(fact "re-find-named-groups"
      (re-find-named-groups #"(?<letter>[a-z]+) (?<number>\d+)" "abc 22") =>
      {:letter "abc"
       :number "22"}
      (re-find-named-groups #"([a-z]+) (\d+)" "abc 22") => {}
      (re-find-named-groups #"[a-z]+ \d+" "abc 22") => {}
      (re-find-named-groups #"^\d+$" "abc") => {})
