(def project 'aoc)
(def version "0.1.0-SNAPSHOT")

(set-env! :resource-paths #{"src"}
          :source-paths   #{"test"}
          :dependencies   '[[org.clojure/clojure "1.10.1"]
                            [adzerk/boot-test "RELEASE" :scope "test"]])

(task-options!
 pom {:project     project
      :version     version
      :description "FIXME: write description"
      :url         "http://example/FIXME"
      :scm         {:url "https://github.com/yourname/aoc"}
      :license     {"Eclipse Public License"
                    "http://www.eclipse.org/legal/epl-v10.html"}})

(deftask build
  "Build and install the project locally."
  []
  (comp (pom) (jar) (install)))

(deftask prepl-server
  "Start a prepl server."
  [p port PORT int "The port on which to start the prepl server (optional)."]
  (comp
    (socket-server
      :accept 'clojure.core.server/io-prepl
      :port   port)
    (wait)))

(require '[adzerk.boot-test :refer [test]])
