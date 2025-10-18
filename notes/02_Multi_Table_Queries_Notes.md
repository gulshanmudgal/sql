# Multi Table Queries Notes

This document provides detailed explanations and notes for the multi-table queries in `02_Multi_Table_Queries.sql`. These queries demonstrate how to combine data from multiple tables using various join operations and set operations in SQL Server using the Chinook database schema.

## Table of Contents

- [Inner Joins](#inner-joins)
- [Self Joins](#self-joins)
- [Cross Joins](#cross-joins)
- [Outer Joins](#outer-joins)
- [Union Operations](#union-operations)
- [Set Operations (EXCEPT and INTERSECT)](#set-operations-except-and-intersect)

## Inner Joins

Inner joins return only the rows where there is a match in both tables based on the join condition.

### Basic Inner Join
```sql
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
```
- Joins Customer and Invoice tables on CustomerId
- Uses table aliases (c and i) for clarity
- Filters for invoices with Total > 10
- Orders by Total in descending order
- Only returns customers who have invoices

## Self Joins

Self joins are used when a table needs to be joined with itself, typically to find relationships within the same table.

### Employee Reporting Structure
```sql
SELECT e1.EmployeeId
    , e1.FirstName + ' ' + e1.LastName AS EmployeeName
    , e2.FirstName + ' ' + e2.LastName AS ReportsToName
FROM Employee AS e1
LEFT JOIN Employee AS e2
ON e1.ReportsTo = e2.EmployeeId
ORDER BY e1.EmployeeId;
```
- Uses LEFT JOIN to include employees who don't report to anyone
- e1 represents employees, e2 represents their managers
- Shows the hierarchical reporting structure

### Finding Customers in Same Location
```sql
SELECT c1.FirstName + ' ' + c1.LastName AS CustomerName
    , c1.City
    , c1.[State]
FROM Customer c1
JOIN Customer c2
on c1.[State] = c2.[State]
AND c1.City = c2.City
AND c1.CustomerId <> c2.CustomerId
ORDER BY c1.[State], c1.City;
```
- Finds customers who live in the same city and state
- Uses self-join with different aliases (c1, c2)
- Excludes self-matches with `c1.CustomerId <> c2.CustomerId`

## Cross Joins

Cross joins return the Cartesian product of two tables - every row from the first table combined with every row from the second table.

```sql
SELECT c1.FirstName
    , c2.LastName
FROM Customer AS c1
CROSS JOIN Customer AS c2
```
- Creates all possible combinations of first names and last names
- Can result in very large result sets
- Rarely used in practice without filtering

## Outer Joins

Outer joins return all rows from one table and matching rows from the other table. Non-matching rows contain NULL values.

### Left Outer Join
```sql
SELECT c.FirstName + ' ' + c.LastName AS CustomerName
    , e.FirstName + ' ' + e.LastName AS EmployeeName
FROM Customer AS c
LEFT JOIN Employee AS e
on c.SupportRepId = e.EmployeeId
```
- Returns all customers, even those without a support representative
- Employees who don't support any customers won't appear
- Useful for finding customers without assigned support reps

## Union Operations

UNION combines the results of two or more SELECT statements into a single result set.

```sql
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
```
- Combines customer and employee contact information
- Adds a status column to distinguish between customers and employees
- Automatically removes duplicate rows
- Column data types must be compatible between SELECT statements

## Set Operations (EXCEPT and INTERSECT)

### EXCEPT
Returns rows from the first query that are not in the second query.

```sql
SELECT FirstName
    , LastName
    , Email
FROM Customer
EXCEPT
SELECT FirstName
    , LastName
    , Email
FROM Employee
```
- Returns customers whose name/email combinations don't match any employees
- Useful for finding unique records in one table

### INTERSECT
Returns rows that appear in both queries.

```sql
SELECT FirstName
    , LastName
    , Email
FROM Customer
INTERSECT
SELECT FirstName
    , LastName
    , Email
FROM Employee
```
- Returns customers and employees who have identical name/email combinations
- Useful for finding overlapping data between tables