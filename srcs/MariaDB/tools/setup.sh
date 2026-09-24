#!/bin/bash

set -ex

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld

su -s /bin/bash mysql -c "mariadbd" &

MYSQL_PID=$!

while ! mysqladmin ping -h localhost --silent
do
	sleep 1
done

USER=ylagzoul
DATABASE=wordpress

mysql -e "CREATE DATABASE IF NOT EXISTS $DATABASE;"

mysql -e "CREATE USER IF NOT EXISTS '$USER'@'%';"

mysql -e "GRANT ALL PRIVILEGES ON $DATABASE.* TO '$USER'@'%';"

mariadb-admin shutdown

wait "$MYSQL_PID"

exec mariadbd --user=mysql
