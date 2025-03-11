alter table amazon_details
add column month_name varchar(20);

UPDATE amazon_details 
SET 
    month_name = MONTHNAME(order_date);

SELECT 
    month_name, order_date
FROM
    amazon_details;