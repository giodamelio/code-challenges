(ns aoc.challenge.c08
  (:require [clojure.string :as str]
            [aoc.util :as util]))

; Vector and matrix utils
(defn rotate-vector
  "Rotate a vector by n"
  [coll n]
  (let [len (count coll)]
    (vec (take len (drop (* n (dec len)) (cycle coll))))))

(defn screen-create
  "Creates a 2d list of :. to repersent an empty screen. Optionally specify screen size"
  ([] (screen-create 50 6))
  ([width height]
   (vec (repeat height (vec (repeat width :.))))))

;; TODO: make this a bit better
(defn screen-render
  "Renders a screen to a string"
  [screen]
  (str/join
   "\n"
   (for [row screen]
     (->> row
          (map name)
          (reduce str)))))

(defn screen-print
  "Print a screen to stdout"
  [screen]
  (println (screen-render screen)))

(defn screen-get
  "Get the value at x, y from screen"
  [x y screen]
  (get-in screen [y x]))

(defn screen-set
  "Set n to x, y in screen. If coords are outside of the screen return the screen unchanged."
  [x y n screen]
  (try
    (cond
      ; Check to see that the coords are not out of bounds
      (> y (dec (count screen))) screen
      (> x (dec (count (first screen)))) screen
      :else (assoc-in screen [y x] n))
    (catch IndexOutOfBoundsException e screen)))

; TODO rework this function
(defn screen-transform-rect
  "Take a screen and draw a rect on it"
  [width height screen]
  ; Get a list of coords that need to be set
  (let [coords (for [x (range width)
                     y (range height)]
                 [x y])]
    ; Recurse through the coords applying to the screen
    (loop [s screen
           c coords]
      (let [coord (first c)]
        (if (empty? c)
          s
          (recur (screen-set (first coord) (second coord) :# s)
                 (rest c)))))))

(defn screen-transform-rotate-row
  "Rotate a row y of the screen right by n. If row is larger then the screen height, return screen unchanged."
  [y n screen]
  (try
    (update-in screen [y] rotate-vector n)
    (catch IndexOutOfBoundsException e screen)))

(defn screen-transform-rotate-col
  "Rotate a col x of the screen down by n. If row is larger then the screen height, return screen unchanged."
  [x n screen]
  (util/transpose-vector
   (screen-transform-rotate-row
    x
    n
    (util/transpose-vector screen))))

(def command-regex #"^(rect|rotate row|rotate column) (?:(\d+)x(\d+)|(?:x|y)=(\d+) by (\d+))$")
(defn parse-command
  "Parse a command string."
  [line]
  (let [tokens (remove nil? (rest (re-find command-regex line)))
        type (keyword (str/join "-" (str/split (first tokens) #" ")))
        arg1 (util/parse-int (nth tokens 1))
        arg2 (util/parse-int (nth tokens 2))]
    (list type arg1 arg2)))

(defn apply-commands-to-screen
  "Take a screen and apply a list of commands to it."
  [screen commands]
  (loop [screen screen commands commands]
    (let [command (first commands)]
      (if (empty? commands)
        screen
        (recur (case (first command)
                 :rect (screen-transform-rect
                        (second command)
                        (nth command 2)
                        screen)
                 :rotate-column (screen-transform-rotate-col
                                 (second command)
                                 (nth command 2)
                                 screen)
                 :rotate-row (screen-transform-rotate-row
                              (second command)
                              (nth command 2)
                              screen))
               (rest commands))))))

(defn answer-part-1 [input]
  (let [screen (screen-create)
        commands (map parse-command (str/split-lines input))]
    (count
     (filter #(= %1 :#)
             (flatten (apply-commands-to-screen screen commands))))))

(defn answer-part-2 [input]
  (let [screen (screen-create)
        commands (map parse-command (str/split-lines input))]
    (str "\n" (screen-render (apply-commands-to-screen screen commands)))))
