-- книги и категории
SELECT b.title, c.name AS category
FROM book b
JOIN category c ON b.category_id = c.category_id;

-- книги и авторы
SELECT b.title, a.name AS author
FROM book b
JOIN book_author ba ON b.book_id = ba.book_id
JOIN author a ON ba.author_id = a.author_id;

-- сколько книг брал читатель
SELECT r.name, COUNT(l.loan_id) AS total
FROM reader r
LEFT JOIN loan l ON r.reader_id = l.reader_id
GROUP BY r.name
ORDER BY total DESC;

-- книги на руках
SELECT b.title, r.name, l.issue_date
FROM loan l
JOIN book b ON l.book_id = b.book_id
JOIN reader r ON l.reader_id = r.reader_id
WHERE l.return_date IS NULL;

-- популярные книги
SELECT b.title, COUNT(*) AS cnt
FROM loan l
JOIN book b ON l.book_id = b.book_id
GROUP BY b.title
ORDER BY cnt DESC
LIMIT 5;

-- читатели с бронью
SELECT DISTINCT r.name
FROM reader r
JOIN reservation res ON r.reader_id = res.reader_id;

-- книги без выдач
SELECT b.title
FROM book b
LEFT JOIN loan l ON b.book_id = l.book_id
WHERE l.loan_id IS NULL;

-- средний срок (дни)
SELECT AVG(return_date - issue_date)
FROM loan
WHERE return_date IS NOT NULL;

-- количество книг по категориям
SELECT c.name, COUNT(b.book_id)
FROM category c
LEFT JOIN book b ON c.category_id = b.category_id
GROUP BY c.name;

-- читатели, бравшие фэнтези
SELECT DISTINCT r.name
FROM reader r
JOIN loan l ON r.reader_id = l.reader_id
JOIN book b ON l.book_id = b.book_id
JOIN category c ON b.category_id = c.category_id
WHERE c.name = 'Fantasy';
