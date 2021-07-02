FROM postgres:alpine
RUN mkdir -p /tmp/psql_data
COPY schema.sql /tmp/psql_data/
COPY data.sql /tmp/psql_data/
COPY scripts/init_docker_postgres.sh /docker-entrypoint-initdb.d/
EXPOSE 5432
