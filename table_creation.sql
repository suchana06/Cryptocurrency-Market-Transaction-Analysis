-- Create cryptocurrencies table
CREATE TABLE cryptocurrencies (
    coin_id VARCHAR PRIMARY KEY,
    name VARCHAR NOT NULL,
    symbol VARCHAR NOT NULL,
    market_cap_rank INT
);

-- Create coin_prices table
CREATE TABLE coin_prices (
    coin_id VARCHAR REFERENCES cryptocurrencies(coin_id),
    current_price DECIMAL NOT NULL,
    market_cap DECIMAL NOT NULL,
    total_volume DECIMAL NOT NULL,
    price_change_24h DECIMAL NOT NULL,
    price_change_percentage_24h DECIMAL NOT NULL,
    market_cap_change_24h DECIMAL NOT NULL,
    market_cap_change_percentage_24h DECIMAL NOT NULL,
    last_updated TIMESTAMP NOT NULL
);

-- Create coin_supply table
CREATE TABLE IF NOT EXISTS coin_supply (
    coin_id VARCHAR PRIMARY KEY REFERENCES cryptocurrencies(coin_id) ON DELETE CASCADE,
    circulating_supply DECIMAL,
    total_supply DECIMAL,
    max_supply DECIMAL,
    ath DECIMAL,
    ath_date TIMESTAMP,
    atl DECIMAL,
    atl_date TIMESTAMP
);
CREATE TABLE historical_prices (
    id SERIAL PRIMARY KEY,
    coin_id TEXT REFERENCES cryptocurrencies(coin_id),
    currency TEXT,
    price NUMERIC,
    market_cap NUMERIC,
    total_volume NUMERIC,
    timestamp TIMESTAMP,
    UNIQUE (coin_id, timestamp)  -- Prevent duplicate entries
);