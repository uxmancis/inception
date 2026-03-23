#!/bin/bash

echo "Starting WordPress setup..."

cd /var/www/html

# Clean folder
rm -rf /var/www/html/*

# Wait for MariaDB (robust)
echo "Waiting for MariaDB..."
sleep 10

# Download WordPress
wp core download --allow-root

# Create config
wp config create \
    --dbname=${SQL_DATABASE} \
    --dbuser=${SQL_USER} \
    --dbpass=${SQL_PASSWORD} \
    --dbhost=mariadb \
    --allow-root

# Install WordPress
wp core install \
    --url=https://uxmancis.42.fr \
    --title="Inception" \
    --admin_user=${WP_ADMIN_USER} \
    --admin_password=${WP_ADMIN_PASSWORD} \
    --admin_email=${WP_ADMIN_EMAIL} \
    --skip-email \
    --allow-root

# Create user
wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --role=author \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Fix permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "WordPress setup complete!"

# Start PHP-FPM
exec php-fpm8.2 -F