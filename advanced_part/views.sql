CREATE VIEW active_loans AS
SELECT l.loan_id, r.name, b.title, l.issue_date
FROM loan l
JOIN reader r ON l.reader_id = r.reader_id
JOIN book b ON l.book_id = b.book_id
WHERE l.return_date IS NULL;


CREATE VIEW reader_stats AS
SELECT r.name, COUNT(l.loan_id) AS total_books
FROM reader r
LEFT JOIN loan l ON r.reader_id = l.reader_id
GROUP BY r.name;
