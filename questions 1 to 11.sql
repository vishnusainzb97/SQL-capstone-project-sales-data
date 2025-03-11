-- Q1) What is the count of distinct cities in the dataset?
SELECT 
    COUNT(DISTINCT (city))
FROM
    amazon_details;
-- ans)there are three didtinct cities

-- Q2) For each branch, what is the corresponding city?
SELECT DISTINCT
    (branch), city
FROM
    amazon_details; 
-- ans) for branch A city is Yangon 
--     branch B city is Mandalay
--     branch C city is Naypyitaw

-- Q3) What is the count of distinct product lines in the dataset?
SELECT 
    COUNT(DISTINCT (product_line))
FROM
    amazon_details; 
-- ans) count of distinct product lines is 6

-- Q4) Which payment method occurs most frequently?
SELECT 
    payment_method, COUNT(*) AS payment_count
FROM
    amazon_details
GROUP BY payment_method
ORDER BY payment_count DESC
LIMIT 1;
-- ans) cash 344 times 

-- Q5) Which product line has the highest sales?
SELECT 
    product_line, sum(quantity) AS Highest_sales
FROM
    amazon_details
GROUP BY product_line
ORDER BY Highest_sales DESC
;
-- ans) Electroinics accesories has highest sales 

-- Q6) How much revenue is generated each month?
SELECT 
    month_name, SUM(unit_price * quantity) AS revenue
FROM
    amazon_details
GROUP BY month_name , MONTH(order_date)
ORDER BY MONTH(order_date);
-- ans) January 110754.16
-- 	 February 91168.93
--      March	103683.00

-- Q7) In which month did the cost of goods sold reach its peak?
SELECT 
    month_name, ROUND(SUM(cogs)) AS peak_figure
FROM
    amazon_details
GROUP BY month_name
ORDER BY peak_figure DESC
LIMIT 1;
-- ans) in the month of january 

-- Q8) Which product line generated the highest revenue?
SELECT 
    product_line, ROUND(SUM(unit_price * quantity)) AS revenue
FROM
    amazon_details
GROUP BY product_line
ORDER BY revenue DESC
limit 1;
-- ans) Food and beverages has highest revenue

-- Q9) In which city was the highest revenue recorded?
SELECT 
    city, ROUND(SUM(unit_price * quantity)) AS revenue
FROM
    amazon_details
GROUP BY city
ORDER BY revenue DESC; 
-- ans) Naypyitaw has the highest revenue recorded

-- Q10) Which product line incurred the highest Value Added Tax?
SELECT 
    product_line, SUM(VAT) AS highest_VAT
FROM
    amazon_details
GROUP BY product_line
ORDER BY highest_VAT DESC;
-- ans) Food and beverages has highest VAT

-- Q11) For each product line, add a column indicating "Good" if its sales are above average, otherwise "Bad."
WITH SalesCTE AS (
    SELECT 
        Product_line, 
        count(unit_price * quantity) AS total_sales
    FROM 
        amazon_details
    GROUP BY 
        Product_line
)
SELECT 
    Product_line, 
    total_sales,
    CASE 
        WHEN total_sales > (SELECT AVG(total_sales) FROM SalesCTE) THEN 'Good' 
        ELSE 'Bad' 
    END AS sales_status
FROM 
    SalesCTE;
    
    



















