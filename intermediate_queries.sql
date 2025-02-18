-- Intermediate SQL Queries
select * from cryptocurrencies
select * from coin_prices
select * from coin_supply
-- 1. Calculate the average price_change_24h for all cryptocurrencies
select round(avg(price_change_24h),2) as avg_price_change_daily from coin_prices;

-- 2. Retrieve the name, symbol, and market_cap of the cryptocurrency with the highest market cap
select a.name, a.symbol, b.market_cap 
from cryptocurrencies a
join coin_prices b
on a.coin_id = b.coin_id
where b.market_cap = (select max(market_cap) from coin_prices);

-- 3. Retrieve the top 10 cryptocurrencies based on circulating_supply from the coin_supply table.
select a.name, b.coin_id from coin_supply b
join cryptocurrencies a
on a.coin_id = b.coin_id
order by circulating_supply desc
limit 10;

-- 4. Find the relationship between market_cap_change_24h and price_change_24h. 
-- Select the coin_id, price_change_24h, and market_cap_change_24h where the price_change_24h is greater than 5%.
select coin_id, price_change_24h, market_cap_change_24h from coin_prices
where price_change_percentage_24h > 5;

-- 5. Retrieve all cryptocurrencies whose market cap is greater than a given value (e.g., 1 billion USD).
select a.coin_id, a.name, a.symbol from cryptocurrencies a
join coin_prices b
using(coin_id)
where market_cap > 1000000000;
