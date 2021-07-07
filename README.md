# Library Database

## Running locally

* Runs a lint against the SQL files to make sure syntax is correct.
* Builds the container
* Starts the container with a **blank volume**
* Container will apply `schema.sql` to the `library` db
* Container will apply `data.sql` to the `library` db
* Container will make postgres server ready for connections.

Start the container: `bash start.sh`

## Postgres Credentials

Host: 127.0.0.1 (localhost)
Port: 5432 (default)
Username: library
Password: library
dbname: library

Connect with the psql cli to verify or troubleshoot: `PGPASSWORD=library psql -h 127.0.0.1 -u library -p library`

## Blank volume

The container packaged in this repo is not intended to serve a production environment.  The volume will be erased upon each execution of `start.sh`.  This is to aide faster schema development.