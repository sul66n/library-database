CREATE OR REPLACE FUNCTION get_reader_books(r_id INT)
RETURNS INT AS $$
DECLARE total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM loan
    WHERE reader_id = r_id;

    RETURN total;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION avg_loan_days()
RETURNS NUMERIC AS $$
DECLARE result NUMERIC;
BEGIN
    SELECT AVG(return_date - issue_date)
    INTO result
    FROM loan
    WHERE return_date IS NOT NULL;

    RETURN result;
END;
$$ LANGUAGE plpgsql;


CREATE OR REPLACE FUNCTION books_in_category(cat_id INT)
RETURNS INT AS $$
DECLARE total INT;
BEGIN
    SELECT COUNT(*) INTO total
    FROM book
    WHERE category_id = cat_id;

    RETURN total;
END;
$$ LANGUAGE plpgsql;
