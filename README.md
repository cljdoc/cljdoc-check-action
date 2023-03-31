# CljDoc Check Action

GitHub Action for checking that CljDoc will be able to analyze the project successfully

NOTE: Currently it only checks for successful analysis of the source codes. Import of articles is not verified yet.

IMPORTANT: CljDoc only works on the JAR archive of the library so you need to build it first.

Checking a clojure-deps based library is as simple as:

```yaml
name: Check Cljdoc
on: [pull_request]
jobs:
  check-cljdoc:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v1
      - name Build target/<the lib>*.jar so that CljDoc analyze can use it:
        run: clojure -T:build jar # REPLACE with whatever you do to build your jar
      - name: CljDoc Check
          uses: cljdoc/cljdoc-check-action@v1
```

For other types of libraries, you need to install these into the local Maven repository (e.g. via `lein install`) and pass it the Maven coordinate and version:

```yaml
# inside jobs.<name>.steps
- run: lein install # or whatever is suitable for your build tool/project, to install the library into a maven repo
- name: CljDoc Check
    uses: cljdoc/cljdoc-check-action@v1
    with:
      mvn_project: io.aviso/pretty
      mvn_version: LATEST # this is the default
```

## Development

The cljdoc changes supporting this action were originally introduced in cljdoc/cljdoc-analyzer#44

Running the action locally:

```bash
cljdoc-check-action$ docker build -t cljdoc-check-action .
cljdoc-check-action$ cd ../my-library; clojure -T:build jar
my-library$ docker run --rm -ti --volume `pwd`:/tmp/prj --workdir /tmp/prj cljdoc-check-action
```
