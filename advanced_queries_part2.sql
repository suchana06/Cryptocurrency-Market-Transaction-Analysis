-- Advanced SQL Queries Part 2
select * from cryptocurrencies
select * from coin_prices
select * from coin_supply
select * from historical_prices

-- 1. Calculate the 7-day rolling average and 30-day rolling average for the price of each coin.
SELECT DISTINCT ON (coin_id, timestamp) coin_id,
       AVG(price) OVER (PARTITION BY coin_id 
                        ORDER BY timestamp 
                        RANGE BETWEEN INTERVAL '7 days' PRECEDING AND CURRENT ROW) AS weekly_moving_avg,
       AVG(price) OVER (PARTITION BY coin_id 
                        ORDER BY timestamp 
                        RANGE BETWEEN INTERVAL '30 days' PRECEDING AND CURRENT ROW) AS monthly_moving_avg
FROM historical_prices
ORDER BY coin_id, timestamp;

-- 2. Identify the *top 5 most volatile coins* over the last 30 days based on price fluctuations.
WITH volatility_cte AS (
    SELECT
        coin_id,
        timestamp,
        price,
        STDDEV(price) OVER (PARTITION BY coin_id ORDER BY timestamp ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS price_volatility
    FROM historical_prices
)
SELECT coin_id, 
       AVG(price_volatility) AS avg_volatility
FROM volatility_cte
WHERE price_volatility IS NOT NULL
GROUP BY coin_id
ORDER BY avg_volatility DESC
LIMIT 5;

-- 3.Calculate the 7-day price volatility for each coin.
select coin_id, 
	stddev(price) over(PARTITION BY coin_id ORDER BY timestamp ROWS BETWEEN 6 PRECEDING AND CURRENT ROW) as price_volatility
from historical_prices;

-- 4. Calculate the correlation between price and total_volume for each coin over the last 30 days
select coin_id, corr(price,total_volume) OVER (PARTITION BY coin_id ORDER BY timestamp ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS price_volume_correlation
from historical_prices;

-- 5. Find coins with the highest positive correlation and highest negative correlation between their price and market_cap over the last 30 days
WITH correlations AS (
  SELECT coin_id,
         CORR(price, market_cap) OVER (PARTITION BY coin_id ORDER BY timestamp ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS price_market_cap_correlation
  FROM historical_prices
)
SELECT coin_id, price_market_cap_correlation
FROM correlations
where price_market_cap_correlation is not null
ORDER BY price_market_cap_correlation asc --desc for highest +ve corr
LIMIT 1; 

-- 6. Identify large transactions (whale movements) by checking if a coin's volume significantly deviates from its mean.
with cte as(select coin_id,
avg(total_volume) over(partition by coin_id order by timestamp rows between 29 preceding and current row) as avg_volume,
stddev(total_volume) over(partition by coin_id order by timestamp rows between 29 preceding and current row) as std_dev_volume
from historical_prices)
select h.coin_id, h.timestamp, h.total_volume, v.avg_volume, v.std_dev_volume
from historical_prices h
join cte v
on h.coin_id = v.coin_id
WHERE h.total_volume > (v.avg_volume + 2 * v.std_dev_volume)
ORDER BY h.total_volume DESC;

-- 7. Identify coins with sudden abnormal price changes (e.g., more than 10% in a single day)
with cte as
(SELECT coin_id, timestamp, price,
       LAG(price, 1) OVER (PARTITION BY coin_id ORDER BY timestamp) AS prev_day_price,
       ROUND(((price - LAG(price, 1) OVER (PARTITION BY coin_id ORDER BY timestamp)) / 
       LAG(price, 1) OVER (PARTITION BY coin_id ORDER BY timestamp)) * 100, 2) AS daily_price_change
FROM historical_prices
)
select coin_id, price, prev_day_price, daily_price_change
from cte where daily_price_change>10;