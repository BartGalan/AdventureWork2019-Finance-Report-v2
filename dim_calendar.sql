-- Preview Calendar table
WITH DateTable AS (
    SELECT 
        CAST('2011-01-01' AS DATE) AS DateValue
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, DateValue)
    FROM DateTable
    WHERE DateValue < '2014-12-31'
)
SELECT 
    DateValue,
    YEAR(DateValue) AS YearNo,
    MONTH(DateValue) AS MonthNo,
    DATENAME(MONTH, DateValue) AS MonthName,
    LEFT(DATENAME(MONTH, DateValue), 3) AS MonthAbbr, -- Abbreviated name of the month
    CONCAT(LEFT(DATENAME(MONTH, DateValue), 3), ' ', YEAR(DateValue)) AS MonthYearFormatted, -- New column mmm yyyy
    DAY(DateValue) AS DayNo,
    DATENAME(WEEKDAY, DateValue) AS WeekDayName,
    DATEPART(WEEK, DateValue) AS WeekNumber,
    DATEPART(QUARTER, DateValue) AS QuarterNo,
    CONCAT(RIGHT('00' + CAST(MONTH(DateValue) AS VARCHAR(2)), 2), YEAR(DateValue)) AS MonthYear,
    CONCAT(RIGHT('00' + CAST(DATEPART(QUARTER, DateValue) AS VARCHAR(2)), 2), YEAR(DateValue)) AS QuarterYear
FROM DateTable
OPTION (MAXRECURSION 0);

-- Creating the Calendar table
CREATE TABLE dim_Calendar (
    DateValue     DATE PRIMARY KEY,
    YearNo        INT NOT NULL,
    MonthNo       INT NOT NULL,
    MonthName     NVARCHAR(20) NOT NULL,
    DayNo         INT NOT NULL,
    WeekDayName   NVARCHAR(20) NOT NULL,
    WeekNumber    INT NOT NULL,
    QuarterNo     INT NOT NULL,
    MonthYear     CHAR(6) NOT NULL,
    QuarterYear   CHAR(6) NOT NULL
);

-- Updating Calendar table with new columns
ALTER TABLE dim_Calendar
ADD MonthAbbr CHAR(3) NOT NULL,
    MonthYearFormatted NVARCHAR(10) NOT NULL;


-- Inserting data into Calendar table
WITH DateTable AS (
    SELECT 
        CAST('2011-01-01' AS DATE) AS DateValue
    UNION ALL
    SELECT 
        DATEADD(DAY, 1, DateValue)
    FROM DateTable
    WHERE DateValue < '2014-12-31'
)
INSERT INTO dim_Calendar (
    DateValue, YearNo, MonthNo, MonthName, MonthAbbr, MonthYearFormatted, 
    DayNo, WeekDayName, WeekNumber, QuarterNo, MonthYear, QuarterYear
)
SELECT 
    DateValue,
    YEAR(DateValue) AS YearNo,
    MONTH(DateValue) AS MonthNo,
    DATENAME(MONTH, DateValue) AS MonthName,
    LEFT(DATENAME(MONTH, DateValue), 3) AS MonthAbbr, -- Month abbreviation (Jan, Feb, ...)
    CONCAT(LEFT(DATENAME(MONTH, DateValue), 3), ' ', YEAR(DateValue)) AS MonthYearFormatted, -- Format mmm yyyy (e.g. Jan 2013)
    DAY(DateValue) AS DayNo,
    DATENAME(WEEKDAY, DateValue) AS WeekDayName,
    DATEPART(WEEK, DateValue) AS WeekNumber,
    DATEPART(QUARTER, DateValue) AS QuarterNo,
    CONCAT(RIGHT('00' + CAST(MONTH(DateValue) AS VARCHAR(2)), 2), YEAR(DateValue)) AS MonthYear,
    CONCAT(RIGHT('00' + CAST(DATEPART(QUARTER, DateValue) AS VARCHAR(2)), 2), YEAR(DateValue)) AS QuarterYear
FROM DateTable
OPTION (MAXRECURSION 0);




