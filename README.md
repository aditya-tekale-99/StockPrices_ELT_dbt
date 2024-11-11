DATA226_Lab2

This repository contains files and code for building ETL and ELT pipelines using dbt on Snowflake, with Apache Airflow for orchestration and scheduling. The project demonstrates a complete data pipeline, including data extraction, transformation, loading, and basic predictive analytics.

Table of Contents

	•	Overview
	•	Project Structure
	•	Setup
	•	Usage
	•	Contributing
	•	License

Overview

This project is part of the DATA226 course and focuses on implementing ETL and ELT processes using:
	•	dbt (Data Build Tool): For transformations and managing analytics in Snowflake.
	•	Apache Airflow: To schedule and manage the ETL pipeline.
	•	Docker Compose: To configure the environment.

The project includes a data pipeline for stock data, implementing calculations for average true range, Bollinger Bands, moving averages, and RSI. It also incorporates machine learning to predict stock prices for the next 7 days.

Project Structure

DATA226_Lab2/
├── docker-compose-min.yaml     # Docker Compose configuration to add dbt in Airflow setup
├── dags/
│   ├── Stock_prediction_dag.py  # Airflow DAG for ETL and stock price prediction
│   └── build_elt_with_dbt.py    # Airflow DAG for dbt-based ELT operations
├── stock_dbt/
│   ├── models/
│   │   ├── raw_data/            # Models for raw data transformation
│   │   ├── transformations/     # Models for calculating indicators (ATR, Bollinger, etc.)
│   │   ├── schema.yml           # Tests for data validation
│   │   └── source.yml           # Source configuration for Snowflake data
│   └── snapshots/               # Snapshot configurations for historical data
└── README.md                    # Project documentation

Key Files

	•	docker-compose-min.yaml: Configures Airflow with dbt for a streamlined environment setup using Docker.
	•	Stock_prediction_dag.py: Defines an ETL pipeline in Airflow to extract and load data into Snowflake, train a predictive model, and forecast stock prices for the next 7 days.
	•	build_elt_with_dbt.py: An Airflow DAG to run dbt commands (dbt run, dbt test, dbt snapshot, dbt docs) via Bash operations for ELT processes.

stock_dbt Directory

	•	models:
	•	raw_data: Defines a view in the analytics schema to extract raw data from Snowflake.
	•	transformations: Contains SQL files that calculate key metrics on the raw data view:
	•	Average True Range (ATR)
	•	Bollinger Bands
	•	Moving Average
	•	RSI (Relative Strength Index)
	•	schema.yml: Includes tests to validate data integrity (e.g., checking for null values).
	•	snapshots: Contains SQL files for creating snapshots of tables in the analytics schema, allowing historical data tracking and point-in-time analysis.

Setup

	1.	Clone the repository:

git clone https://github.com/aditya-tekale-99/DATA226_Lab2.git
cd DATA226_Lab2


	2.	Start Docker Compose:
Run the following command to start services defined in docker-compose-min.yaml:

docker-compose -f docker-compose-min.yaml up


	3.	Configure Snowflake and dbt:
	•	Ensure Snowflake credentials are set up in the dbt profile.
	•	Adjust the dbt project settings as needed for your Snowflake environment.

Usage

	•	Run ETL Pipeline: Use Stock_prediction_dag.py to execute the full ETL pipeline, including stock prediction.
	•	Execute ELT Operations: Use build_elt_with_dbt.py to perform ELT processes with dbt, including transformations and documentation.
