USE restaurant_db;

--- Explore the menu items table
--- Show Menu items table
SELECT *
FROM menu_items;

--- List of items on the menu
SELECT COUNT(*) AS Number_of_items
FROM menu_items;

--- List the most items in the menu
SELECT item_name AS Most_Expensive_Item,price 
FROM menu_items
ORDER BY price DESC LIMIT 1;

--- List the least items in the menu
SELECT item_name AS Least_Expensive_Item,price 
FROM menu_items
ORDER BY price LIMIT 1;

--- How many Italian dishes on the menu?
SELECT DISTINCT category
FROM menu_items;

SELECT DISTINCT COUNT(*) AS "Number_of_Italian_Items"
FROM menu_items
WHERE category = "Italian";

--- List the most and least Italian Items on the menu
SELECT category ,MAX(price) AS Most_Expensive_Item, MIN(price) AS Least_Expensive_Item
FROM menu_items
WHERE category = "Italian" LIMIT 1;

--- Average price for each category
SELECT category, ROUND(AVG(price),2) AS "Average_price"
FROM menu_items
GROUP BY category
ORDER BY Average_price DESC;

--- How many dishes are there in each category?
SELECT category, COUNT(*) AS Number_of_dishes
FROM menu_items
GROUP BY category
ORDER BY Number_of_dishes DESC;

--- Explore the order details table
--- View the order table
SELECT *
FROM order_details;

--- Feature Engineering
--- Create Day name column
SELECT DAYNAME(order_date)
FROM order_details;

ALTER TABLE order_details
ADD COLUMN dayname VARCHAR(30);

UPDATE order_details
SET dayname = DAYNAME(order_date);

--- Create Month name column
SELECT MONTHNAME(order_date)
FROM order_details;

ALTER TABLE order_details
ADD COLUMN monthname VARCHAR(30);

UPDATE order_details
SET monthname = MONTHNAME(order_date);

--- Create Time of the day column
SELECT CASE WHEN order_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN order_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
            END AS time_of_day 
FROM order_details;

ALTER TABLE order_details
ADD COLUMN time_of_day VARCHAR(30);

UPDATE order_details
SET time_of_day = (SELECT CASE WHEN order_time BETWEEN "00:00:00" AND "12:00:00" THEN "Morning"
            WHEN order_time BETWEEN "12:01:00" AND "16:00:00" THEN "Afternoon"
            ELSE "Evening"
            END AS time_of_day ); 
            
--- View the order details table with added columns           
SELECT * FROM order_details;

--- What is the date range of the order table?
SELECT MIN(order_date) AS Minimum_date_range, MAX(order_date) AS Maximum_date_range
FROM order_details;

--- How many orders were made within this date range? 
SELECT COUNT(DISTINCT order_id) AS Number_of_orders
FROM order_details;

--- How many items were ordered within this date range?
SELECT COUNT(*) AS Num_Of_Items_ordered
FROM order_details;

--- which order had the most number of items?
SELECT order_id,COUNT(item_id) AS Number_of_Items
FROM order_details
GROUP BY order_id
ORDER BY Number_of_Items DESC LIMIT 1;

--- How many orders had more than 12 items?
SELECT COUNT(*) FROM
(SELECT order_id,COUNT(item_id) AS count
FROM order_details
GROUP BY order_id
HAVING count > 12) AS number_of_orders;

--- Find the average number of customers who come in for each day of the week
SELECT dayname,ROUND(AVG(total_customers),0) AS average_customers 
FROM (
SELECT monthname,dayname,COUNT(DISTINCT order_id) AS total_customers
FROM order_details
GROUP BY monthname,dayname
ORDER BY total_customers DESC
) AS total_customer
GROUP BY dayname
ORDER BY average_customers DESC;

--- what time of the day is bussiest on average?
SELECT time_of_day, ROUND(AVG(total_customers),0) AS average_number_customers
 FROM (
SELECT monthname,dayname,time_of_day,COUNT(order_id) AS total_customers
 FROM order_details
 GROUP BY monthname,dayname,time_of_day
 ORDER BY total_customers DESC
 ) AS total_customer
 GROUP BY time_of_day;
   
 --- Which day of the week do customers normally order from this restuarant?
 SELECT dayname, COUNT(order_id) AS total_customers
 FROM order_details
 GROUP BY dayname
 ORDER BY total_customers DESC;
 
 --- What were the most and least ordered items? what categories were they in?
 SELECT menu_item_id, item_name, category, COUNT(o.order_details_id) AS number_items_ordered
 FROM order_details o
 LEFT JOIN menu_items m
 ON o.item_id = m.menu_item_id
 GROUP BY menu_item_id, item_name
 ORDER BY number_items_ordered DESC;
 
 --- Total amount each person ordered
 SELECT order_id, SUM(price) AS total_amount_spend_customer
 FROM order_details o
 LEFT JOIN menu_items m
 ON m.menu_item_id = o.item_id
 GROUP BY order_id
 ORDER BY total_amount_spend_customer DESC;
 
 --- Gross sales based on category
 SELECT category, SUM(price) AS total_amount
 FROM order_details o 
 LEFT JOIN menu_items m
 ON m.menu_item_id = o.item_id
 GROUP BY category
 ORDER BY total_amount DESC;
 
 --- Top 5 For Month
 SELECT category, monthname, SUM(price) AS total_amount
 FROM order_details o 
 LEFT JOIN menu_items m
 ON m.menu_item_id = o.item_id
 GROUP BY category,monthname
 ORDER BY total_amount DESC LIMIT 5;
 
 --- Top 5 For Each Day
 SELECT category, dayname, SUM(price) AS total_amount
 FROM order_details o 
 LEFT JOIN menu_items m
 ON m.menu_item_id = o.item_id
 GROUP BY category,dayname
 ORDER BY total_amount DESC;
 
--- Explore the Customer Behaviour
--- Combine menu items and order details table
SELECT *
FROM order_details o
LEFT JOIN menu_items m
ON   o.item_id = m.menu_item_id;

--- What were the lease and most ordered items? What categories were they in?
--- Most ordered item
SELECT m.item_name, m.category,COUNT(o.order_details_id) AS Number_of_orders
FROM order_details o
LEFT JOIN menu_items m
ON o.item_id = m.menu_item_id
GROUP BY m.item_name,m.category
ORDER BY Number_of_orders DESC LIMIT 1;

--- Least ordered item
SELECT m.item_name, m.category,COUNT(o.order_details_id) AS Number_of_orders
FROM order_details o
LEFT JOIN menu_items m
ON o.item_id = m.menu_item_id
GROUP BY m.item_name, category
ORDER BY Number_of_orders LIMIT 1;








