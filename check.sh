set -x
set -e
die {
    echo "ERROR: $1"
    exit -1;
}

if [ "$action" -eq "analyze" ]; then
    echo "Running 'analyze :project $mvn_project :version $mvn_version' to check a libary installed into a Maven repo"
    [ -n "$mvn_project" ] || die 'Missing argument mvn_project that is required for action=analyze'
    [ -n "$mvn_version" ] || die 'Missing argument mvn_version that is required for action=analyze'
    clojure -Tcljdoc-analyzer :download true analyze :project \""$mvn_project"\" :version \""$mvn_version"\"
else
  echo "Running 'analyze-local' to check the deps.edn based project in the current directory..."
  clojure -Tcljdoc-analyzer analyze-local
fi