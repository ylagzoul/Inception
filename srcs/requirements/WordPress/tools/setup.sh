#!/bin/bash

set -ex

DB_NAME=wordpress
DB_USER=ylagzoul
DB_PASSWORD=123
DB_HOST=mariadb

if [ ! -f /var/www/html/wp-config.php ]; then

    cp /var/www/html/wp-config-sample.php /var/www/html/wp-config.php

    sed -i "s/database_name_here/$DB_NAME/" \
        /var/www/html/wp-config.php

    sed -i "s/username_here/$DB_USER/" \
        /var/www/html/wp-config.php

    sed -i "s/password_here/$DB_PASSWORD/" \
        /var/www/html/wp-config.php

    sed -i "s/localhost/$DB_HOST/" \
        /var/www/html/wp-config.php

fi

chown -R www-data:www-data /var/www/html

exec php-fpm8.4 -F