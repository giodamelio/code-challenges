(ns aoc.challenge.c01-test
  (:require [clojure.test :refer :all]
            [aoc.challenge.c01 :refer :all]))

(deftest manhatten-distance-test
  (testing "distances are correct"
    (is (= (manhatten-distance [0 0] [2 2]) 4))))

(deftest parse-path-test
  (testing "parse path"
    (is (= (parse-path "R22, R9, L33")
           [[:R 22] [:R 9] [:L 33]])))
  (testing "parse with no spaces"
    (is (= (parse-path "R22,R9,L33")
           [[:R 22] [:R 9] [:L 33]]))))

(deftest turn-test
  (testing "turn right"
    (is (= (turn :N :R) :E)))

  (testing "turn left"
    (is (= (turn :S :L) :E))))

(deftest go-test
  (testing "go north"
    (is (= (go :N [0 0]) [0 1])))

  (testing "turn east"
    (is (= (go :E [0 0]) [1 0])))

  (testing "go south"
    (is (= (go :S [0 0]) [0 -1])))

  (testing "go west"
    (is (= (go :W [0 0]) [-1 0]))))

(deftest directions-to-path-test
  (testing "calculates path correctly"
    (is (= (directions-to-path (parse-path "R2, R2, R2"))
           {:facing :W
            :path '([0 0] [1 0] [2 0] [2 -1] [2 -2] [1 -2] [0 -2])}))))
