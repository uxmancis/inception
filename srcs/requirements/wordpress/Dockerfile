FROM debian:bookworm

# Thanks to this Wordpress can talk to MariaDB
RUN apt-get update && apt-get install -y \
    php \
    php-fpm \
    php-mysql \
    curl \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Installs Wordpress CLI tool, to install wordpress automatically
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp

# Wordpress listens on port 9000 so that nginx can talk to Wordpress.
# Changes PHP-FPM from socket to TCP port 9000
RUN sed -i 's|listen = .*|listen = 9000|' /etc/php/8.2/fpm/pool.d/www.conf

COPY wp_setup.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/wp_setup.sh

CMD ["wp_setup.sh"]