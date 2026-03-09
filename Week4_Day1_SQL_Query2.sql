-- =============================================
-- Create Database
-- =============================================
CREATE DATABASE InventoryDB;
GO

USE InventoryDB;
GO

-- =============================================
-- Table: ProductList
-- =============================================
CREATE TABLE ProductLists
(
    product_id INT PRIMARY KEY,
    product_name VARCHAR(50)
);

-- =============================================
-- Table: ProductStock
-- =============================================
CREATE TABLE ProductStocks
(
    product_id INT PRIMARY KEY,
    stock_quantity INT,
    FOREIGN KEY (product_id) REFERENCES ProductLists(product_id)
);

-- =============================================
-- Table: OrderDetails
-- =============================================
CREATE TABLE OrderDetail
(
    item_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    FOREIGN KEY (product_id) REFERENCES ProductLists(product_id)
);

-- =============================================
-- Insert Products
-- =============================================
INSERT INTO ProductLists VALUES
(1,'Laptop'),
(2,'Mouse'),
(3,'Keyboard');

-- =============================================
-- Insert Stock
-- =============================================
INSERT INTO ProductStocks VALUES
(1,50),
(2,100),
(3,75);

-- Valid Order
INSERT INTO OrderDetail VALUES (1,1,5);

-- Check stock
SELECT * FROM ProductStocks;

-- Invalid Order (More than stock)
INSERT INTO OrderDetail VALUES (2,1,100);

--1. Create an AFTER INSERT trigger on order_items.--
CREATE TRIGGER trg_AfterInsert_OrderItems
ON order_items
AFTER INSERT
AS
BEGIN

    BEGIN TRY

        -- Update stock quantity when a new order item is inserted
        UPDATE s
        SET s.stock_quantity = s.stock_quantity - i.quantity
        FROM stocks s
        JOIN inserted i
        ON s.product_id = i.product_id;

    END TRY

    BEGIN CATCH

        -- Rollback if any error occurs
        ROLLBACK;

        -- Custom error message
        RAISERROR('Error occurred while updating stock after order insertion.',16,1);

    END CATCH

END;
GO
INSERT INTO order_items VALUES (1,1,5);

SELECT * FROM stocks;