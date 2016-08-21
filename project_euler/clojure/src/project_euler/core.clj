(ns project-euler.core
  (:gen-class))

(defn run-problem
  "Run a specific problem"
  [n]
  (let [number (format "%04d" n)
        problem-ns (str "project-euler.problems.p" number)]
    (require (symbol problem-ns))
    (load-string (str problem-ns "/answer"))))

(defn -main
  "Run a problem"
  [& args]
  (if (and args (= 1 (count args)))
    (println (time (run-problem (Integer/parseInt (first args)))))
    (println "Usage: lein run [number]")))
