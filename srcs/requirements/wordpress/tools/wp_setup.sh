#!/bin/bash

echo "Starting WordPress setup..."

cd /var/www/html

rm -rf /var/www/html/*

echo "Waiting for MariaDB..."

until mysql -h mariadb -u ${SQL_USER} -p${SQL_PASSWORD} -e "SELECT 1" >/dev/null 2>&1; do
    echo "Still waiting..."
    sleep 2
done

echo "MariaDB is ready!"

# Download WordPress
wp core download --allow-root

# Create config file
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

# Create extra user (optional but recommended)
wp user create ${WP_USER} ${WP_USER_EMAIL} \
    --role=author \
    --user_pass=${WP_USER_PASSWORD} \
    --allow-root

# Fix permissions
chown -R www-data:www-data /var/www/html
chmod -R 755 /var/www/html

echo "WordPress setup complete!"

exec php-fpm8.2 -F