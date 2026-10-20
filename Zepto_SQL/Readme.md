# Olist E-Commerce SQL Analytics

## Project Overview
This project analyzes a sample of the Olist Brazilian e-commerce dataset using MySQL Workbench. The goal is to explore sales performance, customer purchasing behavior, product categories, payment methods, and delivery performance.

## Tools Used
- MySQL
- MySQL Workbench
- SQL

## Dataset
The project uses a reduced sample of the public Olist Brazilian E-Commerce dataset.

Core tables:
- customers
- orders
- order_items
- products
- sellers
- payments
- reviews

## SQL Concepts Demonstrated
- SELECT, WHERE, ORDER BY
- GROUP BY and HAVING
- Aggregate functions
- INNER JOIN and LEFT JOIN
- Subqueries and CTEs
- CASE statements
- Window functions: RANK, DENSE_RANK, LAG
- Revenue and delivery metrics

## Business Questions
1. What is the total product revenue?
2. What is the average order value?
3. Which product categories generate the most revenue?
4. Which cities contribute the most revenue?
5. Which payment methods are most commonly used?
6. How many orders are cancelled?
7. What percentage of deliveries arrive late?
8. Which customers spend the most?

## Key Findings
- Total product revenue in the selected sample: R$258,163.49.
- Average order value: R$135.23.
- São Paulo was the highest-revenue city in the analyzed sample.
- Watches and gifts (`relogios_presentes`) was the highest-revenue category in the analyzed sample.
- The late-delivery rate was 7.39%.

## Project Structure
- `01_data_validation.sql` — Data quality checks
- `02_sales_analysis.sql` — Sales and monthly revenue
- `03_customer_analysis.sql` — Customer spending and behavior
- `04_product_analysis.sql` — Product and category performance
- `05_payment_analysis.sql` — Payment analysis
- `06_delivery_analysis.sql` — Delivery performance
- `07_advanced_sql.sql` — CTEs and window functions
- `business_insights.md` — Summary of findings

## How to Run
1. Install MySQL Server and MySQL Workbench.
2. Create the project database.
3. Import the required CSV files into the corresponding tables.
4. Open the SQL scripts in MySQL Workbench.
5. Execute the scripts against the imported dataset.

## Important Note
This project uses a selected sample of the Olist public dataset. The results describe the sample and should not be interpreted as the performance of the entire Olist business.