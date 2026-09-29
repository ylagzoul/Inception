#!/bin/bash

set -ex

DB_PASSWORD=$(cat /run/secrets/db_password)

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld

su -s /bin/bash mysql -c "mariadbd" &

MYSQL_PID=$!

while ! mysqladmin ping -h localhost --silent
do
	sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"

mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"

mariadb-admin shutdown

wait "$MYSQL_PID"

exec mariadbd --user=mysql
