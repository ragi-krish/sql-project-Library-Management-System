Library Management System

Project Overview:
The Library Management System is a comprehensive database project designed to manage the operations of a library. It includes tables for branches, employees, books, customers, issue statuses, and return statuses. This system helps in keeping track of all information related to books, including their availability, rental prices, and the status of issued and returned books.

Database Schema:
The database schema includes the following tables:

1. Branch:
Branch_no (Primary Key)
Manager_Id
Branch_address
Contact_no

2. Employee:
Emp_Id (Primary Key)
Emp_name
Position
Salary
Branch_no (Foreign Key referencing Branch_no in Branch table)

3. Books:
ISBN (Primary Key)
Book_title
Category
Rental_Price
Status (Yes if available, No if not available)
Author
Publisher

4. Customer:
Customer_Id (Primary Key)
Customer_name
Customer_address
Reg_date

5. IssueStatus:
Issue_Id (Primary Key)
Issued_cust (Foreign Key referencing Customer_Id in Customer table)
Issued_book_name
Issue_date
Isbn_book (Foreign Key referencing ISBN in Books table)

6. ReturnStatus:
Return_Id (Primary Key)
Return_cust (Foreign Key referencing Customer_Id in Customer table)
Return_book_name
Return_date
Isbn_book2 (Foreign Key referencing ISBN in Books table)




