#!/bin/bash

# this script is run when the docker container is launched for the first time
# it imports the base database structure and create the database for the tests
# https://hub.docker.com/_/postgres

DATABASE_NAME="library"
DB_DUMP_LOCATIONS="/tmp/psql_data/schema.sql /tmp/psql_data/data.sql"

echo "*** Activating PostgreSQL uuid plugin ***"
PGPASSWORD=library psql -U library "$DATABASE_NAME" <<-EOSQL
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
EOSQL

echo "*** CREATING DATABASE ***"

# clean sql_dump - because I want to have a one-line command

for DB_DUMP_LOCATION in ${DB_DUMP_LOCATIONS}; do
  echo "Applying: ${DB_DUMP_LOCATION}"

  # import sql_dump
  PGPASSWORD=library psql -U library "$DATABASE_NAME" < "$DB_DUMP_LOCATION";

done

echo "*** NORMALIZING AUTHORS ***"
old_pwd=$(pwd)
cd /tmp/psql_data/
python3 normalize.py
cd ${old_pwd}

echo "*** DATABASE CREATED! ***"
