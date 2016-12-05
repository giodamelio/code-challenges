(ns aoc.challenge.c02-test
  (:require [clojure.test :refer :all]
            [aoc.challenge.c02 :refer :all]))

(deftest go-test
  (testing "go up"
    (is (= (go 5 :U) 2))
    (is (= (go 3 :U) 3)))

  (testing "go down"
    (is (= (go 5 :D) 8))
    (is (= (go 7 :D) 7)))

  (testing "go left"
    (is (= (go 5 :L) 4))
    (is (= (go 4 :L) 4)))

  (testing "go right"
    (is (= (go 5 :R) 6))
    (is (= (go 3 :R) 3))))

(deftest parse-paths-text
  (testing "parse a few paths"
    (is (= (parse-paths "UDU\nRLUL\nDDLR")
           [[:U :D :U]
            [:R :L :U :L]
            [:D :D :L :R]]))))

(deftest walk-path-test
  (testing "walk some a path"
    (is (= (walk-path 5 [:U :L :L]) 1))
    (is (= (walk-path 1 [:R :R :D :D :D]) 9))
    (is (= (walk-path 9 [:L :U :R :D :L]) 8))
    (is (= (walk-path 8 [:U :U :U :U :D]) 5))))

(deftest walk-paths-test
  (testing "walk a series of paths"
    (is (= (walk-paths 5 '([:U :L :L] [:R :R :D :D :D] [:L :U :R :D :L] [:U :U :U :U :D]))
           '(1 9 8 5)))))
