(ns aoc.challenge.c02-test
  (:require [clojure.test :refer :all]
            [aoc.challenge.c02 :refer :all]))

(deftest go-normal-test
  (testing "go up"
    (is (= (go-normal 5 :U) 2))
    (is (= (go-normal 3 :U) 3)))

  (testing "go down"
    (is (= (go-normal 5 :D) 8))
    (is (= (go-normal 7 :D) 7)))

  (testing "go left"
    (is (= (go-normal 5 :L) 4))
    (is (= (go-normal 4 :L) 4)))

  (testing "go right"
    (is (= (go-normal 5 :R) 6))
    (is (= (go-normal 3 :R) 3))))

(deftest go-weird-test
  (testing "go up"
    (is (= (go-weird 5 :U) 5))
    (is (= (go-weird 3 :U) 1)))

  (testing "go down"
    (is (= (go-weird 5 :D) 5))
    (is (= (go-weird 7 :D) "B")))

  (testing "go left"
    (is (= (go-weird 5 :L) 5))
    (is (= (go-weird 4 :L) 3)))

  (testing "go right"
    (is (= (go-weird 5 :R) 6))
    (is (= (go-weird 3 :R) 4))))

(deftest parse-paths-text
  (testing "parse a few paths"
    (is (= (parse-paths "UDU\nRLUL\nDDLR")
           [[:U :D :U]
            [:R :L :U :L]
            [:D :D :L :R]]))))

(deftest walk-path-test
  (testing "walk some a path"
    (is (= (walk-path 5 [:U :L :L] go-normal) 1))
    (is (= (walk-path 1 [:R :R :D :D :D] go-normal) 9))
    (is (= (walk-path 9 [:L :U :R :D :L] go-normal) 8))
    (is (= (walk-path 8 [:U :U :U :U :D] go-normal) 5))))

(deftest walk-paths-test
  (testing "walk a series of paths"
    (is (= (walk-paths 5 '([:U :L :L] [:R :R :D :D :D] [:L :U :R :D :L] [:U :U :U :U :D]) go-normal)
           '(1 9 8 5)))))
