#!/bin/bash

set -ex

DB_PASSWORD=$(cat /run/secrets/db_password)

# Wait for MariaDB
# I need to wait it with ping ...
until php -r "
\$connection = @mysqli_connect('$DB_HOST', '$DB_USER', '$DB_PASSWORD', '$DB_NAME');
if (!\$connection) {
    exit(1);
}
"; do
    echo "Waiting for MariaDB..."
    sleep 2
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


# Install WordPress
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

    # how to add a author user in wordpress 

fi


# Permissions
# chown -R www-data:www-data /var/www/html


# Start PHP-FPM
exec php-fpm8.4 -F
