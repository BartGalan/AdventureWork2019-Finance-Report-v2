-- Preview Employees table
SELECT 
    e.BusinessEntityID AS EmployeeID,
    p.FirstName,
    p.LastName,
    p.MiddleName,
    e.JobTitle,
    d.Name AS DepartmentName,
    sh.Name AS ShiftName,
    e.HireDate,
    e.BirthDate
FROM HumanResources.Employee e
JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d
    ON edh.DepartmentID = d.DepartmentID
JOIN HumanResources.Shift sh
    ON edh.ShiftID = sh.ShiftID
WHERE edh.EndDate IS NULL;

-- Creating Employees table
CREATE TABLE dim_Employees (
    EmployeeID      INT PRIMARY KEY,
    FirstName       NVARCHAR(50) NOT NULL,
    LastName        NVARCHAR(50) NOT NULL,
    MiddleName      NVARCHAR(50) NULL,
    JobTitle        NVARCHAR(100) NOT NULL,
    DepartmentName  NVARCHAR(100) NOT NULL,
    ShiftName       NVARCHAR(50) NOT NULL,
    HireDate        DATE NOT NULL,
    BirthDate       DATE NOT NULL
);

-- Inserting data into Employees table
INSERT INTO dim_Employees (EmployeeID, FirstName, LastName, MiddleName, JobTitle, DepartmentName, ShiftName, HireDate, BirthDate)
SELECT 
    e.BusinessEntityID AS EmployeeID,
    p.FirstName,
    p.LastName,
    p.MiddleName,
    e.JobTitle,
    d.Name AS DepartmentName,
    sh.Name AS ShiftName,
    e.HireDate,
    e.BirthDate
FROM HumanResources.Employee e
JOIN Person.Person p
    ON e.BusinessEntityID = p.BusinessEntityID
JOIN HumanResources.EmployeeDepartmentHistory edh
    ON e.BusinessEntityID = edh.BusinessEntityID
JOIN HumanResources.Department d
    ON edh.DepartmentID = d.DepartmentID
JOIN HumanResources.Shift sh
    ON edh.ShiftID = sh.ShiftID
WHERE edh.EndDate IS NULL;

