(ns aoc.util-test
  (:require [midje.sweet :refer :all]
            [aoc.util :refer :all]))

(fact "parse-int"
      (parse-int "2222") => 2222
      (parse-int "+66") => 66
      (parse-int "1_000_000_000") => 1000000000
      (parse-int "__sdas 299 asdfdf 33") => 29933
      (parse-int "haha") => (throws NumberFormatException))

(fact "transpose"
      (transpose '((1 2 3)
                   (4 5 6)
                   (7 8 9))) =>
      '((1 4 7)
        (2 5 8)
        (3 6 9)))

(fact "transpose-vector"
      (transpose [[1 2 3]
                  [4 5 6]
                  [7 8 9]]) =>
      [[1 4 7]
       [2 5 8]
       [3 6 9]])
