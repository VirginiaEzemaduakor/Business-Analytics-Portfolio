* ===========================
   CUSTOMERS PRODUCTS ANALYSIS
   =========================== *

* 1. Total Sales per Product */
SELECT p.productName,
       p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS total_sales
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName, p.productLine
ORDER BY total_sales DESC;

/* 2. Top 10 Products by Quantity Sold */
SELECT p.productName,
       SUM(od.quantityOrdered) AS total_quantity
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productName
ORDER BY total_quantity DESC
LIMIT 10;

/* 3. Customer Lifetime Value (LTV) */
SELECT c.customerNumber,
       c.customerName,
       SUM(od.quantityOrdered * od.priceEach) AS lifetime_value
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
JOIN orderdetails od ON o.orderNumber = od.orderNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY lifetime_value DESC;

/* 4. Average Payment per Customer */
SELECT c.customerNumber,
       c.customerName,
       ROUND(AVG(p.amount),2) AS avg_payment
FROM customers c
JOIN payments p ON c.customerNumber = p.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY avg_payment DESC;

/* 5. Order Frequency by Customer */
SELECT c.customerNumber,
       c.customerName,
       COUNT(o.orderNumber) AS total_orders
FROM customers c
JOIN orders o ON c.customerNumber = o.customerNumber
GROUP BY c.customerNumber, c.customerName
ORDER BY total_orders DESC;

/* 6. Product Line Performance */
SELECT p.productLine,
       SUM(od.quantityOrdered * od.priceEach) AS revenue
FROM products p
JOIN orderdetails od ON p.productCode = od.productCode
GROUP BY p.productLine
ORDER BY revenue DESC;

/* 7. Customers by Region */
SELECT c.country,
       COUNT(DISTINCT c.customerNumber) AS total_customers
FROM customers c
GROUP BY c.country
ORDER BY total_customers DESC;
