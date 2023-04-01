FROM clojure:tools-deps

COPY check.sh /check.sh

RUN clojure -Ttools install io.github.cljdoc/cljdoc-analyzer '{:git/tag "RELEASE"}' :as cljdoc-analyzer

ENTRYPOINT ["bash", "/check.sh"]