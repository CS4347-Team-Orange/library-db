#!/usr/bin/env bash

set -euo pipefail 

if [[ "${container_image}" == "" && "${TRAVIS_COMMIT}" == "" ]]; then
    container_image="alex4108/library-db"
fi

docker build -t ${container_image} .

