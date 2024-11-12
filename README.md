# StockPrices_ELT_dbt

## Overview

This project focuses on implementing ETL and ELT processes using:

	•	dbt (Data Build Tool): For transformations and managing analytics schema in Snowflake.
 	•	Snowflake: Data warehouse to store the raw data and analytics on raw data
	•	Apache Airflow: To schedule and manage the ETL/ELT pipeline.
	•	Docker: To configure the environment.

The project includes a data pipeline for stock data, implementing calculations for Average True Range, Bollinger Bands, Moving Averages, and RSI.

## Project Structure
```
DATA226_Lab2/
├── docker-compose-min.yaml     # Docker Compose configuration to add dbt in Airflow setup
├── dags/
│   ├── Stock_prediction_dag.py  # Airflow DAG for ETL and stock price prediction
│   └── build_elt_with_dbt.py    # Airflow DAG for dbt-based ELT operations
├── stock_dbt/
│   ├── dbt_project.yml          # dbt project configuration file
│   ├── profiles.yml             # dbt profiles configuration file
│   ├── models/
│   │   ├── raw_data/            # Models for raw data transformation
│   │   │   └── stock_prices.sql # SQL script to create a view from raw stock price data
│   │   ├── tranformations/     # Models for calculating stock indicators
│   │   │   ├── avg_true_range.sql     # Average True Range calculation
│   │   │   ├── bollinger.sql          # Bollinger Bands calculation
│   │   │   ├── moving_average.sql     # Moving Average calculation
│   │   │   └── rsi_calculations.sql   # Relative Strength Oscillator calculations
│   │   ├── schema.yml           # Data validation tests configuration
│   │   └── source.yml           # Source configuration for Snowflake data
│   └── snapshots/               # Snapshot configurations for historical data tracking
│       ├── snapshot_atr.sql         # Snapshot for Average True Range
│       ├── snapshot_bollinger.sql   # Snapshot for Bollinger Bands
│       ├── snapshot_moving_avg.sql  # Snapshot for Moving Average
│       └── snapshot_rsi.sql         # Snapshot for Relative Strength Index
└── README.md                    # Project documentation
```

## Setup

	1.	Clone the repository: git clone https://github.com/aditya-tekale-99/DATA226_Lab2.git
	2.	Start Docker Compose: docker-compose -f docker-compose-min.yaml up
	3.	Configure Snowflake and dbt:
		Ensure Snowflake credentials are set up in the dbt profile.
		Adjust the dbt project settings as needed for your Snowflake environment.

## Usage

	•	Run ETL Pipeline: Use Stock_prediction_dag.py to execute the full ETL pipeline, including stock prediction.
	•	Execute ELT Operations: Use build_elt_with_dbt.py to perform ELT processes with dbt, including transformations and documentation.
