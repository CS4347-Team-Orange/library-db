FROM postgres:alpine
RUN rm -rf /tmp/pgdata
RUN mkdir -p /tmp/psql_data
COPY schema.sql /tmp/psql_data/
COPY data.sql /tmp/psql_data/
COPY books.tsv /tmp/psql_data/
COPY borrowers.csv /tmp/psql_data/
COPY scripts/init_docker_postgres.sh /docker-entrypoint-initdb.d/
EXPOSE 5432
