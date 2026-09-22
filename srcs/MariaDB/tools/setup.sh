#!/bin/bash

set -e

DATADIR="/var/lib/mysql"

echo "Initializing MariaDB..."

# if [ ! -d "$DATADIR/mysql" ]; then

#     echo "Initializing database directory..."

#     mariadb-install-db --user=mysql --datadir="$DATADIR"

# fi


echo "starting temporary mariaDB server..."

# mysqld --user=mysql --datadir="$DATADIR" --skip-networking &


# MYSQL_PID=$!

# echo "waiting for mariaDB...."

# until mariadb-admin ping --silent; do 
#     sleep 1
# done

# echo "mariaDB is ready ."

# MYSQL_DATABASE="wordpress"
# MYSQL_USER="youssef"
# MYSQL_PASSWORD="you123"

# mariadb <<EOF
# CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}`;

# CREATE USER IF NOT EXTSTS '${MYSQL_USER}'@'%' IDENTIED BY '${MYSQL_PASSWORD}';

# GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO '${MYSQL_USER}'@'%';

# FLUSH PRIVILEGES;
# EOF

# echo "Stopping temporary mariaDB..."

# mariadb-admin shutdown


# # wait "$MYSQL_PID"
sleep 1000000000
# echo "Starting MariaDB..."

# exec mysqld --user=mysql --datadir="$DATADIR"