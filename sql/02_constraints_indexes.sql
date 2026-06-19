-- Book Copies
CREATE INDEX idx_bookcopies_bookid ON Book_Copies(book_id);

-- Books (for search)
CREATE INDEX idx_books_title ON Books(title);

-- Users
CREATE INDEX idx_users_email ON Users(email);

-- Book Issues
CREATE INDEX idx_bookissues_userid ON Book_Issues(user_id);
CREATE INDEX idx_bookissues_copyid ON Book_Issues(copy_id);
CREATE INDEX idx_bookissues_bookid ON Book_Issues(book_id);
CREATE INDEX idx_bookissues_status ON Book_Issues(status);
