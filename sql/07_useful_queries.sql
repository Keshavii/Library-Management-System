-- Some Important Queries for managing the library system
 
-- 1. Get all available books with basic info
select b.book_id, count(b.book_id) ,b.title , b.author
from books as b
inner join Book_Copies as bc on b.book_id = bc.book_id
where bc.status = 'Available'
group by b.book_id

-- 2. Get full user profile
select *
from users
where email = 'user12@example.com'

-- 3. Check all books issued to a specific user
select bi.issue_id, b.title, bi.issue_date, bi.due_date, bi.status
from Book_Issues bi
Join Books b on bi.book_id = b.book_id
where bi.user_id = 1;

-- 4. Update book copy status on return (Should be triggered on returning the book)
update Book_Copies
set status = 'Issued'
where copy_id = (select copy_id from Book_Issues where issue_id = 1)

-- 5. List overdue books
select b.book_id,b.title,count(b.book_id) as cout
from books as b
inner join Book_Issues as bi on b.book_id = bi.book_id
where bi.status = 'Overdue'
group by b.book_id

-- 6. List all subscription plans
select * from Subscription_Plans where available = true;

-- 7. Get the current active plan for a user
select *
from User_Subscriptions
where user_id = 1 and end_date<=CURRENT_DATE

-- 8. Get the payment history for a user
select *
from Subscription_Payments  
where user_id = 1
order by payment_date desc

-- 9. Check if the user has overdue books before issuing a new one
select count(*) from Book_Issues
where user_id = 101 and status = 'Overdue';

-- 10. Add new feedback for a book
insert into Book_Feedback (user_id, book_id, rating, comment)
values(1, 101, 4, 'Great book for beginners!');

-- 11. Get the average rating for a book
select book_id,avg(rating)
from Book_Feedback
group by book_id
having book_id = 101
Or
select avg(rating) as avg_rating
from Book_Feedback
where book_id = 101;

-- 12. Top 5 most borrowed books
select b.book_id,b.title,count(b.book_id) as cout
from books as b
inner join book_issues as bi on b.book_id = bi.book_id
group by b.book_id
order by cout desc
limit 5

-- 13. Top 5 most borrowed books in a specific category
select b.book_id,b.title,b.category,count(b.book_id) as cout
from books as b
inner join book_issues as bi on b.book_id = bi.book_id
where b.category = 'Classic'
group by b.book_id
order by cout desc
limit 5

-- 14. Count how many users are subscribed to each plan ( use of left join )
select sp.plan_id,sp.plan_name, count(sp.plan_id)
from Subscription_Plans as sp
left join User_Subscriptions as us on sp.plan_id = us.plan_id
group by sp.plan_id

-- 15. Count how many active subscribers of each plan
select sp.plan_id,sp.plan_name, count(sp.plan_id)
from Subscription_Plans as sp
left join User_Subscriptions as us on sp.plan_id = us.plan_id
where us.end_date<=current_date
group by sp.plan_id

-- 16. Check whether a user has reached the maximum limit of book issues.
select bi.user_id,us.plan_id ,us.start_date,us.end_date,us.plan_id,sp.plan_name,sp.max_book_limit ,count(bi.user_id)
from book_issues as bi
inner join User_Subscriptions as us on us.user_id = bi.user_id
inner join Subscription_Plans as sp on us.plan_id = sp.plan_id
where bi.user_id = 1 and bi.status in('Issued','Overdue') and isactive = true
group by bi.user_id, us.plan_id ,us.start_date ,us.end_date,us.plan_id,sp.plan_name,sp.max_book_limit
