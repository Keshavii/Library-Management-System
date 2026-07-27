# 📚 Library Management System — PostgreSQL

A relational database project that models the core operations of a library — book inventory, memberships, subscriptions, borrowing, and feedback — using pure PostgreSQL and PL/pgSQL. The goal was to push business rules (borrowing limits, availability checks, subscription logic) down into the database layer itself, using constraints, stored procedures, and transactions, rather than relying on application code to enforce them.

---

## 🧩 Features

- Book catalog and physical copy tracking (a single title can have multiple physical copies, each with its own status)
- User accounts and subscription plans with configurable borrowing limits and holding periods
- Book issuing and returning, wrapped in transactional stored procedures with rollback-safe exception handling
- Subscription purchase flow that deactivates the old plan, activates the new one, and logs the payment atomically
- Book feedback / ratings
- Reporting queries: overdue books, most-borrowed books, payment history, subscription counts per plan

---

## 🏗️ Project Structure

```plaintext
/Library-Management-System/
├── docs/
│   └── ERD.png                        # ER diagram of the schema
├── sql/
│   ├── 01_ddl_tables.sql              # Table definitions
│   ├── 02_constraints_indexes.sql     # Indexes
│   ├── 03_stored_procedures.sql       # add_feedback, register_user, update_subscription_status
│   ├── 04_user_defined_functions.sql  # Reusable lookup functions
│   ├── 05_transactions.sql            # issue_book_transaction, return_book_transaction, purchase_subscription
│   ├── 06_sample_data.sql             # Dummy data for testing
│   └── 07_useful_queries.sql          # Reporting / analytical queries
└── README.md
```

---

## 📚 Schema — 9 Tables

| Table | Purpose |
|---|---|
| `Books` | Catalog metadata — title, author, ISBN, category, shelf location |
| `Book_Copies` | Individual physical copies of a book, each with its own status (`Available`, `Issued`, `Lost`, `Damaged`) and barcode |
| `Users` | Library members |
| `Subscription_Plans` | Plan definitions (e.g., Bronze/Silver/Gold) — duration, fee, max books allowed, max holding time |
| `User_Subscriptions` | Which plan a user currently/previously held, and for how long |
| `Subscription_Payments` | Payment log tied to a subscription purchase |
| `Book_Issues` | Borrowing log — issue date, due date, return date, status, fine |
| `Book_Feedback` | User ratings (1–5) and comments per book |
| `Admins` | Admin login credentials |

Books and Book_Copies are deliberately separate tables: metadata (title, author) lives once per book, while availability/status is tracked per physical copy. Subscription plan details similarly live once in `Subscription_Plans` rather than being duplicated per user.

Full field-level detail is in [`sql/01_ddl_tables.sql`](sql/01_ddl_tables.sql). Relationships are shown in [`docs/ERD.png`](docs/ERD.png).

---

## ⚙️ Indexes

| Table | Indexed Column(s) | Reason |
|---|---|---|
| `Book_Copies` | `book_id` | Fast lookup of all copies for a given book |
| `Books` | `title` | Fast title search |
| `Users` | `email` | Fast login / uniqueness checks |
| `Book_Issues` | `user_id` | Fast lookup of a user's borrowing history |
| `Book_Issues` | `copy_id` | Fast lookup by physical copy |
| `Book_Issues` | `book_id` | Fast lookup by book |
| `Book_Issues` | `status` | Fast filtering (e.g., all `Overdue` records) |

---

## 🔒 Constraints & Validation

Enforced at the database level, not the application level:

- `CHECK` constraints on enumerated fields — `Book_Copies.status`, `Book_Issues.status`, `Users.gender`, `Book_Feedback.rating` (1–5)
- `UNIQUE` constraints — `Users.email`, `Book_Copies.barcode`, `Subscription_Plans.plan_name`
- Foreign keys tying `Book_Copies`, `Book_Issues`, `User_Subscriptions`, `Subscription_Payments`, and `Book_Feedback` back to their parent rows
- `NOT NULL` on required fields throughout

---

## 🔁 Stored Procedures & Functions

**Functions** (`sql/04_user_defined_functions.sql`) — used for lookups/calculations, callable from `SELECT`:
- `get_due_date(user_id)` — computes due date from the user's active plan
- `get_currently_issued_book(user_id)` — count of currently issued books
- `get_max_book_issue_limit(user_id)` — max books allowed under the user's active plan
- `get_book_copy(book_id)` — finds an available copy of a given book

**Procedures** (`sql/03_stored_procedures.sql` and `sql/05_transactions.sql`) — used to perform actions, called via `CALL`:
- `issue_book_transaction(user_id, book_id)` — checks borrowing limit and copy availability, then issues the book and updates copy status, all in one transactional block with exception handling
- `return_book_transaction(issue_id)` — validates the issue is still open, then marks the copy available and the issue returned
- `purchase_subscription(user_id, plan_id, amount, payment_id, payment_mode)` — deactivates any existing active subscription, activates the new one, and logs the payment
- `add_feedback(user_id, book_id, rating, comment)` — inserts a rating/review
- `register_user(...)` — inserts a new user
- `update_subscription_status(user_id)` — marks expired subscriptions inactive

All transactional procedures use `EXCEPTION WHEN OTHERS` blocks to catch failures and avoid partial writes.

---

## 📊 Reporting Queries

`sql/07_useful_queries.sql` includes queries for: available books, a user's issue history, overdue books, subscription plan lookups, payment history, average book rating, top 5 most-borrowed books (overall and by category), and subscriber counts per plan.

---

## 🧪 How to Run

```bash
git clone https://github.com/Keshavii/Library-Management-System.git
cd Library-Management-System
```

Open `psql` or pgAdmin against a fresh PostgreSQL database and run the files **in this order**:

1. `sql/01_ddl_tables.sql`
2. `sql/02_constraints_indexes.sql`
3. `sql/06_sample_data.sql`
4. `sql/03_stored_procedures.sql`
5. `sql/04_user_defined_functions.sql`
6. `sql/05_transactions.sql`
7. `sql/07_useful_queries.sql`

---

## 🛠️ Tech Stack

- **PostgreSQL** — relational database
- **PL/pgSQL** — stored procedures, functions, exception handling
- **pgAdmin / psql** — used for development and testing

---

## ⚠️ Known Limitations

Being upfront about these rather than hiding them:

- `get_book_copy()` selects an available copy without row-level locking (no `SELECT ... FOR UPDATE`), so two simultaneous issue requests for the last copy of a book could race. This would be fixed with `FOR UPDATE SKIP LOCKED` or a stricter isolation level.
- `add_feedback` does not currently enforce one review per user per book — there's no `UNIQUE(user_id, book_id)` constraint on `Book_Feedback`.
- No `ON DELETE` behavior is specified on foreign keys referencing `Books`, so Postgres will block deleting a book that still has copies, issues, or feedback (default `NO ACTION`). A soft-delete flag would be a cleaner alternative to hard deletes for a library catalog.
- `Book_Issues.status` (e.g., transitioning to `Overdue`) is updated manually rather than via a scheduled job or trigger.

---

## 🚀 Future Work

- Row-level locking on copy allocation to close the race condition above
- `UNIQUE(user_id, book_id)` constraint (or existence check) on `Book_Feedback`
- Database views for common reports (active subscriptions, issued-books report) instead of ad-hoc queries
- A trigger or scheduled job to auto-mark overdue issues instead of manual updates
- Application/API layer on top of the schema
- Authentication for the `Admins`/`Users` login flow (currently plain columns, no hashing implemented)

---
