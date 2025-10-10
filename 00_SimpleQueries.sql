-- Simple Queries
SELECT CustomerId
    , FirstName
    , LastName
    , Country
    , PostalCode
    , Phone
    , Email
FROM Customer

-- Insert a row
INSERT INTO Customer (CustomerId, FirstName, LastName, Country, PostalCode, Phone, Email)
VALUES (60, 'John', 'Doe', 'USA', '12345', '555-1234', 'john.doe@example.com');

-- Update a row
UPDATE Customer
SET FirstName = 'Jane', 
    LastName = 'Smith'
WHERE CustomerId = 60;

-- Delete a row
DELETE FROM Customer
WHERE CustomerId = 60;