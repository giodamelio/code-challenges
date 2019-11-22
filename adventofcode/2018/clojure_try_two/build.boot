(set-env!
  :resource-paths #{"src"}
  :dependencies '[[org.clojure/clojure "1.10.1"]])

(deftask prepl-server
  "Start a prepl server."
  [p port PORT int "The port on which to start the prepl server (optional)."]
  (comp
    (socket-server
      :accept 'clojure.core.server/io-prepl
      :port   port)
    (wait)))
