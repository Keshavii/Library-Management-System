-- BOOKS
CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(200),
  author VARCHAR(100),
  edition VARCHAR(20),
  publisher VARCHAR(100),
  language VARCHAR(50),
  category VARCHAR(50),
  isbn VARCHAR(20),
  shelf_location VARCHAR(50)
);

-- BOOK COPIES
CREATE TABLE Book_Copies (
  copy_id SERIAL PRIMARY KEY,
  book_id INT,
  status VARCHAR(20) DEFAULT 'Available' CHECK (status IN ('Available', 'Issued', 'Lost', 'Damaged')),
  barcode VARCHAR(50) UNIQUE,
  FOREIGN KEY (book_id) REFERENCES Books(book_id)
);

-- SUBSCRIPTION PLANS
CREATE TABLE Subscription_Plans (
  plan_id SERIAL PRIMARY KEY,
  plan_name VARCHAR(50) UNIQUE NOT NULL,
  duration_in_days INT NOT NULL,
  fees NUMERIC(10, 2) NOT NULL,
  max_book_limit INT NOT NULL,
  available BOOLEAN NOT NULL,
  max_book_holding_time_in_days INT NOT NULL DEFAULT 7
);

-- USERS
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  phone VARCHAR(15),
  address_line1 TEXT,
  address_line2 TEXT,
  gender VARCHAR(10) CHECK (gender IN ('Male', 'Female', 'Other')),
  date_of_birth DATE
);

-- USER SUBSCRIPTIONS
CREATE TABLE User_Subscriptions (
  subscription_taken_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(user_id),
  plan_id INT REFERENCES Subscription_Plans(plan_id),
  start_date DATE DEFAULT CURRENT_DATE,
  end_date DATE,
  isActive BOOLEAN
);

-- SUBSCRIPTION PAYMENTS
CREATE TABLE Subscription_Payments (
  payment_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(user_id),
  plan_id INT REFERENCES Subscription_Plans(plan_id),
  amount_paid NUMERIC(10, 2) NOT NULL,
  real_bank_payment_id VARCHAR(100),
  payment_mode VARCHAR(20) CHECK (payment_mode IN ('Cash', 'UPI', 'Card', 'NetBanking')),
  payment_date DATE DEFAULT CURRENT_DATE
);

--  BOOK ISSUES  
CREATE TABLE Book_Issues (
  issue_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(user_id),
  copy_id INT REFERENCES Book_Copies(copy_id),
  book_id INT REFERENCES Books(book_id),
  issue_date DATE DEFAULT CURRENT_DATE,
  due_date DATE NOT NULL,
  return_date DATE,
  status VARCHAR(20) DEFAULT 'Issued' CHECK (status IN ('Issued', 'Returned', 'Overdue', 'Lost')),
  fine NUMERIC(10, 2) DEFAULT 0.00
);

-- ADMINS
CREATE TABLE Admins (
  admin_id SERIAL PRIMARY KEY,
  email VARCHAR(100) UNIQUE NOT NULL,
  password VARCHAR(100) NOT NULL,
  name VARCHAR(100)
);

-- BOOK FEEDBACK
CREATE TABLE Book_Feedback (
  feedback_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES Users(user_id),
  book_id INT REFERENCES Books(book_id),
  rating INT CHECK (rating BETWEEN 1 AND 5),
  comment TEXT,
  submitted_on DATE DEFAULT CURRENT_DATE
);
