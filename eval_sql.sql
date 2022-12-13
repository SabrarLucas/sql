-- 1
SELECT *
FROM customers
WHERE Country = 'France'

-- 2
SELECT ProductName, UnitPrice
FROM products
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE CompanyName = 'Exotic Liquids'

-- 3
SELECT CompanyName, COUNT(ProductID) AS 'Nbr produits'
FROM products
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE Country = 'France'
GROUP BY CompanyName
ORDER BY COUNT(ProductID) DESC

-- 4
SELECT CompanyName, COUNT(OrderID) AS 'Nbr commandes'
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
WHERE Country = 'France'
GROUP BY CompanyName
HAVING COUNT(OrderID) > 10

-- 5
SELECT CompanyName, SUM(UnitPrice * Quantity) AS 'CA', Country
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
JOIN `order details` ON `order details`.OrderID = orders.OrderID
GROUP BY CompanyName
HAVING SUM(UnitPrice * Quantity) > 30000

-- 6
SELECT ShipCountry
FROM orders
JOIN `order details` ON `order details`.OrderID = orders.OrderID 
JOIN products ON products.ProductID = `order details`.ProductID
JOIN suppliers ON suppliers.SupplierID = products.SupplierID
WHERE CompanyName = 'Exotic Liquids'
GROUP BY ShipCountry

-- 7
SELECT SUM(Quantity * `order details`.UnitPrice) AS 'Ventes en 97'
FROM `order details`
JOIN orders ON orders.OrderID = `order details`.OrderID
WHERE YEAR(OrderDate) = '1997'

-- 8
SELECT MONTH(OrderDate) AS 'mois 97', SUM(Quantity * `order details`.UnitPrice) AS 'Ventes en 97'
FROM `order details`
JOIN orders ON orders.OrderID = `order details`.OrderID
WHERE YEAR(OrderDate) = '1997'
GROUP BY MONTH(OrderDate)

-- 9
SELECT MAX(OrderDate) AS 'derniere commande'
FROM customers
JOIN orders ON orders.CustomerID = customers.CustomerID
WHERE CompanyName = 'Du monde entier'

-- 10
SELECT ROUND(AVG(DATEDIFF(ShippedDate, OrderDate))) AS 'Delai moyen de livraison en jours'
FROM orders