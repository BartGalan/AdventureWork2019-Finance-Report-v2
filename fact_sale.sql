-- Creating the SaleDetail table
CREATE TABLE fact_SaleDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT NOT NULL,
    OrderDate DATE NOT NULL,
    DueDate DATE NOT NULL,
    ShipDate DATE NULL,
    CustomerID INT NOT NULL,
    TerritoryID INT NULL,
    ProductID INT NOT NULL,
    SpecialOfferID INT NOT NULL, 
    SalesPersonID INT NULL,
    ShipMethodID INT NOT NULL,
    CurrencyRateID INT NULL,
    OrderQty INT NOT NULL,
    UnitPrice DECIMAL(19,4) NOT NULL,
    UnitPriceDiscount DECIMAL(19,4) NOT NULL,
    NettAmount DECIMAL(19,4) NOT NULL, -- OrderQty * (UnitPrice - Discount)
    TaxAmt DECIMAL(19,4) NOT NULL,  -- Proportional distribution TaxAmt
    Freight DECIMAL(19,4) NOT NULL, -- Proportional distribution Freight
    GrossAmount DECIMAL(19,4) NOT NULL, -- Proportional distribution GrossAmount
);

-- Inserting data into SaleDetail table
INSERT INTO fact_SaleDetail (
    SalesOrderID, SalesOrderDetailID, OrderDate, DueDate, ShipDate, 
    CustomerID, TerritoryID, ProductID, SpecialOfferID, SalesPersonID, ShipMethodID, CurrencyRateID, 
    OrderQty, UnitPrice, UnitPriceDiscount, NettAmount, TaxAmt, Freight, GrossAmount
)
SELECT 
    sod.SalesOrderID,
    sod.SalesOrderDetailID,
    soh.OrderDate,
    soh.DueDate,
    soh.ShipDate,
    soh.CustomerID,
    soh.TerritoryID,
    sod.ProductID,
    sod.SpecialOfferID,
    soh.SalesPersonID,
    soh.ShipMethodID,
    soh.CurrencyRateID,
    sod.OrderQty,
    sod.UnitPrice,
    sod.UnitPriceDiscount,
    sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount) AS NettAmount,
    
    -- Proportional distribution TaxAmt
    (soh.TaxAmt * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
      NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
              FROM Sales.SalesOrderDetail 
              WHERE SalesOrderID = sod.SalesOrderID), 0)) AS TaxAmt,
    
    -- Proportional distribution Freight
    (soh.Freight * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
      NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
              FROM Sales.SalesOrderDetail 
              WHERE SalesOrderID = sod.SalesOrderID), 0)) AS Freight,
    
    -- Proportional distribution GrossAmount
    (soh.TotalDue * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
      NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
              FROM Sales.SalesOrderDetail 
              WHERE SalesOrderID = sod.SalesOrderID), 0)) AS GrossAmount

FROM Sales.SalesOrderDetail sod
JOIN Sales.SalesOrderHeader soh ON soh.SalesOrderID = sod.SalesOrderID;


