#!/bin/bash

# 🐋 Docker rule:
# 1 container = runs 1 main process
#
# and... we do have 2 steps:
#       1) Step A
#       2) Step B
#
# How can we run setup AND keep MariaDB running?
# Solution:
#   Start DB (mysqld_safe &) - MySQL running (background process)
#   BUT keep script running - Script running (main process)



echo "Starting MariaDB..."
# MariaDB starts in the background:
#   &: tempoorary, in the background

mysqld_safe &

# Wait for DB to be ready, before executing commands
# 1. Hey MariaDB, are you running?
# if yes, returns Success
# if not, connection fails
#
# until... do : repeats until condition is true
# it waits 2 seconds between attempts
#       try ping -- fail
#       try ping -- fail
#       try ping -- success✅
#       continues script
until mysqladmin ping --silent; do
    echo "Waiting for MariaDB..."
    sleep 2
done

echo "MariaDB is ready!"

# DB Configuration:
# Create DB + user. SQL Language to create DB.c
# (Can be typed manually in Terminal if mariadb is installed) 
# e.g.: CREATE USER 'bratz1'@'%' IDENTIFIED BY '123bratz';
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
# Wordpress: 'still waiting...' never gets to connect.
#
# --
# 1. Database is created inside /var/lib/mysql
# 2. User is created to connect from anywhere
# 3. Permissions are given to user in 100% tables of DB (E.g.: SELECT, INSERT, UPDATE, DELETE, CREATE, ... )
# 4. root password is modified
####################################################################################
mysql -u root << Script
CREATE DATABASE IF NOT EXISTS ${SQL_DATABASE};
CREATE USER IF NOT EXISTS '${SQL_USER}'@'%' IDENTIFIED BY '${SQL_PASSWORD}';
GRANT ALL PRIVILEGES ON ${SQL_DATABASE}.* TO '${SQL_USER}'@'%';
ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';
FLUSH PRIVILEGES;
Script

# Stop temp server: "Tell MariaDB to stop"
#
# Before MariaDB was in background setup mode, that's not suitable for final container.
# That's why...
#       1) Shut the background process down
mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

#       2) Start final server:
# As Docker only cares about the main process,
# MariaDB = main process, then container stays alive 🙌 
exec mysqld_safe --bind-address=0.0.0.0
# It does accept connections from anywhere, 0.0.0.0