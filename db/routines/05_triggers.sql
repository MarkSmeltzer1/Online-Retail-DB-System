-- =====================================================
-- Triggers for Online Retail Database
-- =====================================================

DELIMITER //

CREATE TRIGGER trg_UpdateStockOnOrderItemInsert
AFTER INSERT ON OrderItem
FOR EACH ROW
BEGIN
    UPDATE Product
    SET StockQuantity = StockQuantity - NEW.Quantity
    WHERE ProductID = NEW.ProductID;
END //

CREATE TRIGGER trg_LogOrderCreation
AFTER INSERT ON `Order`
FOR EACH ROW
BEGIN
    INSERT INTO OrderLog(OrderID, CustomerID, LogDate, Message)
    VALUES (NEW.OrderID, NEW.CustomerID, NOW(), 'Order successfully created');
END //

DELIMITER ;