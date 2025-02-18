-- Advanced SQL Queries
select * from cryptocurrencies
select * from coin_prices
select * from coin_supply
select * from historical_prices
-- 1. Retrieve the cryptocurrency with the maximum max_supply and the cryptocurrency with the minimum max_supply.
select coin_id, max_supply from coin_supply
where max_supply = (select max(max_supply) from coin_supply)
union
select coin_id, max_supply from coin_supply
where max_supply = (select min(max_supply) from coin_supply)

-- 2. Retrieve the name, symbol, and price_change_percentage_24h of the top 5 cryptocurrencies with the highest price_change_percentage_24h in the last 24 hours.
select a.name, a.symbol, b.price_change_percentage_24h
from cryptocurrencies a
join coin_prices b
using(coin_id)
where price_change_percentage_24h is not null
order by price_change_percentage_24h desc
limit 5;

-- 3. Join the coin_prices and coin_supply tables and retrieve the coin_id, current_price, circulating_supply, and ath for each coin.
select a.coin_id, a.current_price, b.circulating_supply, b.ath
from coin_prices a
join coin_supply b
using(coin_id);

-- 4. Retrieve the coin_id, name, ath, and ath_date for the cryptocurrency with the highest ath.
select a.coin_id, a.name, b.ath, b.ath_date
from cryptocurrencies a
join  coin_supply b
using(coin_id)
order by b.ath desc
limit 1;

-- 5. Compare the market_cap with the circulating_supply and calculate the market cap per unit of supply (market cap / circulating supply) for each coin.
select a.coin_id, a.market_cap, b.circulating_supply,
(market_cap/circulating_supply) as marketing_cap_per_unit
from coin_prices a
join coin_supply b
using(coin_id);

-- 6. Retrieve the coin_id and the percentage change of the price_change_percentage_24h over the last 7 days for top 50 coins. 
WITH cte AS (
    SELECT coin_id,
           ROUND(((price - LAG(price, 30) OVER (PARTITION BY coin_id ORDER BY timestamp)) / 
           LAG(price, 30) OVER (PARTITION BY coin_id ORDER BY timestamp)), 2) * 100 AS percentage_change_30d
    FROM historical_prices
)
SELECT coin_id, percentage_change_30d
FROM cte
WHERE percentage_change_30d IS NOT NULL;


-- 7. Retrieve the coin_id and name of all coins where the total_supply is less than the market_cap.
select a.coin_id, a.name
from cryptocurrencies a
join coin_prices b
using(coin_id)
join coin_supply c
on a.coin_id=c.coin_id
where c.total_supply < b.market_cap;