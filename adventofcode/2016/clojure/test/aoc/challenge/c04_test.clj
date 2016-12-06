(ns aoc.challenge.c04-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c04 :refer :all]))

(fact "parse-room"
      (parse-room "aaaaa-bbb-z-y-x-123[abxyz]") =>
      {:name "aaaaa-bbb-z-y-x", :sector-id "123", :checksum "abxyz"}
      (parse-room "not-a-real-room-404[oarel]") =>
      {:name "not-a-real-room", :sector-id "404", :checksum "oarel"})

(fact "letter-frequencies"
      (letter-frequencies "not-a-real-room") =>
      {1 '(\e \l \m \n \t), 3 '(\o), 2 '(\a \r)}
      (letter-frequencies "a-b-c-d-e-f-g-h") =>
      {1 '(\a \b \c \d \e \f \g \h)})

(fact "checksum-from-freqs"
      (checksum-from-freqs {5 '(\a), 3 '(\b), 1 '(\x \y \z)}) =>
      "abxyz"
      (checksum-from-freqs {1 '(\e \l \m \n \t), 3 '(\o), 2 '(\a \r)}) =>
      "oarel")

(fact "valid-room?"
      (valid-room? {:name "aaaaa-bbb-z-y-x", :sector-id "123", :checksum "abxyz"}) => true
      (valid-room? {:name "totally-real-room", :sector-id "200", :checksum "decoy"}) => false)
