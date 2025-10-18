USE Chinook;

SELECT CustomerId
    , FirstName
    , LastName
FROM Customer

SELECT InvoiceId
    , CustomerId
    , InvoiceDate
    , Total
FROM Invoice

SELECT InvoiceId
    , c.CustomerId
    , FirstName
    , LastName
    , CONVERT(nvarchar(20), InvoiceDate, 101) AS InvoiceDate
    , Total
FROM Customer AS c
JOIN Invoice AS i
ON c.CustomerId = i.CustomerId
WHERE Total > 10
ORDER BY Total DESC;

-- Self Join
SELECT e1.EmployeeId
    , e1.FirstName + ' ' + e1.LastName AS EmployeeName
    , e2.FirstName + ' ' + e2.LastName AS ReportsToName
FROM Employee AS e1
LEFT JOIN Employee AS e2
ON e1.ReportsTo = e2.EmployeeId
ORDER BY e1.EmployeeId;

-- another exaple
SELECT c1.FirstName + ' ' + c1.LastName AS CustomerName
    , c1.City
    , c1.[State]
FROM Customer c1
JOIN Customer c2
on c1.[State] = c2.[State]
AND c1.City = c2.City
AND c1.CustomerId <> c2.CustomerId
ORDER BY c1.[State], c1.City;

-- Cross Join
SELECT c1.FirstName
    , c2.LastName
FROM Customer AS c1
CROSS JOIN Customer AS c2

-- Outer Join
-- (LEFT|RIGHT|FULL) JOIN

SELECT c.FirstName + ' ' + c.LastName AS CustomerName
    , e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Customer AS c
LEFT JOIN Employee AS e
on c.SupportRepId = e.EmployeeId

-- Unions
SELECT FirstName
    , LastName
    , Email
    , 'Customer' AS [Status]
FROM Customer
UNION
SELECT FirstName
    , LastName
    , Email
    , 'Employee' AS [Status]
FROM Employee

/*
    Except and Intersect
*/
SELECT FirstName
    , LastName
    , Email
FROM Customer
EXCEPT
SELECT FirstName
    , LastName
    , Email
FROM Employee

SELECT FirstName
    , LastName
    , Email
FROM Customer
INTERSECT
SELECT FirstName
    , LastName
    , Email
FROM Employee