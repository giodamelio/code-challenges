(ns aoc.puzzles.day-2
  (:require [clojure.string :as str]
            [clojure.pprint :as pp]))

(defn parse
  "Parse the input into a vector of numbers"
  [input]
  (as-> input $
    ;; Split it into lines
    (str/split $ #",")
    ;; Convert each line to a number
    (map read-string $)
    ;; Convert to a vector
    (vec $)))

(def operations
  {01 {:name "add"
       :arguments 3
       :function
       (fn [ip memory [n1-address n2-address output-address]]
         ;; Resolve the actual numbers from the addresses
         (let [n1 (get memory n1-address)
               n2 (get memory n2-address)]
           [;; Move the instruction pointer up 4
            (+ ip 4)
            ;; Add the two address contents up and store them to memory
            (-> memory
                (assoc output-address (+ n1 n2)))]))}
   02 {:name "multiply"
       :arguments 3
       :function
       (fn [ip memory [n1-address n2-address output-address]]
         ;; Resolve the actual numbers from the addresses
         (let [n1 (get memory n1-address)
               n2 (get memory n2-address)]
           [;; Move the instruction pointer up 4
            (+ ip 4)
            ;; Add the two address contents up and store them to memory
            (-> memory
                (assoc output-address (* n1 n2)))]))}
   99 {:name "halt"
       :arguments 0
       :function
       (fn [ip memory _]
         [-1 memory])}})

(defn get-arguments
  "Get the arguments of an operation"
  [instruction-pointer memory]
  (let [argument-count (->> instruction-pointer
                           (get memory)
                           (get operations)
                           (:arguments))]
    (subvec
      memory
      (inc instruction-pointer)
      (+ instruction-pointer 1 argument-count))))

(defn step
  "Step the interpreter one instruction forward"
  ([memory] (step 0 memory))
  ([instruction-pointer memory]
   (let [instruction (get memory instruction-pointer)
         operation (get operations instruction)
         op-function (:function operation)]
     ;; Check that it is not a undefined opcode
     (assert (contains? operations instruction) "Unknown opcode")
     ;; Run the operation function on the arguments and return
     ;; the new instruction pointer and memory
     (apply
       op-function
       [instruction-pointer
        memory
        ;; Get the arguments based on the operation
        (get-arguments instruction-pointer memory)]))))

(defn run
  "Run a program"
  ([memory] (run memory 0))
  ([input-memory instruction-pointer]
   (loop [ip instruction-pointer
          memory input-memory]
     (let [[new-ip new-memory] (step ip memory)]
       (if (= new-ip -1)
         memory
         (recur new-ip new-memory))))))

(defn run-with-inputs
  [program a b]
  (-> program
      (assoc 1 a)
      (assoc 2 b)
      run
      (get 0)))

(def all-noun-verb-combos
  (for [noun (range 100) verb (range 100)]
    (vector noun verb)))

(defn part-1
  [program]
  (run-with-inputs program 12 02))

(defn part-2
  [program target]
  (as-> all-noun-verb-combos $
    ;; Run the program with each combo input and store outputs and noun-verb combos in a map
    (reduce
      (fn [outputs [noun verb]]
        (assoc
          outputs
          (run-with-inputs program noun verb)
          [noun verb]))
      {}
      $)
    ;; Get just the item we want
    (get $ target)
    ;; Calculate the answer (100 * noun + verb)
    (apply
      (fn [noun verb]
        (+ (* 100 noun) verb))
      $)))
