CREATE DATABASE db_employee;
USE db_employee; 

CREATE TABLE Tbl_Employee(
    employee_name varchar(255) primary key not null,
    street varchar(255),
    city varchar(255)
    );
    
CREATE TABLE Tbl_company(
    company_name varchar(255) primary key not null,
    city varchar(255)
    );

CREATE TABLE Tbl_works(
    employee_name varchar(255) primary key not null,
    company_name varchar(255),
    salary int not null,
    FOREIGN KEY (employee_name) REFERENCES Tbl_employee(employee_name),
    FOREIGN KEY (company_name) REFERENCES Tbl_company(company_name)
    );


CREATE TABLE Tbl_manages(
    employee_name varchar(255) primary key not null,
    manager_name varchar(255),
    FOREIGN KEY (employee_name) REFERENCES Tbl_employee(employee_name)
    );

INSERT INTO Tbl_Employee(employee_name, street, city)
VALUES ('Rajin', 'Dadhikot', 'Bhaktapur'),
        ('Rabin', 'Dadhikot', 'Bhaktapur'),
        ('Sujan', 'Patan', 'Bhaisepati'),
        ('Dipesh', 'Manmohan Road', 'Chitwan'),
        ('Nischal', 'Prithvi Chowk', 'Pokhara'),
        ('Viktor', 'Auschawltz', 'Berlin');
        
INSERT INTO Tbl_company(company_name, city)
VALUES ('Neosphere', 'Kathmandu'),
        ('First bank corporatioon','Bhaktapur'),
        ('Moonlight Developers', 'Bhaisepati'),
        ('Bhoos', 'Patan'),
        ('First bank corporation', 'Pokhara');

INSERT INTO Tbl_works(employee_name, company_name, salary)
VALUES ('Rajin', 'Neosphere', 12345),
        ('Rabin', 'First bank corporation', 67890),
        ('Sujan', 'Moonlight Developers', 14789),
        ('Dipesh', 'Bhoos', 36987),
        ('Nischal', 'First bank corporation', 55555),
        ('Viktor', 'First bank corporation', 89652);


INSERT INTO Tbl_manages(employee_name, manager_name)
VALUES ('Rajin', 'Naruto'),
        ('Rabin', 'Saitama'),
        ('Sujan', 'Keshar'),
        ('Dipesh', 'Shiva'),
        ('Nischal', 'Saitama'),
        ('Viktor', 'Anthony');
        
INSERT INTO tbl_employee(employee_name, street, city)
VALUES('Anthony','Dadhikoot','Bhaktapur'),
		('Saitama','Manmohan Rooad','Chitwan'),
        ('Shiva','New Road','Bhaisepati');
        
INSERT INTO tbl_works(employee_name, company_name, salary)
VALUES('Anthony','Neosphere',1234),
		('Saitama','Bhoos',56897),
        ('Shiva','Moonlight developers', 9999);
        
INSERT INTO tbl_company(company_name, city)
VALUES('Fuse', 'Patam'),
		('Dell', 'Patan');

-- answer for 2 a --
SELECT employee_name FROM Tbl_works WHERE company_name = 'First bank corporation';

-- answer for 2 b --
-- using subquery --
SELECT employee_name, city FROM Tbl_Employee
WHERE employee_name = ANY ( SELECT employee_name
FROM Tbl_works WHERE company_name = 'First bank corporation');

-- using join --
SELECT tbl_employee.employee_name, city FROM Tbl_employee INNER JOIN Tbl_works
ON Tbl_employee.employee_name = Tbl_works.employee_name
WHERE Tbl_works.company_name = 'First bank corporation';

-- answer for 2 c --
-- using subquery --
SELECT tbl_employee.employee_name, city, street FROM Tbl_employee
WHERE Tbl_employee.employee_name = ANY( SELECT employee_name 
FROM tbl_works WHERE tbl_works.company_name = 'First bank corporation' AND tbl_works.salary > 10000);

-- using join --
SELECT tbl_employee.employee_name, city, street FROM tbl_employee INNER JOIN tbl_works
ON tbl_employee.employee_name = tbl_works.employee_name 
WHERE tbl_works.company_name = 'First bank corporation' AND salary > 10000;

-- answer for 2 d --
-- using subquery --
SELECT tbl_employee.employee_name, city FROM Tbl_employee
WHERE Tbl_employee.city = (SELECT Tbl_company.city 
FROM tbl_company WHERE tbl_company.company_name = ( SELECT Tbl_works.company_name
FROM tbl_works WHERE tbl_works.employee_name = Tbl_employee.employee_name));

-- using join --
SELECT tbl_employee.employee_name, tbl_employee.city FROM tbl_employee 
INNER JOIN tbl_company ON tbl_company.city = tbl_employee.city	
INNER JOIN tbl_works ON tbl_works.company_name = tbl_company.company_name
WHERE tbl_employee.employee_name = tbl_works.employee_name; 

-- answer for 2 f --
-- using subquery --
SELECT tbl_works.employee_name FROM tbl_works 
WHERE company_name != 'First bank corporation';

-- assumption: secoond bank corporation is replaced by bhoos --
-- answer for 2 g --
-- using subquery --
 SELECT tbl_works.employee_name, salary FROM tbl_works WHERE tbl_works.salary > (
SELECT max(salary) FROM tbl_works WHERE tbl_works.company_name = 'Bhoos');


-- answer for 2 h --
SELECT company_name FROM tbl_company 
WHERE tbl_company.city = (
SELECT tbl_company.city FROM tbl_company WHERE tbl_company.company_name = 'Bhoos');

-- answer for 2 i --
SELECT * from tbl_works AS temp
WHERE temp.salary > (SELECT avg(salary) from tbl_works
WHERE tbl_works.company_name = temp.company_name
GROUP BY company_name);

-- answer for 2 j --
SELECT company_name, COUNT(*) AS employee_num
FROM tbl_works 
GROUP BY company_name
ORDER BY employee_num DESC
LIMIT 1;

-- answer for 2 k --
SELECT company_name, SUM(salary) AS payroll
FROM tbl_works 
GROUP BY company_name
ORDER BY payroll ASC
LIMIT 1;

-- answer for 2 l --
-- HAVING is used to filter the results provided by the subquery following it --
-- using first bank corporation gives no results
-- first back coorporation has been substituted for neosphere in this question
SELECT company_name, AVG(salary) as avg_salary
FROM tbl_works
GROUP BY company_name
HAVING avg_salary > (SELECT AVG(salary) FROM tbl_works WHERE company_name = 'Neosphere');

-- no 3 starts here

-- answer for 3 a
-- Anthony is used instead of Jones
UPDATE tbl_employee SET street = 'Newtown' WHERE employee_name = 'Anthony';
SELECT * FROM tbl_employee;

-- answer for 3 b
UPDATE tbl_works SET salary = salary * 1.1 WHERE company_name = 'First bank corporation';
SELECT * FROM tbl_works;

-- answer for 3 c
UPDATE tbl_works SET salary = salary*1.1 WHERE employee_name = ANY (
SELECT DISTINCT manager_name FROM tbl_manages) AND company_name = 'first bank corporation';

-- answer for 3 d
UPDATE tbl_works SET salary = IF(salary<100000, salary*1.1, salary*1.03) 
WHERE employee_name = ANY (SELECT DISTINCT manager_name FROM tbl_manages) AND company_name = 'First bank corporation';

-- answer for 3 e
-- neosphere used instead of small bank corporation
SET foreign_key_checks = 0;
DELETE FROM tbl_works WHERE company_name = 'Neosphere';