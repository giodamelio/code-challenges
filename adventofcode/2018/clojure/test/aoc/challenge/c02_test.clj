(ns aoc.challenge.c02-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c02 :refer :all]
            [aoc.util :refer [load-input]]))

(def example-input-part-1 "abcdef\nbababc\nabbcde\nabcccd\naabcdd\nabcdee\nababab")
(def example-input-part-2 "abcde\nfghij\nklmno\npqrst\nfguij\naxcye\nwvxyz")

(fact "parse-input"
      (parse-input "aaa\nbbb\nccc") => ["aaa" "bbb" "ccc"])

(facts "letter-frequencies"
       (letter-frequencies "abc") => {:a 1 :b 1 :c 1}
       (letter-frequencies "aaa") => {:a 3})

(facts "has-n-duplicates"
       (has-n-duplicates 2 {:a 2}) => true
       (has-n-duplicates 3 {:a 2}) => false)

(facts "count-duplicates-of-n"
       (count-duplicates-of-n [{:a 2} {:b 2} {:c 3}] 2) => 2)

(facts "letter-diff"
       (letter-diff "aaa" "aaa") => [false false false]
       (letter-diff "aaa" "bbb") => [true true true]
       (letter-diff "aaa" "abc") => [false true true])

(facts "difference-by-letters"
       (different-by-letters "aaa" "bbb") => 3
       (different-by-letters "abc" "bbb") => 2)

(facts "shared-letters"
       (shared-letters "abcdef" "abcdez") => "abcde")

(facts "answer-part-1"
       (answer-part-1 example-input-part-1) => 12
       (answer-part-1 (load-input)) => 5704)

(facts "answer-part-2"
       (answer-part-2 example-input-part-2) => "fgij"
       (answer-part-2 (load-input)) => "umdryabviapkozistwcnihjqx")
