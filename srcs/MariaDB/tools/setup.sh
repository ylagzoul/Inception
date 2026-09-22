#!/bin/bash

set -e

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld

su -s /bin/bash mysql -c "mariadbd &"


while !mysqladmin ping -h localhost --silent
do
	sleep 1
done

mysql -e "CREATE DATABASE IF NOT EXISTS wordpress;"

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
sleep 10000000000000000
# echo "Starting MariaDB..."

# exec mysqld --user=mysql --datadir="$DATADIR"
