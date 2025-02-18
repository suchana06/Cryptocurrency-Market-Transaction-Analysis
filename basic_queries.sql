-- Basic SQL Queries
select * from cryptocurrencies
select * from coin_prices
select * from coin_supply
-- 1. Retrieve the list of all cryptocurrencies with their coin_id, name, and symbol
select coin_id, name, symbol from cryptocurrencies; 

-- 2. Retrieve the current_price of a cryptocurrency by its coin_id
select coin_id , current_price from coin_prices;

-- 3. Fetch the name, symbol, and market_cap of the top 5 cryptocurrencies based on market_cap_rank
select a.name, a.symbol, b.market_cap
from cryptocurrencies a
join coin_prices b
on a.coin_id = b.coin_id
order by a.market_cap_rank
limit 5;

-- 4. Retrieve the latest current_price, price_change_24h, and last_updated of a cryptocurrency by coin_id
select coin_id, current_price, price_change_24h, last_updated from coin_prices;

-- 5. Count how many cryptocurrencies are available in the cryptocurrencies table
select count(coin_id) from cryptocurrencies;