show databases;

CREATE DATABASE IF NOT EXISTS zepto_SQL_project ;
USE zepto_SQL_project;

DROP TABLE zepto;

USE zepto_sql_project;
SHOW TABLES;

-- data exploration
-- no. of rows
SELECT COUNT(*) AS total_rows
FROM zepto_v2;

-- sample data upto 10 rows

SELECT * FROM zepto_v2
LIMIT 10;

-- null values

select * from zepto_v2
where name is null 
or
Category is null
or 
mrp is null
or 
discountPercent is null
or 
discountedSellingPrice is null 
or 
weightInGms is null
or
availableQuantity is null
or 
outOfStock is null
or 
quantity is null;

-- different product categories
select distinct Category
from zepto_v2
order by Category;

-- products in stock vs out of stock
select outOfStock, count(*) as product_count
from zepto_v2
group by outOfStock;

-- product names present multiple times
select name, count(*) as "occurance count"
from zepto_v2 
group by name 
having count(*) > 1
order by count(*) desc;

-- data cleaning 
select * from zepto_v2 
where mrp = 0 or discountedSellingPrice = 0;

SELECT COUNT(*)
FROM zepto_v2
WHERE mrp = 0;

SET SQL_SAFE_UPDATES = 0;

delete from zepto_v2
where mrp=0;

-- convert paise to rupees
update zepto_v2 
set mrp = mrp/100.0, 
discountedSellingPrice = discountedSellingPrice/100.0 ;

select mrp, discountedSellingPrice 
from zepto_v2;

-- data analysis
-- Q1. Find the top 10 best-value products based on the discount percentage.
select distinct name, mrp, discountPercent
from zepto_v2 
order by discountPercent desc
limit 10;

-- Q2.What are the Products with High MRP but Out of Stock

select distinct name, mrp
from zepto_v2
where outOfStock = "TRUE" and mrp > 300 
order by mrp desc;

-- Q3.Calculate Estimated Revenue for each category

select category, 
sum(discountedSellingPrice * availableQuantity) as total_revenue
from zepto_v2
group by Category 
order by total_revenue;

-- Q4. Find all products where MRP is greater than ₹500 and discount is less than 10%.

select name, mrp, discountPercent
from zepto_v2
where mrp > 500 and discountPercent < 10 
order by mrp desc, discountPercent desc;















