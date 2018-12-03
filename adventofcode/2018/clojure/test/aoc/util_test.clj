(ns aoc.util-test
  (:require [midje.sweet :refer :all]
            [aoc.util :refer :all]))

(facts "parse-int"
       (parse-int "10") => 10
       (parse-int "+10") => 10
       (parse-int "-10") => -10)
