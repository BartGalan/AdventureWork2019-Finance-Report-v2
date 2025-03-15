-- Preview Territories table
SELECT 
    TerritoryID,
    [Name] AS TerritoryName,
    CountryRegionCode,
    [Group] AS TerritoryGroup
FROM Sales.SalesTerritory;

-- Creating Territories table
CREATE TABLE dim_Territories (
    TerritoryID        INT PRIMARY KEY,
    TerritoryName      NVARCHAR(100) NOT NULL,
    CountryRegionCode  NVARCHAR(3) NOT NULL,
    TerritoryGroup     NVARCHAR(50) NULL
);

-- Inserting data into Territories table
INSERT INTO dim_Territories (TerritoryID, TerritoryName, CountryRegionCode, TerritoryGroup)
SELECT 
    st.TerritoryID,
    st.Name AS TerritoryName,
    st.CountryRegionCode,
    st.[Group] AS TerritoryGroup
FROM Sales.SalesTerritory st;



