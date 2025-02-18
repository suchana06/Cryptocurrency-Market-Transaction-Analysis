# Cryptocurrency Market & Transaction Analysis

## 🔹 Overview
This project analyzes **real-time cryptocurrency market data** using **SQL**. It collects data from the **CoinGecko API** and stores it in a **PostgreSQL** database. The analysis covers **price trends, market volatility, trading volume, and whale movements** to provide actionable financial insights.

## 🔹 Key Features
- **📥 Data Collection**: Real-time cryptocurrency data fetched via the **CoinGecko API**.
- **📊 Database Setup**: PostgreSQL database with structured tables for efficient querying.
- **🔎 Data Analysis**: Advanced SQL queries for market trends, volatility, and supply insights.
- **📈 Time-Series Analysis**: Rolling averages and correlation analysis for deeper insights.
- **🐋 Whale Detection**: Identification of large transactions influencing market movements.
- **📌 Financial Metrics**: Price change %, liquidity ratio, and market cap comparisons.

---

## 🔹 Tech Stack
- **Database**: PostgreSQL (Managed via **pgAdmin**)
- **API**: CoinGecko Public API (Free Tier)
- **Query Language**: SQL
- **Data Handling**: Python (for JSON transformation & structured storage)

---

## 🔹 Data Collection & Storage
### **1️⃣ Data Source**
- **API Used**: CoinGecko API
- **Data Type**: Real-time cryptocurrency market data

### **2️⃣ Database Schema**
The following PostgreSQL tables store the collected data:

#### 📌 `cryptocurrencies` (Basic details)
| Column | Type | Description |
|--------|------|-------------|
| coin_id | TEXT | Unique identifier for each cryptocurrency |
| name | TEXT | Full name of the cryptocurrency |
| symbol | TEXT | Ticker symbol (e.g., BTC, ETH) |
| market_cap_rank | INT | Market rank based on capitalization |

#### 📌 `coin_prices` (Market metrics)
| Column | Type | Description |
|--------|------|-------------|
| coin_id | TEXT | Foreign key referencing `cryptocurrencies` |
| current_price | FLOAT | Latest price in USD |
| market_cap | FLOAT | Total market capitalization |
| total_volume | FLOAT | 24-hour trading volume |
| price_change_24h | FLOAT | Absolute price change in the last 24 hours |

#### 📌 `coin_supply` (Supply details)
| Column | Type | Description |
|--------|------|-------------|
| coin_id | TEXT | Foreign key referencing `cryptocurrencies` |
| total_supply | FLOAT | Maximum supply of the coin |
| circulating_supply | FLOAT | Currently circulating supply |

#### 📌 `historical_prices` (Daily price history)
| Column | Type | Description |
|--------|------|-------------|
| coin_id | TEXT | Foreign key referencing `cryptocurrencies` |
| date | DATE | Date of the recorded data |
| price | FLOAT | Closing price for the day |
| market_cap | FLOAT | Market capitalization at that date |
| total_volume | FLOAT | Trading volume at that date |

---

## 🔹 Data Cleaning & Transformation
- **Removed null values and duplicates** for accurate analysis.
- **Converted string-based numeric values** into proper data types.
- **Created derived metrics for deeper insights:**
  - **Price Change (%)** → `(price_change_24h / (current_price - price_change_24h)) * 100`
  - **Market Liquidity Ratio** → `total_volume / market_cap`
  - **7-Day Rolling Average** → Used SQL window functions to smooth trends.

---

## 🔹 Data Analysis & SQL Queries
### **1️⃣ Basic Market Information**
✔ Retrieve all available cryptocurrencies.
✔ Fetch real-time prices to monitor trends.
✔ Identify the **Top 5 cryptocurrencies** by market cap.
✔ Calculate **total number of cryptocurrencies** in the dataset.

### **2️⃣ Market Trends & Supply Analysis**
✔ Find **highest market cap cryptocurrency**.
✔ Retrieve **Top 10 cryptocurrencies** based on circulating supply.
✔ Analyze correlation between **market cap change & price change**.
✔ Identify coins with **market cap exceeding $1 billion**.

### **3️⃣ Historical Performance & ATH Analysis**
✔ Find the cryptocurrency with **maximum total supply**.
✔ Retrieve **Top 5 cryptocurrencies** with the highest **price gains in 24 hours**.
✔ Merge price and supply data for **All-Time High (ATH) analysis**.
✔ Identify cryptocurrency with **highest ATH value**.

### **4️⃣ Time-Series & Volatility Analysis**
✔ Compute **7-day & 30-day rolling averages**.
✔ Identify the **5 most volatile cryptocurrencies** over the last month.
✔ Measure **7-day price volatility** for each coin.
✔ Compute **correlation between price & volume** over 30 days.

### **5️⃣ Whale Movements & Anomaly Detection**
✔ Detect **large transactions (whale movements)** based on abnormal volume changes.
✔ Identify coins with **sudden price spikes above 10% in a single day**.

---

## 🔹 Insights & Findings
🔹 **Bitcoin & Ethereum consistently dominate** in market capitalization.
🔹 **High price volatility** is observed during **major news events & regulations**.
🔹 **Whale transactions significantly impact short-term market trends**.
🔹 **Certain altcoins exhibit strong growth patterns**, useful for investment insights.
🔹 **Trading volume peaks during major global financial market openings**.

---

## 🔹 Challenges & Limitations
❗ **API Rate Limit** → (~30 requests/min), requiring **efficient data fetching**.
❗ **Data Gaps** → Some cryptocurrencies lack complete historical data.
❗ **Query Complexity** → Advanced SQL techniques (e.g., window functions) used for time-series analysis.
❗ **Storage Considerations** → Large datasets demand **efficient indexing strategies**.
❗ **Real-time Limitations** → This setup does not support **high-frequency trading analysis**.

---

## 🔹 Future Enhancements 🚀
✅ **Automate data collection** via scheduled API calls.
✅ **Add predictive modeling** using machine learning for trend forecasting.
✅ **Improve real-time updates** with **streaming data pipelines**.
✅ **Extend visualization** using Power BI/Tableau for dashboards.

---

## 🔹 How to Run the Project
### **1️⃣ Clone the Repository**
```sh
git clone https://github.com/suchana06/Cryptocurrency-Market-Transaction-Analysis.git
```

### **2️⃣ Set Up PostgreSQL Database**
1. Install PostgreSQL and pgAdmin.
2. Create a new database.
3. Execute the SQL scripts in `/table_creation` to create tables.

### **3️⃣ Run Data Collection**
```sh
crypto_analysis_script.ipynb  # Script to collect & store CoinGecko API data
```

### **4️⃣ Execute SQL Queries**

---

---

## 🔹 Contributing 🤝
Contributions are welcome! Feel free to **fork**, **open issues**, or submit **pull requests**.

---
