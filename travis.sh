#!/usr/bin/env bash

set -euo pipefail

echo ${DOCKER_PASS} | docker login -u ${DOCKER_USER} --password-stdin

container_registry="registry.hub.docker.com"
container_image="alex4108/library-db:${TRAVIS_COMMIT}"
container_uri="${container_registry}/${container_image}"

bash build.sh
# bash test.sh

docker push ${container_image}

cd terraform && bash ci.sh
