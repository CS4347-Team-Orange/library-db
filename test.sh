#!/usr/bin/env bash

PROJECT_NAME="library-db" # The project's name

# Do any testing here
npm install -g squawk-cli

files="schema data"

for f in ${files}; do
	echo "Linting: ${f}"
	squawk ${f}.sql
	lintResult=$?
	if [[ "${lintResult}" != "0" ]]; then
		echo "Lint failed, aborting!  Code: ${lintResult}"
		exit 1
	fi
done

