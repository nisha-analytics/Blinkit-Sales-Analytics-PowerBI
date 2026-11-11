Blinkit Sales Analytics Dashboard | Power BI

Project Overview

This project focuses on analyzing retail sales data using Power BI to generate meaningful business insights. The dashboard helps understand sales performance, product performance, customer behavior, order trends, and business opportunities.

The project uses a synthetic Blinkit-style retail sales dataset created for learning and portfolio purposes. It does not contain actual Blinkit company data.

Dataset Details

- Total Records: 5,000 Rows
- Total Columns: 17
- Dataset Type: Synthetic Retail Sales Dataset
- Database: PostgreSQL

Tools & Technologies

- Power BI
- PostgreSQL
- SQL
- Microsoft Excel
- DAX

Dashboard Pages

1. Sales Overview

- Total Sales
- Total Orders
- Total Profit
- Total Quantity
- Monthly Sales Trend
- Category-wise Sales
- Region-wise Sales
- Order Status Analysis
- Order Date, Region, and Category Slicers

2. Product Analysis

- Top 10 Products by Sales
- Category-wise Profit Analysis
- Product-wise Quantity Sold

3. Customer & Order Analysis

- Payment Method Analysis
- Top 10 Customers by Sales
- Average Delivery Time
- Sales vs Profit Analysis

4. Business Insights & Recommendations

- Sales Performance Insights
- Product Performance Insights
- Customer and Order Insights
- Business Recommendations

Key DAX Measures

The following DAX measures calculate metrics for Delivered orders only.

1. Total Sales

Total_sales =
CALCULATE(
    SUM('public sales_data'[sales_inr]),
    'public sales_data'[order_status] = "Delivered"
)

2. Total Profit

Total_Profit =
CALCULATE(
    SUM('public sales_data'[profit_inr]),
    'public sales_data'[order_status] = "Delivered"
)

3. Total Orders

Total_Orders =
CALCULATE(
    DISTINCTCOUNT('public sales_data'[order_id]),
    'public sales_data'[order_status] = "Delivered"
)

4. Total Quantity

Total_Quantity =
CALCULATE(
    SUM('public sales_data'[quantity]),
    'public sales_data'[order_status] = "Delivered"
)

5. Average Delivery Time

Avg_Delivery_Time =
CALCULATE(
    AVERAGE('public sales_data'[delivery_minutes]),
    'public sales_data'[order_status] = "Delivered"
)

Key Business Insights

- Electronics generated the highest sales among the categories.
- The West region recorded the highest sales.
- Delivered orders accounted for the majority of orders.
- Cash on Delivery was the most commonly used payment method.
- Electronics showed strong category-wise profit performance.

Business Recommendations

- Maintain sufficient stock of high-demand products.
- Focus on reducing order cancellations and returns.
- Improve delivery efficiency to enhance customer satisfaction.
- Encourage customers to use digital payment methods.
- Monitor product and category-wise profitability.
- Focus on customer retention strategies.

Key Learnings

- Connecting PostgreSQL with Power BI.
- Working with and analyzing a 5,000-row dataset.
- Creating interactive dashboards and visualizations.
- Writing DAX measures using CALCULATE and other functions.
- Analyzing sales, profit, products, customers, and order performance.
- Converting data into meaningful business insights.

Project Objective

The objective of this project is to demonstrate practical skills in SQL, PostgreSQL, Power BI, DAX, data analysis, and business reporting.

Note: This is a self-created portfolio project based on synthetic Blinkit-style retail sales data. It is not an official Blinkit report or actual company data.
