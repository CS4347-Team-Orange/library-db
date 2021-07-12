#!/usr/bin/env bash

set -e # Abort on any error 

PROJECT_NAME="db" # Set this to the repo's name

# Build the container
docker build -t alex4108/library-${PROJECT_NAME} .

