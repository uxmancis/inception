#!/bin/bash

echo "Starting MariaDB..."

mysqld_safe &

# Wait for DB
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

# Create DB + user. SQL Language to create DB.c
# (manually) e.g.: CREATE USER 'bratz1'@'%' IDENTIFIED BY '123bratz';
#   where... '@' means: it can connect from anywhere
#            'bratz1'@'%': WHO can connect + FROM WHERE
#            It can connect from any host/computer/server/container
#            Other possible host values:
#                   'localhost': same machine
#                   '127.0.0.1': same machine (IP)
#                   '%': ANY machine
#                   '192.168.1.10': specific machine
# Docker context: WordPress container and MariaDB container are different machines
# conceptually. If we do CREATE USER 'bratz1'@'localhost' it FAILS.
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