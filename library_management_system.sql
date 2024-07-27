create database library;
use library;

create table branch 
(branch_no int primary key auto_increment,
manager_id int,
branch_add varchar(50),
con_no bigint);
alter table branch auto_increment=1;
select * from branch;

insert into branch(manager_id,branch_add,con_no) values(15,'nitha',9034578912);
insert into branch(manager_id,branch_add,con_no) values(102,'palakkadu',9038962012);
insert into branch(manager_id,branch_add,con_no) values(103,'thiruvalla',9038990012),
(104,'trivandrum',9038990092),(105,'thrissur',9038789012);
update branch set branch_add='kochi' where branch_no=1005;
select * from branch;

create table employee
(emp_id int primary key auto_increment,
emp_name varchar(25) not null,
position varchar(30),
salary float,
branch_no int,
foreign key (branch_no) references branch (branch_no));
alter table employee auto_increment=10;
insert into employee(emp_name,position,salary,branch_no) values('sree','clerk',25000.0,1001);
insert into employee(emp_name,position,salary,branch_no) values('geetha','librarian',30000.0,1002),
('nidhi','staff',30000.0,1002),('gourav','librarian',30000.0,1003),('arnav','clerk',20000.0,1004);
insert into employee(emp_name,position,salary,branch_no) values('saran','manager',55000.0,1002);
insert into employee(emp_name,position,salary,branch_no) values('mrunal','librarian',55000.0,1002),
('midhuna','clerk',25000.0,1002),('ssabareesh','staff',20000.0,1002);
select * from employee;


create table books
(isbn int primary key auto_increment,
book_title varchar(100),
category varchar(50),
rental_price float,
status bool,
author varchar(50),
publisher varchar(100));
alter table books auto_increment=5000;
alter table books modify column status int;
select * from books;

create table customer
(customer_id int primary key auto_increment,
customer_name varchar(20),
cust_add varchar(100),
reg_date date);
alter table customer auto_increment=100;
insert into customer(customer_name,cust_add,reg_date) values('aju','vaikkom','2021-01-13'),
('siju','attinkara','2021-06-13'),('sinu','mannarkkadu','2021-02-13'),
('gana','paadathil','2021-05-13');
insert into customer(customer_name,cust_add,reg_date) values('amala','varkala','2023-06-13'),
('sini','shornur','2023-06-01'),('sibi','manjadikkadu','2023-06-30');
select * from customer;

create table issuestatus
(issue_id int primary key auto_increment,
issued_cust_id int,
issued_book_name varchar(50),
issued_date date,
isbn int,
foreign key(issued_cust_id) references customer(customer_id),
foreign key(isbn) references books(isbn)
);
alter table issuestatus auto_increment=200;
insert into issuestatus (issued_cust_id,issued_book_name,issued_date,isbn) 
values(110,'To Kill a Mockingbird','2023-06-04',5010),
(109,'The Alchemist','2023-06-028',5011);
insert into issuestatus (issued_cust_id,issued_book_name,issued_date,isbn) 
values(108,'The Immortal Life of Henrietta Lacks','2023-06-28',5013);
select * from issuestatus;

create table returnstatus
(return_id int primary key auto_increment,
return_date date,
return_cust varchar(50),
return_book_name varchar(100),
isbn int,
foreign key(isbn) references books(isbn));
alter table returnstatus auto_increment=400;

select * from books;
insert into books (book_title,category,rental_price,status,author,publisher)
values('Harry Potter and the Philosophers Stone','Fantasy',19.99,1,'J.K. Rowling','Bloomsbury');
insert into books (book_title,category,rental_price,status,author,publisher)
values('Harry Potter and the Chamber of Secrets','Fantasy',19.99,0,'J.K. Rowling','Bloomsbury'),
('Brave New World','Dystopian',14.99,0,'Aldous Huxley','Harper Perennial'),
('To Kill a Mockingbird','Fiction',18.99,0,'Harper Lee','J.B. Lippincott & Co.'),
('The Alchemist','Fiction',16.99,0,'Paulo Coelho','HarperCollins')
;

insert into books (book_title,category,rental_price,status,author,publisher)
values('Sapiens: A Brief History of Humankind','History',22.99,1,'Yuval Noah Harari','Harper');
insert into books (book_title,category,rental_price,status,author,publisher)
values('The Immortal Life of Henrietta Lacks','History',25.99,0,'Rebecca Skloot','Crown Publishing Group');


#1. Retrieve the book title, category, and rental price of all available books. 
select book_title,category,rental_price from books;

#2. List the employee names and their respective salaries in descending order of salary. 
select emp_name,salary from employee order by salary desc;

#3. Retrieve the book titles and the corresponding customers who have issued those books.
select i.issued_book_name,i.issued_cust_id,c.customer_name 
from issuestatus i inner join customer c on i.issued_cust_id=c.customer_id;

#4. Display the total count of books in each category. 
select count(isbn) as count_of_books,category from books group by category;

#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
select emp_name,position from employee where salary>50000;

#6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT c.customer_name
FROM customer c
LEFT JOIN issuestatus i ON c.customer_id = i.issued_cust_id
WHERE c.reg_date < '2022-01-01'
AND i.issued_cust_id IS NULL;


#7. Display the branch numbers and the total count of employees in each branch. (it is including manager)
select count(emp_id),branch_no from employee group by branch_no;

#8. Display the names of customers who have issued books in the month of June 2023.
select c.customer_name from customer c 
join issuestatus i on i.issued_cust_id=c.customer_id
where issued_date between '2023-06-01' and '2023-06-30';

#9. Retrieve book_title from book table containing history. 
select book_title from books where category like '%history%';

#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
select branch_no,count(emp_id) from employee group by branch_no having count(emp_id)>5;

#11. Retrieve the names of employees who manage branches and their respective branch addresses.
select b.branch_no,b.branch_add,e.emp_name as manager_name 
from branch b join employee e on e.emp_id=b.manager_id;

#12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
select c.customer_name from customer c
join issuestatus i on c.customer_id=i.issued_cust_id
join books b on i.isbn=b.isbn
where b.rental_price>25;


