-- =====================================================
-- CREATE DATABASE
-- =====================================================


CREATE DATABASE OrderCancelDB;
GO

USE OrderCancelDB;
GO


-- =====================================================
-- CREATE TABLES
-- =====================================================

CREATE TABLE Products(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL(10,2)
);

CREATE TABLE Stocks(
    product_id INT PRIMARY KEY,
    quantity INT,
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);

CREATE TABLE Orders(
    order_id INT PRIMARY KEY,
    order_date DATE,
    order_status INT DEFAULT 1   -- 1=Placed, 2=Shipped, 3=Rejected
);

CREATE TABLE Order_Items(
    order_item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    FOREIGN KEY(order_id) REFERENCES Orders(order_id),
    FOREIGN KEY(product_id) REFERENCES Products(product_id)
);


-- =====================================================
-- INSERT SAMPLE DATA
-- =====================================================

INSERT INTO Products VALUES
(1,'Car Battery',5000),
(2,'Brake Pad',2000),
(3,'Engine Oil',1200);

INSERT INTO Stocks VALUES
(1,10),
(2,20),
(3,15);

INSERT INTO Orders VALUES
(101,GETDATE(),1);

INSERT INTO Order_Items VALUES
(1,101,1,2),
(2,101,2,3);


-- =====================================================
-- OUTPUT BEFORE CANCELLATION
-- =====================================================
SELECT * FROM Stocks;
SELECT * FROM Orders;
SELECT * FROM Order_Items;


-- =====================================================
-- REQUIREMENT 1
-- Begin a transaction when cancelling an order
-- =====================================================
BEGIN TRANSACTION;


-- =====================================================
-- REQUIREMENT 2
-- Use SAVEPOINT before stock restoration
-- =====================================================
SAVE TRANSACTION BeforeStockRestore;


-- =====================================================
-- REQUIREMENT 3
-- Restore stock quantities based on order_items
-- =====================================================
BEGIN TRY

UPDATE s
SET s.quantity = s.quantity + oi.quantity
FROM Stocks s
JOIN Order_Items oi
ON s.product_id = oi.product_id
WHERE oi.order_id = 101;


-- =====================================================
-- REQUIREMENT 4
-- Update order_status to Rejected (3)
-- =====================================================
UPDATE Orders
SET order_status = 3
WHERE order_id = 101;


-- =====================================================
-- REQUIREMENT 5
-- Commit transaction only if all operations succeed
-- =====================================================
COMMIT;

PRINT 'Order cancelled successfully';

END TRY


-- =====================================================
-- REQUIREMENT 6
-- If stock restoration fails, rollback to SAVEPOINT
-- =====================================================
BEGIN CATCH

PRINT 'Error occurred. Rolling back to SAVEPOINT';

ROLLBACK TRANSACTION BeforeStockRestore;

ROLLBACK;

END CATCH;


-- =====================================================
-- FINAL OUTPUT AFTER ORDER CANCELLATION
-- =====================================================
SELECT * FROM Stocks;
SELECT * FROM Orders;
SELECT * FROM Order_Items;