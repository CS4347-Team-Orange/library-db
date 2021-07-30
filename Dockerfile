FROM postgres
RUN rm -rf /tmp/pgdata
RUN mkdir -p /tmp/psql_data
COPY schema.sql /tmp/psql_data/
COPY data.sql /tmp/psql_data/
COPY books.tsv /tmp/psql_data/
COPY borrowers.csv /tmp/psql_data/
COPY scripts/init_docker_postgres.sh /docker-entrypoint-initdb.d/
RUN apt-get -y update && apt-get -y install libpq-dev gcc python3 python3-pip
RUN pip3 install psycopg2-binary
COPY normalize.py /tmp/psql_data/
EXPOSE 5432
