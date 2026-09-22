#!/bin/bash

set -e

sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php/8.2/fpm/pool.d/www.conf


# 










exec php-fpm8.2 -F