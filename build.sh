#!/usr/bin/env bash

set -e # Abort on any error 

PROJECT_NAME="" # Set this to the repo's name

# Do what you need to do to prepare for the container's build here.
# Compile your code, run unit tests, etc.

# Build the container
docker build -t library:${project_name} .
