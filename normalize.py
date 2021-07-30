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
conn = psycopg2.connect(dbname="library", user="library", password="library")
cur = conn.cursor()

for author in authorsList:
    try:   
        cur.execute(insert_author_query, [author])
        conn.commit()
    except (psycopg2.errors.UniqueViolation, psycopg2.errors.InFailedSqlTransaction):
        conn.rollback()

print("Inserted authors")

## Iterate each author in db

booksCur = conn.cursor('get-books')
booksCur.itersize = 10000
booksCur.execute("SELECT * FROM book;")

authorsCur = conn.cursor('get-authors')
authorsCur.itersize = 10000
authorsCur.execute("SELECT * FROM authors;")

booksList = []
authorsList = []

for book in booksCur:
    booksList.append(book)

for author in authorsCur:
    authorsList.append(author)

for book in booksList:
    name = book[4]
    if name is None:
        name = "Unknown Author"
    
    authors = name.split(",")
    for author in authors:
        for author_tuple in authorsList:
            if author == author_tuple[1]:
                try:   
                    cur.execute("INSERT INTO BOOK_AUTHORS (book_id, author_id) VALUES (%s, %s)", [book[0], author_tuple[0]])
                    conn.commit()
                except (psycopg2.errors.UniqueViolation, psycopg2.errors.InFailedSqlTransaction):
                    conn.rollback()

print("Finished linking authors to books")