CREATE DATABASE company;
USE company;

CREATE TABLE employee (
    Fname VARCHAR(50),
    Minit CHAR(1),
    Lname VARCHAR(50),
    Ssn CHAR(9) PRIMARY KEY,
    Bdate DATE,
    Address VARCHAR(100),
    Sex CHAR(1),
    Salary DECIMAL(10, 2),
    Super_ssn CHAR(9),
    Dno INT
);

ALTER TABLE employee
ADD CONSTRAINT fk_super_ssn FOREIGN KEY (Super_ssn) REFERENCES employee(Ssn);

ALTER TABLE employee
ADD CONSTRAINT fk_dno FOREIGN KEY (Dno) REFERENCES department(Dnumber);

-- Tabela DEPARTMENT
CREATE TABLE department (
    Dname VARCHAR(50),
    Dnumber INT PRIMARY KEY,
    Mgr_ssn CHAR(9),
    Mgr_start_date DATE,
    FOREIGN KEY (Mgr_ssn) REFERENCES employee(Ssn)
);

-- Tabela DEPT_LOCATIONS
CREATE TABLE dept_locations (
    Dnumber INT,
    Dlocation VARCHAR(50),
    PRIMARY KEY (Dnumber, Dlocation),
    FOREIGN KEY (Dnumber) REFERENCES department(Dnumber)
);

-- Tabela PROJECT
CREATE TABLE project (
    Pname VARCHAR(50),
    Pnumber INT PRIMARY KEY,
    Plocation VARCHAR(50),
    Dnum INT,
    FOREIGN KEY (Dnum) REFERENCES department(Dnumber)
);

-- Tabela WORKS_ON
CREATE TABLE works_on (
    Essn CHAR(9),
    Pno INT,
    Hours DECIMAL(4, 2),
    PRIMARY KEY (Essn, Pno),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn),
    FOREIGN KEY (Pno) REFERENCES project(Pnumber)
);

-- Tabela DEPENDENT
CREATE TABLE dependent (
    Essn CHAR(9),
    Dependent_name VARCHAR(50),
    Sex CHAR(1),
    Bdate DATE,
    Relationship VARCHAR(25),
    PRIMARY KEY (Essn, Dependent_name),
    FOREIGN KEY (Essn) REFERENCES employee(Ssn)
);

-- Inserindo dados na tabela DEPARTMENT
-- Inserir departamentos com Mgr_ssn já existente
INSERT INTO department (Dname, Dnumber, Mgr_ssn, Mgr_start_date)
VALUES
    ('Finance', 1, '123456789', '2020-01-01'),
    ('HR', 2, '234567890', '2021-06-01'),
    ('IT', 3, '345678901', '2022-09-15');


-- Inserindo dados na tabela EMPLOYEE
INSERT INTO employee (Fname, Minit, Lname, Ssn, Bdate, Address, Sex, Salary, Super_ssn)
VALUES
    ('John', 'A', 'Doe', '123456789', '1980-03-15', '123 Elm St', 'M', 60000.00, NULL),
    ('Jane', 'B', 'Smith', '234567890', '1985-07-22', '456 Oak St', 'F', 55000.00, '123456789'),
    ('Tom', 'C', 'Jones', '345678901', '1990-11-10', '789 Pine St', 'M', 70000.00, '123456789');

-- Atualizando o Dno dos funcionários de acordo com os departamentos
UPDATE employee
SET Dno = 1
WHERE Ssn = '123456789';

UPDATE employee
SET Dno = 2
WHERE Ssn = '234567890';

UPDATE employee
SET Dno = 3
WHERE Ssn = '345678901';

-- Inserindo dados na tabela DEPT_LOCATIONS
INSERT INTO dept_locations (Dnumber, Dlocation)
VALUES 
(1, 'New York'),
(2, 'Los Angeles'),
(3, 'Chicago'),
(1, 'Boston');

-- Inserindo dados na tabela PROJECT
INSERT INTO project (Pname, Pnumber, Plocation, Dnum)
VALUES
('Project Alpha', 101, 'New York', 1),
('Project Beta', 102, 'Los Angeles', 2),
('Project Gamma', 103, 'Chicago', 3);

-- Inserindo dados na tabela WORKS_ON
INSERT INTO works_on (Essn, Pno, Hours)
VALUES
('123456789', 101, 40.0),
('234567890', 102, 35.0),
('345678901', 103, 10.0);

-- Inserindo dados na tabela DEPENDENT
INSERT INTO dependent (Essn, Dependent_name, Sex, Bdate, Relationship)
VALUES
('123456789', 'Chris Doe', 'M', '2015-05-10', 'Son'),
('345678901', 'Alex Smith', 'F', '2018-09-25', 'Daughter'),
('234567890', 'Taylor Johnson', 'M', '2012-12-14', 'Spouse');


CREATE INDEX idx_employee_dno ON employee(Dno);

SELECT Dno, COUNT(*) AS num_employees
FROM employee
GROUP BY Dno
ORDER BY num_employees DESC
LIMIT 1;

CREATE INDEX idx_employee_address ON employee(Address);

SELECT d.Dname, e.Address
FROM department d
JOIN employee e ON d.Dnumber = e.Dno
ORDER BY e.Address;
