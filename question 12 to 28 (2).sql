-- Q12) Identify the branch that exceeded the average number of products sold.

WITH BranchSales AS (
    SELECT 
        branch, 
        sum(quantity) AS number_of_products_sold
    FROM 
        amazon_details
    GROUP BY 
        branch
),
AverageSales AS (
    SELECT 
        round(AVG(number_of_products_sold)) AS average_products_sold
    FROM 
        BranchSales
)
SELECT 
    b.branch, 
    b.number_of_products_sold,
    a.average_products_sold
FROM 
    BranchSales b, AverageSales a
WHERE 
    b.number_of_products_sold > a.average_products_sold
    order by number_of_products_sold
    limit 1;
-- ans) branch c has most number of products sold which is greater than average which is 1824

-- Q13)Which product line is most frequently associated with each gender?
WITH ProductLineFrequency AS (
    SELECT 
        gender, 
        product_line, 
        SUM(quantity) AS total_quantity
    FROM 
        amazon_details
    GROUP BY 
        gender, 
        product_line
),
RankedProductLines AS (
    SELECT 
        gender, 
        product_line, 
        total_quantity,
        RANK() OVER (PARTITION BY gender ORDER BY total_quantity DESC) AS rank_of
    FROM 
        ProductLineFrequency
)
SELECT 
    gender, 
    product_line, 
    total_quantity
FROM 
    RankedProductLines
WHERE 
    rank_of = 1;
-- ans) female fashion accesories and for male Health and beauty

-- Q14) Calculate the average rating for each product line.
SELECT 
    product_line, AVG(rating) AS average_rating
FROM
    amazon_details
GROUP BY product_line
ORDER BY average_rating desc;

-- Q15) Count the sales occurrences for each time of day on every weekday.
SELECT 
    day_name,
    time_of_day,
    COUNT(*) AS sales_count
FROM amazon_details
GROUP BY 
    day_name,
    time_of_day
ORDER BY 
    CASE day_name
        WHEN 'Monday' THEN 1
        WHEN 'Tuesday' THEN 2
        WHEN 'Wednesday' THEN 3
        WHEN 'Thursday' THEN 4
        WHEN 'Friday' THEN 5
        WHEN 'Saturday' THEN 6
        WHEN 'Sunday' THEN 7
    END,
    CASE time_of_day
        WHEN 'Morning' THEN 1
        WHEN 'Afternoon' THEN 2
        WHEN 'Evening' THEN 3
        WHEN 'Night' THEN 4
    END;
    
    
-- Q16) Identify the customer type contributing the highest revenue
SELECT 
    customer_type, ROUND(SUM(unit_price * quantity)) AS Revenue
FROM
    amazon_details
GROUP BY customer_type
ORDER BY Revenue DESC
LIMIT 1;

-- Q17) Determine the city with the highest VAT percentage.
SELECT 
  city,
  MAX((vat / (unit_price * quantity)) * 100) AS highest_vat_percentage
FROM 
  amazon_details
GROUP BY 
  city
ORDER BY 
  highest_vat_percentage DESC
LIMIT 1;

-- Q18) Identify the customer type with the highest VAT payments.
SELECT 
    customer_type, SUM(vat) AS total_vat_payments
FROM
    amazon_details
GROUP BY customer_type
ORDER BY total_vat_payments DESC;

-- Q19) What is the count of distinct customer types in the dataset?
SELECT 
    COUNT(DISTINCT (customer_type)) AS distinct_customer_type
FROM
    amazon_details;

-- Q20) What is the count of distinct payment methods in the dataset?
SELECT 
    COUNT(DISTINCT (payment_method)) AS distinct_payment_methods
FROM
    amazon_details;
    
  --   Q21) Which customer type occurs most frequently?
SELECT 
    customer_type, COUNT(*) AS frequent
FROM
    amazon_details
GROUP BY customer_type
ORDER BY frequent DESC
LIMIT 1;
 
 -- Q22) Identify the customer type with the highest purchase frequency.
SELECT 
    customer_type, COUNT(invoice_id) AS purchase_frequency
FROM
    amazon_details
GROUP BY customer_type
ORDER BY purchase_frequency DESC
LIMIT 1; 
 
 
-- Q23) Determine the predominant gender among customers
SELECT 
    gender, COUNT(*) AS predominant_gender
FROM
    amazon_details
GROUP BY gender
ORDER BY predominant_gender DESC
LIMIT 1;


-- Q24) Examine the distribution of genders within each branch.
SELECT 
    branch,
    gender,
    COUNT(*) AS gender_count,
    ROUND((COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (PARTITION BY branch)), 2) AS percentage
FROM amazon_details
GROUP BY branch, gender
ORDER BY branch, gender_count DESC;
-- second method without percentage column
SELECT 
  branch,
  gender,
  COUNT(*) AS count
FROM 
  amazon_details
GROUP BY 
  branch, gender
ORDER BY 
  branch, gender desc;


-- Q25) Identify the time of day when customers provide the most ratings.
SELECT 
    COUNT(rating) AS most_ratings, time_of_day
FROM
    amazon_details
GROUP BY time_of_day
ORDER BY most_ratings DESC;

-- Q26) Determine the time of day with the highest customer ratings for each branch.
WITH ratingCTE AS (
    SELECT 
        branch, 
        time_of_day, 
        COUNT(rating) AS most_ratings,
        RANK() OVER (PARTITION BY branch ORDER BY COUNT(rating) DESC) AS customer_rank
    FROM 
        amazon_details
    GROUP BY 
        time_of_day, 
        branch
)
SELECT 
    branch, 
    time_of_day, 
    most_ratings
FROM 
    ratingCTE 
WHERE 
    customer_rank = 1
ORDER BY 
    branch;


-- Q27) Identify the day of the week with the highest average ratings.
SELECT 
    AVG(rating) AS average_ratings, day_name
FROM
    amazon_details
GROUP BY day_name
ORDER BY average_ratings DESC
limit 1;

-- Q28) Determine the day of the week with the highest average ratings for each branch.
WITH AverageratingsCTE AS (
    SELECT 
        branch,
        day_name,
        AVG(rating) AS highest_rating,
        RANK() OVER (PARTITION BY branch ORDER BY AVG(rating) DESC) AS branch_rank
    FROM 
        amazon_details 
    GROUP BY 
        branch,
        day_name
)
SELECT 
    branch,
    day_name,
    highest_rating
FROM 
    AverageratingsCTE
WHERE 
    branch_rank = 1
ORDER BY 
    branch;












