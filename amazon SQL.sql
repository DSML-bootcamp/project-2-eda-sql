use amazon;

RENAME TABLE amazon_v2 TO amazon;

select count(*) from amazon;

# 1. What is the total revenue per month?
SELECT order_month, SUM(order_amount) AS total_revenue
FROM orders
GROUP BY order_month;



# 2. What is the growth (or decrease) rate?


# 3. What is the Revenue by Category?
SELECT p.product_category, SUM(order_amount) AS total_revenue
FROM products
LEFT JOIN orders on p.sku = o.sku
GROUP BY p.product_category
;


# 4. What is the revenue share by Category? #TEST IT WITH INNER JOIN
SELECT p.product_category, SUM(o.order_amount) / (SELECT SUM(order_amount) FROM orders) AS revenue_share
FROM orders o
LEFT JOIN products p ON o.sku = p.sku
GROUP BY p.product_category;


# 5. What is the average price per category?
SELECT p.product_category, SUM(o.order_amount)/SUM(o.order_quantity) as avg_price
FROM orders o
LEFT JOIN products p ON o.sku = p.sku
GROUP BY p.product_category;


# 6. How many orders got cancelled? and % on total
SELECT COUNT(*) as cancelled_orders
FROM orders
WHERE ship_status IN ('Cancelled', 'Shipped - Lost in Transit')
;


# 7. How many orders got returned? and % on total
SELECT COUNT(*) as returned_orders
FROM orders
WHERE ship_status IN ('Shipped - Returned to Seller', 'Shipped - Returning to Seller', 'Shipped - Rejected by Buyer', 'Shipped - Damaged')
;


# 8. What are the most popular category by state?
SELECT o.state, p.product_category, COUNT(*) AS order_count
FROM orders o
INNER JOIN products p ON o.sku = p.sku
GROUP BY o.state, p.product_category
ORDER BY o.state, order_count DESC;

# 9. What is the AOV by customer type?
SELECT customer_type, AVG(order_amount) AS AOV
FROM orders
GROUP BY customer_type;

# 10. What is the most ordered size by category?
-- Subquery to count the number of orders per size within each category
WITH size_order_count as (
	SELECT p.product_category, p.size, COUNT(o.order_ID) as order_count
    FROM orders o 
    JOIN products p ON o.sku = p.sku
    GROUP BY p.product_category, p.size),
    
-- Subquery to get the max orders per category
max_size_counts AS (
	SELECT product_category, MAX(order_count) as max_order_count
    FROM size_order_count
    GROUP BY product_category)
    
-- Final query to get the most ordered size by category
SELECT s.product_category, s.size, s.order_count
FROM size_order_count s
JOIN max_size_counts m ON s.product_category = m.product_category
GROUP BY s.product_category, s.size
ORDER BY s.order_count DESC;

# now with selecting only 1 size per category
WITH size_order_counts AS (
    -- Subquery to count the number of orders per size within each category
    SELECT 
        p.product_category,
        p.size,
        COUNT(o.order_ID) AS order_count,
        ROW_NUMBER() OVER (PARTITION BY p.product_category ORDER BY COUNT(o.order_ID) DESC) AS size_rank
        -- window function ROW_NUMBER() to assign ranks to sizes within each category based on their order counts. 
    FROM 
        orders o
    JOIN 
        products p ON o.sku = p.sku
    GROUP BY 
        p.product_category,
        p.size
),
max_size_order_counts AS (
    -- Subquery to find the maximum order count per category
    SELECT 
        product_category,
        MAX(order_count) AS max_order_count
    FROM 
        size_order_counts
    GROUP BY 
        product_category
)

-- Final query to get the most ordered size by category
SELECT 
    soc.product_category,
    soc.size,
    soc.order_count
FROM 
    size_order_counts soc
JOIN 
    max_size_order_counts m
ON 
    soc.product_category = m.product_category
    AND soc.order_count = m.max_order_count
WHERE
    soc.size_rank = 1
ORDER BY 
    soc.order_count DESC;
