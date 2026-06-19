-- Data for Books Table
INSERT INTO Books (book_id, title, author, edition, publisher, language, category, isbn, shelf_location) VALUES
(101, 'The Great Gatsby', 'F. Scott Fitzgerald', 'First', 'Scribner', 'English', 'Classic Fiction', '978-0743273565', 'A1-01'),
(102, '1984', 'George Orwell', 'Centennial Edition', 'Signet Classic', 'English', 'Dystopian Fiction', '978-0451524935', 'A1-02'),
(103, 'To Kill a Mockingbird', 'Harper Lee', '50th Anniversary', 'Grand Central Publishing', 'English', 'Classic Fiction', '978-0446310789', 'A1-03'),
(104, 'Pride and Prejudice', 'Jane Austen', 'Collector''s', 'Penguin Classics', 'English', 'Romance', '978-0141439518', 'A2-01'),
(105, 'The Hobbit', 'J.R.R. Tolkien', 'Revised Edition', 'Mariner Books', 'English', 'Fantasy', '978-0345339683', 'A2-02'),
(106, 'The Lord of the Rings', 'J.R.R. Tolkien', 'Paperback', 'Mariner Books', 'English', 'Fantasy', '978-0618053267', 'A2-03'),
(107, 'Sapiens: A Brief History of Humankind', 'Yuval Noah Harari', 'International', 'Harper Perennial', 'English', 'Non-Fiction', '978-0062316097', 'B1-01'),
(108, 'Educated', 'Tara Westover', 'First', 'Random House', 'English', 'Memoir', '978-0399590504', 'B1-02'),
(109, 'Atomic Habits', 'James Clear', 'First', 'Avery', 'English', 'Self-Help', '978-0735211292', 'B2-01'),
(110, 'The Midnight Library', 'Matt Haig', 'First', 'Viking', 'English', 'Contemporary Fiction', '978-0525559474', 'C1-01'),
(111, 'Dune', 'Frank Herbert', 'Voyager Classics', 'Ace Books', 'English', 'Science Fiction', '978-0441172719', 'C1-02'),
(112, 'Project Hail Mary', 'Andy Weir', 'First', 'Ballantine Books', 'English', 'Science Fiction', '978-0593135204', 'C1-03'),
(113, 'The Silent Patient', 'Alex Michaelides', 'First', 'Celadon Books', 'English', 'Thriller', '978-1250301697', 'D1-01'),
(114, 'Becoming', 'Michelle Obama', 'First', 'Crown', 'English', 'Memoir', '978-1524763138', 'B2-02'),
(115, 'Where the Crawdads Sing', 'Delia Owens', 'First', 'G.P. Putnam''s Sons', 'English', 'Mystery', '978-0735219090', 'D1-02'),
(116, 'The Alchemist', 'Paulo Coelho', '25th Anniversary', 'HarperOne', 'English', 'Philosophical Fiction', '978-0062315007', 'A3-01'),
(117, 'Cosmos', 'Carl Sagan', 'Reissue', 'Ballantine Books', 'English', 'Science', '978-0345539434', 'B3-01'),
(118, 'A Brief History of Time', 'Stephen Hawking', 'Updated and Expanded', 'Bantam', 'English', 'Science', '978-0553380163', 'B3-02'),
(119, 'The Art of War', 'Sun Tzu', 'Translated', 'Shambhala', 'English', 'Philosophy', '978-1590302255', 'A3-02'),
(120, 'Critique of Pure Reason', 'Immanuel Kant', 'Penguin Classics', 'Penguin Books', 'English', 'Philosophy', '978-0140447477', 'A3-03');

-- Data for Book_Copies Table
INSERT INTO Book_Copies (book_id, status, barcode) VALUES
(101, 'Available', 'GC001'), (101, 'Issued', 'GC002'), (101, 'Available', 'GC003'),
(102, 'Available', '1984_001'), (102, 'Available', '1984_002'), (102, 'Issued', '1984_003'),
(103, 'Available', 'MOCK001'), (103, 'Damaged', 'MOCK002'), (103, 'Available', 'MOCK003'),
(104, 'Available', 'PP001'), (104, 'Issued', 'PP002'),
(105, 'Available', 'HOBBIT001'), (105, 'Available', 'HOBBIT002'),
(106, 'Available', 'LOTR001'), (106, 'Issued', 'LOTR002'), (106, 'Available', 'LOTR003'),
(107, 'Available', 'SAPIENS001'), (107, 'Available', 'SAPIENS002'),
(108, 'Available', 'EDUCATED001'),
(109, 'Available', 'ATOMIC001'), (109, 'Issued', 'ATOMIC002'),
(110, 'Available', 'MIDNIGHT001'), (110, 'Available', 'MIDNIGHT002'),
(111, 'Available', 'DUNE001'), (111, 'Issued', 'DUNE002'),
(112, 'Available', 'PHM001'),
(113, 'Available', 'SILENT001'), (113, 'Issued', 'SILENT002'),
(114, 'Available', 'BECOMING001'),
(115, 'Available', 'CRAWDADS001'),
(116, 'Available', 'ALCHEMIST001'), (116, 'Available', 'ALCHEMIST002'),
(117, 'Available', 'COSMOS001'),
(118, 'Available', 'HISTORYTIME001'),
(119, 'Available', 'ARTWAR001'),
(120, 'Available', 'CRITIQUE001');

-- Data for Subscription_Plans Table
INSERT INTO Subscription_Plans (plan_name, duration_in_days, fees, max_book_limit, available, max_book_holding_time_in_days) VALUES
('Bronze', 30, 99.99, 2, TRUE, 7),
('Silver', 90, 249.99, 3, TRUE, 14),
('Gold', 180, 449.99, 5, TRUE, 21),
('Platinum', 365, 799.99, 7, TRUE, 30),
('Student Basic', 60, 49.99, 1, TRUE, 7);

-- Data for Users Table
INSERT INTO Users (email, password, first_name, last_name, phone, address_line1, address_line2, gender, date_of_birth) VALUES
('alice.smith@example.com', 'securepass123', 'Alice', 'Smith', '123-456-7890', '123 Main St', 'Apt 101', 'Female', '1990-05-15'),
('bob.johnson@example.com', 'mypassword456', 'Bob', 'Johnson', '987-654-3210', '45 Elm St', NULL, 'Male', '1988-11-20'),
('charlie.brown@example.com', 'brownie_pwd', 'Charlie', 'Brown', '555-123-4567', '789 Oak Ave', 'Suite 200', 'Male', '1995-03-01'),
('diana.prince@example.com', 'wonderwoman', 'Diana', 'Prince', '111-222-3333', 'Amazon Plaza', 'Tower A', 'Female', '1980-07-22'),
('eve.davis@example.com', 'evedavis789', 'Eve', 'Davis', '444-555-6666', '10 Pine Lane', NULL, 'Female', '1992-09-10'),
('frank.white@example.com', 'white_frank', 'Frank', 'White', '777-888-9999', '22 Apple Blvd', 'Unit 5', 'Male', '1985-01-25'),
('grace.green@example.com', 'green_grace', 'Grace', 'Green', '333-444-5555', '33 Oakwood Dr', NULL, 'Female', '1998-04-18'),
('henry.black@example.com', 'black_henry', 'Henry', 'Black', '222-333-4444', '44 Willow Cres', 'Apt 3B', 'Male', '1975-12-05'),
('irene.adler@example.com', 'irenesecure', 'Irene', 'Adler', '666-777-8888', '221B Baker St', NULL, 'Female', '1983-06-30'),
('jack.sparrow@example.com', 'pirateking', 'Jack', 'Sparrow', '999-000-1111', 'The Black Pearl', 'Cabin 7', 'Male', '1970-02-14'),
('karen.jones@example.com', 'karenjones', 'Karen', 'Jones', '888-777-6666', '55 Cedar Rd', NULL, 'Female', '1993-10-02'),
('liam.martin@example.com', 'liamstrong', 'Liam', 'Martin', '123-123-1234', '66 Birch Ave', 'Floor 2', 'Male', '1991-08-08');

-- Data for User_Subscriptions Table
-- Alice (user_id 1) has a Gold plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(1, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Gold'), '2024-01-01', '2024-06-29', TRUE); -- Gold (180 days)

-- Bob (user_id 2) has a Silver plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(2, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Silver'), '2024-04-01', '2024-06-29', TRUE); -- Silver (90 days)

-- Charlie (user_id 3) has a Bronze plan (recently expired)
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(3, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), '2024-05-01', '2024-05-30', FALSE); -- Bronze (30 days)

-- Diana (user_id 4) has a Platinum plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(4, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Platinum'), '2023-12-15', '2024-12-14', TRUE); -- Platinum (365 days)

-- Eve (user_id 5) has a Bronze plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(5, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), '2024-06-01', '2024-06-30', TRUE); -- Bronze (30 days)

-- Frank (user_id 6) has a Silver plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(6, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Silver'), '2024-05-10', '2024-08-08', TRUE); -- Silver (90 days)

-- Grace (user_id 7) has a Student Basic plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(7, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Student Basic'), '2024-05-20', '2024-07-19', TRUE); -- Student Basic (60 days)

-- Karen (user_id 11) has a Bronze plan
INSERT INTO User_Subscriptions (user_id, plan_id, start_date, end_date, isActive) VALUES
(11, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), '2024-06-10', '2024-07-09', TRUE);


-- Data for Subscription_Payments Table
INSERT INTO Subscription_Payments (user_id, plan_id, amount_paid, real_bank_payment_id, payment_mode, payment_date) VALUES
(1, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Gold'), 449.99, 'PAYID1001', 'Card', '2024-01-01'),
(2, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Silver'), 249.99, 'PAYID1002', 'UPI', '2024-04-01'),
(3, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), 99.99, 'PAYID1003', 'Cash', '2024-05-01'),
(4, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Platinum'), 799.99, 'PAYID1004', 'NetBanking', '2023-12-15'),
(5, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), 99.99, 'PAYID1005', 'Card', '2024-06-01'),
(6, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Silver'), 249.99, 'PAYID1006', 'UPI', '2024-05-10'),
(7, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Student Basic'), 49.99, 'PAYID1007', 'UPI', '2024-05-20'),
(11, (SELECT plan_id FROM Subscription_Plans WHERE plan_name = 'Bronze'), 99.99, 'PAYID1008', 'Card', '2024-06-10');


-- Data for Book_Issues Table
-- Alice (user_id 1) - Gold Plan (max 5 books, 21 days holding)
INSERT INTO Book_Issues (user_id, copy_id, book_id, issue_date, due_date, return_date, status, fine) VALUES
(1, (SELECT copy_id FROM Book_Copies WHERE barcode = 'GC002'), 101, '2024-06-01', '2024-06-22', NULL, 'Issued', 0.00), -- The Great Gatsby (Issued)
(1, (SELECT copy_id FROM Book_Copies WHERE barcode = 'LOTR002'), 106, '2024-05-25', '2024-06-15', '2024-06-10', 'Returned', 0.00), -- The Lord of the Rings (Returned)
(1, (SELECT copy_id FROM Book_Copies WHERE barcode = 'ATOMIC002'), 109, '2024-05-20', '2024-06-10', NULL, 'Overdue', 5.00); -- Atomic Habits (Overdue by 4 days if today is June 14)

-- Bob (user_id 2) - Silver Plan (max 3 books, 14 days holding)
INSERT INTO Book_Issues (user_id, copy_id, book_id, issue_date, due_date, return_date, status, fine) VALUES
(2, (SELECT copy_id FROM Book_Copies WHERE barcode = '1984_003'), 102, '2024-06-05', '2024-06-19', NULL, 'Issued', 0.00), -- 1984 (Issued)
(2, (SELECT copy_id FROM Book_Copies WHERE barcode = 'PP002'), 104, '2024-05-15', '2024-05-29', '2024-05-28', 'Returned', 0.00); -- Pride and Prejudice (Returned)

-- Charlie (user_id 3) - Bronze Plan (max 2 books, 7 days holding) - Expired
INSERT INTO Book_Issues (user_id, copy_id, book_id, issue_date, due_date, return_date, status, fine) VALUES
(3, (SELECT copy_id FROM Book_Copies WHERE barcode = 'DUNE002'), 111, '2024-05-28', '2024-06-04', NULL, 'Lost', 150.00); -- Dune (Lost)

-- Eve (user_id 5) - Bronze Plan (max 2 books, 7 days holding)
INSERT INTO Book_Issues (user_id, copy_id, book_id, issue_date, due_date, return_date, status, fine) VALUES
(5, (SELECT copy_id FROM Book_Copies WHERE barcode = 'SILENT002'), 113, '2024-06-10', '2024-06-17', NULL, 'Issued', 0.00); -- The Silent Patient (Issued)


-- Data for Admins Table
INSERT INTO Admins (email, password, name) VALUES
('admin.main@example.com', 'admin_secure_pwd', 'Super Admin'),
('librarian.alex@example.com', 'alex_lib_123', 'Alex Johnson'),
('librarian.sarah@example.com', 'sarah_lib_pass', 'Sarah Davis');

-- Data for Book_Feedback Table
INSERT INTO Book_Feedback (user_id, book_id, rating, comment, submitted_on) VALUES
(1, 101, 5, 'An absolute classic! Loved every bit of it.', '2024-06-01'),
(2, 102, 4, 'Thought-provoking and relevant, even today.', '2024-05-20'),
(3, 103, 5, 'A truly timeless and powerful story.', '2024-06-05'),
(4, 107, 5, 'Mind-blowing insights into human history. Highly recommend!', '2024-04-10'),
(5, 110, 4, 'Very engaging concept, made me think about life choices.', '2024-06-12'),
(6, 109, 5, 'Practical advice for building good habits. A game changer!', '2024-06-08'),
(7, 115, 3, 'Interesting plot, but the pacing was a bit slow for me.', '2024-06-11'),
(1, 116, 4, 'Inspiring and a good reminder about following dreams.', '2024-06-14'),
(2, 117, 5, 'Carl Sagan makes complex science so accessible and beautiful.', '2024-06-13'),
(4, 114, 5, 'A powerful and honest memoir. Michelle Obama''s journey is truly inspiring.', '2024-05-01');
