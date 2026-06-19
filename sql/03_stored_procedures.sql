-- 📘 Add Book Feedback
CREATE OR REPLACE PROCEDURE add_feedback(u_id INT, b_id INT, rate INT, comment TEXT)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Book_Feedback (user_id, book_id, rating, comment)
    VALUES (u_id, b_id, rate, comment);
END;
$$;

-- 👤 Register New User
CREATE OR REPLACE PROCEDURE register_user(
    email VARCHAR(100), password VARCHAR(100), first_name VARCHAR(50),
    last_name VARCHAR(50), phone VARCHAR(15),
    address_line1 TEXT, address_line2 TEXT,
    gender VARCHAR(10), date_of_birth DATE)
LANGUAGE plpgsql AS $$
BEGIN
    INSERT INTO Users (email, password, first_name, last_name, phone, address_line1, address_line2, gender, date_of_birth)
    VALUES (email, password, first_name, last_name, phone, address_line1, address_line2, gender, date_of_birth);
END;
$$;

-- 🔁 Deactivate Expired Subscriptions
CREATE OR REPLACE PROCEDURE update_subscription_status(u_id INT)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE User_Subscriptions
    SET isActive = FALSE
    WHERE user_id = u_id AND end_date < CURRENT_DATE;
    RAISE NOTICE 'Expired user subscriptions marked as inactive.';
END;
$$;