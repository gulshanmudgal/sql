-- Retrieve all records from the Invoice table
SELECT * FROM Invoice;

-- Retrieve specific columns from the Invoice table and order by Total(by deafault ascending)
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
ORDER BY Total;

-- Retrieve specific columns from the Invoice table and order by Total in descending order
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
ORDER BY Total DESC;


-- Retrieve specific columns from the Invoice table where Total is greater than 10.0 and order by Total in descending order
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
WHERE Total > 10.0
ORDER BY Total DESC;

-- Retrieve specific columns from the Invoice table where Total is between 10.91 and 13.86 and order by Total in ascending order
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
WHERE Total
BETWEEN 10.91
AND 13.86
ORDER BY Total ASC;

-- Retrieve specific columns from the Invoice table where Total is greater than or equal to 10.91 and less than or equal to 13.86 and order by Total in ascending order
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
WHERE Total >= 10.91
AND Total <= 13.86
ORDER BY Total ASC;

-- Retrieve specific columns from the Invoice table where InvoiceDate is between '2021-01-01' and '2021-12-31' and order by InvoiceDate
SELECT InvoiceId
    , InvoiceDate
    , Total
FROM Invoice
WHERE InvoiceDate
BETWEEN '2021-01-01'
AND '2021-12-31'
ORDER BY InvoiceDate;

-- Use a calculated value with an alias 
-- can use *, /, +, - operators
SELECT InvoiceId
    , UnitPrice
    , Quantity
    , UnitPrice * Quantity as Total
    -- , Total = UnitPrice * Quantity -- This also works as alias
FROM InvoiceLine

-- String Concatenation
SELECT EmployeeId
    , FirstName
    , LastName
    , FirstName + ' ' + LastName AS FullName
    , Title
FROM EMPLOYEE
ORDER BY LastName

-- Using Left
SELECT EmployeeId
    , FirstName
    , LastName
    , LEFT(FirstName, 1) + '. ' + LastName AS ShortName
    , Title
FROM EMPLOYEE

-- Using Date Functions: Convert, GetDate, DateDiff
SELECT EmployeeId
    , FirstName
    , LastName
    , CONVERT(varchar(10), BirthDate, 10) AS BirthDate
    , DateDiff(year, BirthDate, GETDATE()) AS Age
    , Title
FROM EMPLOYEE

-- Distinct
SELECT DISTINCT BillingCity
FROM Invoice
ORDER BY BillingCity;

-- This will return multiple rows for each BillingCity if there are multiple InvoiceId in that city
SELECT DISTINCT BillingCity, InvoiceId
FROM Invoice
ORDER BY BillingCity;

-- TOP
SELECT TOP 10 InvoiceId, Total
FROM Invoice
ORDER BY Total DESC;

-- Comparison Operators: =, <>, !=, >, <, >=, <=
-- = Equal To
-- <> and != both mean NOT EQUAL TO
-- IS NULL and IS NOT NULL
-- > Greater Than
-- < Less Than
-- >= Greater Than or Equal To
-- <= Less Than or Equal To
-- IN (value1, value2, ...)
SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
AND (BillingState = 'AZ'
OR BillingState > 'B')
AND Total > 4
ORDER BY BillingState;

SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState IN ('AZ', 'CA', 'NY')
ORDER BY BillingState;

-- LIKE Phrase
-- % wildcard for zero or more characters
-- _ wildcard for a single character
-- [] single character within a range or set
-- [^] single character not within a range or set
-- [!] single character not within a range or set (works in SQL Server, not in other DBMS)
-- [ - ] range of characters
SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE 'N%'
ORDER BY BillingState;

SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE '_Y%'
ORDER BY BillingState;

SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE 'N[A-Z]%'
ORDER BY BillingState;

-- More About ORDER BY
-- FETCH and OFFSET
SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
ORDER BY BillingState
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY;

SELECT InvoiceId
    , Total
    , InvoiceDate
    , BillingCity
    , BillingState
FROM Invoice
WHERE BillingCity IS NOT NULL
ORDER BY BillingState
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;