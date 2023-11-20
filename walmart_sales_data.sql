CREATE DATABASE IF NOT EXISTS salesDataWalmart;

CREATE TABLE IF NOT EXISTS salesdb(
	invoice_id VARCHAR(30) NOT NULL PRIMARY KEY,
    branch VARCHAR(5) NOT NULL,
    city VARCHAR(30) NOT NULL,
    customer_type VARCHAR(30) NOT NULL,
    gender VARCHAR(30) NOT NULL,
    product_line VARCHAR(100) NOT NULL,
    unit_price DECIMAL(10,2) NOT NULL,
    quantity INT NOT NULL,
    tax_pct FLOAT(6,4) NOT NULL,
    total DECIMAL(12, 4) NOT NULL,
    date DATETIME NOT NULL,
    time TIME NOT NULL,
    payment VARCHAR(15) NOT NULL,
    cogs DECIMAL(10,2) NOT NULL,
    gross_margin_pct FLOAT(11,9),
    gross_income DECIMAL(12, 4),
    rating FLOAT(2, 1)
);
SELECT * FROM salesdb;

select time, (case 
					when time between "00:00:00" and "12:00:00" then "Morning"
					when time between "12:01:00" and "16:00:00" then "Afternoon"
					else "Evening"
end
) as time_of_day from salesdb;

alter table salesdb add column time_of_day varchar(50);

update salesdb set time_of_day = (case 
					when time between "00:00:00" and "12:00:00" then "Morning"
					when time between "12:01:00" and "16:00:00" then "Afternoon"
					else "Evening"
end);

select date,
		dayname(date)
from salesdb;

alter table salesdb add column day_name varchar(10);

update salesdb 
set day_name = dayname(date);

select date, monthname(date) from salesdb;
alter table salesdb add column month_name varchar(10);
update salesdb 
set month_name = monthname(date);

select distinct city from salesdb;

select distinct branch from salesdb;

select distinct city,
		branch
        from salesdb;

select count( distinct product_line) from salesdb;

select payment, count(payment) as cnt from salesdb group by payment order by cnt desc;

select product_line, count(product_line) as cnt from salesdb group by product_line order by cnt desc;

select * from salesdb;
select sum(total) as total_revenue, month_name as month 
from salesdb group by month_name order by total_revenue desc;

select sum(cogs) as max_cogs, month_name as month 
from salesdb group by month_name order by max_cogs desc;

select sum(total) as total_revenue, product_line
from salesdb group by product_line order by total_revenue desc;

select sum(total) as total_revenue, city
from salesdb group by city order by total_revenue desc;

select avg(tax_pct) as avg_tax, product_line
from salesdb group by product_line order by avg_tax desc;

select branch, sum(quantity) as qty
from salesdb group by branch having sum(quantity) > (select avg(quantity) from salesdb)
;

select gender, product_line, count(gender)as total_cnt
from salesdb group by gender, product_line
order by total_cnt desc;

select round(avg(rating),2) as avg_rating, product_line 
from salesdb group by product_line order by avg_rating desc;

select time_of_day, count(*) as total_sales 
from salesdb 
where day_name = 'Monday'
group by time_of_day order by total_sales desc;

select customer_type, sum(total) as total_rev 
from salesdb group by customer_type order by total_rev;

select avg(tax_pct) as vat, city
from salesdb group by city order by vat desc;

select customer_type, avg(tax_pct) as vat
from salesdb group by customer_type order by vat desc;

select customer_type,count(*) as total_customers from salesdb group by customer_type;

select time_of_day, avg(rating) as avg_rating from salesdb group by time_of_day order by avg_rating
;