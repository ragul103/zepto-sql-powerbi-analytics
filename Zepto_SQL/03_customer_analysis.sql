#17 Customer spending analysis

SELECT
    c.customer_unique_id,
    c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY
    c.customer_unique_id,
    c.customer_city
ORDER BY total_spent DESC
LIMIT 10;

#18 Find repeat customers
SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_spent
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_unique_id
HAVING COUNT(DISTINCT o.order_id) > 1
ORDER BY total_orders DESC, total_spent DESC;

#19  Orders by city
SELECT
    c.customer_city,
    COUNT(DISTINCT o.order_id) AS total_orders,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM customers c
JOIN orders o
    ON c.customer_id = o.customer_id
JOIN order_items oi
    ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_city
ORDER BY total_revenue DESC
LIMIT 10;

#21 CTE: Customers spending above average
#Q:Which customers spend more than the average customer?
WITH customer_spending AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    ROUND(total_spent, 2) AS total_spent
FROM customer_spending
WHERE total_spent > (
    SELECT AVG(total_spent)
    FROM customer_spending
)
ORDER BY total_spent DESC;


#23  Rank customers by spending
#Who are the highest-spending customers?
WITH customer_sales AS (
    SELECT
        c.customer_unique_id,
        SUM(oi.price) AS total_spent
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY c.customer_unique_id
)
SELECT
    customer_unique_id,
    ROUND(total_spent, 2) AS total_spent,
    DENSE_RANK() OVER (
        ORDER BY total_spent DESC
    ) AS spending_rank
FROM customer_sales
ORDER BY spending_rank
LIMIT 20;

#25 Compare customer spending with the previous order
#Q For customers who ordered more than once, how does each order's value compare with their previous order?

WITH order_spending AS (
    SELECT
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp,
        SUM(oi.price) AS order_value
    FROM customers c
    JOIN orders o
        ON c.customer_id = o.customer_id
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        c.customer_unique_id,
        o.order_id,
        o.order_purchase_timestamp
),
previous_orders AS (
    SELECT
        customer_unique_id,
        order_id,
        order_purchase_timestamp,
        order_value,
        LAG(order_value) OVER (
            PARTITION BY customer_unique_id
            ORDER BY order_purchase_timestamp
        ) AS previous_order_value
    FROM order_spending
)
SELECT
    customer_unique_id,
    order_id,
    ROUND(order_value, 2) AS order_value,
    ROUND(previous_order_value, 2) AS previous_order_value
FROM previous_orders
WHERE previous_order_value IS NOT NULL
ORDER BY customer_unique_id, order_purchase_timestamp;
