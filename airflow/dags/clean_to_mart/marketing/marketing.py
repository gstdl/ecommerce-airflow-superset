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
    "owner": "Data Analyst - Marketing Team",
    "depends_on_past": False,
    "email": ["airflow@company.com"],
    "email_on_failure": False,
    "email_on_retry": False,
    "retries": 1,
    "retry_delay": timedelta(minutes=5),
}

with DAG(
    default_args=default_args,
    dag_id="marketing_RFM_views",
    description="RFM segmentation used by marketing team",
    schedule_interval=None, # triggered manually
    start_date=datetime(2016, 9, 1, tzinfo=local_tz),
    tags=["clean_to_mart", "marketing"],
    template_searchpath=["/opt/airflow/dags/clean_to_mart/marketing/sql"],
    max_active_runs=1,
    concurrency=1,
) as dag:
    drop_views = PostgresOperator(
        task_id="DROP__VIEWS",
        postgres_conn_id="postgres_ecommerce",
        sql="drop_views.sql",
        task_concurrency=1,
    )
    rfm_base = PostgresOperator(
        task_id="CREATE__VIEW__mart.rfm_base",
        postgres_conn_id="postgres_ecommerce",
        sql="rfm.sql",
        task_concurrency=1,
    )
    rfm_ordinal = PostgresOperator(
        task_id="CREATE__VIEW__mart.rfm_ordinal",
        postgres_conn_id="postgres_ecommerce",
        sql="rfm_ordinal.sql",
        task_concurrency=1,
    )
    rfm_segments = PostgresOperator(
        task_id="CREATE__VIEW__mart.rfm_segments",
        postgres_conn_id="postgres_ecommerce",
        sql="rfm_segments.sql",
        task_concurrency=1,
    )
    drop_views >> rfm_base >> rfm_ordinal >> rfm_segments
