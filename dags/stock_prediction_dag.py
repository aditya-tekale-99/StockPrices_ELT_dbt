#importing necessary libraries
from airflow import DAG
from airflow.models import Variable
from airflow.decorators import task
from airflow.providers.snowflake.hooks.snowflake import SnowflakeHook
from datetime import datetime
import requests
import logging

#setting up snowflake connection
def return_snowflake_conn():
    hook = SnowflakeHook(snowflake_conn_id='snowflake_conn')
    conn = hook.get_conn()
    return conn

#task to extract data from alphavantage 
@task
def extract_stock_data():
    api_key = Variable.get("alpha_vantage_api_key")
    symbols = ["TTWO", "GOOGL"]
    stock_data = {}  # Empty dictionary

    for symbol in symbols:
        url = f'https://www.alphavantage.co/query?function=TIME_SERIES_DAILY&symbol={symbol}&apikey={api_key}'
        response = requests.get(url)
        data = response.json()
        
        if "Time Series (Daily)" in data:
            daily_data = data["Time Series (Daily)"]
            latest_90_days_data = dict(list(daily_data.items())[:90])
            stock_data[symbol] = latest_90_days_data
        else:
            logging.error(f"No data for {symbol}: {data}")
    
    logging.info(stock_data)
    return stock_data

#task to transform the extracted data
@task
def transform_stock_data(raw_data):
    transformed_data = [] #empty list

    for symbol, daily_data in raw_data.items():
        if not daily_data:
            logging.warning(f"No daily data for {symbol}.")
            continue

        for date, price_info in daily_data.items():
            transformed_data.append({
                'symbol': symbol,
                'date': date,
                'open': price_info['1. open'],
                'high': price_info['2. high'],
                'low': price_info['3. low'],
                'close': price_info['4. close'],
                'volume': price_info['5. volume']
            })
    
    logging.info(transformed_data)
    return transformed_data[:180]

#task to load transformed data into snowflake table
@task
def load_to_snowflake(data):
    conn = return_snowflake_conn() 
    cur = conn.cursor() 
    try:
        cur.execute("BEGIN;")
        cur.execute("CREATE DATABASE IF NOT EXISTS dev;")
        cur.execute("USE DATABASE dev;")
        cur.execute("CREATE SCHEMA IF NOT EXISTS raw_data;")
        cur.execute("USE SCHEMA raw_data;")        
        cur.execute("""
            CREATE OR REPLACE TABLE raw_data.stock_prices (
                symbol VARCHAR(10),
                date timestamp_ntz,
                open FLOAT,
                high FLOAT,
                low FLOAT,
                close FLOAT,
                volume FLOAT,
                PRIMARY KEY (symbol, date)
            );
        """)
        
        for record in data:
            try:
                sql = f"""
                    INSERT INTO dev.raw_data.stock_prices (symbol, date, open, high, low, close, volume)
                    VALUES ('{record['symbol']}', '{record['date']}', {record['open']}, {record['high']}, {record['low']}, {record['close']}, {record['volume']});
                """
                cur.execute(sql)
            except Exception as e:
                logging.error(f"Failed to insert record for {record['symbol']} on {record['date']}: {e}")

        cur.execute("COMMIT;")
        
    except Exception as e:
        logging.error(f"Error occurred during loading to Snowflake: {e}")
        cur.execute("ROLLBACK;")
        raise e
    finally:
        cur.close() 
        conn.close()

#dag information
with DAG(
    dag_id='stock_prediction_model_v1.2',
    start_date=datetime(2024, 11, 11),
    schedule_interval='@daily',
    catchup=False,
    tags=['stock_prices', 'ETL', 'TTWO', 'GOOGL', 'Analytics'] #tags to easily identify the dag in airflow
) as dag:

    raw_data = extract_stock_data()
    transformed_data = transform_stock_data(raw_data)
    load_task = load_to_snowflake(transformed_data)

    load_task
