# CljDoc Check Action

GitHub Action for checking that CljDoc will be able to analyze the project successfully

NOTE: CljDoc only works on the JAR archive of the library so you need to build it first.

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
        run: clojure -T:build jar # REPALCE with whatever you do to build your jar
      - name: CljDoc Check
          uses: cljdoc/cljdoc-check-action@v1
```

For other types of libraries, you need to install these into the local Maven repository (e.g. via `lein install`) and pass it the Maven coordinate and version:

```yaml
# inside jobs.<name>.steps
- run: lein install # or whatever is usitable for your build tool/project, to install the library into a maven repo
- name: CljDoc Check
    uses: cljdoc/cljdoc-check-action@v1
    with:
      mvn_project: io.aviso/pretty
      mvn_version: LATEST # this is the default
```