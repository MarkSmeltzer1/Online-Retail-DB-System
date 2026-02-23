-- =====================================================
-- Views for Online Retail Database
-- =====================================================

CREATE VIEW CustomerOrderOverviewView AS
SELECT 
    o.OrderID,
    o.CustomerID,
    o.OrderDate,
    o.OrderStatus,
    SUM(oi.Quantity * oi.ProductPrice - oi.Discount) AS OrderTotal
FROM `Order` o
JOIN OrderItem oi ON o.OrderID = oi.OrderID
GROUP BY o.OrderID;

CREATE VIEW ProductSalesView AS
SELECT 
    p.ProductID,
    p.ProductName,
    SUM(oi.Quantity) AS TotalUnitsSold,
    SUM(oi.Quantity * oi.ProductPrice) AS TotalRevenue
FROM Product p
LEFT JOIN OrderItem oi ON p.ProductID = oi.ProductID
GROUP BY p.ProductID;