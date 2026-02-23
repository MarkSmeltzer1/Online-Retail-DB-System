-- =====================================================
-- Schema updates / fixes for Online Retail Database
-- Adds ProductID to OrderItem and creates OrderLog
-- =====================================================

USE `online_retail`;

-- 1) Add ProductID to OrderItem (if it doesn't exist yet)
ALTER TABLE OrderItem
ADD COLUMN ProductID INT NOT NULL;

-- 2) Add FK from OrderItem.ProductID -> Product.ProductID
ALTER TABLE OrderItem
ADD CONSTRAINT fk_orderitem_product
FOREIGN KEY (ProductID) REFERENCES Product(ProductID);

-- 3) Create OrderLog table (used by trg_LogOrderCreation trigger)
CREATE TABLE IF NOT EXISTS OrderLog (
    LogID INT AUTO_INCREMENT PRIMARY KEY,
    OrderID INT NOT NULL,
    CustomerID INT NOT NULL,
    LogDate DATETIME NOT NULL,
    Message VARCHAR(255) NOT NULL
);