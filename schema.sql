CREATE TABLE IF NOT EXISTS test (
    id INT PRIMARY KEY
);
CREATE TABLE IF NOT EXISTS BOOK (
    isbn bigint PRIMARY KEY,
    title TEXT
);
CREATE TABLE IF NOT EXISTS AUTHORS (
    author_id SERIAL PRIMARY KEY,
    name TEXT
);
CREATE TABLE IF NOT EXISTS BOOK_AUTHORS (
    author_id SERIAL,
    CONSTRAINT book_author_authorid
    FOREIGN KEY(author_id)
    REFERENCES AUTHORS(author_id),
    isbn bigint,
    PRIMARY KEY(author_id, isbn),
    CONSTRAINT book_author_isbn
      FOREIGN KEY(isbn)
      REFERENCES BOOK(isbn)
      ON DELETE SET NULL
);

CREATE TABLE IF NOT EXISTS BORROWER (
    card_id TEXT PRIMARY KEY DEFAULT uuid_generate_v1(),
    ssn BIGINT UNIQUE,
    bname TEXT,
    address TEXT,
    phone TEXT
);
CREATE TABLE IF NOT EXISTS BOOK_LOANS (
    loan_id UUID PRIMARY KEY,
    isbn bigint,
    CONSTRAINT book_loan_isbn
    FOREIGN KEY(isbn)
    REFERENCES BOOK(isbn),
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