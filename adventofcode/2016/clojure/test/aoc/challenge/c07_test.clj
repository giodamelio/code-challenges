(ns aoc.challenge.c07-test
  (:require [midje.sweet :refer :all]
            [aoc.challenge.c07 :refer :all]
            [aoc.util :refer [load-input]]))

(fact "parse-ipv7"
      (parse-ipv7 "aaaa[qwer]tyui[add]e") =>
      {:hypernet '("qwer" "add"), :supernet '("aaaa" "tyui" "e")})

(fact "is-abba?"
      (is-abba? "abba") => true
      (is-abba? "aaaa") => false
      (is-abba? "abc") => false)

(fact "is-aba-or-bab?"
      (is-aba-or-bab? "aba") => true
      (is-aba-or-bab? "bab") => true
      (is-aba-or-bab? "abc") => false)

(fact "contains-abbas"
      (contains-abbas "eabbass") =>
      '("abba")
      (contains-abbas "abbacggc") =>
      '("abba" "cggc")
      (contains-abbas "abcd") =>
      '())

(fact "contains-abas-or-babs"
      (contains-abas-or-babs "lksabakjd") =>
      '("aba")
      (contains-abas-or-babs "jhjjkj") =>
      '("jhj" "jkj")
      (contains-abas-or-babs "sss") =>
      '())

(fact "invert-aba-or-bab"
      (invert-aba-or-bab "aba") => "bab"
      (invert-aba-or-bab "bab") => "aba")

(fact "list-to-aba-set"
      (list-to-aba-set '("ababa" "zxc" "xyzy")) =>
      #{"aba" "bab" "yzy"}
      (list-to-aba-set '()) =>
      #{})

(fact "ipv7-supports-tls?"
      (ipv7-supports-tls? "abba[mnop]qrst") => true
      (ipv7-supports-tls? "abcd[bddb]xyyx") => false
      (ipv7-supports-tls? "aaaa[qwer]tyui") => false
      (ipv7-supports-tls? "ioxxoj[asdfgh]zxcvbn") => true)

(fact "ipv7-supports-ssl"
      (ipv7-supports-ssl? "aba[bab]xyz") => true
      (ipv7-supports-ssl? "xyx[xyx]xyx") => false
      (ipv7-supports-ssl? "aaa[kek]eke") => true
      (ipv7-supports-ssl? "zazbz[bzb]cdb") => true)

(fact "answer-part-1"
      (answer-part-1 (load-input)) => 105)

(fact "answer-part-2"
      (answer-part-2 (load-input)) => 258)
