#!/bin/bash

set -e


# Wait for MariaDB
while ! mysqladmin ping -h mariadb --silent
do
	sleep 1
done

if [ ! -f /var/www/html/wp-load.php ]; then
    wp core download --path=/var/www/html --allow-root
fi

# Create wp-config.php
if [ ! -f /var/www/html/wp-config.php ]; then

    wp config create \
        --dbname="$DB_NAME" \
        --dbuser="$DB_USER" \
        --dbpass="$DB_PASSWORD" \
        --dbhost="$DB_HOST" \
        --path=/var/www/html \
        --allow-root
fi

if ! wp core is-installed \
    --path=/var/www/html \
    --allow-root
then

    wp core install \
        --url="$WP_URL" \
        --title="$WP_TITLE" \
        --admin_user="$WP_ADMIN_USER" \
        --admin_password="$WP_ADMIN_PASSWORD" \
        --admin_email="$WP_ADMIN_EMAIL" \
        --path=/var/www/html \
        --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
        --role=author \
        --user_pass="$WP_USER_PASSWORD" \
        --path=/var/www/html \
        --allow-root

fi


exec php-fpm8.2 -F
