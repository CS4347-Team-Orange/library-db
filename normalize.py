import csv
import psycopg2

insert_author_query = """
INSERT INTO
    AUTHORS (name)
VALUES
    (%s)
"""

## Load the authors
tsv_file = open('books.tsv')
lines = csv.reader(tsv_file, delimiter="\t")
authorsList = []
for line in lines:
    names = line[3].split(",")
    for name in names:
        if name != 'author':
            name = name.strip()
            authorsList.append(name)

## Insert each author to the database
conn = None
conn = psycopg2.connect(dbname="library", user="library", password="library", host="localhost")
cur = conn.cursor()

for author in authorsList:
    try:   
        cur.execute(insert_author_query, [author])
        conn.commit()
    except (psycopg2.errors.UniqueViolation, psycopg2.errors.InFailedSqlTransaction):
        conn.rollback()

print("Inserted authors")

## Iterate each author in db

#### Link to books