(ns project-euler.core
  (:gen-class))

(defn run-problem
  "Run a specific problem"
  [n]
  (let [number (format "%04d" n)
        problem-ns (str "project-euler.problems.p" number)]
    (require (symbol problem-ns))
    (load-string (str problem-ns "/answer"))))

(def answers (map (partial bigint)
                  (clojure.string/split-lines (slurp "../problems/answers.txt"))))

(defn check-problem
  "Check to see if the answer to a problem is correct"
  [number]
  (let [real-answer (nth answers (dec number) -1)]
    (if (= real-answer -1)
      (str "Problem #" number " has not been solved")
      (= real-answer (run-problem number)))))

(defn -main
  "Run a problem"
  [& args]
  (if (and args (= 1 (count args)))
    (println (time (run-problem (Integer/parseInt (first args)))))
    (println "Usage: lein run [number]")))
