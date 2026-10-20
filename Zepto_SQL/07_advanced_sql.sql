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

#22  Rank products by revenue
#Q:What are the top three products by revenue within each category? 
WITH product_sales AS (
    SELECT
        p.product_category_name,
        p.product_id,
        SUM(oi.price) AS revenue
    FROM order_items oi
    JOIN products p
        ON oi.product_id = p.product_id
    JOIN orders o
        ON oi.order_id = o.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY
        p.product_category_name,
        p.product_id
),
ranked_products AS (
    SELECT
        product_category_name,
        product_id,
        revenue,
        RANK() OVER (
            PARTITION BY product_category_name
            ORDER BY revenue DESC
        ) AS product_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE product_rank <= 3
ORDER BY product_category_name, product_rank;

#24  Monthly revenue with a running total
#Q: How does cumulative revenue increase over time?

WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(
            o.order_purchase_timestamp, '%Y-%m'
        ) AS order_month,
        SUM(oi.price) AS revenue
    FROM orders o
    JOIN order_items oi
        ON o.order_id = oi.order_id
    WHERE o.order_status = 'delivered'
    GROUP BY DATE_FORMAT(
        o.order_purchase_timestamp, '%Y-%m'
    )
)
SELECT
    order_month,
    ROUND(revenue, 2) AS monthly_revenue,
    ROUND(
        SUM(revenue) OVER (
            ORDER BY order_month
            ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
        ),
        2
    ) AS cumulative_revenue
FROM monthly_sales
ORDER BY order_month;

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

