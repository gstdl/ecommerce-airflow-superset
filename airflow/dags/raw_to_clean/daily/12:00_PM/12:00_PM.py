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
    dag_id="raw_to_clean_daily_12.00_PM",
    description="12.00 PM raw_to_clean DAG",
    schedule_interval="0 7 * * *",
    start_date=datetime(2018, 2, 1, tzinfo=local_tz),
    end_date=datetime(2019, 1, 1, tzinfo=local_tz),
    tags=["raw to clean"],
    template_searchpath=["/opt/airflow/dags/raw_to_clean/daily/12:00_PM/sql"],
    catchup=True,
    max_active_runs=1,
    concurrency=5,
) as dag:
    fact_order_reviews = PostgresOperator(
        task_id="WRITE_APPEND_order_reviews",
        postgres_conn_id="postgres_ecommerce",
        sql="order_reviews.sql",
        task_concurrency=1,
    )
    fact_dim_orders = PostgresOperator(
        task_id="WRITE_TRUNCATE_APPEND_order_purchases",
        postgres_conn_id="postgres_ecommerce",
        sql="orders.sql",
        task_concurrency=1,
    )

    fact_dim_orders >> fact_order_reviews
