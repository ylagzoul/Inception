#!/bin/bash

set -e

service mariadb start

# ziid l ROOOT password

echo "yousssssssssssef"

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"

mysql -e "CREATE USER IF NOT EXISTS 'wpuser'@'%' IDENTIFIED BY 'wppassword';"

mysql -e "GRANT ALL PRIVILEGES ON wordpress.* TO 'wpuser'@'%';"

mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u root shutdown

exec mariadbd --user=mysql