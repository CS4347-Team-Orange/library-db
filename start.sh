#!/usr/bin/env bash

source postgres.env
docker-compose kill
docker-compose up -d

psql --host=127.0.0.1 --username=${POSTGRES_USER} --password=${POSTGRES_PASSWORD} --dbname=${POSTGRES_DB} migrate.sql 
