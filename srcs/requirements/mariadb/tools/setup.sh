#!/bin/bash

set -e

#
DB_NAME=wordpress
DB_USER=ylagzoul
DB_PASSWORD=data123
ROOT_PASSWORD=root123
DB_HOST=mariadb
#

mkdir -p /run/mysqld

chown mysql:mysql /run/mysqld

if [ ! -d /var/lib/mysql/wordpress ]
then

service mariadb start

until mariadb-admin ping --silent
do
        sleep 1
    done

mariadb -u root  << EOF
CREATE DATABASE $DB_NAME;
CREATE USER '$DB_USER'@'%' IDENTIFIED BY '$DB_PASSWORD';
GRANT ALL PRIVILEGES ON $DB_NAME.* TO '$DB_USER'@'%';
ALTER USER root@localhost IDENTIFIED BY '$ROOT_PASSWORD';
EOF

    mariadb-admin -u root -p"$ROOT_PASSWORD" shutdown

    while mariadb-admin -u root -p"$ROOT_PASSWORD" ping --silent
    do
        sleep 1
    done
fi

echo "Maraidb is running !!"

exec mariadbd --user=mysql --bind-address=0.0.0.0 --port=3306
