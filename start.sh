#!/usr/bin/env bash

bash build.sh
bash test.sh
docker-compose up --renew-anon-volumes
