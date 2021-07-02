#!/usr/bin/env bash

set -e # Bomb on any error

PROJECT_NAME="library-db" # The project's name

# Do any testing here
npm install -g squawk-cli

files="schema data"

for f in ${files}; do
	echo "Linting: ${f}"
	squawk ${f}.sql --reporter Json
done

