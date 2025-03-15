-- Preview Customers table
select 
	sc.CustomerID		as CustomerID
	,sc.PersonID		as PersonID
	,sc.StoreID			as StoreID
	,sc.TerritoryID		as TerritoryID 
	,pp.PersonType		as PType
	,pp.FirstName		as FirstName
	,pp.LastName		as LastName
	,ss.Name			as CompanyName
from Sales.Customer sc
left join Person.Person pp
	on pp.BusinessEntityID = sc.PersonID
left join Sales.Store ss
	on ss.BusinessEntityID = sc.StoreID

-- Creating Customers table
CREATE TABLE dim_Customers (
    CustomerID   INT PRIMARY KEY,
    PersonID     INT NULL,
    StoreID      INT NULL,
    TerritoryID  INT NULL,
    PType        NVARCHAR(10) NULL,
    FirstName    NVARCHAR(50) NULL,
    LastName     NVARCHAR(50) NULL,
    CompanyName  NVARCHAR(100) NULL
);

-- Inserting data into Customers table
INSERT INTO dim_Customers (CustomerID, PersonID, StoreID, TerritoryID, PType, FirstName, LastName, CompanyName)
SELECT 
    sc.CustomerID, 
    sc.PersonID, 
    sc.StoreID, 
    sc.TerritoryID, 
    pp.PersonType, 
    pp.FirstName, 
    pp.LastName, 
    ss.Name
FROM Sales.Customer sc
LEFT JOIN Person.Person pp ON pp.BusinessEntityID = sc.PersonID
LEFT JOIN Sales.Store ss ON ss.BusinessEntityID = sc.StoreID;


