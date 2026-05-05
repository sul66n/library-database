CREATE OR REPLACE FUNCTION check_book_available()
RETURNS TRIGGER AS $$
BEGIN
    IF EXISTS (
        SELECT 1 FROM loan
        WHERE book_id = NEW.book_id AND return_date IS NULL
    ) THEN
        RAISE EXCEPTION 'Book is already on loan';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_check_book
BEFORE INSERT ON loan
FOR EACH ROW
EXECUTE FUNCTION check_book_available();


CREATE OR REPLACE FUNCTION auto_set_return_date()
RETURNS TRIGGER AS $$
BEGIN
    IF NEW.return_date IS NULL THEN
        NEW.return_date := NEW.issue_date + INTERVAL '14 days';
    END IF;

    RETURN NEW;
END;
$$ LANGUAGE plpgsql;


CREATE TRIGGER trg_auto_return
BEFORE INSERT ON loan
FOR EACH ROW
EXECUTE FUNCTION auto_set_return_date();
