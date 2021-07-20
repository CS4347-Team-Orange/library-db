CREATE TABLE IF NOT EXISTS test (
    id INT PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS BOOK (
    book_id TEXT PRIMARY KEY DEFAULT uuid_generate_v1(),
    isbn10 text UNIQUE,
    isbn13 text UNIQUE,
    title TEXT,
    author TEXT,
    cover TEXT,
    publisher TEXT,
    pages INT
);
CREATE TABLE IF NOT EXISTS AUTHORS (
    author_id SERIAL PRIMARY KEY,
    name TEXT
);
CREATE TABLE IF NOT EXISTS BOOK_AUTHORS (
    author_id SERIAL,
    book_id text,
    PRIMARY KEY(author_id, book_id),
    CONSTRAINT book_author_book_id
      FOREIGN KEY(book_id)
      REFERENCES BOOK(book_id)
      ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS BORROWER (
    card_id TEXT PRIMARY KEY DEFAULT uuid_generate_v1(),
	ssn TEXT UNIQUE,
	first_name TEXT,
	last_name TEXT,
	email TEXT,
	address TEXT,
	city TEXT,
	state TEXT,
	phone TEXT
);
CREATE TABLE IF NOT EXISTS BOOK_LOANS (
    loan_id UUID PRIMARY KEY,
    book_id text,
    CONSTRAINT book_loan_book_id
    FOREIGN KEY(book_id)
    REFERENCES BOOK(book_id),
    card_id TEXT,
    CONSTRAINT borrower_card_id
    FOREIGN KEY(card_id)
    REFERENCES BORROWER(card_id),
    date_out date not null default CURRENT_DATE,
    due_date date not null default CURRENT_DATE + INTERVAL '14 days',
    date_in date default NULL
);
CREATE TABLE IF NOT EXISTS FINES (
    loan_id UUID PRIMARY KEY,
    fine_amt decimal,
    paid boolean
);
