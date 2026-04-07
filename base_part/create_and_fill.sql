CREATE SCHEMA library;

SET search_path TO library;

-- tables

CREATE TABLE reader (
    reader_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

CREATE TABLE category (
    category_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE author (
    author_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE book (
    book_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    year INT,
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(category_id) ON DELETE SET NULL
);

CREATE TABLE book_author (
    book_id INT,
    author_id INT,
    PRIMARY KEY (book_id, author_id),
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE,
    FOREIGN KEY (author_id) REFERENCES author(author_id) ON DELETE CASCADE
);

CREATE TABLE loan (
    loan_id SERIAL PRIMARY KEY,
    reader_id INT NOT NULL,
    book_id INT NOT NULL,
    issue_date DATE NOT NULL,
    return_date DATE,
    CHECK (return_date IS NULL OR return_date >= issue_date),
    FOREIGN KEY (reader_id) REFERENCES reader(reader_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE
);

CREATE TABLE reservation (
    reservation_id SERIAL PRIMARY KEY,
    reader_id INT NOT NULL,
    book_id INT NOT NULL,
    reservation_date DATE DEFAULT CURRENT_DATE,
    FOREIGN KEY (reader_id) REFERENCES reader(reader_id) ON DELETE CASCADE,
    FOREIGN KEY (book_id) REFERENCES book(book_id) ON DELETE CASCADE
);

-- data

COPY category(name) FROM 'data/category.csv' DELIMITER ',' CSV HEADER;
COPY author(name) FROM 'data/author.csv' DELIMITER ',' CSV HEADER;
COPY reader(name, email) FROM 'data/reader.csv' DELIMITER ',' CSV HEADER;
COPY book(title, year, category_id) FROM 'data/book.csv' DELIMITER ',' CSV HEADER;
COPY book_author(book_id, author_id) FROM 'data/book_author.csv' DELIMITER ',' CSV HEADER;
COPY loan(reader_id, book_id, issue_date, return_date) FROM 'data/loan.csv' DELIMITER ',' CSV HEADER;
COPY reservation(reader_id, book_id, reservation_date) FROM 'data/reservation.csv' DELIMITER ',' CSV HEADER;
