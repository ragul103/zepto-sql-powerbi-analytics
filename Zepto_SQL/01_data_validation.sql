USE ECOMMERCE;

#1 check Order Status
SELECT
    order_status,
    COUNT(*) AS total_orders
FROM orders GROUP BY order_status ORDER BY total_orders DESC;

#2 Check missing customer IDs
SELECT COUNT(*) AS missing_customer_ids
FROM orders
WHERE customer_id IS NULL;

#3 Check duplicate order IDs
SELECT
    order_id,
    COUNT(*) AS occurrences
FROM orders
GROUP BY order_id
HAVING COUNT(*) > 1;

#4 Check whether all orders have matching customers
SELECT COUNT(*) AS unmatched_orders
FROM orders o
LEFT JOIN customers c
    ON o.customer_id = c.customer_id
WHERE c.customer_id IS NULL;

#5 Check product prices
SELECT COUNT(*) AS invalid_prices
FROM order_items
WHERE price <= 0 OR price IS NULL;

#6 Check delivery dates
SELECT COUNT(*) AS invalid_delivery_dates
FROM orders
WHERE order_status = 'delivered'
  AND (
      order_delivered_customer_date IS NULL
      OR order_purchase_timestamp IS NULL
  );

#7 Check payment values
SELECT
    COUNT(*) AS invalid_payments
FROM payments
WHERE payment_value <= 0
   OR payment_value IS NULL;  

#8 Check review scores
SELECT
    review_score,
    COUNT(*) AS total_reviews
FROM reviews
GROUP BY review_score
ORDER BY review_score;

#9 Check order items without matching products
SELECT COUNT(*) AS unmatched_products
FROM order_items oi
LEFT JOIN products p
    ON oi.product_id = p.product_id
WHERE p.product_id IS NULL;   

#10 Check order items without matching sellers
SELECT COUNT(*) AS unmatched_sellers
FROM order_items oi
LEFT JOIN sellers s
    ON oi.seller_id = s.seller_id
WHERE s.seller_id IS NULL;  
