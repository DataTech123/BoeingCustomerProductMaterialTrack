USE CustomerProductMaterialTrack;
 
SELECT 
    c.FirstName + ' ' + c.LastName AS CustomerName,    so.OrderDate,    p.ProductName,    m.MaterialName,
    COUNT(DISTINCT so.ServiceOrderID) AS TotalServiceOrder,    COUNT(DISTINCT p.ProductName) AS TotalProduct,
    SUM(i.StockQuantity) AS TotalStockQuantity,    '$' + CAST(FORMAT(SUM(p.Price), 'N2') AS VARCHAR) AS TotalPrice
FROM 
    Customer c
INNER JOIN 
    ServiceOrder so ON c.CustomerID = so.CustomerID
INNER JOIN 
    Product p ON p.ServiceOrderID = so.ServiceOrderID
INNER JOIN 
    Material m ON m.ServiceOrderID = so.ServiceOrderID
INNER JOIN 
    Inventory i ON p.ProductID = i.ProductID OR m.MaterialID = i.MaterialID
INNER JOIN 
    CustomerMaterialProductWarehouse cmpw ON i.InventoryID = cmpw.InventoryID
GROUP BY 
    c.FirstName + ' ' + c.LastName, 
    so.OrderDate, 
    p.ProductName, 
    m.MaterialName
ORDER BY
    CustomerName,
    so.OrderDate,
    p.ProductName,
    m.MaterialName;


