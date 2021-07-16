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
	author_id SERIAL, -- TODO FK to AUTHORS
	isbn bigint -- TODO FK to BOOK
);
-- TODO Composite key on BOOK_AUTHORS of both columns
CREATE TABLE IF NOT EXISTS BORROWER (
	card_id TEXT PRIMARY KEY DEFAULT uuid_generate_v1(),
	ssn BIGINT, -- TODO Unique constraint
	bname TEXT,
	address TEXT,
	phone TEXT
);
CREATE TABLE IF NOT EXISTS BOOK_LOANS (
	loan_id UUID PRIMARY KEY,
	isbn bigint, -- TODO FK to BOOK
	card_id TEXT, -- TODO FK to BORROWER
	date_out date, -- TODO Default today
	due_date date, -- TODO Default Date_out + 14 days
	date_in date -- TODO default NULL
);
-- TODO INSERT Constraint for BOOK_LOANS
-- Number of BOOK_LOANS may not be > 3 for the same CARD_ID
CREATE TABLE IF NOT EXISTS FINES (
	loan_id UUID PRIMARY KEY,
	fine_amt decimal,
	paid boolean
);
