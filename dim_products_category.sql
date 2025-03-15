-- Preview Product Categories table
SELECT 
    pc.ProductCategoryID,
    pc.Name AS CategoryName
FROM Production.ProductCategory pc
ORDER BY pc.ProductCategoryID

-- Creating Product Categories table
CREATE TABLE dim_ProductCategories (
    ProductCategoryID INT PRIMARY KEY,
    CategoryName      NVARCHAR(50) NOT NULL
);

--Inserting data into Product Categories table
INSERT INTO dim_ProductCategories (ProductCategoryID, CategoryName)
SELECT 
    pc.ProductCategoryID,
    pc.Name AS CategoryName
FROM Production.ProductCategory pc
ORDER BY pc.ProductCategoryID;

