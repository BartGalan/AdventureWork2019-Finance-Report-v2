-- Preview Product Subcategories table
select 
	ps.ProductSubcategoryID AS SubcategoryID,
	ps.Name					AS SubcategoryName,
	ps.ProductCategoryID	AS CategoryID
from Production.ProductSubcategory ps

-- Creating Product Subcategories table
CREATE TABLE dim_ProductSubcategories (
    SubcategoryID   INT PRIMARY KEY,
    SubcategoryName NVARCHAR(100) NOT NULL,
    CategoryID      INT NOT NULL
);

-- Inserting data into Product Subcategories table
INSERT INTO dim_ProductSubcategories (SubcategoryID, SubcategoryName, CategoryID)
SELECT 
    ps.ProductSubcategoryID AS SubcategoryID,
    ps.Name AS SubcategoryName,
    ps.ProductCategoryID AS CategoryID
FROM Production.ProductSubcategory ps;

