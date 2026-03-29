#!/bin/bash

echo "Starting WordPress setup..."

# Our WordPress is in /var/www/html.
# This is where we'll install wordpress (wp core download...)
#  
# Why? 
#   - That's where nginx serves files from
#   - PHP executes from there
# If WordPress files go somewhere else, nginx
# cannot find them = web site breaks.
cd /var/www/html
rm -rf /var/www/html/* #starting new, so that "wp core download" works correctly. Reason: Containers restart, reuse volumes, keep old files...

echo "Waiting for MariaDB..."

# Service Dependency Management: Waits until MariaDB is ready.
#   - Why? Containers start in parallel.
until mysql -h mariadb -u ${SQL_USER} -p${SQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    echo "Still waiting..."
    sleep 2
done

echo "MariaDB is ready!"

# 1.- Download WordPress 
wp core download --allow-root

# 2.- Connect WordPress to DataBase. How? Create config file: wp_config.php
wp config create \
    --dbname=${SQL_DATABASE} \
    --dbuser=${SQL_USER} \
    --dbpass=${SQL_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

# 3.- Install WordPress
wp core install \
    --url=https://uxmancis.42.fr \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

# 4.- Create extra user (optional but recommended)
wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --role=author \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Fix permissions
# Makes sure the web server (nginx) can read/write files
#   www.data: User that nginx/php-fpm runs as
#   chown: change owner
#   755: read/write/execute
# This is so that WordPress has the right permissions
# to upload files, write configs and serve content properly.
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "WordPress setup complete!"

# Critical for Docker:
#   To run PHP-FPM as the main process of the container.
exec php-fpm8.2 -F