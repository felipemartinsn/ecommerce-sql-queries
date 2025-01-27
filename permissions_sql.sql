
GRANT SELECT ON EmployeesPerDeptAndLocation TO 'manager_user'@'localhost';
GRANT SELECT ON DepartmentsAndManagers TO 'manager_user'@'localhost';
GRANT SELECT ON ProjectsDepartmentsManagers TO 'manager_user'@'localhost';

GRANT SELECT ON ProjectsByEmployeeCount TO 'employee_user'@'localhost';
GRANT SELECT ON EmployeesWithDependents TO 'employee_user'@'localhost';
