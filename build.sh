#!/usr/bin/env bash

set -eo pipefail 

if [[ "${container_image}" == "" && "${TRAVIS_COMMIT}" == "" ]]; then
    container_image="alex4108/library-db"
fi

echo "Building image: ${container_image}"

docker build -t ${container_image} .

