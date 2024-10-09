CREATE DATABASE department;
USE department;

CREATE TABLE customers (
    customer_id INT PRIMARY KEY,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    email VARCHAR(100)
);

CREATE TABLE products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    price DECIMAL
);

CREATE TABLE order_table (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE
);

CREATE TABLE order_items (
    order_id INT,
    product_id INT,
    quantity INT
);


INSERT INTO customers (customer_id, first_name, last_name, email) VALUES
(1, 'John', 'Doe', 'johndoe@email.com'),
(2, 'Jane', 'Smith', 'janesmith@email.com'),
(3, 'Bob', 'Johnson', 'bobjohnson@email.com'),
(4, 'Alice', 'Brown', 'alicebrown@email.com'),
(5, 'Charlie', 'Davis', 'charliedavis@email.com'),
(6, 'Eva', 'Fisher', 'evafisher@email.com'),
(7, 'George', 'Harris', 'georgeharris@email.com'),
(8, 'Ivy', 'Jones', 'ivyjones@email.com'),
(9, 'Kevin', 'Miller', 'kevinmiller@email.com'),
(10, 'Lily', 'Nelson', 'lilynelson@email.com');


INSERT INTO products (product_id, product_name, price) VALUES
(1, 'Product A', 10.00),
(2, 'Product B', 15.00),
(3, 'Product C', 20.00),
(4, 'Product D', 25.00),
(5, 'Product E', 30.00),
(6, 'Product F', 35.00),
(7, 'Product G', 40.00),
(8, 'Product H', 45.00),
(9, 'Product I', 50.00),
(10, 'Product J', 55.00),
(11, 'Product K', 60.00),
(12, 'Product L', 65.00),
(13, 'Product M', 70.00);

INSERT INTO order_table (order_id, customer_id, order_date) VALUES
(1, 1, '2023-05-01'),
(2, 2, '2023-05-02'),
(3, 3, '2023-05-03'),
(4, 1, '2023-05-04'),
(5, 2, '2023-05-05'),
(6, 3, '2023-05-06'),
(7, 4, '2023-05-07'),
(8, 5, '2023-05-08'),
(9, 6, '2023-05-09'),
(10, 7, '2023-05-10'),
(11, 8, '2023-05-11'),
(12, 9, '2023-05-12'),
(13, 10, '2023-05-13'),
(14, 11, '2023-05-14'),
(15, 12, '2023-05-15'),
(16, 13, '2023-05-16');

INSERT INTO order_items (order_id, product_id, quantity) VALUES
(1, 1, 2),
(1, 2, 1),
(2, 2, 1),
(2, 3, 3),
(3, 1, 1),
(3, 3, 2),
(4, 2, 4),
(4, 3, 1),
(5, 1, 1),
(5, 3, 2),
(6, 2, 3),
(6, 1, 1),
(7, 4, 1),
(7, 5, 2),
(8, 6, 3),
(8, 7, 1),
(9, 8, 2),
(9, 9, 1),
(10, 10, 3),
(10, 11, 2),
(11, 12, 1),
(11, 13, 3),
(12, 4, 2),
(12, 5, 1),
(13, 6, 3),
(13, 7, 2),
(14, 8, 1),
(14, 9, 2),
(15, 10, 3),
(15, 11, 1),
(16, 12, 2),
(16, 13, 3);

-- Customer Queries
-- 1. List all customers with their details.
SELECT * FROM customers;

-- 2. Find a customer by their email address.
SELECT * FROM customers WHERE email = 'johndoe@email.com';

-- 3. Count the total number of customers.
SELECT COUNT(*) AS total_customers FROM customers;

-- 4. Retrieve customers who have made more than one order.
SELECT c.customer_id, c.first_name, c.last_name, COUNT(o.order_id) AS order_count
FROM customers c
JOIN order_table o ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(o.order_id) > 1;

-- 5. Find customers with last names starting with a specific letter (e.g., 'J').
SELECT * FROM customers WHERE last_name LIKE 'J%';

-- Product Queries
-- 6. List all products with their prices.
SELECT * FROM products;

-- 7. Find the product with the highest price.
SELECT * FROM products ORDER BY price DESC LIMIT 1;

-- 8. Count the total number of products.
SELECT COUNT(*) AS total_products FROM products;

-- 9. Retrieve products priced below a certain amount (e.g., 30.00).
SELECT * FROM products WHERE price < 30.00;

-- 10. Find products that have never been ordered.
SELECT * FROM products 
WHERE product_id NOT IN (SELECT DISTINCT product_id FROM order_items);


-- Order Queries
-- 11. List all orders with their details.
SELECT * FROM order_table;

-- 12. Find the order with the highest number of items.
SELECT order_id, SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id
ORDER BY total_items DESC LIMIT 1;

-- 13. Count the total number of orders placed.
SELECT COUNT(order_id) AS total_orders FROM order_table;

-- 14. Retrieve orders placed within a specific date range (e.g., '2023-05-01' to '2023-05-10').
SELECT * FROM order_table WHERE order_date BETWEEN '2023-05-01' AND '2023-05-10';

-- 15. Find orders made by a specific customer (e.g., customer_id = 1).
SELECT c.first_name, c.last_name, o.order_id
FROM customers c 
JOIN order_table o ON c.customer_id = o.customer_id
WHERE o.customer_id = 1;

SELECT * FROM order_table WHERE customer_id = 1;


-- Order Item Queries
-- 16. List all items in a specific order
SELECT * FROM order_items
ORDER BY quantity DESC;

-- 17. Find the total quantity of a specific product sold (e.g., product_id = 1).
SELECT p.product_name, SUM(o.quantity) AS total_quantity
FROM order_items o
JOIN products p ON o.product_id = p.product_id
GROUP BY p.product_id
HAVING p.product_id = 1;

-- 18. Count how many times each product has been ordered.
SELECT product_id, COUNT(*) AS order_count
FROM order_items
GROUP BY product_id; 

-- 19. Retrieve items that were ordered more than a certain quantity (e.g., 2).
SELECT * FROM order_items WHERE quantity > 2;

-- 20. Find orders that include a specific product (e.g., product_id = 1).
SELECT o.order_id, p.product_name
FROM order_items o
JOIN products p ON o.product_id = p.product_id
WHERE o.product_id = 1;


-- Revenue Queries
-- 21. Calculate total revenue generated from all orders.
SELECT SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id;

-- 22. Calculate total revenue generated per product.
SELECT p.product_name, SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_name;

-- 23. Find the day with the highest revenue.
SELECT o.order_date, SUM(p.price * oi.quantity) AS daily_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN order_table o ON oi.order_id = o.order_id
GROUP BY o.order_date
ORDER BY daily_revenue DESC LIMIT 1;

-- 24. Determine the average revenue per order.
SELECT AVG(total_revenue) AS average_revenue
FROM (
    SELECT o.order_id, SUM(p.price * oi.quantity) AS total_revenue
    FROM order_items oi
    JOIN products p ON oi.product_id = p.product_id
    JOIN order_table o ON oi.order_id = o.order_id
    GROUP BY o.order_id
) AS order_revenues;

-- 25. Identify which customer has generated the most revenue.
SELECT c.customer_id, c.first_name, c.last_name, SUM(p.price * oi.quantity) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN order_table o ON oi.order_id = o.order_id
JOIN customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id, c.first_name, c.last_name
ORDER BY total_revenue DESC LIMIT 1;


-- Aggregation and Grouping Queries
-- 26. Find the total number of items sold per order.
SELECT order_id, SUM(quantity) AS total_items
FROM order_items
GROUP BY order_id;

-- 27. Determine the average price of products in the database.
SELECT AVG(price) AS average_price FROM products;

-- 28. Group orders by customer and count the number of orders per customer.
SELECT customer_id, COUNT(order_id) AS order_count
FROM order_table
GROUP BY customer_id;

-- 29. Find the maximum quantity of any product ordered in a single order.
SELECT MAX(quantity) AS max_quantity
FROM order_items;

-- 30. Group products by price range and count the number of products in each range.
SELECT CASE 
         WHEN price BETWEEN 0 AND 20 THEN '0-20'
         WHEN price BETWEEN 21 AND 40 THEN '21-40'
         WHEN price BETWEEN 41 AND 60 THEN '41-60'
         ELSE '61+'
       END AS price_range,
       COUNT(*) AS product_count
FROM products
GROUP BY price_range;


-- Advanced Queries
-- 31. Find the first order date for each customer.
SELECT customer_id, MIN(order_date) AS first_order_date
FROM order_table
GROUP BY customer_id;

-- 32. Retrieve customers who have ordered products above a specific price (e.g., 50).
SELECT DISTINCT c.customer_id, c.first_name, c.last_name, p.product_name, p.price
FROM customers c
JOIN order_table o ON c.customer_id = o.customer_id
JOIN order_items oi ON o.order_id = oi.order_id
JOIN products p ON oi.product_id = p.product_id
WHERE p.price > 50;

-- 33. List all products that have been ordered more than once.
SELECT p.product_id, p.product_name
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
GROUP BY p.product_id, p.product_name
HAVING COUNT(oi.order_id) > 1;

-- 34. Find customers who have never placed an order.
SELECT * FROM customers
WHERE customer_id NOT IN (SELECT DISTINCT customer_id FROM order_table);

-- 35. Retrieve orders placed in the last 30 days.
SELECT * FROM order_table
WHERE order_date >= CURDATE() - INTERVAL 30 DAY;


