#!/bin/bash

echo "Starting MariaDB..."

mysqld_safe &

# Wait for DB
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

# Create DB + user
mysql -u root << EOF
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
EOF

# Stop temp server
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

# Start final server
exec mysqld_safe --bind-address=0.0.0.0