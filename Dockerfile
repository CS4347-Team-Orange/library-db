FROM postgres:alpine
COPY schema.sql /docker-entrypoint-initdb.d/98-schema.sql
COPY data.sql /docker-entrypoint-initdb.d/99-data.sql
