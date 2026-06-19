-- Transaction for issue book
CREATE PROCEDURE issue_book_transaction(u_id INT, b_id INT)
AS $$
DECLARE 
    due_date DATE;
    plan_max_limit INT;
    currently_issued_book INT;
    book_copy_id INT;
BEGIN
    -- Get required values from helper functions
    SELECT get_due_date(u_id) INTO due_date;
    SELECT get_max_book_issue_limit(u_id) INTO plan_max_limit;
    SELECT get_currently_issued_book(u_id) INTO currently_issued_book;
    SELECT get_book_copy(b_id) INTO book_copy_id;

    -- Business logic checks
    IF currently_issued_book >= plan_max_limit THEN
        RAISE EXCEPTION 'User has reached the maximum book issue limit!';
    END IF;

    IF book_copy_id IS NULL THEN
        RAISE EXCEPTION 'Book copy is not available!';
    END IF;

    -- Insert issue record
    INSERT INTO book_issues(user_id, book_id, copy_id, due_date)
    VALUES (u_id, b_id, book_copy_id, due_date);

    -- Update copy status
    UPDATE book_copies
    SET status = 'Issued'
    WHERE copy_id = book_copy_id;

    RAISE NOTICE 'Book issued successfully.';
    
EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- Transaction for return book
CREATE PROCEDURE return_book_transaction(p_issue_id INT)
AS $$
DECLARE
    v_copy_id INT;
BEGIN
    -- Check if the issue exists and is still marked as 'Issued'
    SELECT copy_id INTO v_copy_id
    FROM Book_Issues
    WHERE issue_id = p_issue_id AND status = 'Issued';

    IF v_copy_id IS NULL THEN
        RAISE EXCEPTION 'Invalid issue_id or book already returned.';
    END IF;

    -- Step 1: Update Book_Copies to Available
    UPDATE Book_Copies
    SET status = 'Available'
    WHERE copy_id = v_copy_id;

    -- Step 2: Update Book_Issues to Returned with return_date
    UPDATE Book_Issues
    SET status = 'Returned',
        return_date = CURRENT_DATE
    WHERE issue_id = p_issue_id;

    RAISE NOTICE 'Book returned successfully.';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
END;
$$ LANGUAGE plpgsql;

-- Transaction for Subscription Purchase
 
CREATE PROCEDURE purchase_subscription(
    u_id INT,
    p_id INT,
    p_amount NUMERIC,
    p_real_payment_id VARCHAR(100),
    p_payment_mode VARCHAR(20)
)
AS $$
DECLARE
    v_duration INT;
    v_start_date DATE := CURRENT_DATE;
    v_end_date DATE;
BEGIN
    -- 1. Deactivate existing active subscriptions
    UPDATE User_Subscriptions
    SET isActive = false
    WHERE user_id = u_id AND isActive = true;

    -- 2. Get the duration of the selected plan
    SELECT duration_in_days INTO v_duration
    FROM Subscription_Plans
    WHERE plan_id = p_id;

    IF v_duration IS NULL THEN
        RAISE EXCEPTION 'Invalid plan ID: %', p_id;
    END IF;

    -- 3. Calculate end date
    v_end_date := v_start_date + v_duration;

    -- 4. Insert new active subscription
    INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive)
    VALUES (u_id, p_id, v_start_date, v_end_date, true);

    -- 5. Record the payment
    INSERT INTO Subscription_Payments (user_id, plan_id, amount_paid, real_bank_payment_id, payment_mode)
    VALUES (u_id, p_id, p_amount, p_real_payment_id, p_payment_mode);

    RAISE NOTICE 'Subscription purchased successfully.';

EXCEPTION
    WHEN OTHERS THEN
        RAISE NOTICE 'Error occurred: %', SQLERRM;
        -- In PostgreSQL 13+, you can use ROLLBACK inside procedures only if using CALL inside an explicit transaction block
END;
$$ LANGUAGE plpgsql;
