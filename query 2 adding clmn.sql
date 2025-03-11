alter table amazon_details
add column time_of_day varchar(10);

set sql_safe_updates = 0;

UPDATE amazon_details 
SET 
    time_of_day = CASE
        WHEN
            TIME(order_time) >= '06:00:00'
                AND TIME(order_time) <= '11:59:59'
        THEN
            'Morning'
        WHEN
            TIME(order_time) >= '12:00:00'
                AND TIME(order_time) <= '17:59:59'
        THEN
            'Afternoon'
        WHEN
            TIME(order_time) >= '18:00:00'
                AND TIME(order_time) <= '23:59:59'
        THEN
            'Evening'
        ELSE 'Night'
    END;


SELECT 
    order_time, time_of_day
FROM
    amazon_details


