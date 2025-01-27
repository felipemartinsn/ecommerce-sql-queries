CREATE VIEW EmployeesPerDeptAndLocation AS
SELECT 
    d.Dname AS DepartmentName,
    dl.Dlocation AS Location,
    COUNT(e.Ssn) AS NumberOfEmployees
FROM 
    employee e
JOIN 
    department d ON e.Dno = d.Dnumber
JOIN 
    dept_locations dl ON d.Dnumber = dl.Dnumber
GROUP BY 
    d.Dname, dl.Dlocation;

CREATE VIEW DepartmentsAndManagers AS
SELECT 
    d.Dname AS DepartmentName,
    e.Fname AS ManagerFirstName,
    e.Lname AS ManagerLastName,
    e.Salary AS ManagerSalary
FROM 
    department d
JOIN 
    employee e ON d.Mgr_ssn = e.Ssn;

CREATE VIEW ProjectsByEmployeeCount AS
SELECT 
    p.Pname AS ProjectName,
    COUNT(w.Essn) AS NumberOfEmployees
FROM 
    project p
LEFT JOIN 
    works_on w ON p.Pnumber = w.Pno
GROUP BY 
    p.Pname
ORDER BY 
    NumberOfEmployees DESC;

CREATE VIEW ProjectsDepartmentsManagers AS
SELECT 
    p.Pname AS ProjectName,
    d.Dname AS DepartmentName,
    e.Fname AS ManagerFirstName,
    e.Lname AS ManagerLastName
FROM 
    project p
JOIN 
    department d ON p.Dnum = d.Dnumber
JOIN 
    employee e ON d.Mgr_ssn = e.Ssn;

CREATE VIEW EmployeesWithDependents AS
SELECT 
    e.Fname AS EmployeeFirstName,
    e.Lname AS EmployeeLastName,
    d.Dependent_name AS DependentName,
    d.Relationship AS Relationship,
    CASE 
        WHEN e.Ssn IN (SELECT Mgr_ssn FROM department) THEN 'Yes'
        ELSE 'No'
    END AS IsManager
FROM 
    employee e
LEFT JOIN 
    dependent d ON e.Ssn = d.Essn;

