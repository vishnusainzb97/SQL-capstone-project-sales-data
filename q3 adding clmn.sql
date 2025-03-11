alter table amazon_details
add column day_name varchar(20);

UPDATE amazon_details 
SET 
    day_name = DAYNAME(order_date);


SELECT 
    order_date, day_name
FROM
    amazon_details;

