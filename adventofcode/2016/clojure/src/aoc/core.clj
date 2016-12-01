(ns aoc.core
  (:gen-class))

(defn run-challenge
  "Run a specific challenge"
  [n]
  (let [number (format "%02d" n)
        problem-ns (str "aoc.challenge.c" number)]
    (try
      (require (symbol problem-ns))
      (load-string (str "(" problem-ns "/answer)"))
      (catch java.io.FileNotFoundException e
        (str "Problem #" number " does not exist")))))

(defn -main
  "Run a the challenge for a day"
  [& args]
  (if (and args (= 1 (count args)))
    (println (time (run-challenge (Integer/parseInt (first args)))))
    (println "Usage: lein run [number]")))
