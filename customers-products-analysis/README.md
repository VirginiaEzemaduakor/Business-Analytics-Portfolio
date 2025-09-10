# Customers Products Analysis  

**Tools Used:** SQL (DB Browser for SQLite)  
**Domain:** Retail / Customer & Product Analytics  

---

## Problem Statement  
Retail businesses collect large volumes of customer and product data but often lack structured insights into purchasing patterns.  
This project analyzes a retail database to answer key questions such as:  
- Which products should be restocked?  
- Who are the top customers by revenue?  
- What is the average customer lifetime value (CLV)?  
- Which product lines generate the most revenue?  

---

## Method  
- Designed a *relational database schema* with customers, products, orders, and transactions.  
- Applied *SQL queries* to analyze sales performance, customer behavior, and product demand.  
- Structured findings into actionable insights for inventory management and customer strategy.  

---

## Sample SQL Queries  

### 1. Products to Restock (Low Stock)  
```sql
SELECT productCode,
       ROUND(SUM(quantityOrdered) * 1.0 /
             (SELECT quantityInStock FROM products p WHERE od.productCode = p.productCode), 2) AS low_stock
  FROM orderdetails od
 GROUP BY productCode
 ORDER BY low_stock DESC
 LIMIT 10;

```

### 2. Top Customer by Revenue
```sql
WITH customer_revenue AS (
  SELECT o.customerNumber,
         SUM(quantityOrdered * (priceEach - buyPrice)) AS revenue
    FROM products p
    JOIN orderdetails od ON p.productCode = od.productCode
    JOIN orders o ON o.orderNumber = od.orderNumber
   GROUP BY o.customerNumber
)
SELECT c.contactLastName, c.contactFirstName, c.city, c.country, cr.revenue
  FROM customers c
  JOIN customer_revenue cr ON cr.customerNumber = c.customerNumber
 ORDER BY cr.revenue DESC
 LIMIT 5;

```
Full SQL script with all queries available here:
[customers_products_analysis.sql](/customers-products-analysis/customers_products_analysis.sql)

---

## Key Insights

- **Inventory:** 60% of low-stock items came from the “Classic Cars” product line, signaling high demand.
- **Customers:** A small group of VIP customers generated the highest revenue, while low-engagement customers showed significant churn risk.
- **Product Lines:** Product line performance varied, with cars and motorcycles driving the majority of sales.
- **Customer Lifetime Value (CLV):** Average CLV was estimated at $39,040, guiding budget allocation for customer acquisition.

---

## Recommendations

- Prioritize restocking high-demand product lines like Classic Cars.
- Build a loyalty program to retain high-value customers.
- Launch targeted promotions to re-engage low-spend customers.
- Use CLV benchmarks to optimize marketing and acquisition spending.

---

## Files in this Repository

- README.md → Project documentation
- customers_products_analysis.sql → Full SQL queries

---

## Contact

For dataset or additional details, please reach out at virginia.ezemaduakor@gmail.com
