create database Olist;
use Olist;

-- Create table olist_customers_dataset
drop TABLE customers;
CREATE TABLE customers (
    customer_id VARCHAR(255),
    customer_unique_id VARCHAR(255),
    customer_zip_code_prefix INT,
    customer_city VARCHAR(255),
    customer_state VARCHAR(255)
);
-- Load data from CSV file for olist_customers_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_customers_dataset.csv'
INTO TABLE customers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_geolocation_dataset
drop TABLE geolocation;
CREATE TABLE geolocation (
    geolocation_zip_code_prefix INT,
    geolocation_lat FLOAT,
    geolocation_lng FLOAT,
    geolocation_city VARCHAR(255),
    geolocation_state VARCHAR(255)
);
-- Load data from CSV file for olist_geolocation_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_geolocation_dataset.csv'
INTO TABLE geolocation
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_order_items_dataset with headers
drop TABLE order_items;
CREATE TABLE order_items (
    order_id VARCHAR(255),
    order_item_id INT,
    product_id VARCHAR(255),
    seller_id VARCHAR(255),
    shipping_limit_date DATE,
    price DECIMAL(10, 2),
    freight_value DECIMAL(10, 2)
);
-- Load data from CSV file for olist_order_items_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_items_dataset.csv'
INTO TABLE order_items
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_order_payments_dataset with headers
drop TABLE order_payments;
CREATE TABLE order_payments (
    order_id VARCHAR(255),
    payment_sequential INT,
    payment_type VARCHAR(255),
    payment_installments INT,
    payment_value DECIMAL(10, 2)
);
-- Load data from CSV file for olist_order_payments_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_payments_dataset.csv'
INTO TABLE order_payments
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_order_reviews_dataset with headers
drop TABLE order_reviews;
CREATE TABLE order_reviews (
    review_id VARCHAR(255),
    order_id VARCHAR(255),
    review_score INT,
    review_comment_title VARCHAR(255),
    review_comment_message TEXT,
    review_creation_date DATE,
    review_answer_timestamp DATETIME
);
-- Load data from CSV file for olist_order_reviews_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_order_reviews_dataset.csv'
INTO TABLE order_reviews
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_orders_dataset with headers
drop table orders;
CREATE TABLE orders (
    order_id varchar(255) primary key,
    customer_id varchar(255),
    order_status VARCHAR(255),
    order_purchase_timestamp DATETIME null,
    order_approved_at DATETIME null,
    order_delivered_carrier_date DATETIME null,
    order_delivered_customer_date DATETIME null,
    order_estimated_delivery_date DATETIME null
);
-- Load data from CSV file for olist_orders_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_orders_dataset.csv'
INTO TABLE orders
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_products_dataset with headers
drop TABLE products;
CREATE TABLE products (
    product_id VARCHAR(255),
    product_category_name VARCHAR(255),
    product_name_length INT,
    product_description_length INT,
    product_photos_qty INT,
    product_weight_g INT,
    product_length_cm INT,
    product_height_cm INT,
    product_width_cm INT
);
-- Load data from CSV file for olist_products_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_products_dataset.csv'
INTO TABLE products
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


-- Create table olist_sellers_dataset with headers
drop TABLE sellers;
CREATE TABLE sellers (
    seller_id VARCHAR(255),
    seller_zip_code_prefix INT,
    seller_city VARCHAR(255),
    seller_state VARCHAR(255)
);
-- Load data from CSV file for olist_sellers_dataset
LOAD DATA INFILE 'C:/ProgramData/MySQL/MySQL Server 8.0/Uploads/olist_sellers_dataset.csv'
INTO TABLE sellers
FIELDS TERMINATED BY ',' ENCLOSED BY '"' 
IGNORE 1 LINES;


SHOW VARIABLES LIKE "secure_file_priv";


-- Weekday Vs Weekend (order_purchase_timestamp) Payment Statistics
SELECT 
    CASE 
        WHEN DAYOFWEEK(order_purchase_timestamp) IN (1, 7) THEN 'Weekend' 
        ELSE 'Weekday' 
    END AS Day_Type,
    CONCAT(FORMAT(COUNT(DISTINCT o.order_id) / 1000, 2), 'K') AS Num_Orders,
     CONCAT(FORMAT(SUM(payment_value)/1000000, 2), 'M') AS Payment_Value
FROM 
    order_payments op
    JOIN orders o ON op.order_id = o.order_id
GROUP BY 
    Day_Type;



-- Number of Orders with review score 5 and payment type as credit card.
SELECT 
    CONCAT(FORMAT(COUNT(DISTINCT r.order_id)/1000, 2), 'K') AS Num_Orders
FROM 
    order_reviews r
    JOIN order_payments p ON r.order_id = p.order_id
WHERE 
    r.review_score = 5
    AND p.payment_type = 'credit_card';
    
    

-- Average number of days taken for order_delivered_customer_date for pet_shop
SELECT 
    AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)) AS Avg_Delivery_Time
FROM 
    orders
WHERE 
    order_id IN (SELECT order_id FROM order_items WHERE product_id IN (SELECT product_id FROM products WHERE product_category_name = 'pet_shop'));


-- Average price and payment values from customers of sao paulo city
/*SELECT 
    AVG(oi.price) AS Avg_Price,
    AVG(op.payment_value) AS Avg_Payment_Value
FROM 
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN order_payments op ON o.order_id = op.order_id
    JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    c.customer_city = 'Sao Paulo';*/
    
# Price
SELECT 
    AVG(oi.price) AS Avg_Price
FROM 
    orders o
    JOIN order_items oi ON o.order_id = oi.order_id
    JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    c.customer_city = 'Sao Paulo';

# Payment_value
SELECT 
    AVG(op.payment_value) AS Avg_Payment_Value
FROM 
    orders o
    JOIN order_payments op ON o.order_id = op.order_id
    JOIN customers c ON o.customer_id = c.customer_id
WHERE 
    c.customer_city = 'Sao Paulo';


-- Relationship between shipping days (order_delivered_customer_date - order_purchase_timestamp) Vs review scores.
SELECT 
    review_score,
    round(AVG(DATEDIFF(order_delivered_customer_date, order_purchase_timestamp)),0) AS Avg_Shipping_Days
FROM 
    order_reviews r
    JOIN orders o ON r.order_id = o.order_id
WHERE 
    order_delivered_customer_date IS NOT NULL
GROUP BY 
    review_score
ORDER BY 
    review_score;