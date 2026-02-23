-- =====================================================
-- Functions for Online Retail Database
-- =====================================================

DELIMITER //

CREATE FUNCTION GetOrderTotal(p_OrderID INT)
RETURNS DECIMAL(10,2)
DETERMINISTIC
BEGIN
    DECLARE total DECIMAL(10,2);

    SELECT SUM(Quantity * ProductPrice - Discount)
    INTO total
    FROM OrderItem
    WHERE OrderID = p_OrderID;

    RETURN IFNULL(total, 0);
END //

CREATE FUNCTION GetCustomerFullName(p_CustomerID INT)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE name VARCHAR(255);

    SELECT CONCAT(FirstName, ' ', LastName)
    INTO name
    FROM Customer
    WHERE CustomerID = p_CustomerID;

    RETURN name;
END //

DELIMITER ;