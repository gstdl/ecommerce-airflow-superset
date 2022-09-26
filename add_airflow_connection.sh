source .env
conn_uri="postgresql+psycopg2://$username:$password@postgres_airflow:5432/$ecommerce_db_name"
echo $conn_uri
# docker exec airflow-webserver airflow connections delete 'postgres_ecommerce'
docker exec airflow-webserver airflow connections add 'postgres_ecommerce' --conn-uri $conn_uri