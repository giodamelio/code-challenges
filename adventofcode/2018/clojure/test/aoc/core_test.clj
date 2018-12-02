(ns aoc.core-test
  (:use midje.sweet)
  (:require [clojure.test :refer :all]
            [aoc.core :refer :all]))

(facts "haha"
  [1 2 3] => [1 2 3 4]
  [1 2 3] => [1 2 3])
