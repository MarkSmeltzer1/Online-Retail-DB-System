-- =====================================================
-- Procedures for Online Retail Database
-- =====================================================

DELIMITER //

CREATE PROCEDURE PlaceOrder(
    IN p_CustomerID INT,
    IN p_ProductID INT,
    IN p_Quantity INT
)
BEGIN
    DECLARE currentStock INT;
    DECLARE newOrderID INT;

    START TRANSACTION;

    -- Check stock
    SELECT StockQuantity INTO currentStock
    FROM Product
    WHERE ProductID = p_ProductID
    FOR UPDATE;

    IF currentStock < p_Quantity THEN
        ROLLBACK;
        SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Not enough stock';
    END IF;

    -- Create a new order
    INSERT INTO `Order`(CustomerID, OrderDate, SubTotal, TaxAmount, ShippingCost, OrderStatus)
    VALUES (p_CustomerID, NOW(), 0, 0, 0, 'Pending');

    SET newOrderID = LAST_INSERT_ID();

    -- Insert order item
    INSERT INTO OrderItem(OrderID, ProductID, Quantity, ProductPrice, Discount)
    SELECT newOrderID, ProductID, p_Quantity, ProductPrice, 0
    FROM Product
    WHERE ProductID = p_ProductID;


    COMMIT;
END //

CREATE PROCEDURE GetCustomerOrderHistory(IN p_CustomerID INT)
BEGIN
    SELECT 
        o.OrderID,
        o.OrderDate,
        o.OrderStatus,
        GetOrderTotal(o.OrderID) AS TotalAmount
    FROM `Order` o
    WHERE o.CustomerID = p_CustomerID;
END //

DELIMITER ;