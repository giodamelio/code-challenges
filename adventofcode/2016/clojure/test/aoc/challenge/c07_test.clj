(ns aoc.challenge.c07-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c07 :refer :all]))

(fact "parse-ipv7"
      (parse-ipv7 "aaaa[qwer]tyui[add]e") =>
      {:hypernet '("qwer" "add"), :supernet '("aaaa" "tyui" "e")})

(fact "is-abba?"
      (is-abba? "abba") => true
      (is-abba? "aaaa") => false
      (is-abba? "abc") => false)

(fact "contains-abba?"
      (contains-abba? "eabbass") => true
      (contains-abba? "abbacggc") => true
      (contains-abba? "abcd") => false)

(fact "ipv7-supports-tls?"
      (ipv7-supports-tls? "abba[mnop]qrst") => true
      (ipv7-supports-tls? "abcd[bddb]xyyx") => false
      (ipv7-supports-tls? "aaaa[qwer]tyui") => false
      (ipv7-supports-tls? "ioxxoj[asdfgh]zxcvbn") => true)
