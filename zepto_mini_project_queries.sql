# creating the database
create database if not exists zepto;

# using database
use  zepto;

# fetching 9 records
select * from zepto_v1 limit 9;

# counting total records
select count(*) from zepto_v1;

# handling null values
select count(*) as "total rows",
count(*) - count(name) as name_nulls,
count(*) - count(category) as name_nulls,
count(*) - count(mrp) as name_nulls,
count(*) - count(discountpercent) as name_nulls,
count(*) - count(availablequantity) as name_nulls,
count(*) - count(discountedsellingprice) as name_nulls,
count(*) - count(weightingms) as name_nulls,
count(*) - count(outofstock) as name_nulls,
count(*) - count(quantity) as name_nulls
from zepto_v1;

# checking how many records are out/in stock
select  outofstock,count(*) from zepto_v1
group by outofstock;

# product names present multiple times
select name,count(*) from zepto_v1
group by name
having count(*) > 1
order by count(*) desc;

# data cleaning
# products with price 0
select * from zepto_v1
where mrp=0 or discountedSellingPrice=0;

delete from  zepto_v1
where mrp=0;

# convert paisa to rupee
UPDATE  zepto_v1
set mrp=mrp/100.0,  discountedsellingprice=discountedsellingprice/100.0;


# business quesn


# top 10 best value products based on their discount percentage
select distinct name , mrp,discountpercent from zepto_v1
order by discountpercent desc limit 10 ;

# products with high mrp and out of stock
select distinct(name),mrp from zepto_v1
where outofstock=false 
order by mrp desc limit 5;

# estimated revenue for each category
select category,
sum(discountedsellingprice * availablequantity/100000) as "total_revenue_in_LAKHS"
from zepto_v1
group by category
order by total_revenue_in_LAKHS  desc;

 # Find top 10 products where MRP is greater than ₹500 and discount is less than 10%.
select distinct name,mrp,discountpercent
from zepto_v1
where mrp>500 and discountpercent<10
order by mrp desc,discountpercent desc 
limit 10;

# Identify the top 5 categories offering the highest average discount percentage.
select category , avg(discountpercent) as "% of discount"
from zepto_v1
group by category
order by "% of discount" desc limit 5;









 



