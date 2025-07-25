SELECT * FROM members;
SELECT * FROM branch;
SELECT * FROM employees;
SELECT * FROM books;
SELECT * FROM issued_status;
SELECT * FROM return_issues;

---Project Task

--Task 1. Create a New Book Record
  -- "978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.')"

Insert into books(isbn,book_title,category,rental_price,status,author,publisher)
values('978-1-60129-456-2', 'To Kill a Mockingbird', 'Classic', 6.00, 'yes', 'Harper Lee', 'J.B. Lippincott & Co.');

--Task 2: Update an Existing Member's Address

UPDATE members
SET member_address = '125 Oak St'
WHERE member_id = 'C103';

--Task 3: Delete a Record from the Issued Status Table
   -- Objective: Delete the record with issued_id = 'IS121' from the issued_status table.

Delete from issued_status
where issued_id = 'IS121';

--Task 4: Retrieve All Books Issued by a Specific Employee**
   -- Objective: Select all books issued by the employee with emp_id = 'E101'.

select * from issued_status
where issued_emp_id= 'E101';

--Task 5: List Members Who Have Issued More Than One Book**
  -- Objective: Use GROUP BY to find members who have issued more than one book.

SELECT 
    m.member_id,
    m.member_name,
    COUNT(i.issued_id) AS total_books_issued
FROM 
    members AS m
JOIN 
    issued_status AS i ON m.member_id = i.issued_member_id
GROUP BY 
    m.member_id, m.member_name
HAVING 
    COUNT(i.issued_id) > 1;

--Task 6: Create Summary Tables : Used CTAS to generate new tables based on query results - each book and total book_issued_cnt

SELECT 
    b.isbn, 
    b.book_title, 
    COUNT(ist.issued_id) AS issue_count
INTO book_issued_cnt
FROM issued_status AS ist
JOIN books AS b
    ON ist.issued_book_isbn = b.isbn
GROUP BY b.isbn, b.book_title;

Select * from book_issued_cnt;

--Task 7. Retrieve All Books in a Specific Category:

Select * from books
where category ='classic';

--Task 8: Find Total Rental Income by Category :

Select category,sum(rental_price) as Total_Rental_Income from books
group by category;

--Task 9. List Members Who Registered in the Last 180 Days

SELECT * FROM members
WHERE reg_date >= DATEADD(DAY, -180, GETDATE());

--Task 10. List Employees with Their Branch Manager's Name and their branch details

Select e1.*,b.branch_id,e2.emp_name as managers_name
from employees as e1
join branch as b
on b.branch_id = e1.branch_id
join employees as e2
on b.manager_id = e2.emp_id;

--Task 11. Create a Table of Books with Rental Price Above a Certain Threshold 7Usd :

select a.* into Higher_rentals
from books as a
Where rental_price>7;

select * from Higher_rentals;

--Task 12: Retrieve the List of Books Not Yet Returned :


Select ist.issued_book_name
from issued_status as ist
left join 
return_issues as r
on r.issued_id = ist.issued_id
where r.return_id is null;