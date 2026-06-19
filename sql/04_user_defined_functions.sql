-- 📅 Get Due Date
CREATE OR REPLACE FUNCTION get_due_date(u_id INT)
RETURNS DATE LANGUAGE plpgsql AS $$
DECLARE due_date DATE;
BEGIN
    SELECT CURRENT_DATE + sp.max_book_holding_time_in_days
    INTO due_date
    FROM User_Subscriptions us
    INNER JOIN Subscription_Plans sp ON us.plan_id = sp.plan_id
    WHERE us.user_id = u_id AND us.isActive = TRUE;
    RETURN due_date;
END;
$$;

-- 📚 Get Currently Issued Book Count
CREATE OR REPLACE FUNCTION get_currently_issued_book(u_id INT)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE book_count INT;
BEGIN
    SELECT COUNT(*) INTO book_count
    FROM Book_Issues
    WHERE user_id = u_id AND status = 'Issued';
    RETURN book_count;
END;
$$;

-- 📈 Get Max Book Issue Limit
CREATE OR REPLACE FUNCTION get_max_book_issue_limit(u_id INT)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE max_book_limit INT;
BEGIN
    SELECT sp.max_book_limit INTO max_book_limit
    FROM User_Subscriptions us
    INNER JOIN Subscription_Plans sp ON sp.plan_id = us.plan_id
    WHERE us.user_id = u_id AND us.isActive = TRUE;
    RETURN max_book_limit;
END;
$$;

-- 🔍 Allocate Available Book Copy
CREATE OR REPLACE FUNCTION get_book_copy(b_id INT)
RETURNS INT LANGUAGE plpgsql AS $$
DECLARE allocated_copy_id INT;
BEGIN
    SELECT copy_id INTO allocated_copy_id
    FROM Book_Copies
    WHERE book_id = b_id AND status = 'Available'
    LIMIT 1;
    RETURN allocated_copy_id;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        RAISE NOTICE 'No available copy found for book_id = %', b_id;
        RETURN NULL;
END;
$$;
