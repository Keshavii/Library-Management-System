# 📚 Library Management System – DBMS Project

A relational database project built using **PostgreSQL** to simulate real-world operations of a Library. This project includes table creation, constraints, indexing, transactions, views, stored procedures, and user-defined functions to manage books, users, subscriptions, book issues, and more.

---

## 🧩 Features

- 📖 Book and Book Copy Management  
- 👥 User Memberships and Subscription Plans  
- 🔄 Book Issuing and Returning (With Transactions)  
- 🔔 Fine and Overdue Tracking  
- 💳 Subscription Payments  
- 📝 Book Rating and Feedback  
- ⚙️ Use of Views, Indexes, Triggers, Functions, and Procedures

---

## 🏗️ Project Structure

```plaintext
/Library-Management-System/
├── docs/
│   └── ERD.png                    # ER diagram of the system
├── sql/
│   ├── 01_ddl_tables.sql          # Table definitions
│   ├── 02_constraints_indexes.sql # Constraints & Indexes
│   ├── 03_stored_procedures.sql  # Useful procedures (add_feedback, issue_book, etc.)
│   ├── 04_user_defined_functions.sql # Functions for reuse
│   ├── 05_transactions.sql       # Book issue/return logic with transactions
│   ├── 06_sample_data.sql        # Insert dummy data for testing
│   └── 07_useful_queries.sql     # Reporting and analytical queries
└── README.md
```
---

## 📚 Key Tables

| Table Name              | Description                            |
|-------------------------|----------------------------------------|
| `Users`                 | Library members                        |
| `Books`                 | Book information                       |
| `Book_Copies`           | Physical copies                        |
| `Book_Issues`           | Issued/returned book log               |
| `Subscription_Plans`    | Plans like Basic, Premium, etc.        |
| `User_Subscriptions`    | User-plan relations                    |
| `Subscription_Payments` | Payment logs                           |
| `Book_Feedback`         | User reviews                           |
| `Admins`                | Admin authentication info              |

---

## ⚙️ Indexes Used

| Table             | Indexed Columns                           | Purpose                              |
|------------------|--------------------------------------------|--------------------------------------|
| `Book_Copies`     | `book_id`                                 | Faster lookup of book copies         |
| `Books`           | `title`                                   | Quick title-based searches           |
| `Users`           | `email`                                   | Fast login/email checks              |
| `Book_Issues`     | `user_id`, `book_id`, `copy_id`, `status` | Efficient queries for issue tracking |

---

## 🔁 Transactions Implemented

- **`issue_book`**: Checks availability, issues book, and updates status in one atomic action.
- **`return_book`**: Updates return date and status.
- **`pay_subscription`**: Inserts payment and activates user’s subscription.
- **`add_feedback`**: Safely inserts a review, avoiding duplicates.

---

## 🧪 How to Run

1. Clone the repository:
   ```bash
   git clone <repository_url>
   cd library-management-system-DBMS
2. Open pgAdmin or psql CLI.
3.Run the SQL files in order:
    - 01_ddl_tables.sql
    - 02_constraints_indexes.sql
    - 06_sample_data.sql
    - 03_stored_procedures.sql
    - 04_user_defined_functions.sql
    - 05_transactions.sql
    - 07_useful_queries.sql

---

## 📊 Sample Views & Procedures

- **`active_user_subscriptions`**: Lists users with ongoing plans.
- **`issued_books_report`**: Shows current issued books and due dates.
- **`user_book_limit_check`**: Checks if user reached plan limit.
- **`add_feedback`**: Procedure to insert a book review.
- **`issue_book`**: Wrapped in a transaction for safe issue handling.

---

## 🛠️ Technologies Used

- **PostgreSQL** – Relational Database Management System (RDBMS)  
- **PL/pgSQL** – PostgreSQL's Procedural Language for advanced logic  
- **pgAdmin** – GUI tool for managing PostgreSQL databases  
- **SQL** – Used for schema design, indexing, constraints, and queries

---

## 🚀 Future Work

- ✅ **Authentication System:** Add a login/signup mechanism for users and admins using encrypted credentials.
- 📈 **Analytics Module:** Generate detailed reports (e.g., most borrowed books, overdue trends, top-rated books).
- 🌐 **Web Integration:** Build a front-end UI using web technologies (React.js or HTML/CSS/JS) to interact with the database.
- 📱 **Mobile App Extension:** Create an Android/iOS app interface using Flutter or React Native.
- 🧠 **Recommendation System:** Suggest books to users based on their borrowing and rating history.
- 🔄 **Backup & Recovery:** Implement automated backup procedures and recovery scripts for production use.
- ⏱️ **Real-Time Notifications:** Email or SMS reminders for return due dates and subscription expiries.

---

## 📄 License

This project is open-source and available under the **MIT License**.  
Feel free to use, modify, and distribute with proper attribution.

