# AdventureWorks 2019 v2 – Power BI Dashboard

## Introduction

This dashboard presents the overall performance of AdventureWorks 2019, a sample database provided by Microsoft. It enables users to analyze how the company evolved between June 2012 and June 2014, focusing on key performance indicators (KPIs).

Using various DAX measures, users can analyze the distribution of KPIs by month and region, and assess performance from different perspectives, such as previous month, quarter-to-date, or year-over-year. Additionally, sales data is presented in three perspectives: top 5 customers, sales by category and subcategory, and employee performance.

The data from the AdventureWorks 2019 database was first transformed using SQL in Microsoft SQL Server Management Studio (SSMS) and then imported into Power BI. The visualizations are powered by DAX-based measures.

## Project Creation Steps

- Step 1: Download the dataset (.bak file) from the official Microsoft website:
  https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms

- Step 2: Restore the database in SQL Server Management Studio according to Microsoft’s instructions.

- Step 3: Create fact tables using SQL.
  Fact tables are used to aggregate sales and order data. In this project, the fact_SaleDetail table was created based on SalesOrderDetail and SalesOrderHeader tables.
  Columns such as NettAmount, TaxAmt, Freight, and GrossAmount were calculated using proportional distribution, as shown below (SQL scripts included in the project):

        -- NettAmount
        sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount) AS NettAmount,

        -- TaxAmt
        (soh.TaxAmt * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
        NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
                FROM Sales.SalesOrderDetail 
                WHERE SalesOrderID = sod.SalesOrderID), 0)) AS TaxAmt,

        -- Freight
        (soh.Freight * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
        NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
                FROM Sales.SalesOrderDetail 
                WHERE SalesOrderID = sod.SalesOrderID), 0)) AS Freight,

        -- GrossAmount
        (soh.TotalDue * (sod.OrderQty * (sod.UnitPrice - sod.UnitPriceDiscount)) / 
        NULLIF((SELECT SUM(OrderQty * (UnitPrice - UnitPriceDiscount)) 
                FROM Sales.SalesOrderDetail 
                WHERE SalesOrderID = sod.SalesOrderID), 0)) AS GrossAmount

- Step 4: Create dimension tables.
  Dimension tables were created for customers, employees, products, categories, and subcategories.
  Additionally, a calendar table was created using SQL date functions (SQL scripts included in the project).

- Step 5: Import data from SQL Server to Power BI using the SQL Server connector and select the appropriate views or tables.

- Step 6: Transform data in Power Query. Mark the calendar table as the official date table.

- Step 7: Create DAX measures to display insights using Power BI visualizations.
  Measures were created for KPIs over time, customer segmentation, product analysis, and employee performance.
  External tools such as DAX Studio and Tabular Editor were used to optimize and organize the measures.

- Step 8: Build the dashboard.
  DAX measures were matched with appropriate visualizations to best illustrate the results.
  The dashboard background was designed using Figma.

## Dashboard Structure

The dashboard includes visualizations for:

- KPIs: revenue, orders, gross profit, costs, net profit, and margin.
  All KPIs can be analyzed for a selected month as total value, average, or percentage change from the previous month.

- KPIs over time:
  Selected KPIs are shown in a line chart (YTD perspective) and matrix with values divided by region in five time perspectives:
    - QTD – quarter-to-date
    - YTD – year-to-date
    - PY – previous year (same month)
    - YoY – year-over-year (absolute difference)
    - YoY% – year-over-year percentage change

- Top 5 Customers: sales results for the top 5 customers by selected month and region.

- Sales by Category/Subcategory: analysis of sales by product categories and subcategories.

- Best Sales Employees: performance of sales employees by total sales amount and share in overall sales.

All visualizations allow selection of month and region to dynamically adjust displayed results.

## Report Snapshot (Power BI Desktop)

![Image](https://github.com/user-attachments/assets/9d356a38-6583-4f9c-82f5-6ceb28a4311c)

## Summary

This project can be used to analyze key account KPIs and support strategic business planning. Based on the presented data, users can better understand sales performance drivers and their impact in previous periods. The dashboard also serves as a visually engaging way to present insights to stakeholders.
