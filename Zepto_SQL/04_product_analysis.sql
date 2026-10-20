#13 Find the top 10 product categories by revenue
SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue,
    COUNT(DISTINCT oi.order_id) AS total_orders
FROM order_items oi
JOIN products p
    ON oi.product_id = p.product_id
JOIN orders o
    ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 10;

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

#27 — Identify the highest-revenue category
#Q Which product category generates the most revenue?

SELECT
    p.product_category_name,
    ROUND(SUM(oi.price), 2) AS total_revenue
FROM order_items oi
JOIN products p ON oi.product_id = p.product_id
JOIN orders o ON oi.order_id = o.order_id
WHERE o.order_status = 'delivered'
GROUP BY p.product_category_name
ORDER BY total_revenue DESC
LIMIT 1;	