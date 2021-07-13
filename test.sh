#!/usr/bin/env bash

echo "Running tests..."

PROJECT_NAME="library-db" # The project's name

# Do any testing here
npm i -g sql-lint

files="schema data"

for f in ${files}; do
	echo "Linting: ${f}"
	sql-lint ${f}.sql
	lintResult=$?
	if [[ "${lintResult}" != "0" ]]; then
		echo "Lint failed, aborting!  Code: ${lintResult}"
		exit 1
	fi
done

echo "Tests passed!"