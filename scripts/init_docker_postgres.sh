#!/bin/bash

# this script is run when the docker container is built
# it imports the base database structure and create the database for the tests

DATABASE_NAME="library"
DB_DUMP_LOCATIONS="/tmp/psql_data/schema.sql /tmp/psql_data/data.sql"

echo "*** CREATING DATABASE ***"

# clean sql_dump - because I want to have a one-line command

for DB_DUMP_LOCATION in ${DB_DUMP_LOCATIONS}; do
  echo "Applying: ${DB_DUMP_LOCATION}"

  # import sql_dump
  PGPASSWORD=library psql -U library "$DATABASE_NAME" < "$DB_DUMP_LOCATION";

done

echo "*** DATABASE CREATED! ***"
