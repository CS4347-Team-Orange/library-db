#!/usr/bin/env bash
set -e

bash build.sh
# bash test.sh
docker-compose up --renew-anon-volumes
