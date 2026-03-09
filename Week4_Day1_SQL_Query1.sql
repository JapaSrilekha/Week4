
-- Create Database
CREATE DATABASE SalesReportDB;
GO

USE SalesReportDB;
GO

-- =============================================
-- Table: Stores
-- =============================================
CREATE TABLE Stores
(
    store_id INT PRIMARY KEY,
    store_name VARCHAR(50),
    city VARCHAR(50)
);

-- =============================================
-- Table: Customers
-- =============================================
CREATE TABLE Customers
(
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(50),
    city VARCHAR(50)
);

-- =============================================
-- Table: Orders
-- =============================================
CREATE TABLE Orders
(
    order_id INT PRIMARY KEY,
    customer_id INT,
    store_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),

    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id),
    FOREIGN KEY (store_id) REFERENCES Stores(store_id)
);

-- =============================================
-- Table: OrderItems
-- =============================================
CREATE TABLE OrderItems
(
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(50),
    quantity INT,
    price DECIMAL(10,2),

    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);

-- =============================================
-- Insert Data into Stores
-- =============================================
INSERT INTO Stores VALUES
(1,'Central Store','Hyderabad'),
(2,'City Mall Store','Bangalore'),
(3,'Super Mart','Chennai');


-- =============================================
-- Insert Data into Customers
-- =============================================
INSERT INTO Customers VALUES
(1,'Ravi','Hyderabad'),
(2,'Sneha','Bangalore'),
(3,'Arjun','Chennai'),
(4,'Priya','Hyderabad');


-- =============================================
-- Insert Data into Orders
-- =============================================
INSERT INTO Orders VALUES
(101,1,1,'2026-03-01',5000),
(102,2,2,'2026-03-02',3500),
(103,3,3,'2026-03-03',4200),
(104,4,1,'2026-03-04',2800),
(105,2,2,'2026-03-05',6100);


-- =============================================
-- Insert Data into OrderItems
-- =============================================
INSERT INTO OrderItems VALUES
(1,101,'Laptop Bag',1,1500),
(2,101,'Mouse',2,500),
(3,102,'Keyboard',1,1200),
(4,103,'Monitor',1,4200),
(5,104,'Headphones',2,1400),
(6,105,'External HDD',1,6100);


-- View all tables

SELECT * FROM Stores;
SELECT * FROM Customers;
SELECT * FROM Orders;
SELECT * FROM OrderItems;
------------------------------
--1. Create a stored procedure to generate total sales amount per store.--
------------------------------

CREATE PROCEDURE sp_TotalSalesPerStore
AS
BEGIN

    SELECT 
        s.store_id,
        s.store_name,
        SUM(ISNULL(o.total_amount,0)) AS total_sales
    FROM Stores s
    LEFT JOIN Orders o
        ON s.store_id = o.store_id
    GROUP BY 
        s.store_id,
        s.store_name
    ORDER BY 
        total_sales DESC;

END;
GO

EXEC sp_TotalSalesPerStore;
-----------------------------
--2.Create a stored procedure to retrieve orders by date range.--
-----------------------------
CREATE PROCEDURE sp_GetOrdersByDateRange
    @StartDate DATE,
    @EndDate DATE
AS
BEGIN

    SELECT 
        o.order_id,
        c.customer_name,
        s.store_name,
        o.order_date,
        ISNULL(o.total_amount,0) AS total_amount
    FROM Orders o
    JOIN Customers c 
        ON o.customer_id = c.customer_id
    JOIN Stores s 
        ON o.store_id = s.store_id
    WHERE o.order_date BETWEEN @StartDate AND @EndDate
    ORDER BY o.order_date;

END;
GO
EXEC sp_GetOrdersByDateRange '2026-03-01', '2026-03-04';

-----------------------
--3.Create a scalar function to calculate total price after discount.--
-----------------------

CREATE FUNCTION fn_CalculateDiscount
(
    @TotalAmount DECIMAL(10,2),
    @DiscountPercent DECIMAL(5,2)
)
RETURNS DECIMAL(10,2)
AS
BEGIN

    DECLARE @FinalAmount DECIMAL(10,2)

    SET @FinalAmount = @TotalAmount - (@TotalAmount * @DiscountPercent / 100)

    RETURN @FinalAmount

END;
GO
SELECT dbo.fn_CalculateDiscount(5000,10) AS FinalPrice;
---------------------------
--4.Create a table-valued function to return top 5 selling products.--
---------------------------
CREATE FUNCTION fn_Top5SellingProducts()
RETURNS TABLE
AS
RETURN
(
    SELECT TOP 5
        product_name,
        SUM(quantity) AS total_quantity_sold
    FROM OrderItems
    GROUP BY product_name
    ORDER BY total_quantity_sold DESC
);
GO
SELECT * FROM dbo.fn_Top5SellingProducts();