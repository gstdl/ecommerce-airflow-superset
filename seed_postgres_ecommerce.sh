source .env
docker exec postgres_airflow psql -U $username -d $ecommerce_db_name -a -f /docker-entrypoint-initdb.d/seed.sql
docker exec postgres_airflow psql -U $username -d $ecommerce_db_name -a -f /docker-entrypoint-initdb.d/staging.sql
