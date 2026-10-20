# Olist E-Commerce Sales Analytics

## Project Overview

This project analyzes a sample of the Olist Brazilian E-Commerce dataset using MySQL and Power BI. It explores sales performance, customer locations, product categories, payment methods, and monthly revenue trends.

## Tools Used

- MySQL
- MySQL Workbench
- Power BI
- SQL

## Database Schema

The database contains seven main tables: customers, orders, order_items, products, sellers, payments, and reviews.

![Olist Database EER Diagram](images/eer-diagram.png)

## Power BI Dashboard

The interactive dashboard presents key performance indicators and sales insights.

![Olist E-Commerce Sales Analytics Dashboard](images/sales-dashboard.png)

## Key Performance Indicators

- **Total Revenue:** $258.16K
- **Average Order Value:** $135.23
- **Total Orders:** 1,936

*Note: These figures come from the selected dataset sample. Confirm the currency and metric definitions before presenting them as final business results.*

## Key Insights

- `relogios_presentes` is the highest-revenue product category in the analyzed sample.
- São Paulo contributes the highest revenue among the five displayed cities.
- Credit cards account for the largest share of recorded payment value.
- The monthly revenue chart shows changes in sales performance over time.

## SQL Concepts Demonstrated

- Data validation and quality checks
- Aggregate functions and `GROUP BY`
- Joins and subqueries
- Common Table Expressions (CTEs)
- Window functions, including `RANK`, `DENSE_RANK`, and `LAG`
- Revenue, customer, payment, and delivery analysis

## Project Structure

- `01_data_validation.sql` — Data quality checks
- `02_sales_analysis.sql` — Sales and monthly revenue analysis
- `03_customer_analysis.sql` — Customer spending analysis
- `04_product_analysis.sql` — Product and category performance
- `05_payment_analysis.sql` — Payment method analysis
- `06_delivery_analysis.sql` — Delivery and cancellation analysis
- `07_advanced_sql.sql` — Advanced SQL queries
- `business_insights.md` — Summary of findings
- `images/` — Database diagram and Power BI dashboard

## How to Run

1. Install MySQL Server and MySQL Workbench.
2. Create the project database and import the required CSV files.
3. Open the SQL scripts in MySQL Workbench.
4. Run the queries against the imported tables.
5. Open the Power BI report and connect it to the prepared data.

## Dataset Note

This project uses a reduced sample of the public Olist Brazilian E-Commerce dataset. The findings describe the selected sample, not the entire Olist business.
