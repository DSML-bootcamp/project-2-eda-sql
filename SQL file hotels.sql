USE hotel;

-- 1. Booking Trends: What are the overall booking trends over the years, 
-- in terms of the number of bookings made and canceled?
SELECT 
b.arrival_year,
COUNT(*) AS total_bookings,
SUM(CASE WHEN bd.booking_status = 'Canceled' THEN 1 ELSE 0 END) AS canceled_bookings
FROM 
booking b
JOIN
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
b.arrival_year;
    
-- 2. Guest Preferences: What are the most preferred room types among guests
--  who require a car parking space?
SELECT 
room_type_reserved,
COUNT(*) AS total_bookings
FROM 
booking
WHERE 
required_car_parking_space = 1
GROUP BY 
room_type_reserved
ORDER BY 
total_bookings DESC;

-- 3.Cancellation Analysis: What is the average lead time for bookings 
-- that were canceled versus bookings that were not canceled?
SELECT 
bd.booking_status,
AVG(b.lead_time) AS avg_lead_time
FROM 
bookingdetails bd
JOIN 
booking b ON bd.Booking_ID = b.Booking_ID
GROUP BY 
bd.booking_status;

-- 4. Market Segment Analysis: Which market segment generates 
-- the highest average revenue per booking?
SELECT 
market_segment_type,
AVG(avg_price_per_room) AS avg_revenue_per_booking
FROM 
bookingdetails
GROUP BY 
market_segment_type
ORDER BY 
avg_revenue_per_booking DESC;

-- 5. Repeat Guest Behavior: Do repeat guests tend to make more 
-- special requests compared to new guests?
SELECT 
CASE 
WHEN repeated_guest = 1 THEN 'Repeated Guest'
ELSE 'New Guest'
END AS guest_type,
AVG(no_of_special_requests) AS avg_special_requests
FROM 
bookingdetails
GROUP BY 
repeated_guest;

-- 6. Weekend vs. Weeknight Stays: What is the average length of
-- stay (in nights) for weekend stays versus weeknight stays?
SELECT 
AVG(no_of_weekend_nights) AS avg_weekend_stay,
AVG(no_of_week_nights) AS avg_weeknight_stay
FROM 
booking;

-- 7. Seasonal Booking Trends: 
-- How do booking patterns vary across different months of the year?
SELECT 
arrival_month,
COUNT(*) AS total_bookings
FROM 
booking
GROUP BY 
arrival_month
ORDER BY 
arrival_month;

-- 8. Impact of Special Requests: Is there a correlation between the 
-- number of special requests made and the likelihood of cancellation?
SELECT 
no_of_special_requests,
AVG(CASE WHEN booking_status = 'Canceled' THEN 1 ELSE 0 END) AS cancellation_rate
FROM 
bookingdetails
GROUP BY 
no_of_special_requests;

-- 9. Booking Behavior of Families: Do bookings with children tend to 
-- have a higher number of previous cancellations?
SELECT 
b.no_of_children,
AVG(bd.no_of_previous_cancellations) AS avg_previous_cancellations
FROM
booking b
JOIN 
bookingdetails bd ON bd.Booking_ID = b.Booking_ID
GROUP BY 
b.no_of_children;

-- 10. Parking Space Requirement Analysis: What percentage of bookings require a car
-- parking space, and how does this vary across different market segments?
SELECT 
bd.market_segment_type,
COUNT(*) AS total_bookings,
SUM(b.required_car_parking_space) AS bookings_with_parking_space,
(SUM(b.required_car_parking_space) / COUNT(*)) * 100 AS percentage_with_parking_space
FROM
booking b
JOIN 
bookingdetails bd ON bd.Booking_ID = b.Booking_ID
GROUP BY 
bd.market_segment_type;

-- 11. Customer Segmentation: Can you identify distinct segments of customers based on 
-- their booking behavior and demographics? For example, grouping customers based on their 
-- booking frequency, average lead time, preferred room types, etc.
SELECT 
CASE 
	WHEN bd.repeated_guest = 1 THEN 'Repeated Guest'
	ELSE 'New Guest'
END AS guest_type,
AVG(b.lead_time) AS avg_lead_time,
AVG(bd.no_of_special_requests) AS avg_special_requests
FROM 
booking b
JOIN 
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
CASE 
	WHEN bd.repeated_guest = 1 THEN 'Repeated Guest'
	ELSE 'New Guest'
END;

-- 12. Churn Analysis: Can you predict the likelihood of a booking being canceled based on 
-- historical data? Explore factors such as lead time, previous cancellations, special requests,
-- etc., to identify patterns associated with cancellations.
 SELECT 
bd.booking_status,
AVG(b.lead_time) AS avg_lead_time,
AVG(bd.no_of_special_requests) AS avg_special_requests
FROM 
booking b
JOIN 
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
bd.booking_status;

 
-- 13. Price Elasticity: How sensitive are customers to changes in room prices? Analyze the
-- relationship between average price per room and booking volume to determine price elasticity
-- and optimize pricing strategies.
SELECT 
arrival_year,
arrival_month,
AVG(bd.avg_price_per_room) AS avg_price_per_room,
COUNT(*) AS total_bookings
FROM 
booking b
JOIN 
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
arrival_year, arrival_month
ORDER BY
arrival_year;

-- 14. Seasonal Demand Forecasting: Can you forecast demand for hotel rooms across different
-- seasons or months? Use historical booking data to build time-series models and predict future
-- demand fluctuations.
SELECT 
arrival_year,
arrival_month,
COUNT(*) AS total_bookings
FROM 
booking
GROUP BY 
arrival_year, arrival_month
ORDER BY 
arrival_year, arrival_month;


-- 15. Cross-Selling Opportunities: Identify potential cross-selling opportunities by analyzing 
-- the association between room types, meal plans, and special requests. Determine which combinations 
-- are frequently booked together and design targeted marketing campaigns.
SELECT 
b.room_type_reserved,
b.type_of_meal_plan,
COUNT(*) AS total_bookings
FROM 
booking b
GROUP BY 
b.room_type_reserved, b.type_of_meal_plan
ORDER BY
b.room_type_reserved;

-- 16. Customer Lifetime Value (CLV): Calculate the CLV for each customer based on their
-- booking history, average spend per booking, and retention rate. Identify high-value
-- customers and tailor loyalty programs accordingly.
SELECT 
CASE 
WHEN bd.repeated_guest = 1 THEN 'Repeated Guest'
ELSE 'New Guest'
END AS guest_type,
SUM(bd.avg_price_per_room) AS total_revenue,
COUNT(*) AS total_bookings
FROM 
booking b
JOIN 
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
CASE 
WHEN bd.repeated_guest = 1 THEN 'Repeated Guest'
ELSE 'New Guest'
END;



-- 17. Market Basket Analysis: Perform market basket analysis to uncover associations between
-- different room types, special requests, and amenities. Identify common booking patterns 
-- and optimize room package offerings.
SELECT 
b.room_type_reserved,
bd.no_of_special_requests,
b.type_of_meal_plan,
b.required_car_parking_space,
COUNT(*) AS total_bookings
FROM 
booking b
JOIN 
bookingdetails bd ON b.Booking_ID = bd.Booking_ID
GROUP BY 
b.room_type_reserved, 
bd.no_of_special_requests,
b.type_of_meal_plan,
b.required_car_parking_space
ORDER BY 
room_type_reserved, total_bookings DESC;

-- 18. Dynamic Pricing Strategies: Develop dynamic pricing models to optimize room rates based 
-- on factors such as demand, seasonality, booking lead time, and competitor prices. Implement 
-- pricing rules that maximize revenue while ensuring competitiveness

-- 19. Customer Satisfaction Analysis: Measure customer satisfaction levels based on feedback, 
-- ratings, and reviews. Analyze correlations between satisfaction scores and booking attributes
-- to identify areas for improvement.


-- 20. Operational Efficiency: Evaluate operational efficiency by analyzing metrics such as 
-- check-in/check-out times, room turnover rates, and staff workload. Identify bottlenecks and 
-- inefficiencies in hotel operations and implement process improvements.


 
 