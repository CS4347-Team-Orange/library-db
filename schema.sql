CREATE TABLE IF NOT EXISTS test (
	id INT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS BOOK ( 
	Isbn bigint PRIMARY KEY,
	Title TEXT
);

CREATE TABLE IF NOT EXISTS AUTHORS ( 
	Author_id SERIAL PRIMARY KEY, 
	Name TEXT
);


CREATE TABLE IF NOT EXISTS BOOK_AUTHORS ( 
	Author_id SERIAL, -- TODO FK to AUTHORS
	Isbn bigint -- TODO FK to BOOK
);

-- TODO Composite key on BOOK_AUTHORS of both columns

CREATE TABLE IF NOT EXISTS BORROWER ( 
	Card_id TEXT PRIMARY KEY,
	Ssn INT, -- TODO Unique constraint
	Bname TEXT,
	"Address" TEXT,
	Phone TEXT
);

CREATE TABLE IF NOT EXISTS BOOK_LOANS ( 
	Loan_id UUID PRIMARY KEY,
	Isbn bigint, -- TODO FK to BOOK
	Card_id TEXT, -- TODO FK to BORROWER
	Date_out date, -- TODO Default today
	Due_date date, -- TODO Default Date_out + 14 days
	Date_in date -- TODO default NULL
)

-- TODO INSERT Constraint for BOOK_LOANS
-- Number of BOOK_LOANS may not be > 3 for the same CARD_ID

CREATE TABLE IF NOT EXISTS FINES ( 
	Loan_id UUID PRIMARY KEY,
	Fine_amt decimal,
	Paid boolean 
)
