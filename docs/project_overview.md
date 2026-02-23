# Project Overview

Below is an outline of the foundation for the 'Is Bitcoin Digital Gold' project. It follows best practices for organization, reproducibility, and collaborative work.

## Project Structure

```
rg_project/
├── .git/                       # Git Repository
├── .venv/                      # Virtual Python environment
├── .vscode/                    # VS Code configuration
│   ├── extensions.json         # VS Code extensions
│   └── settings.json           # Workspace-specific settings
├── data/                       # Data directory
│   ├── clean/                  # Data processed through cleaning measures
│   ├── etl_scripts/            # Scripts for extracting, cleaning and finalizing data 
│   ├── final/                  # Finalized data ready to be commited to database
│   ├── raw/                    # Raw data extracted from Python Libraries and APIs
│   └── bitcoin_gold_database   # Database housing finalized data                  
├── docs/                       # Project documentation
├── notebooks/                  # Jupyter Notebooks and Python Scripts for data analysis
├── plots/                      # Visualisations
├── src/                        # Python Source Code
├── .gitignore                  # Git Ignore rules
├── .python-version             # Python Version fur uv
├── pyproject.toml              # Project configuration
├── README.md                   # Project description
└── uv.lock                     # Dependencies Lock file
```

## Data Dictionary

- **Bitcoin**: Daily close price values.
- **Gold**: Daily close price values.
- **S&P 500**: Stock market index tracking the performance of 500 of the largest publicly traded companies in the US.
- **US Dollar Index (DXY)**: Measures the value of the US Dollar compared to a basket of other currencies.
- **Treasury Yields (Yield_10Y)**: The interest rate the U.S. government pays to borrow money for a decade.
- **CBOE Volatility Index (VIX)**: Tracks how much investors expect S&P 500 prices to swing over the next 30 days.
- **Consumer Price Index (CPI)**: Primary measure of inflation, calculated monthly.
- **M2 Money Supply (M2)**: Measure of the total amount of money available in the U.S. economy, calculated monthly.

## ETL Process

**Extract**

Pulled market price data from yfinance library and macro economic data from US Federal Reserve API.

**Transform** 

- Checked shape, data types and min / max values
- For market data created two versions to deal with NaN values - synced and filled.
- Added columns for normalised values:  
  - For Bitcoin, Gold, S&P 500, DXY, and Yield_10Y normalized columns added - all values start at 100 and measure growth not price.
  - For all metrics added % change columns - Yield_10Y already being % first differencing [ .dff() ] was used.
  - Due to the US Govt shutdown on Oct 25 CPI data was missing this month - Used linear interpolation to estimate it..


**Load**

- Created bitcoin_gold_database.db using SQlite
- Three tables in total: macro_data, market_filled_data and market_synced_data

