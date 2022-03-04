FROM clojure:tools-deps

COPY check.sh /check.sh

RUN clojure -Ttools install io.github.cljdoc/cljdoc-analyzer '{:git/tag "v1.0.695"}' :as cljdoc

ENTRYPOINT ["bash", "/check.sh"]