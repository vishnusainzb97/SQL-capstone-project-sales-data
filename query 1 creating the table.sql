

CREATE TABLE amazon_details (
    invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(10) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10 , 2 ) NOT NULL,
    quantity INT NOT NULL,
    VAT FLOAT(6 , 4 ) NOT NULL,
    total DECIMAL(10 , 2 ) NOT NULL,
    order_date DATE NOT NULL,
    order_time TIME NOT NULL,
    payment_method VARCHAR(30) NOT NULL,
    cogs DECIMAL(10 , 2 ) NOT NULL,
    gross_margin_percentage FLOAT(11 , 9 ) NOT NULL,
    gross_income DECIMAL(10 , 2 ) NOT NULL,
    rating FLOAT(2 , 1 ) NOT NULL
);	

SELECT 
    *
FROM
    amazon_details;








