# Single Table Queries Notes

This document provides detailed explanations and notes for the single table queries in `01_Single_Table_Queries.sql`. These queries demonstrate fundamental SQL operations on individual tables using the Chinook database schema.

## Table of Contents

- [Basic SELECT Statements](#basic-select-statements)
- [Filtering with WHERE Clause](#filtering-with-where-clause)
- [Ordering Results](#ordering-results)
- [Aliases and Calculations](#aliases-and-calculations)
- [String Functions](#string-functions)
- [Date Functions](#date-functions)
- [DISTINCT Keyword](#distinct-keyword)
- [TOP Keyword](#top-keyword)
- [Comparison Operators](#comparison-operators)
- [LIKE Operator](#like-operator)
- [Pagination with OFFSET and FETCH](#pagination-with-offset-and-fetch)

## Basic SELECT Statements

### Retrieving All Records
```sql
SELECT * FROM Invoice;
```
- Uses `*` to select all columns from the Invoice table
- Returns all rows without any filtering or ordering
- Useful for exploring table structure and data

### Selecting Specific Columns
```sql
SELECT InvoiceId, InvoiceDate, Total FROM Invoice ORDER BY Total;
```
- Specifies exact columns to retrieve
- Orders results by Total in ascending order (default)
- More efficient than `SELECT *` when you don't need all columns

### Descending Order
```sql
SELECT InvoiceId, InvoiceDate, Total FROM Invoice ORDER BY Total DESC;
```
- Uses `DESC` keyword for descending order
- Shows highest totals first

## Filtering with WHERE Clause

### Simple Filtering
```sql
SELECT InvoiceId, InvoiceDate, Total FROM Invoice WHERE Total > 10.0 ORDER BY Total DESC;
```
- Filters records where Total is greater than 10.0
- Only returns matching rows

### BETWEEN Operator
```sql
SELECT InvoiceId, InvoiceDate, Total FROM Invoice WHERE Total BETWEEN 10.91 AND 13.86 ORDER BY Total ASC;
```
- Inclusive range filtering
- Equivalent to `Total >= 10.91 AND Total <= 13.86`

### Date Range Filtering
```sql
SELECT InvoiceId, InvoiceDate, Total FROM Invoice WHERE InvoiceDate BETWEEN '2021-01-01' AND '2021-12-31' ORDER BY InvoiceDate;
```
- Filters invoices from the year 2021
- Uses date literals in 'YYYY-MM-DD' format

## Aliases and Calculations

### Calculated Columns
```sql
SELECT InvoiceId, UnitPrice, Quantity, UnitPrice * Quantity AS Total FROM InvoiceLine;
```
- Creates a calculated column using arithmetic operators
- Uses `AS` keyword for column alias
- Makes results more readable

### String Concatenation
```sql
SELECT EmployeeId, FirstName, LastName, FirstName + ' ' + LastName AS FullName FROM Employee ORDER BY LastName;
```
- Combines multiple string columns
- Uses `+` operator for concatenation in SQL Server

## String Functions

### LEFT Function
```sql
SELECT EmployeeId, FirstName, LastName, LEFT(FirstName, 1) + '. ' + LastName AS ShortName FROM Employee;
```
- Extracts specified number of characters from the left
- Creates abbreviated names (e.g., "J. Doe")

## Date Functions

### Date Formatting and Calculations
```sql
SELECT EmployeeId, FirstName, LastName, CONVERT(varchar(10), BirthDate, 10) AS BirthDate, DATEDIFF(year, BirthDate, GETDATE()) AS Age FROM Employee;
```
- `CONVERT`: Formats dates (style 10 = 'DD-MM-YYYY')
- `GETDATE()`: Returns current date and time
- `DATEDIFF`: Calculates difference between dates in specified units

## DISTINCT Keyword

### Removing Duplicates
```sql
SELECT DISTINCT BillingCity FROM Invoice ORDER BY BillingCity;
```
- Returns unique values only
- Useful for getting a list of unique cities

### DISTINCT with Multiple Columns
```sql
SELECT DISTINCT BillingCity, InvoiceId FROM Invoice ORDER BY BillingCity;
```
- Returns unique combinations of specified columns
- May still show duplicates if other columns differ

## TOP Keyword

### Limiting Results
```sql
SELECT TOP 10 InvoiceId, Total FROM Invoice ORDER BY Total DESC;
```
- Returns only the first 10 rows
- Useful for getting top N results

## Comparison Operators

### Multiple Conditions
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
AND (BillingState = 'AZ' OR BillingState > 'B')
AND Total > 4
ORDER BY BillingState;
```
- `IS NOT NULL`: Checks for non-null values
- Logical operators: `AND`, `OR`
- Comparison operators: `=`, `>`, `<`

### IN Operator
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState IN ('AZ', 'CA', 'NY')
ORDER BY BillingState;
```
- Tests if a value matches any in a list
- More readable than multiple OR conditions

## LIKE Operator

### Pattern Matching
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE 'N%'
ORDER BY BillingState;
```
- `%`: Wildcard for zero or more characters
- `'N%'`: Matches states starting with 'N'

### Single Character Wildcard
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE '_Y%'
ORDER BY BillingState;
```
- `_`: Wildcard for exactly one character
- `'_Y%'`: Matches states with 'Y' as second character

### Character Sets
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
AND BillingState LIKE 'N[A-Z]%'
ORDER BY BillingState;
```
- `[A-Z]`: Matches any uppercase letter
- `'N[A-Z]%'`: States starting with 'N' followed by any uppercase letter

## Pagination with OFFSET and FETCH

### First Page
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
ORDER BY BillingState
OFFSET 0 ROWS
FETCH FIRST 5 ROWS ONLY;
```
- `OFFSET 0`: Start from the beginning
- `FETCH FIRST 5`: Get first 5 rows

### Subsequent Pages
```sql
SELECT InvoiceId, Total, InvoiceDate, BillingCity, BillingState FROM Invoice
WHERE BillingCity IS NOT NULL
ORDER BY BillingState
OFFSET 5 ROWS
FETCH NEXT 5 ROWS ONLY;
```
- `OFFSET 5`: Skip first 5 rows
- `FETCH NEXT 5`: Get next 5 rows
- Enables pagination in applications

## Key Concepts Covered

1. **SELECT Statement Basics**: Column selection, wildcards
2. **Filtering**: WHERE clause, comparison operators, NULL handling
3. **Sorting**: ORDER BY with ASC/DESC
4. **Calculations**: Arithmetic and string operations
5. **Functions**: String manipulation, date operations
6. **Duplicates**: DISTINCT keyword
7. **Limiting Results**: TOP clause
8. **Pattern Matching**: LIKE operator with wildcards
9. **Pagination**: OFFSET and FETCH clauses

These queries form the foundation for more complex SQL operations and multi-table queries.