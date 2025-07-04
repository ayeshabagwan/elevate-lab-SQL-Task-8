--  1. Create a NEW database and use it
CREATE DATABASE IF NOT EXISTS employee_management;
USE employee_management;

--  2. Create the employee table
DROP TABLE IF EXISTS employee;

CREATE TABLE employee (
    empID INT AUTO_INCREMENT PRIMARY KEY,
    empName VARCHAR(100)
);

--  3. Insert sample data
INSERT INTO employee (empName) VALUES
('Ayesha Sameer Bagwan'),
('Uzma Raja Chaudhary');

--  4. Create a stored procedure to add a new employee
DELIMITER $$

CREATE PROCEDURE ADDEMPLOYEE(
    IN p_empName VARCHAR(100)
)
BEGIN
    INSERT INTO employee (empName) VALUES (p_empName);
END $$

DELIMITER ;

--  5. Call the stored procedure
CALL ADDEMPLOYEE('Asma Sameer Bagwan');
CALL ADDEMPLOYEE('Sakina Sameer Bagwan');
-- 🔹 6. View all employee data
SELECT * FROM employee;
ALTER TABLE employee
ADD COLUMN salary DECIMAL(10,2);

UPDATE employee
SET salary = 35000
WHERE empID = 1;

UPDATE employee
SET salary = 42000
WHERE empID = 2;

UPDATE employee
SET salary = 78000
WHERE empID = 3;

UPDATE employee
SET salary = 78090
WHERE empID = 4;
--  Task 2: Create a simple function (Calculate yearly salary)

DELIMITER $$

CREATE FUNCTION GetYearlySalary(p_empID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE yearly_salary DECIMAL(10,2);
    SELECT salary * 12 INTO yearly_salary
    FROM employee
    WHERE empID = p_empID;
    RETURN yearly_salary;
END $$

DELIMITER ;


SELECT GetYearlySalary(1);
DROP FUNCTION IF EXISTS GetYearlySalary;

DELIMITER $$

CREATE FUNCTION GetYearlySalary(p_empID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE yearly_salary DECIMAL(10,2);
    SELECT salary * 12 INTO yearly_salary
    FROM employee
    WHERE empID = p_empID;
    RETURN yearly_salary;
END $$

DELIMITER ;

SELECT GetYSalary(1);
 -- 3: Procedure with IF...ELSE condition
DELIMITER $$

CREATE PROCEDURE CheckS(
    IN p_empID INT,
    OUT result VARCHAR(50)
)
BEGIN
    DECLARE emp_salary DECIMAL(10,2);

    SELECT salary 
    INTO emp_salary 
    FROM employee 
    WHERE empID = p_empID
    LIMIT 1; 

    IF emp_salary > 50000 THEN
        SET result = 'High salary';
    ELSE
        SET result = 'Moderate salary';
    END IF;
END $$

DELIMITER ;
CALL CheckS(3, @output);
SELECT @output;
-- 4: Procedure with LOOP
DELIMITER $$

CREATE PROCEDURE PrintNumbers()
BEGIN
    DECLARE i INT DEFAULT 1;
    my_loop: LOOP
        IF i > 5 THEN
            LEAVE my_loop;
        END IF;
        SELECT i;
        SET i = i + 1;
    END LOOP;
END $$

DELIMITER ;

-- CALL:
CALL PrintNumbers();

-- 5 function to check bonus eligiblity
DELIMITER $$

CREATE FUNCTION CheckBonus(salary DECIMAL(10,2))
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    IF salary >= 50000 THEN
        RETURN 'Eligible';
    ELSE
        RETURN 'Not Eligible';
    END IF;
END $$

DELIMITER ;

-- Test:
SELECT empName, CheckBonus(salary) AS bonus_status FROM employee;

