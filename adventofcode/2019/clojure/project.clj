(defproject aoc "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "EPL-2.0 OR GPL-2.0-or-later WITH Classpath-exception-2.0"
            :url "https://www.eclipse.org/legal/epl-2.0/"}
  :dependencies [[org.clojure/clojure "1.10.0"]
                 [metosin/testit "0.4.0"]]
  :repl-options {:init-ns aoc.core
                 :init (clojure.core.server/start-server
                         {:accept 'clojure.core.server/io-prepl
                          :address "localhost"
                          :port 55555
                          :name "lein"})})
