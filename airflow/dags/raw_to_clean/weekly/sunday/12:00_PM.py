from textwrap import dedent

# The DAG object; we'll need this to instantiate a DAG
from airflow import DAG

# set DAG timezone
import pendulum
from datetime import datetime, timedelta

local_tz = pendulum.timezone("Asia/Jakarta")

# Operators; we need this to operate!
from airflow.operators.bash import BashOperator
from airflow.providers.postgres.operators.postgres import PostgresOperator

# These args will get passed on to each operator
# You can override them on a per-task basis during operator initialization
default_args = {
    "owner": "admin",
    "depends_on_past": False,
    "email": ["airflow@company.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    default_args=default_args,
    dag_id="raw_to_clean_weekly_sunday_12.00_PM",
    description="weekly Sunday at 12.00 PM raw_to_clean DAG",
    schedule_interval="0 7 * * 0",
    start_date=datetime(2019, 1, 1, tzinfo=local_tz),
    end_date=datetime(2019, 1, 8, tzinfo=local_tz),
    tags=["raw to clean"],
    template_searchpath=["/opt/airflow/dags/raw_to_clean/weekly/sunday/sql"],
    catchup=True,
    max_active_runs=1,
    concurrency=5,
) as dag:
    dim_customers = PostgresOperator(
        task_id="WRITE_TRUNCATE_dim_customers",
        postgres_conn_id="postgres_ecommerce",
        sql="customers.sql",
        task_concurrency=1,
    )
    dim_geolocation = PostgresOperator(
        task_id="WRITE_TRUNCATE_dim_geolocation",
        postgres_conn_id="postgres_ecommerce",
        sql="geolocation.sql",
        task_concurrency=1,
    )
    dim_products = PostgresOperator(
        task_id="WRITE_TRUNCATE_dim_products",
        postgres_conn_id="postgres_ecommerce",
        sql="products.sql",
        task_concurrency=1,
    )
    dim_sellers = PostgresOperator(
        task_id="WRITE_TRUNCATE_dim_sellers",
        postgres_conn_id="postgres_ecommerce",
        sql="sellers.sql",
        task_concurrency=1,
    )

    dim_customers
    dim_geolocation
    dim_products
    dim_sellers
