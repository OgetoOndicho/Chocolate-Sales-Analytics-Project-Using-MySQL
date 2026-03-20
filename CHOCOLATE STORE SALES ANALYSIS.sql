#. Designation of a Database for the startup to store information
CREATE DATABASE Blessed_ChocolateStore_db;

## Authorize the usage of our database.
USE Blessed_ChocolateStore_db;

# Add by creating tables to store some data. The tables are;
### Products to hold information about different elements  of our products
### Employed_Salespeople to hold data about the sales people who are under the company
### Geography to host geographical data
### Sales to host sales data i response to the products sold by the company.
CREATE TABLE Products (
	Product_id VARCHAR(20) PRIMARY KEY,
    Product_name VARCHAR(50),
    Category VARCHAR(50),
    Size INT,
    Cost_per_box DECIMAL(5,2)
);

INSERT INTO Products VALUES
	('G301', 'Velvet truffle', 'Dark chocolate', '4', '100.40'),
    ('G404', 'Velvet truffle', 'Dark chocolate', '8', '121.10'),
    ('G505', 'Sweet chocolate', 'Milk chocolate', '4', '100.20'),
    ('G100', 'Candy captain', 'Dark chocolate', '12', '256.44'),
    ('G106', 'Truffle tango', 'Coco choco', '10', '144.44'),
    ('G109', 'Velvet truffle', 'Dark chocolate', '16', '431.13'),
    ('G478', 'Cocoa mango', 'Milk chocolate', '12', '231.12'),
    ('G326', 'Truffle tango', 'Coco choco', '16', '350.00'),
    ('G108', 'Velvet truffle', 'Dark chocolate', '4', '89.16'),
    ('G444', 'Cocoa mango', 'Milk chocolate', '10', '180.55'),
    ('G810', 'Candy captain', 'Dark chocolate', '4', '88.81'),
    ('G678', 'Velvet truffle', 'Dark chocolate', '12', '155.78'),
    ('G110', 'Sweet chocolate', 'Milk chocolate', '8', '113.23'),
    ('G117', 'Cocoa mango', 'Milk chocolate', '4', '89.90'),
    ('G155', 'Candy captain', 'Dark chocolate', '16', '488.84'),
    ('G180', 'Truffle tango', 'Coco choco', '4', '94.56');
	
SELECT * FROM Products;

CREATE TABLE Employed_alespeople (
	Saleperson_name VARCHAR(50),
    Saleperson_id VARCHAR(20) PRIMARY KEY,
    Specialization VARCHAR(50),
    Location VARCHAR(30)
);

RENAME TABLE Employed_alespeople TO Employed_salespeople;

INSERT INTO Employed_salespeople VALUES
	('Daniel Adams', 'H4040', 'Delicious', 'Nairobi'),
    ('Stacy Rotwell', 'H7890', 'Yummy sweet', 'Nairobi'),
    ('Aguella Johnson', 'H5656', 'Delicious', 'Kisumu'),
    ('Adrian Gaitho', 'H8900', 'Juicy', 'Mombasa'),
    ('Paula Gibson', 'H5059', 'Yummy sweet', 'Kisumu'),
    ('Jared Ondiek', 'H4890', 'Delicious', 'Mombasa'),
    ('Sophia Wachika', 'H1091', 'Yummy sweet', 'Mombasa'),
    ('Deborah Aujija', 'H6789', 'Juicy', 'Nairobi'),
    ('Lamack Lebanon', 'H7654', 'Juicy', 'Kisumu');

SELECT * FROM Employed_salespeople;    
    
CREATE TABLE Geography (
	Geography_id VARCHAR(20) PRIMARY KEY,
    Region VARCHAR(20)
);

INSERT INTO Geography VALUES 
	('F10009', 'East'),
    ('A23490', 'West'),
    ('B40040', 'North'),
    ('G78001', 'South');
    
SELECT * from Geography;



CREATE TABLE Sales (
	Product_id VARCHAR(20),
	Saleperson_id VARCHAR(50),
    Geography_id VARCHAR(20),
    Sale_date DATE,
    Amount DECIMAL,
    Customers INT,
    Boxes_sold INT 
);

SELECT * FROM Sales;
INSERT INTO Sales VALUES
	('G404', 'H7890', 'F10009', '2025-12-23', '99.89', '13', '230'),
    ('G301', 'H8080', 'B40040', '2025-10-11', '100.40', '60', '100'),
    ('G505', 'H5059', 'G78001', '2026-03-01', '89.22', '889', 409),
    ('G100', 'H5059', 'F10009', '2025-12-24', '136.10', '200', '301'),
    ('G106', 'H8900', 'B40040', '2026-01-01', '110.12', '346', '211'),
    ('G109', 'H1091', 'A23490', '2026-01-23', '189.44', '89', '560'),
    ('G110', 'H4890', 'A23490', '2025-11-01', '94.44', '67', '98'),
    ('G180', 'H6789', 'A23490', '2026-02-14', '99.80', '890', '601'),
    ('G478', 'H1091', 'F10009', '2025-12-20', '129.99', '489', '456'),
    ('G404', 'H5059', 'F10009', '2026-01-31', '99.89', '100', '1000'),
    ('G109', 'H6789', 'G78001', '2025-12-25', '189.44', '255', '287'),
    ('G505', 'H8900', 'B40040', '2025-11-01', '89.22', '154', '89');
    
##Slight update for our Sales data to allow decimal values in the Amount Column Since data was truncated due to incorrect Decimal places values allowance
ALTER TABLE Sales
MODIFY  Amount DECIMAL(6,2);

# Confirm and view the changes made 
SELECT * FROM Sales;

##Sample practices exercises to query our database and obtain more insights on our data;
#Q1. Retrieve data from the Sale_date, Amount, Salesperson_id, Customers, Boxes_sold columns from the Sales Table.
SELECT Sale_date, Amount, Saleperson_id, Customers, Boxes_sold
FROM Sales;

#Q2. Calculate the amount on each box for each single sale made in each sale date
SELECT Sale_date, Amount, Boxes_sold, Amount / Boxes_sold AS Amount_per_box
FROM Sales;

#Q3. Retrieve the minimum and maaximum amount made from the sales of chocolates
SELECT
	MIN(Amount) AS Minimum_Value,
	MAX(Amount) AS Maximum_Value
FROM Sales;
    
#Q4. Find all the sales made over the Amount of 89
SELECT * FROM Sales
WHERE Amount > 89;

#Q5. View data from the highest to lowest Amount in sales over 89
SELECT * FROM Sales
WHERE Amount > 89
ORDER BY Amount DESC;

#Q6. Obtain data for Amount in sales over 100 in the year 2026
SELECT * FROM Sales
WHERE Amount > 100 AND Sale_date >= '2026-01-01';

#Q7. Find the total, the maximum and minimum number of boxes sold from the data
SELECT 
	SUM(Boxes_sold) AS Total_of_Boxes_sold,
    MIN(Boxes_sold) AS Minimum_boxes,
    MAX(Boxes_sold) AS Maximum_boxes
FROM Sales;

#Q8. Investigate on which days of the week were Sales actually made
SELECT Product_id, Saleperson_id, Geography_id, Sale_date, Amount, Boxes_sold,
		weekday(Sale_date) AS Day_ofthe_week FROM Sales
WHERE weekday(Sale_date) =0 
OR weekday(Sale_date) =1 
OR weekday(Sale_date) =2 
OR weekday(Sale_date) =3
OR weekday(Sale_date) =4
OR weekday(Sale_date) =5
OR weekday(Sale_date) =6;

#Q9. Retrieve data where the Sales personnel are either o Yummy Sweet OR Juicy specialization
SELECT * FROM Employed_salespeople
WHERE Specialization ='Yummy sweet'
	OR Specialization = 'Juicy';
    
#Q10. Retrieve data where the Sales personnel are either o Delicious OR Juicy specialization
SELECT * FROM Employed_salespeople
WHERE Specialization IN ('Delicious', 'Juicy');

#Q11. Categorize the information in the Sales Table according to the Amount of Sales made
SELECT * FROM Sales;
SELECT Sale_date, Customers, Boxes_sold, Amount,
	CASE WHEN Amount BETWEEN 89 AND 100 THEN 'Low Sales'
		WHEN Amount BETWEEN 101 AND  130 THEN 'Mid Sales'
        WHEN Amount BETWEEN  131 AND 200 THEN 'High Sales'
        ELSE 'Exemplary Sales'
	END AS Amount_category
FROM Sales;

#Q12. Retrieve the details of the Sales personnel and the Amount each personel sold
SELECT e.Saleperson_name, e.Specialization, e.location, s.Amount, s.Boxes_sold, s.Sale_date
FROM Employed_salespeople e
LEFT JOIN Sales s 
ON e.Saleperson_id = s.Saleperson_id;

#Q13. Retrieve the details of the Sales personnel, The Amount each sold from the highest to the lowest
SELECT e.Saleperson_name, e.Specialization, e.location, s.Amount, s.Boxes_sold
FROM Employed_salespeople e
LEFT JOIN Sales s 
ON e.Saleperson_id = s.Saleperson_id
ORDER BY e.Location, s.Amount DESC;

#Q14.




	



