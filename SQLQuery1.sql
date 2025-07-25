Create Database Library_project_p2;

--Library management system project 2

--Creating the Table

use Library_project_p2

drop Table if exists branch;
CREATE TABLE branch (
    branch_id VARCHAR(10) PRIMARY KEY,
    manager_id VARCHAR(10),
    branch_address VARCHAR(55),
    contact_no VARCHAR(15)
);

drop Table if exists employees;
CREATE TABLE employees (
    emp_id VARCHAR(15) PRIMARY KEY,
    emp_name VARCHAR(20),
    position VARCHAR(20),
    salary INT,
    branch_id VARCHAR(10),
    FOREIGN KEY (branch_id) REFERENCES branch(branch_id)
);

Drop table if exists books
CREATE TABLE books (
    isbn VARCHAR(50) PRIMARY KEY,
    book_title VARCHAR(80),
    category VARCHAR(30),
    rental_price DECIMAL(10,2),
    status VARCHAR(10),
    author VARCHAR(30),
    publisher VARCHAR(30)
);

Drop table if exists members
CREATE TABLE members (
    member_id VARCHAR(30) PRIMARY KEY,
    member_name VARCHAR(30),
    member_address VARCHAR(30),
    reg_date DATE
);

Drop table if exists issued_status
CREATE TABLE issued_status (
    issued_id VARCHAR(10) PRIMARY KEY,
    issued_member_id VARCHAR(30),
    issued_book_name VARCHAR(80),
    issued_date DATE,
    issued_book_isbn VARCHAR(50),
    issued_emp_id VARCHAR(15),
    FOREIGN KEY (issued_member_id) REFERENCES members(member_id),
    FOREIGN KEY (issued_emp_id) REFERENCES employees(emp_id),
    FOREIGN KEY (issued_book_isbn) REFERENCES books(isbn)
);


Drop table if exists return_issues
CREATE TABLE return_status (
    return_id VARCHAR(10) PRIMARY KEY,
    issued_id VARCHAR(30),
    return_book_name VARCHAR(80),
    return_date DATE,
    return_book_isbn VARCHAR(50),
    FOREIGN KEY (return_book_isbn) REFERENCES books(isbn)
);


--Foriegn Keys

Alter table issued_status
Add Constraint fk_members
Foreign Key (issued_member_id)
References members(member_id);

Alter table issued_status
Add Constraint fk_Books
Foreign Key (issued_book_isbn)
References books(isbn);

Alter table issued_status
Add Constraint fk_Employees
Foreign Key (issued_emp_id)
References employees(emp_id);

Alter table return_issues
Add Constraint fk_issued_status
Foreign Key (issued_id)
References issued_status(issued_id);

Alter table employees
Add Constraint fk_Branch
Foreign Key (branch_id)
References branch(branch_id);



               