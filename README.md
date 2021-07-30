# Library Database

[![Build Status](https://travis-ci.com/CS4347-Team-Orange/library-db.svg?token=MyN3vGLjp8SzdckebFqZ&branch=master)](https://travis-ci.com/CS4347-Team-Orange/library-db)

## Local Quickstart

Ensure you have [Docker](https://docs.docker.com/get-docker/) and [Docker Compose](https://docs.docker.com/compose/install/) installed

```
docker-compose up
```

## Environment setup (dev)

Building the container requires node 14 as the default nodejs runtime.

```
nvm install lts/fermium
nvm alias default lts/fermium
bash start.sh
```

## What does start.sh do?

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

Connect with the psql cli to verify or troubleshoot: `PGPASSWORD=library psql -h 127.0.0.1 -U library library`

## Blank volume

The container packaged in this repo is not intended to serve a production environment.  The volume will be erased upon each execution of `start.sh`.  This is to aide faster schema development.
