SELECT *
FROM public.car_price
LIMIT 10;

select column_name, data_type 
from information_schema.columns
WHERE table_schema = 'public'
  AND table_name = 'car_price'
ORDER BY ordinal_position;

-- Finding All Null values 

SELECT
    COUNT(*) FILTER (WHERE selling_price IS NULL) AS missing_price,
    COUNT(*) FILTER (WHERE km_driven IS NULL) AS missing_km_driven,
    COUNT(*) FILTER (WHERE mileage IS NULL) AS missing_mileage,
    COUNT(*) FILTER (WHERE engine IS NULL) AS missing_engine,
    COUNT(*) FILTER (WHERE max_power IS NULL) AS missing_max_power,
    COUNT(*) FILTER (WHERE "Torque" IS NULL) AS missing_torque
FROM car_price;

-- Average price by brand
select distinct("Brand") as "Brand" , round(avg(selling_price),2) as avg_price 
from car_price group by "Brand";

-- Price by fuel type
select
    fuel,
    round(avg(selling_price)::numeric, 2) as avg_price,
    round(avg(mileage)::numeric, 2) as avg_mileage,
    round(avg("Torque")::numeric, 2) as avg_torque
from car_price
group by fuel
order by fuel;

-- Price by transmission
select
    transmission,
    round(avg(selling_price)::numeric, 2) as avg_price,
    round(avg(mileage)::numeric, 2) as avg_mileage,
    round(avg("Torque")::numeric, 2) as avg_torque
from car_price
group by transmission
order by transmission;

-- Effect of car age on price

select 
	extract(year from current_date) :: integer - year  as age,
	round(avg(selling_price )) as avg_price
from car_price  
group by age order by age asc;

-- Most expensive listings

select * from car_price order by selling_price desc limit 10;

-- gold brand performance
create table gold_performance as
select "Brand", count(*), 
		round(avg(selling_price),2) as avg_price,
		max(selling_price) as max_price,
		min(selling_price) as min_price
   from car_price 
 where "Brand" is not null and selling_price is not null 
 group by "Brand" ;
 
-- check all attributes
select * from gold_performance;

-- 