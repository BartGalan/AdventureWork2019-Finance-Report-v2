-- Preview Products table
SELECT 
    p.ProductID,
    p.Name					AS ProductName,
    p.ProductNumber,
    p.Color,
    p.StandardCost,
    p.ListPrice,
    p.Size,
    p.Weight,
	p.ProductSubcategoryID	AS SubcategoryID,
	p.ProductModelID		AS ModelID
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory sc
    ON p.ProductSubcategoryID = sc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c
    ON sc.ProductCategoryID = c.ProductCategoryID;

-- Creating Products table
CREATE TABLE dim_Products (
    ProductID        INT PRIMARY KEY,
    ProductName      NVARCHAR(100) NOT NULL,
    ProductNumber    NVARCHAR(25) NOT NULL,
    Color           NVARCHAR(15) NULL,
    StandardCost     DECIMAL(19,4) NOT NULL,
    ListPrice        DECIMAL(19,4) NOT NULL,
    Size            NVARCHAR(10) NULL,
    Weight          DECIMAL(19,4) NULL,
    SubcategoryID    INT NULL,
    ModelID          INT NULL
);

-- Inserting data into Products table
INSERT INTO dim_Products (ProductID, ProductName, ProductNumber, Color, StandardCost, ListPrice, Size, Weight, SubcategoryID, ModelID)
SELECT 
    p.ProductID,
    p.Name AS ProductName,
    p.ProductNumber,
    p.Color,
    p.StandardCost,
    p.ListPrice,
    p.Size,
    p.Weight,
    p.ProductSubcategoryID AS SubcategoryID,
    p.ProductModelID AS ModelID
FROM Production.Product p
LEFT JOIN Production.ProductSubcategory sc
    ON p.ProductSubcategoryID = sc.ProductSubcategoryID
LEFT JOIN Production.ProductCategory c
    ON sc.ProductCategoryID = c.ProductCategoryID;

