use car_sales;

/* Total sales in 2015 across all sellers */
select sum(sellingprice) as Total_Market_Revenue_2015 
from transactions where year(saledate) = '2015';

/* 0  Show amount of cars sold per month */
select count(vin) as N_of_cars_sold, year(saledate) as Year, month(saledate) as Month 
from transactions group by year(saledate), month(saledate) order by year(saledate), month(saledate);

/* 1  Which car brand sold the most vehicles in 2015 */
select car.brand as Brand, count(transactions.vin) as Vehicles_Sold from transactions left join car 
on transactions.vin = car.vin group by Brand order by Vehicles_Sold desc limit 1;

/* 2  Which vehicle model is the most sold overall models across all brands */
select car.brand as Brand, car.model as Model, count(transactions.vin) as Vehicles_Sold from transactions left join car 
on transactions.vin = car.vin group by Brand, Model order by Vehicles_Sold desc limit 1;

/* 3  What category of vehicle is the most sold */
select car.category as Category, count(transactions.vin) as Vehicles_Sold from transactions 
left join car on transactions.vin = car.vin group by Category order by Vehicles_Sold desc limit 1;


/* 4  What percentage of the sales do all types of vehicle encompass */
SELECT car.category AS Category, COUNT(transactions.vin) AS Vehicles_Sold, 
(COUNT(transactions.vin) * 100.0) / total_sold AS Market_Share_Percentage
FROM transactions LEFT JOIN car ON transactions.vin = car.vin 
CROSS JOIN (SELECT COUNT(vin) AS total_sold FROM transactions) AS total_sales
GROUP BY Category, total_sold
ORDER BY Vehicles_Sold DESC;

/* 5  Most popular colour for toyota cars */
select car.color as Colour, count(transactions.vin) as Count FROM transactions LEFT JOIN car 
ON transactions.vin = car.vin where car.brand = 'Toyota' group by car.color order by Count desc;

/* 6  How many manuals and how many automatics are in the database sorted by each year of production (not sold)? */
SELECT year, SUM(CASE WHEN transmission = 'automatic' THEN 1 ELSE 0 END) AS Automatic, 
SUM(CASE WHEN transmission = 'manual' THEN 1 ELSE 0 END) AS Manual FROM car GROUP BY year ORDER BY year;

/* 7  Average odometer of a car when sold */
select AVG(odometer) from transactions;

/* 8  Most popular interiors */
select interior_color as Interior_Color, count(*) as Colour_Count from car 
group by Interior_Color order by Colour_Count desc;

/* 9  Which seller has the highest total sales in $ ?*/
select seller_name as Seller, sum(sellingprice) as Sales from transactions t 
join seller s on t.seller_id = s.seller_id group by Seller order by Sales desc limit 1;

/* 10  Rank sellers by the amount of cars they sold in total descending */
select seller_name as Seller, count(vin) as Count from transactions t 
join seller s on t.seller_id = s.seller_id group by Seller order by Count desc;