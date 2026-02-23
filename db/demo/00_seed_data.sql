-- ============================
-- 1. CUSTOMER (Parent table)
-- ============================
INSERT INTO Customer (FirstName, LastName, CustomerEmail, CustomerPhoneNumber, Password, AccountCreationDate)
VALUES
('Mark', 'Smith', 'mark@example.com', '555-111-1111', 'pass123', NOW()),
('John', 'Doe', 'john@example.com', '555-222-2222', 'pass123', NOW()),
('Sarah', 'West', 'sarah@example.com', '555-333-3333', 'pass123', NOW()),
('Emily', 'Stone', 'emily@example.com', '555-444-4444', 'pass123', NOW()),
('Kyle', 'Brown', 'kyle@example.com', '555-555-5555', 'pass123', NOW());

-- ============================
-- 2. CART
-- ============================
INSERT INTO Cart (CustomerID, CartCreationDate)
VALUES
(1, NOW()), (2, NOW()), (3, NOW()), (4, NOW()), (5, NOW());

-- ============================
-- 3. PAYMENTMETHOD
-- ============================
INSERT INTO PaymentMethod 
(CustomerID, MethodType, Brand, Last4, ExpMonth, ExpYear, CVV, IsDefault, CreatedAt)
VALUES
(1, 'Credit Card', 'Visa', '1234', 11, 2028, '123', 1, NOW()),
(2, 'Credit Card', 'Mastercard', '5678', 10, 2027, '456', 1, NOW()),
(3, 'Debit Card', 'Visa', '9012', 09, 2026, '789', 1, NOW()),
(4, 'Credit Card', 'Amex', '3456', 04, 2029, '321', 1, NOW()),
(5, 'Credit Card', 'Discover', '8888', 05, 2030, '654', 1, NOW());

-- ============================
-- 4. PAYMENT
-- ============================
INSERT INTO Payment (CustomerID, PaymentMethodID, PaymentDate, AmountPaid)
VALUES
(1, 1, NOW(), 49.99),
(2, 2, NOW(), 89.50),
(3, 3, NOW(), 120.00),
(4, 4, NOW(), 15.75),
(5, 5, NOW(), 500.00);

-- ============================
-- 5. PRODUCTCATEGORY
-- ============================
INSERT INTO ProductCategory (CategoryName, CategoryDescription)
VALUES
('Electronics', 'Electronic devices and gadgets'),
('Home Goods', 'Furniture and home essentials'),
('Clothing', 'Men and women clothing'),
('Sports', 'Sporting goods and accessories'),
('Toys', 'Toys for all ages');

-- ============================
-- 6. PRODUCT
-- ============================
INSERT INTO Product (CategoryID, ProductName, ProductDescription, SKU, ProductPrice, StockQuantity)
VALUES
(1, 'Bluetooth Speaker', 'Portable speaker with high-quality sound.', 'SKU1001', 29.99, 100),
(1, 'Wireless Headphones', 'Noise-cancelling headphones.', 'SKU1002', 79.99, 150),
(2, 'Office Chair', 'Ergonomic office chair.', 'SKU2001', 139.99, 50),
(3, 'Winter Jacket', 'Warm insulated jacket.', 'SKU3001', 99.99, 80),
(4, 'Basketball', 'Official size basketball.', 'SKU4001', 25.99, 200);

-- ============================
-- 7. WATCHLIST
-- ============================
INSERT INTO WatchList (CustomerID, ProductID, DateAdded)
VALUES
(1, 1, NOW()),
(2, 2, NOW()),
(3, 3, NOW()),
(4, 4, NOW()),
(5, 5, NOW());

-- ============================
-- 8. ADDRESS
-- ============================
INSERT INTO Address (Line1, Line2, City, State, Zip, Country)
VALUES
('123 Main St', NULL, 'New York', 'NY', '10001', 'USA'),
('45 West St', 'Apt 2B', 'Philadelphia', 'PA', '19104', 'USA'),
('9 Hill Ave', NULL, 'Boston', 'MA', '02108', 'USA'),
('77 Creek Rd', NULL, 'Chicago', 'IL', '60601', 'USA'),
('500 Pine Ln', 'Unit 4C', 'Miami', 'FL', '33101', 'USA');

-- ============================
-- 9. ORDER
-- ============================
INSERT INTO `Order` (CustomerID, OrderDate, SubTotal, TaxAmount, ShippingCost, OrderStatus)
VALUES
(1, NOW(), 59.98, 4.20, 5.00, 'Shipped'),
(2, NOW(), 89.99, 6.30, 5.00, 'Pending'),
(3, NOW(), 120.00, 8.40, 10.00, 'Delivered'),
(4, NOW(), 15.75, 1.10, 5.00, 'Processing'),
(5, NOW(), 500.00, 35.00, 15.00, 'Delivered');

-- ============================
-- 10. ORDERITEM
-- ============================
INSERT INTO OrderItem (OrderID, Quantity, ProductPrice, Discount)
VALUES
(1, 2, 29.99, 0),
(2, 1, 89.99, 5),
(3, 1, 120.00, 0),
(4, 1, 15.75, 0),
(5, 5, 100.00, 10);

-- ============================
-- 11. SHIPMENT
-- ============================
INSERT INTO Shipment (OrderID, AddressID, ShipmentType, ShipmentDate, EstimatedDelivery)
VALUES
(1, 1, 'Standard', NOW(), DATE_ADD(NOW(), INTERVAL 5 DAY)),
(2, 2, 'Express', NOW(), DATE_ADD(NOW(), INTERVAL 2 DAY)),
(3, 3, 'Standard', NOW(), DATE_ADD(NOW(), INTERVAL 4 DAY)),
(4, 4, 'Overnight', NOW(), DATE_ADD(NOW(), INTERVAL 1 DAY)),
(5, 5, 'Standard', NOW(), DATE_ADD(NOW(), INTERVAL 6 DAY));

-- ============================
-- 12. REVIEW
-- ============================
INSERT INTO Review (CustomerID, ProductID, Rating, Comment, ReviewDate)
VALUES
(1, 1, 5, 'Great sound quality!', NOW()),
(2, 2, 4, 'Very comfortable.', NOW()),
(3, 3, 5, 'Love this chair.', NOW()),
(4, 4, 3, 'Warm but bulky.', NOW()),
(5, 5, 5, 'Great ball for practice.', NOW());

-- ============================
-- 13. PROMOTION
-- ============================
INSERT INTO Promotion (Code, PromotionDiscription, DiscountAmount, StartDate, EndDate)
VALUES
('SAVE10', '10% off electronics', 10.00, NOW(), DATE_ADD(NOW(), INTERVAL 30 DAY)),
('FREESHIP', 'Free shipping on all items', 5.00, NOW(), DATE_ADD(NOW(), INTERVAL 15 DAY)),
('WINTER20', '20% off winter clothing', 20.00, NOW(), DATE_ADD(NOW(), INTERVAL 45 DAY)),
('SPORT5', '5% off sports gear', 5.00, NOW(), DATE_ADD(NOW(), INTERVAL 20 DAY)),
('JACKET15', '15% off jackets', 15.00, NOW(), DATE_ADD(NOW(), INTERVAL 60 DAY));

-- ============================
-- 14. PROMOTIONPRODUCT
-- ============================
INSERT INTO PromotionProduct (PromotionID, ProductID)
VALUES
(1, 1),
(2, 2),
(3, 4),
(4, 5),
(5, 4);

-- ============================
-- 15. NOTIFICATION
-- ============================
INSERT INTO Notification (CustomerID, Message, SentDate, ReadStatus)
VALUES
(1, 'Your order has shipped.', NOW(), 0),
(2, 'New promotion available!', NOW(), 1),
(3, 'Your package has been delivered.', NOW(), 0),
(4, 'Payment received.', NOW(), 1),
(5, 'Your refund has been processed.', NOW(), 0);

-- ============================
-- 16. RETURNREFUND
-- ============================
INSERT INTO ReturnRefund (CustomerID, OrderID, ReturnDate, ReturnReason, RefundAmount, RefundStatus)
VALUES
(1, 1, NOW(), 'Damaged item', 29.99, 'Approved'),
(2, 2, NOW(), 'Not satisfied', 89.99, 'Pending'),
(3, 3, NOW(), 'Wrong item', 120.00, 'Approved'),
(4, 4, NOW(), 'Changed mind', 15.75, 'Declined'),
(5, 5, NOW(), 'Item not needed', 100.00, 'Approved');


-- Showing tables are populated
SELECT 'Customer' AS TableName, COUNT(*) AS RowCount FROM Customer
UNION ALL
SELECT 'Cart', COUNT(*) FROM Cart
UNION ALL
SELECT 'PaymentMethod', COUNT(*) FROM PaymentMethod
UNION ALL
SELECT 'Payment', COUNT(*) FROM Payment
UNION ALL
SELECT 'ProductCategory', COUNT(*) FROM ProductCategory
UNION ALL
SELECT 'Product', COUNT(*) FROM Product
UNION ALL
SELECT 'WatchList', COUNT(*) FROM WatchList
UNION ALL
SELECT 'Address', COUNT(*) FROM Address
UNION ALL
SELECT '`Order`', COUNT(*) FROM `Order`
UNION ALL
SELECT 'OrderItem', COUNT(*) FROM OrderItem
UNION ALL
SELECT 'Shipment', COUNT(*) FROM Shipment
UNION ALL
SELECT 'Review', COUNT(*) FROM Review
UNION ALL
SELECT 'Promotion', COUNT(*) FROM Promotion
UNION ALL
SELECT 'PromotionProduct', COUNT(*) FROM PromotionProduct
UNION ALL
SELECT 'Notification', COUNT(*) FROM Notification
UNION ALL
SELECT 'ReturnRefund', COUNT(*) FROM ReturnRefund;


















