#!/bin/bash

# Define variables
CONTAINER_NAME="postgres-container"
DB_NAME="company_db"
USER_NAME="ituser"
USER_PASSWORD="password"
ADMIN_USER="admin_cee"
DATASET_FILE="/tmp/dataset.sql"
LOG_FILE="/tmp/query_results.log"

# Pull and run the PostgreSQL container
docker run --name $CONTAINER_NAME -e POSTGRES_USER=$USER_NAME -e POSTGRES_PASSWORD=$USER_PASSWORD -e POSTGRES_DB=$DB_NAME -p 5432:5432 -d postgres

# Wait for the container to be ready
sleep 5

# Create the admin user
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -c "CREATE USER $ADMIN_USER WITH PASSWORD 'admin_password';"
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -c "GRANT ALL PRIVILEGES ON DATABASE $DB_NAME TO $ADMIN_USER;"

# Import the dataset
docker cp ./3-db/dataset.sql $CONTAINER_NAME:$DATASET_FILE
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -f $DATASET_FILE

# Run queries and output results to log file
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -c "SELECT COUNT(*) FROM employees;" >> $LOG_FILE
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -c "SELECT name FROM employees WHERE department = 'Engineering';" >> $LOG_FILE
docker exec -it $CONTAINER_NAME psql -U $USER_NAME -d $DB_NAME -c "SELECT department, MAX(salary) AS highest_salary, MIN(salary) AS lowest_salary FROM employees GROUP BY department;" >> $LOG_FILE

# Dump the database to a file
docker exec -it $CONTAINER_NAME pg_dump -U $USER_NAME $DB_NAME > company_db_dump.sql

# Mount persistent volume for PostgreSQL data
docker run --name $CONTAINER_NAME -e POSTGRES_USER=$USER_NAME -e POSTGRES_PASSWORD=$USER_PASSWORD -e POSTGRES_DB=$DB_NAME -v /path/to/your/data:/var/lib/postgresql/data -p 5432:5432 -d postgres

echo "Script executed successfully."

