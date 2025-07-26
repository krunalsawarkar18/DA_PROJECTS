CREATE TABLE pizza_sales (
    pizza_id SERIAL PRIMARY KEY,
    order_id INT NOT NULL,
    pizza_name_id VARCHAR(50),
    quantity INT,
    order_date DATE,
    order_time TIME,
    unit_price NUMERIC(6,2),
    total_price NUMERIC(8,2),
    pizza_size VARCHAR(20),
    pizza_category VARCHAR(30),
    pizza_ingredients TEXT,
    pizza_name VARCHAR(100)
);

COPY pizza_sales FROM 'D:\Excel_sql_powerBi_Project\Pizza_Report_Dashboard\pizza_sales.csv'
DELIMITER ',' 
CSV HEADER 
NULL 'null';

select * from pizza_sales

> Key Performance Indictor

1) Total Revenue

select * from pizza_sales

select sum(total_price) As Total_Revenue from pizza_sales

2) Average Order Value

select * from pizza_sales

select sum(total_price)/count(Distinct order_id) As Avg_order_value from pizza_sales

3) Total Pizzas Sold

select * from pizza_sales

select sum(quantity) As Total_Pizza_Sold from pizza_sales

4) Total Orders

select * from pizza_sales

select count(Distinct order_id) As Total_Orders from pizza_sales

5) Average Pizzas Per Order

select * from pizza_sales

select cast(cast(sum(quantity) As Decimal (10,2))/
cast(count(Distinct order_id) As Decimal (10,2)) As Decimal (10,2)) from pizza_sales


> Charts Requirement

1)Daily Trend for Total Orders

select * from pizza_sales

select to_char(order_date, 'day') as order_day, count(Distinct order_id) As total_orders
from pizza_sales
group by to_char(order_date, 'day')


2)Hourly Trend for Total Orders

select * from pizza_sales


SELECT DATE_TRUNC('hour', order_time) AS hour, COUNT(order_id) AS total_orders
FROM pizza_sales
GROUP BY hour
ORDER BY hour


3)Percentage of sales by Pizza Category

select * from pizza_sales

select pizza_category, sum(total_price) as total_price, sum(total_price) * 100/ (select sum(total_price) from pizza_sales) As percentage
from pizza_sales 
group by pizza_category


4)Percentage of sales by pizza size

select * from pizza_sales

select pizza_size, sum(total_price) As Total_Sales, cast(sum(total_price) * 100/
(select sum(total_price)from pizza_sales) As Decimal (10,2)) As PCT
from pizza_sales
group by pizza_size
order by PCT desc

5)Total Pizzas sold by pizza category

select * from pizza_sales

select pizza_category, sum(quantity)
from pizza_sales
group by pizza_category

6)Top 5 Best sellers by Revenue, total quality and total orders

select * from pizza_sales

select pizza_name, sum(total_price) As Total_Revenue, sum(quantity) as total_quantity, 
count(order_id) as total_ordersfrom pizza_sales
group by pizza_name 
order by Total_Revenue desc limit 5

7)Bottom 5 Best sellers by Revenue, total quantity and total orders

select * from pizza_sales

select pizza_name, sum(total_price) As Total_Revenue, sum(quantity) as total_quantity,
count(order_id) as total_orders from pizza_sales
group by pizza_name 
order by Total_Revenue asc limit 5












