-- SQL Retail sales analysis

create database sql_project_p1;

-- Create table 
create table retail_sales(
transactions_id int primary key,
sale_date date,
sale_time time,
customer_id int,
gender varchar(20),
age int,
category varchar(20),
quantiy	int,
price_per_unit float,
cogs float,
total_sale float

)

select * from retail_sales;

select count(*) from  retail_sales;

-- Identifying Null Value

select * from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null;

delete from retail_sales
where transactions_id is null
or
sale_date is null
or
sale_time is null
or
gender is null
or
customer_id is null
or
age is null
or
category is null
or
quantiy is null
or 
price_per_unit is null
or
cogs is null
or
total_sale is null;

-- how many sales we have

select count(*) as total_sales from retail_sales;

-- How many customer we have ?

select count(distinct customer_id) from retail_sales;

select distinct category from retail_sales;
select count(category) from retail_sales;

-- Data analysis and business key problem and answer

-- write a query to receive all cloumns for sales made on '2022-11-05'

select category, transactions_id , sale_date from retail_sales
where sale_date = '2022-11-05';

-- write a sql queries to receive all transaction  where categories Clothing and 
--the quantity sold more than 10 in the month of november-22

select * from retail_sales
where category ='Clothing' 
and TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
and quantiy >= 4;

-- Write a sql query to calculate the total sales for each category

select category,sum(total_sale) as total_sale,count(*) as total_orders from retail_sales
group by category;

--write a sql query to find the average age customer who purchas category beauty

select round(avg(age),2) as Average_Age from retail_sales
where category='Beauty';

-- Write a sql queries to find all transaction where total sales is greater than 1000

select transactions_id, total_sale from retail_sales
where total_sale >= 1000;

-- write a sql queries to find total number of transaction 
--which made by gender and each category

select gender, category, count(*) as Total_Transaction from retail_sales
group by category,gender
order by category;

-- write a sql quries to calculate the average sales for each month.
-- find the best selling month each year
select * from
(select 
extract(Year from sale_date) as Year,
extract(Month from sale_date) as Month,
avg(total_sale) as Average_sale,
rank() over(partition by extract(Year from sale_date) order by avg(total_sale) desc ) as rank
from retail_sales
group by 1,2) as it
where rank =1;

-- Write a sql quries to find the top 5 customer based on the highest total sale

select customer_id, sum(total_sale) as total_sale , count(*) as total_order
from retail_sales
group by customer_id
order by total_sale desc
limit 5;

-- write a sql quries to find the number of customer who purchase iteam each category

select category, count(distinct customer_id) as distinct_Customer
from retail_sales
group by category;

-- Write a sql query to create each shift and number of orders
--(Example morning <=12, Afternoon between 12 & 17 , evening >17)
with hourly_sales
As(
select *, 
   case
   when extract(Hour from sale_time) < 12 then 'Morning'
   when extract(Hour from sale_time) between 12 and 17 then 'Afternoon'
   else 'Evening'
 end as Shift
from retail_sales)
select shift, count(*) as total_order
from hourly_sales
group by shift;
   



select * from retail_sales;
