-- ================================================================
-- E-COMMERCE SQL PROJECT
-- Commented version of the original MySQL Workbench SQL file.
-- Single-line comments explain tables, relationships, analysis,
-- JOIN connections, CTEs, window functions, views, and indexes.
-- The original SQL statements and data have been preserved.
-- ================================================================

-- Create the main e-commerce database.
CREATE DATABASE ecommerce_db;

-- Select the e-commerce database so all following objects are created inside it.
USE ecommerce_db;

-- Check which database is currently selected.
SELECT DATABASE();

-- TABLE 1: Customers. Stores customer personal/contact and location information.
-- Table 1 this is --
CREATE TABLE customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    created_at DATE
);

-- Display all tables currently available in the selected database.
SHOW TABLES;

-- Show the structure and columns of the customers table.
DESCRIBE customers;

-- Insert sample customer records into the customers table.
INSERT INTO customers
(customer_name, email, phone, city, state, created_at)
VALUES
('Rajesh', 'rajesh@gmail.com', '7032164857', 'Madanapalle', 'Andhra Pradesh', '2026-09-30'),
('Paaru', 'paaru@gmail.com', '7032164858', 'Bengaluru', 'Karnataka', '2026-09-30'),
('Vikram Singh', 'vikram@gmail.com', '9876543212', 'Chennai', 'Tamil Nadu', '2026-02-05'),
('Priya Sharma', 'priya@gmail.com', '9876543213', 'Hyderabad', 'Telangana', '2026-02-12'),
('Arun Kumar', 'arun@gmail.com', '9876543214', 'Madanapalle', 'Andhra Pradesh', '2026-03-01');

-- Display all customer records to verify the inserted data.
SELECT * FROM customers;

-- TABLE 2: Categories. Stores the product category names.
-- Table 2 this is --
CREATE TABLE categories (
    category_id INT PRIMARY KEY AUTO_INCREMENT,
    category_name VARCHAR(100) NOT NULL UNIQUE
);

-- Insert the available product categories.
INSERT INTO categories (category_name)
VALUES
('Electronics'),
('Clothing'),
('Footwear'),
('Books'),
('Home Appliances');

-- Display all category records to verify the inserted data.
SELECT * FROM categories;

-- TABLE 3: Products. Stores products and connects each product to a category.
 -- Table 3 this is --
-- Create the products table.
CREATE TABLE products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(150) NOT NULL,
    category_id INT,
    price DECIMAL(10,2) NOT NULL,
    stock_quantity INT DEFAULT 0,
    brand VARCHAR(100),
    created_at DATE,

-- Connect products.category_id to categories.category_id using a foreign key.
    FOREIGN KEY (category_id)
        REFERENCES categories(category_id)
);

-- Insert sample products and connect each product to its category.
INSERT INTO products
(product_name, category_id, price, stock_quantity, brand, created_at)
VALUES
('Wireless Mouse', 1, 799.00, 50, 'Logitech', '2026-01-05'),
('Bluetooth Headphones', 1, 1499.00, 30, 'Boat', '2026-01-08'),
('Cotton T-Shirt', 2, 599.00, 100, 'Puma', '2026-01-12'),
('Running Shoes', 3, 2499.00, 40, 'Nike', '2026-01-20'),
('SQL Programming Book', 4, 699.00, 25, 'OReilly', '2026-02-01'),
('Mixer Grinder', 5, 3499.00, 20, 'Philips', '2026-02-10');

-- Display all product records to verify the inserted data.
SELECT * FROM products;

-- TABLE 4: Orders. Stores customer orders and connects each order to a customer.
-- ODERS TABLE --

-- Create the orders table.
CREATE TABLE orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    order_date DATE NOT NULL,
    order_status VARCHAR(30) DEFAULT 'Pending',
    total_amount DECIMAL(10,2),

-- Connect orders.customer_id to customers.customer_id using a foreign key.
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id)
);

-- Insert sample orders and connect each order to a customer.
INSERT INTO orders
(customer_id, order_date, order_status, total_amount)
VALUES
(1, '2026-03-01', 'Delivered', 2298.00),
(2, '2026-03-03', 'Shipped', 2499.00),
(3, '2026-03-05', 'Pending', 699.00),
(1, '2026-03-07', 'Delivered', 3499.00),
(4, '2026-03-10', 'Cancelled', 599.00);

-- Display all order records to verify the inserted data.
SELECT * FROM orders;

-- TABLE 5: Order Items. Connects orders and products and stores quantity and selling price.
-- ORDER ITEMS --

-- Create the order_items table.
CREATE TABLE order_items (
    order_item_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    product_id INT NOT NULL,
    quantity INT NOT NULL,
    price DECIMAL(10,2) NOT NULL,

-- Connect each order item to its order through order_id.
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id),

-- Connect each order item to its product through product_id.
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Insert products into orders through the order_items relationship.
INSERT INTO order_items
(order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 799.00),
(1, 2, 1, 1499.00),
(2, 4, 1, 2499.00),
(3, 5, 1, 699.00),
(4, 6, 1, 3499.00),
(5, 3, 1, 599.00);

-- Display all order item records.
SELECT * FROM order_items;

-- TABLE 6: Payments. Stores payment information and connects each payment to an order.
-- PAYEMENTS TABLE ==

-- Create the payments table.
CREATE TABLE payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT NOT NULL,
    payment_method VARCHAR(30),
    payment_status VARCHAR(30),
    payment_date DATE,

-- Connect payments.order_id to orders.order_id using a foreign key.
    FOREIGN KEY (order_id)
        REFERENCES orders(order_id)
);

-- Insert sample payment records for the orders.
INSERT INTO payments
(order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'UPI', 'Paid', '2026-03-01'),
(2, 'Credit Card', 'Paid', '2026-03-03'),
(3, 'Cash on Delivery', 'Pending', NULL),
(4, 'UPI', 'Paid', '2026-03-07'),
(5, 'UPI', 'Refunded', '2026-03-10');

-- Insert the same payment records again. This is preserved from your original file; running both inserts creates duplicate payment rows and may fail if a constraint is later added.
INSERT INTO payments
(order_id, payment_method, payment_status, payment_date)
VALUES
(1, 'UPI', 'Paid', '2026-03-01'),
(2, 'Credit Card', 'Paid', '2026-03-03'),
(3, 'Cash on Delivery', 'Pending', NULL),
(4, 'UPI', 'Paid', '2026-03-07'),
(5, 'UPI', 'Refunded', '2026-03-10');

-- Display all payment records.
SELECT * FROM payments;

-- TABLE 7: Reviews. Stores customer reviews and connects customers to products.
-- REVIEWS TABLE --

-- Create the reviews table.
CREATE TABLE reviews (
    review_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT NOT NULL,
    product_id INT NOT NULL,
    rating INT,
    review_text VARCHAR(500),
    review_date DATE,

-- Connect each review to the customer who wrote it.
    FOREIGN KEY (customer_id)
        REFERENCES customers(customer_id),

-- Connect each review to the product being reviewed.
    FOREIGN KEY (product_id)
        REFERENCES products(product_id)
);

-- Insert sample customer reviews and connect them to customers and products.
INSERT INTO reviews
(customer_id, product_id, rating, review_text, review_date)
VALUES
(1, 1, 5, 'Very good mouse', '2026-03-05'),
(2, 4, 4, 'Comfortable shoes', '2026-03-08'),
(3, 5, 5, 'Easy to understand', '2026-03-09'),
(4, 3, 3, 'Good quality', '2026-03-12');
-- Main review-data check.
-- main code this is --
-- Display all review records.
SELECT * FROM reviews;

-- Verify that all seven main tables exist.
SHOW TABLES;

-- Display all customers.
SELECT * FROM customers;
-- Display all categories.
SELECT * FROM categories;
-- Display all products.
SELECT * FROM products;
-- Display all orders.
SELECT * FROM orders;
-- Display all order items.
SELECT * FROM order_items;
-- Display all payments.
SELECT * FROM payments;
-- Display all reviews.
SELECT * FROM reviews;

-- BUSINESS ANALYSIS: Count the total number of customers.
-- QUESTIONS --
SELECT COUNT(*) AS total_customers
FROM customers;

-- BUSINESS ANALYSIS: Count the total number of products.
SELECT COUNT(*) AS total_products
FROM products;

-- BUSINESS ANALYSIS: Calculate sales excluding cancelled orders.
SELECT SUM(total_amount) AS total_sales
FROM orders
WHERE order_status != 'Cancelled';

-- BUSINESS ANALYSIS: Show product details, prices, brands, and stock.
SELECT
    product_id,
    product_name,
    brand,
    price,
    stock_quantity
FROM products;


-- BUSINESS ANALYSIS: Find products with stock below 30 units.
SELECT
    product_name,
    stock_quantity
FROM products
WHERE stock_quantity < 30;

-- JOIN ANALYSIS: Connect customers with their orders using customer_id.
SELECT
    c.customer_id,
    c.customer_name,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
-- Connect customers to orders through customer_id.
INNER JOIN orders o
    ON c.customer_id = o.customer_id;

-- JOIN ANALYSIS: Connect orders with customers to show customer and order details.
    SELECT
    o.order_id,
    c.customer_name,
    c.city,
    o.order_date,
    o.order_status,
    o.total_amount
FROM orders o
-- Connect orders to customers through customer_id.
INNER JOIN customers c
    ON o.customer_id = c.customer_id;


-- JOIN ANALYSIS: Connect products with categories using category_id.
    SELECT
    p.product_id,
    p.product_name,
    p.brand,
    p.price,
    c.category_name
FROM products p
-- Connect products to categories through category_id.
INNER JOIN categories c
    ON p.category_id = c.category_id;

-- JOIN ANALYSIS: Connect customers, orders, and order_items to show ordered items.
    SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    oi.product_id,
    oi.quantity,
    oi.price
FROM customers c
-- Connect customers to orders through customer_id.
INNER JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/customers to order_items through order_id.
INNER JOIN order_items oi
    ON o.order_id = oi.order_id;

-- JOIN ANALYSIS: Connect customers, orders, order_items, and products to show complete order details.
    SELECT
    c.customer_name,
    o.order_id,
    o.order_date,
    p.product_name,
    p.brand,
    oi.quantity,
    oi.price
FROM customers c
-- Connect customers to orders through customer_id.
INNER JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/customers to order_items through order_id.
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
-- Connect order_items to products through product_id.
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- JOIN ANALYSIS: Calculate revenue for each ordered product item.
    SELECT
    c.customer_name,
    p.product_name,
    oi.quantity,
    oi.price,
    oi.quantity * oi.price AS item_revenue
FROM customers c
-- Connect customers to orders through customer_id.
INNER JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/customers to order_items through order_id.
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
-- Connect order_items to products through product_id.
INNER JOIN products p
    ON oi.product_id = p.product_id;

-- CUSTOMER REPORT: Calculate each customer's non-cancelled orders and total spending.
  -- customer report --
  SELECT
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
-- Connect customers to orders through customer_id.
INNER JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/customers to order_items through order_id.
INNER JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name
ORDER BY total_spent DESC;

-- GROUP BY ANALYSIS: Count customers by city.
-- analsys --
SELECT
    city,
    COUNT(*) AS total_customers
FROM customers
GROUP BY city;

-- GROUP BY ANALYSIS: Count products in each category, including categories with no products.
SELECT
    c.category_name,
    COUNT(p.product_id) AS total_products
FROM categories c
-- Keep every category and connect matching products when available.
LEFT JOIN products p
    ON c.category_id = p.category_id
GROUP BY c.category_id, c.category_name;

-- GROUP BY ANALYSIS: Calculate total spending for each customer.
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_spent DESC;

-- HAVING ANALYSIS: Show customers whose spending is greater than 1000.
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.price) > 1000
ORDER BY total_spent DESC;

-- PRODUCT SALES ANALYSIS: Calculate units sold and revenue for each product.
-- product sales analsys --
SELECT
    p.product_name,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY p.product_id, p.product_name
HAVING SUM(oi.quantity * oi.price) > 1000
ORDER BY total_revenue DESC;

-- CATEGORY SALES ANALYSIS: Calculate revenue generated by each category.
SELECT
    c.category_name,
    SUM(oi.quantity * oi.price) AS category_revenue
FROM categories c
-- Connect order_items to products through product_id.
JOIN products p
    ON c.category_id = p.category_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.category_id, c.category_name
ORDER BY category_revenue DESC;

-- ORDER ANALYSIS: Count non-cancelled orders for each customer.
SELECT
    c.customer_name,
    COUNT(o.order_id) AS total_orders
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
ORDER BY total_orders DESC;

-- SUBQUERY: Calculate the average product price.
SELECT AVG(price)
FROM products;

-- SUBQUERY: Find products priced above the overall average price.
SELECT
    product_name,
    price
FROM products
WHERE price > (
    SELECT AVG(price)
    FROM products
);

-- SUBQUERY: Find customers who have placed at least one order.
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE customer_id IN (
    SELECT customer_id
    FROM orders
);

-- SUBQUERY: Find customers who have not placed any orders.
SELECT
    customer_id,
    customer_name,
    email
FROM customers
WHERE customer_id NOT IN (
    SELECT customer_id
    FROM orders
);

-- SUBQUERY: Calculate the average value of non-cancelled orders.
SELECT AVG(total_amount)
FROM orders
WHERE order_status <> 'Cancelled';

-- SUBQUERY: Find non-cancelled orders above the average order value.
SELECT
    order_id,
    customer_id,
    total_amount,
    order_status
FROM orders
WHERE order_status <> 'Cancelled'
AND total_amount > (
    SELECT AVG(total_amount)
    FROM orders
    WHERE order_status <> 'Cancelled'
);

-- SUBQUERY: Find the most expensive product.
SELECT
    product_name,
    price
FROM products
WHERE price = (
    SELECT MAX(price)
    FROM products
);

-- SUBQUERY: Find products priced higher than every Electronics product.
SELECT
    product_name,
    price
FROM products
WHERE price > ALL (
    SELECT p.price
    FROM products p
-- Connect products to categories through category_id.
    JOIN categories c
        ON p.category_id = c.category_id
    WHERE c.category_name = 'Electronics'
);

-- NESTED SUBQUERY: Find the customer or customers with the highest total spending.
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name
HAVING SUM(oi.quantity * oi.price) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT
            SUM(oi2.quantity * oi2.price) AS customer_total
        FROM orders o2
-- Connect orders/products to order_items through the related order_id or product_id.
        JOIN order_items oi2
            ON o2.order_id = oi2.order_id
        WHERE o2.order_status <> 'Cancelled'
        GROUP BY o2.customer_id
    ) AS customer_sales
);

-- CASE ANALYSIS: Classify products by price level.
SELECT
    product_name,
    price,
    CASE
        WHEN price >= 2000 THEN 'Expensive'
        WHEN price >= 1000 THEN 'Medium'
        ELSE 'Affordable'
    END AS price_category
FROM products;

-- CASE ANALYSIS: Classify products by current stock level.
SELECT
    product_name,
    stock_quantity,
    CASE
        WHEN stock_quantity = 0 THEN 'Out of Stock'
        WHEN stock_quantity < 20 THEN 'Low Stock'
        WHEN stock_quantity < 50 THEN 'Medium Stock'
        ELSE 'Good Stock'
    END AS stock_status
FROM products;

-- CASE ANALYSIS: Convert order statuses into business categories.
SELECT
    order_id,
    total_amount,
    order_status,
    CASE
        WHEN order_status = 'Delivered' THEN 'Completed'
        WHEN order_status = 'Shipped' THEN 'In Progress'
        WHEN order_status = 'Pending' THEN 'Waiting'
        WHEN order_status = 'Cancelled' THEN 'Cancelled'
        ELSE 'Other'
    END AS order_category
FROM orders;

-- CASE ANALYSIS: Classify customers by their total spending.
SELECT
    c.customer_name,
    SUM(oi.quantity * oi.price) AS total_spent,
    CASE
        WHEN SUM(oi.quantity * oi.price) >= 3000 THEN 'High Value'
        WHEN SUM(oi.quantity * oi.price) >= 1500 THEN 'Medium Value'
        ELSE 'Low Value'
    END AS customer_category
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY c.customer_id, c.customer_name;

-- CASE ANALYSIS: Convert payment statuses into business categories.
SELECT
    payment_id,
    order_id,
    payment_method,
    payment_status,
    CASE
        WHEN payment_status = 'Paid' THEN 'Successful'
        WHEN payment_status = 'Pending' THEN 'Waiting'
        WHEN payment_status = 'Refunded' THEN 'Returned'
        ELSE 'Other'
    END AS payment_category
FROM payments;

-- CASE ANALYSIS: Classify orders by their total value.
SELECT
    o.order_id,
    c.customer_name,
    o.total_amount,
    o.order_status,
    CASE
        WHEN o.total_amount >= 3000 THEN 'High Value Order'
        WHEN o.total_amount >= 1500 THEN 'Medium Value Order'
        ELSE 'Low Value Order'
    END AS order_value_category
FROM orders o
-- Connect related tables using the matching key.
JOIN customers c
    ON o.customer_id = c.customer_id
ORDER BY o.total_amount DESC;

-- CTE: Calculate the average product price and show it beside every product.
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT
    product_name,
    price,
    avg_price
FROM products
-- Combine each row from the main query with the single calculated value from the CTE.
CROSS JOIN average_price;

-- CTE: Find products priced above the average product price.
WITH average_price AS (
    SELECT AVG(price) AS avg_price
    FROM products
)
SELECT
    p.product_name,
    p.price
FROM products p
-- Combine each row from the main query with the single calculated value from the CTE.
CROSS JOIN average_price a
WHERE p.price > a.avg_price;

-- CTE: Calculate total spending for each customer.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT *
FROM customer_sales
ORDER BY total_spent DESC;

-- CTE: Calculate customer spending and then filter high-value customers.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent
FROM customer_sales
WHERE total_spent > 2000
ORDER BY total_spent DESC;

-- CTE: Calculate units sold and revenue for each product.
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity) AS units_sold,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY p.product_id, p.product_name
)
SELECT *
FROM product_sales
ORDER BY revenue DESC;

-- CTE + CASE: Classify products according to their revenue.
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_name,
    revenue,
    CASE
        WHEN revenue >= 3000 THEN 'High Revenue'
        WHEN revenue >= 1500 THEN 'Medium Revenue'
        ELSE 'Low Revenue'
    END AS revenue_category
FROM product_sales
ORDER BY revenue DESC;

-- MULTIPLE CTEs: Calculate customer spending and the average customer spending.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
),
customer_average AS (
    SELECT AVG(total_spent) AS avg_spending
    FROM customer_sales
)
SELECT
    cs.customer_name,
    cs.total_spent,
    ca.avg_spending
FROM customer_sales cs
-- Combine each row from the main query with the single calculated value from the CTE.
CROSS JOIN customer_average ca
WHERE cs.total_spent > ca.avg_spending
ORDER BY cs.total_spent DESC;

--

-- WINDOW FUNCTION: Assign a unique row number to customers by spending.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    ROW_NUMBER() OVER (
        ORDER BY total_spent DESC
    ) AS customer_rank
FROM customer_sales;


-- WINDOW FUNCTION: Rank customers by spending; ties receive the same rank.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_sales;

-- WINDOW FUNCTION: Dense-rank customers by spending without gaps after ties.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
)
SELECT
    customer_name,
    total_spent,
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_sales;

-- WINDOW FUNCTION: Rank products by revenue.
WITH product_sales AS (
    SELECT
        p.product_id,
        p.product_name,
        SUM(oi.quantity * oi.price) AS revenue
    FROM products p
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY p.product_id, p.product_name
)
SELECT
    product_name,
    revenue,
    RANK() OVER (
        ORDER BY revenue DESC
    ) AS revenue_rank
FROM product_sales;

-- WINDOW FUNCTION: Calculate a running total of non-cancelled order amounts.
SELECT
    order_id,
    order_date,
    total_amount,
    SUM(total_amount) OVER (
        ORDER BY order_date, order_id
    ) AS running_total
FROM orders
WHERE order_status <> 'Cancelled';

-- WINDOW FUNCTION: Calculate the average value of all non-cancelled orders.
SELECT
    order_id,
    customer_id,
    total_amount,
    AVG(total_amount) OVER () AS average_order_value
FROM orders
WHERE order_status <> 'Cancelled';

-- WINDOW FUNCTION: Compare each order amount with the average order value.
SELECT
    order_id,
    customer_id,
    total_amount,
    AVG(total_amount) OVER () AS average_order_value,
    total_amount -
        AVG(total_amount) OVER () AS difference_from_average
FROM orders
WHERE order_status <> 'Cancelled';

-- CTE + WINDOW FUNCTION: Rank customers and return the top three spending customers.
WITH customer_sales AS (
    SELECT
        c.customer_id,
        c.customer_name,
        SUM(oi.quantity * oi.price) AS total_spent
    FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
    JOIN orders o
        ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status <> 'Cancelled'
    GROUP BY c.customer_id, c.customer_name
),
ranked_customers AS (
    SELECT
        customer_name,
        total_spent,
        RANK() OVER (
            ORDER BY total_spent DESC
        ) AS customer_rank
    FROM customer_sales
)
SELECT
    customer_name,
    total_spent,
    customer_rank
FROM ranked_customers
WHERE customer_rank <= 3;

-- VIEW: Create a reusable view containing customer and order information.
CREATE VIEW customer_orders_view AS
SELECT
    c.customer_id,
    c.customer_name,
    c.city,
    o.order_id,
    o.order_date,
    o.order_status,
    o.total_amount
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id;

-- Test the customer_orders_view view.
    SELECT *
FROM customer_orders_view;

-- VIEW: Create a reusable product sales and revenue report.
CREATE VIEW product_sales_view AS
SELECT
    p.product_id,
    p.product_name,
    p.brand,
    SUM(oi.quantity) AS units_sold,
    SUM(oi.quantity * oi.price) AS total_revenue
FROM products p
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON p.product_id = oi.product_id
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    p.product_id,
    p.product_name,
    p.brand;

-- Test the product_sales_view view.
    SELECT *
FROM product_sales_view;

-- Show product sales ordered from highest to lowest revenue.
SELECT *
FROM product_sales_view
ORDER BY total_revenue DESC;

-- VIEW: Create a reusable customer spending report.
CREATE VIEW customer_spending_view AS
SELECT
    c.customer_id,
    c.customer_name,
    COUNT(DISTINCT o.order_id) AS total_orders,
    SUM(oi.quantity * oi.price) AS total_spent
FROM customers c
-- Connect customers/products to orders through the related order_id or customer_id.
JOIN orders o
    ON c.customer_id = o.customer_id
-- Connect orders/products to order_items through the related order_id or product_id.
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status <> 'Cancelled'
GROUP BY
    c.customer_id,
    c.customer_name;

-- Test the customer_spending_view view.
    SELECT *
FROM customer_spending_view
ORDER BY total_spent DESC;

-- VIEW: Create a reusable order and payment report.
CREATE VIEW order_report_view AS
SELECT
    o.order_id,
    c.customer_name,
    o.order_date,
    o.order_status,
    o.total_amount,
    p.payment_method,
    p.payment_status
FROM orders o
-- Connect related tables using the matching key.
JOIN customers c
    ON o.customer_id = c.customer_id
-- Keep every order and connect matching payment information when available.
LEFT JOIN payments p
    ON o.order_id = p.order_id;

-- Test the order_report_view view.
    SELECT *
FROM order_report_view;

-- Show all views available in the current database.
SHOW FULL TABLES
WHERE TABLE_TYPE = 'VIEW';

-- Display the SQL definition of the product_sales_view view.
SHOW CREATE VIEW product_sales_view;

-- Use the product sales view to find products with revenue above 1000.
SELECT
    product_name,
    units_sold,
    total_revenue
FROM product_sales_view
WHERE total_revenue > 1000
ORDER BY total_revenue DESC;

-- INDEX CHECK: Display indexes currently defined on customers.
SHOW INDEX FROM customers;
-- INDEX CHECK: Display indexes currently defined on products.
SHOW INDEX FROM products;

-- INDEX: Speed up searches that filter customers by city.
CREATE INDEX idx_customers_city
ON customers(city);

-- Verify the customer city index.
SHOW INDEX FROM customers;

-- INDEX: Speed up searches and sorting that use order_date.
CREATE INDEX idx_orders_order_date
ON orders(order_date);

-- INDEX: Speed up searches that filter orders by order_status.
CREATE INDEX idx_orders_status
ON orders(order_status);

-- Test a query that filters orders by delivery status.
SELECT *
FROM orders
WHERE order_status = 'Delivered';

-- INDEX: Speed up searches that filter products by price.
CREATE INDEX idx_products_price
ON products(price);

-- Test a query that filters products by price.
SELECT *
FROM products
WHERE price > 2000;

-- EXPLAIN: Inspect how MySQL plans to execute a customer city search.
EXPLAIN
SELECT *
FROM customers
WHERE city = 'Madanapalle';

-- EXPLAIN: Inspect how MySQL plans to execute an order status search.
EXPLAIN
SELECT *
FROM orders
WHERE order_status = 'Delivered';

-- Test a query that filters orders by both customer and status.
SELECT *
FROM orders
WHERE customer_id = 1
AND order_status = 'Delivered';

-- COMPOSITE INDEX: Optimize searches using customer_id together with order_status.
CREATE INDEX idx_orders_customer_status
ON orders(customer_id, order_status);

-- Verify indexes on the orders table.
SHOW INDEX FROM orders;

-- Verify indexes on the products table.
SHOW INDEX FROM products;


-- STORED PROCEDURE SECTION: Change the delimiter so a procedure can contain semicolons.
DELIMITER $$

-- Remove the existing procedure first so it can be recreated safely.
DROP PROCEDURE IF EXISTS GetCustomerOrders$$
`