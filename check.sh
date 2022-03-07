set -x
set -e
function die {
    echo "ERROR: $1"
    exit -1;
}

if [ "$action" = "analyze" ]; then
    echo "Running 'analyze :project $mvn_project :version $mvn_version' to check a libary installed into a Maven repo"
    [ -n "$mvn_project" ] || die 'Missing argument mvn_project that is required for action=analyze'
    [ -n "$mvn_version" ] || die 'Missing argument mvn_version that is required for action=analyze'
    clojure --report stderr -Tcljdoc-analyzer analyze :download true :project \""$mvn_project"\" :version \""$mvn_version"\"
else
  echo "Running 'analyze-local' to check the deps.edn based project in the current directory $(pwd)..."
  clojure --report stderr -Tcljdoc-analyzer analyze-local
fi