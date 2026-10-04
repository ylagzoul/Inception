#!/bin/bash

set -e

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld

su -s /bin/bash mysql -c "mariadbd" & # مشكل في ان لاينبغي ان تكون اي عمليه في الخلفيه
# subject - Examine the Dockerfiles. If you see 'tail -f' or any command run in background in any of them in the 
# subject - ENTRYPOINT section, the evaluation ends now. Same thing if 'bash' or 'sh' are used but not for running a script (e.g, 'nginx & bash' or 'bash').


MYSQL_PID=$!

while ! mysqladmin ping -h localhost --silent
do
	sleep 1
done

# khass tzid password l root
# mariadb -u root -p"$MYSQL_ROOT_PASSWORD" << EOF
mysql -e "CREATE DATABASE IF NOT EXISTS $DB_NAME;"

mysql -e "CREATE USER IF NOT EXISTS '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';"

mysql -e "GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';"

#FLUSH PRIVILEGES;
#EOF
mariadb-admin shutdown

wait "$MYSQL_PID"

exec mariadbd --user=mysql --bind-address=0.0.0.0 --port=3306
