-- answer to 1
-- creating a university database
-- schema and databse refer to the same object
CREATE DATABASE university;
USE university;

DROP TABLE course;
DROP TABLE department;
DROP TABLE instructor;
DROP TABLE section;
DROP TABLE student;
DROP TABLE teaches;

-- answer to 2
-- coompleting data definition and tuples
CREATE TABLE department(
    department_name VARCHAR(255) PRIMARY KEY NOT NULL,
    building VARCHAR(255) NOT NULL,
    budget INT NOT NULL
);

CREATE TABLE course(
    course_id VARCHAR(255) PRIMARY KEY NOT NULL,
    course_title VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    credits INT NOT NULL,
    FOREIGN KEY (department_name) REFERENCES department(department_name)
);

CREATE TABLE instructor(
    instructor_id INT PRIMARY KEY NOT NULL,
    instructor_name VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    salary INT NOT NULL,
    FOREIGN KEY (department_name) REFERENCES department(department_name)
);

CREATE TABLE section(
    course_id VARCHAR(255) NOT NULL,
    sec_id INT NOT NULL,
    semester VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    building VARCHAR(255) NOT NULL,
    room_number INT NOT NULL,
    time_slot_id VARCHAR(255) NOT NULL,
    FOREIGN KEY (course_id) REFERENCES course(course_id)
);

CREATE TABLE teaches(
    instructor_id INT NOT NULL,
    course_id VARCHAR(255) NOT NULL,
    sec_id INT NOT NULL,
    semester VARCHAR(255) NOT NULL,
    year INT NOT NULL,
    FOREIGN KEY (instructor_id) REFERENCES instructor(instructor_id)
);

CREATE TABLE student(
    student_id INT PRIMARY KEY NOT NULL,
    student_name VARCHAR(255) NOT NULL,
    department_name VARCHAR(255) NOT NULL,
    total_cred INT NOT NULL,
    FOREIGN KEY (department_name) REFERENCES department(department_name)
);

-- ans to 3
-- insert values into the tuples 
INSERT INTO department(department_name, building, budget)
VALUES ('Computer Science','Taylor',10000),
		('Biology','Watson',90000),
        ('Electrical Engineering','Taylor',85000),
        ('Music','Packard',80000),
        ('Finance','Painter',120000),
        ('History','Painter',50000),
        ('Physics','Watson',70000),
        ('Chemistry','Lionel',35000),
        ('Quantum Mechanics','Kylian',65000),
        ('Astronoomy','Sagan',89000);

INSERT INTO course(course_id, course_title, department_name, credits)
VALUES ('BIO-101','Intro to Biology','Biology',4),
        ('BIO-301','Genetics','Biology',4),
        ('BIO-399','Computation Biology','Biology',3),
        ('CS-101','Intro to Computer Science','Computer Science',4),
        ('CS-190','Game Design','Computer Science',4),
        ('CS-315','Robotics','Computer Science',3),
        ('CS-319','Image Processing','Computer Science',3),
        ('CS-347','Database system concepts','Computer Science',3),
        ('EE-181','Intro to Digital Systems','Electrical Engineering',3),
        ('FIN-201','Investment Banking','Finance',3),
        ('HIS-351','World History','History',3),
        ('MU-199','Music Video Production','Music',3),
        ('PHY-101','Physical Principles','Physics',4);

INSERT INTO section(course_id, sec_id, semester, year, building, room_number, time_slot_id) 
VALUES ('BIO-101',1,'Summer',2009,'Painter',514,'B'),
        ('BIO-301',1,'Summer',2010,'Painter',514,'A'),
        ('CS-101',1,'Fall',2009,'Packard',101,'H'),
        ('CS-190',1,'Spring',2010,'Packard',101,'F'),
        ('CS-315',2,'Spring',2009,'Taylor',3128,'E'),
        ('CS-319',1,'Spring',2010,'Taylor',3128,'A'),
        ('CS-319',1,'Spring',2010,'Watson',120,'D'),
        ('CS-347',2,'Spring',2010,'Watson',100,'B'),
        ('CS-319',2,'Spring',2010,'Taylor',3128,'C'),
        ('CS-347',1,'Fall',2009,'Taylor',3128,'A');

INSERT INTO instructor(instructor_id, instructor_name, department_name, salary)
VALUES (10101,'Srinivasan','Computer Science',65000),
        (12121,'Wu','Finance',90000),
        (15151,'Mozart','Music',40000),
        (22222,'Einstein','Physics',95000),
        (32343,'El Said','History',60000),
        (33456,'Gold','Physics',87000),
        (45565,'Katz','Computer Science',75000),
        (145236,'Califeri','History',62000),
        (76543,'Singh','Finance',80000),
        (76766,'Crick','Biology',72000);

INSERT INTO teaches(instructor_id, course_id, sec_id, semester, year)
VALUES (10101,'CS-101',1,'Fall',2009),
        (10101,'CS-315',1,'Spring',2010),
        (10101,'CS-347',1,'Fall',2009),
        (12121,'FIN-201',1,'Spring',2010),
        (145236,'HIS-351',1,'Spring',2010),
        (45565,'CS-101',1,'Spring',2010);

INSERT INTO student(student_id, student_name, department_name, total_cred)
VALUES (128,'Zhang','Computer Science',102),
        (12345,'Mu','Computer Science',30),
        (15637,'Jafar','Computer Science',26),
        (21478,'Feud','History',94),
        (35416,'Rangf','Computer Science',62),
        (44215,'John','History',80),
        (98214,'Ali','Computer Science',74),
        (98564,'Zill','Finance',84);
        
-- answer for 4
-- answer to sub question 1
-- names of instructors in the history department
SELECT instructor_id,instructor_name FROM instructor WHERE department_name = 'History';

-- answer to subquestion 2
-- instruvtor id and department name associated with a department where budget is greater than 95000
SELECT instructor_id, instructor_name, instructor.department_name FROM Instructor 
INNER JOIN Department ON Instructor.Department_Name=Department.Department_Name WHERE Budget>95000;

-- answer to subquestion 3
-- names of all instructors in Comp. Sci department with the course titles of all courses they teach
SELECT instructor.instructor_name, course.course_title FROM teaches
JOIN course ON teaches.course_id = course.course_id
JOIN instructor ON teaches.instructor_id = instructor.instructor_id
WHERE course.department_name = 'Computer Science';

-- answer to sub question 4
-- names of student who have taken the course title of "Game Design"
-- incorrect answer
SELECT student_name FROM student WHERE department_name = 'Computer Science';

-- answer to subquestion 5
-- for each department, find the max salary
SELECT department_name, MAX(salary) FROM instructor
GROUP BY department_name;

-- answer to subquestion 6
-- find the lowest across all department among the max salary
SELECT department_name, salary FROM instructor
WHERE salary IN (
		SELECT MAX(salary)
		FROM instructor
		GROUP BY department_name
	)
ORDER BY salary
LIMIT 1;

-- answer to subquestion 7
-- find id and advisor of student whodonot have an advisor
-- couldnt find solution