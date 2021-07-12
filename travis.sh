#!/usr/bin/env bash

set -e
set -o pipefail

bash build.sh
bash test.sh
docker push alex4108/library-db