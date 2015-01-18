(defproject gorilla-test "0.1.0-SNAPSHOT"
    :description "A test project for Gorilla REPL."
    :dependencies [
                   [clj-http "1.0.1"]
                   [org.clojure/clojure "1.6.0"]]
    :main ^:skip-aot gorilla-test.core
    :target-path "target/%s"
    :plugins [[lein-gorilla "0.3.4"]]
    :profiles {:uberjar {:aot :all}})
