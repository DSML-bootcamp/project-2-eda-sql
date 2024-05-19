use eda_sql;

/* checking the database is complete */
select Count(*)
from transactions;

/*Total sales of business & breakdown by month */
Select 
	FORMAT(sum(unit_price * quantity),2) as total_sales 
from transactions 
WHERE is_negative_transaction = 0;

/*month over month*/
SELECT 
	invoice_date_month as invoice_month,
    FORMAT(sum(unit_price * quantity),0) as total_sales
FROM transactions
WHERE is_negative_transaction =0
GROUP BY invoice_date_month
;

/* sales by products */
select 
	COUNT(DISTINCT stock_code)
FROM transactions;

SELECT 
    stock_code, 
    description,
    FORMAT(total_sales_int, 0) as total_sales
FROM (
    SELECT 
        stock_code, 
        description, 
        SUM(unit_price * quantity) as total_sales_int
    FROM 
        transactions
	WHERE 
		is_negative_transaction = 0
    GROUP BY 
        stock_code, description
) as subquery
ORDER BY 
    total_sales_int DESC;
    
/* average unit price */
SELECT 
	FORMAT(AVG(unit_price),2) AS 'Average Unit Price'
FROM transactions
WHERE is_negative_transaction = 0 ;

/* most expensive product and their sales*/
SELECT 
    stock_code,
    description,
    quantity,
    unit_price,
    SUM(unit_price * quantity) AS total_sales
FROM transactions
WHERE is_negative_transaction = 0
GROUP BY stock_code, description, quantity, unit_price
ORDER BY total_sales DESC
LIMIT 1;

/* least expensive product and their sales */
SELECT 
    stock_code,
    description,
    quantity,
    unit_price,
    SUM(unit_price * quantity) AS total_sales
FROM transactions
WHERE is_negative_transaction = 0
GROUP BY stock_code, description,quantity, unit_price
ORDER BY total_sales ASC
LIMIT 1;


/* AVG sales per month */
SELECT 
	MONTH(invoice_date_nft) AS month,
    FORMAT(AVG(unit_price * quantity),2) AS averga_sales 
from transactions 
WHERE is_negative_transaction = 0
GROUP BY month;

/* Who are our customers */
select 
	first_name,
    last_name
from customers;

/*total number of customers */
select count(*)
from customers;

/*biggest buyer */
SELECT 
	t.customer_id,
    first_name,
    last_name,
    ROUND(sum(quantity* unit_price), 2) as total_sales
from transactions t 
	inner join customers c on t.customer_id = c.CustomerID
WHERE is_negative_transaction = 0
GROUP BY t.customer_id, first_name, last_name
ORDER BY total_sales DESC
Limit 1;

/*countries delivers */
Select 	
	count(distinct country)
from transactions 
WHERE is_negative_transaction = 0;


SELECT 
	country
From transactions
WHERE is_negative_transaction = 0
GROUP BY country;

/* countries sales */
SELECT 
	country,
    count(distinct invoice_no) as 'Number of Transactions',
    ROUND(sum(quantity * unit_price),2) as 'Total Sales'
FROM transactions
WHERE is_negative_transaction = 0
group by country
ORDER BY `Total Sales` DESC
LIMIT 5;
