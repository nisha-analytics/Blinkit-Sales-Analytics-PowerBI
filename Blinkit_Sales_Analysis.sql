CREATE TABLE sales_data (
    order_id VARCHAR(20),
    order_date DATE,
    region VARCHAR(30),
    city VARCHAR(50),
    customer_id VARCHAR(20),
    category VARCHAR(50),
    product_name VARCHAR(100),
    quantity INTEGER,
    unit_price_inr NUMERIC(12,2),
    discount_percent NUMERIC(5,2),
    sales_inr NUMERIC(12,2),
    cost_inr NUMERIC(12,2),
    profit_inr NUMERIC(12,2),
    payment_method VARCHAR(30),
    order_status VARCHAR(20),
    delivery_minutes INTEGER,
    outlet_type VARCHAR(30)
);


SELECT * FROM sales_data;

SELECT COUNT(*) FROM sales_data;

-- Overall Sales Performance--
--Total Sales--
--Total Orders--
--Total Quantity Sold--
--Total Profit--
--Average Order Value (AOV)--

SELECT SUM(sales_inr) AS total_Sales,
COUNT(DISTINCT order_id) AS total_orders,
SUM(quantity) AS total_quantity_sold,
SUM(profit_inr) AS total_profit,
ROUND (SUM(sales_inr) / COUNT(DISTINCT order_id),2) AS average_order_value
FROM sales_data;
--2. SALES PERFORMANCE BY REGION--
SELECT region, SUM(sales_inr) AS total_sales,
COUNT(DISTINCT order_id) AS total_order,
SUM(profit_inr) AS total_profit
FROM sales_data
GROUP BY region;

SELECT * FROM sales_data;

--3. CATEGORY-WISE SALES ANALYSIS--
SELECT category, SUM(sales_inr) AS total_sales,
SUM(profit_inr) AS total_profit,
SUM(quantity) AS total_quantity_sold
FROM sales_data
GROUP BY category;

--4. ORDER STATUS ANALYSIS--
SELECT order_status, COUNT(DISTINCT order_id) AS total_orders,
SUM(sales_inr) AS total_sales
FROM sales_data
GROUP BY order_status;

--5.MONTHLY SALES TREND--
SELECT EXTRACT(YEARS FROM order_date) AS sales_Year,
EXTRACT(MONTH FROM order_date) AS sales_months,
SUM(sales_inr) AS total_slaes,
 COUNT(DISTINCT order_id) AS total_orders
FROM sales_data
GROUP BY EXTRACT(YEARS FROM order_date),
EXTRACT(MONTH FROM order_date)
ORDER BY sales_year, sales_months;

SELECT * FROM sales_data;

--6.TOP 5 BEST-SELLINGN PRODUCTS--

SELECT product_name, SUM(sales_inr) AS total_sales
FROM sales_data
GROUP BY product_name
ORDER BY total_sales DESC
LIMIT 5;

--7. CITY-WISE SALES PERFORMANCE--
SELECT city, SUM(sales_inr) AS total_sales,
COUNT(DISTINCT order_id) AS total_order
FROM sales_data
GROUP BY city
ORDER BY total_sales DESC
LIMIT 5;

SELECT * FROM sales_data;

--8. PAYMENT METHOD ANALYSIS--
SELECT payment_method, SUM(sales_inr) AS total_sales,
COUNT(DISTINCT order_id) AS total_order,
SUM(profit_inr) AS total_profit
FROM sales_data
GROUP BY payment_method
ORDER BY total_sales DESC;

--9. CUSTOMER-WISE SALES ANALYSIS
SELECT customer_id, COUNT(DISTINCT order_id) AS total_order,
SUM(profit_inr) AS total_profit,
SUM(sales_inr) AS total_sales
FROM sales_data
GROUP BY customer_id
ORDER BY  total_sales DESC
LIMIT 10;

--10. HIGH-VALUE ANALYSIS--
SELECT sales_inr, order_id, customer_id, order_date FROM sales_data
WHERE sales_inr>5000
ORDER BY sales_inr DESC;

SELECT * FROM sales_data;

--11.DELIVERED ORDERS ANALYSIS--
SELECT  SUM(profit_inr) AS total_profit,
SUM(sales_inr) AS total_sales,
SUM(quantity) AS total_quantity_sold
FROM sales_data 
WHERE order_status = 'Delivered';

--12. RETURENED ORDERS ANALYSIS--
SELECT COUNT (*) AS total_count,
SUM(profit_inr) AS total_profit,
SUM(sales_inr) AS total_sales
FROM sales_data 
WHERE order_status = 'Returned';

--13. PAYMENT METHOD ANALYSIS--
SELECT payment_method, SUM(sales_inr) AS total_sales,
COUNT(DISTINCT order_id) AS total_order
FROM sales_data
GROUP BY payment_method;

SELECT * FROM sales_data;


--14. REGION-WISE PROFIT ANALYSIS--
SELECT region, SUM(profit_inr) AS total_profit
FROM sales_data
GROUP BY region
ORDER BY total_profit DESC;

--15. CATEGORY-WISE SALES AND PROFIT--
SELECT category, SUM(profit_inr) AS total_profit,
SUM(sales_inr) AS total_sales,
ROUND ((SUM ( profit_inr)/ SUM (sales_inr)) *100,2) AS profit_margin
FROM sales_data
GROUP BY category;

SELECT * FROM sales_data;

--16. MONTHLY SALES GROWTH ANALYSIS--
SELECT EXTRACT ( MONTH FROM order_date ) AS sales_month,
SUM(sales_inr) AS total_sales
FROM sales_data
GROUP BY sales_month
ORDER BY sales_month;

--17. CUSTOMER REPEAT PURCHASE--
SELECT customer_id,
SUM(sales_inr) AS total_sales,
COUNT(DISTINCT order_id) AS total_order
FROM sales_data 
GROUP BY customer_id
HAVING COUNT(DISTINCT order_id)>3
ORDER BY total_order DESC;

SELECT * FROM sales_data;

--18. TOP-SELLING PRODUCTS--
SELECT product_name, SUM(sales_inr) AS total_sales,
SUM(quantity) AS total_quantity_sold
FROM sales_data
GROUP BY product_name
ORDER BY  total_quantity_sold DESC
LIMIT 5;

--19. REGION-WISE AVERAGE PROFIT--
SELECT region, ROUND(AVG(profit_inr),2) AS avg_profit,
SUM(sales_inr) AS total_sales
FROM sales_data
GROUP BY region
HAVING AVG(profit_inr) <(SELECT AVG(profit_inr)
FROM sales_data)
ORDER BY avg_profit ASC;

--20. CATEGORY-WISE TOP PERFORMING PRODUCT--
WITH product_sales AS (
    SELECT
        category,
        product_name,
        SUM(sales_inr) AS total_sales
    FROM sales_data
    GROUP BY category, product_name
),
ranked_products AS (
    SELECT
        category,
        product_name,
        total_sales,
        RANK() OVER (
            PARTITION BY category
            ORDER BY total_sales DESC
        ) AS product_rank
    FROM product_sales
)
SELECT *
FROM ranked_products
WHERE product_rank = 1
ORDER BY category;