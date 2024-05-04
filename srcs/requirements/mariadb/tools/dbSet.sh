#!/bin/bash

service mariadb start

if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]
then
        # Secure Databases
        echo -e "\nY\nY\n$SQL_ROOT\n$SQL_ROOT\nY\nY\nY\nY" | mysql_secure_installation

        # Init Databases
        mariadb -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
        mariadb -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
        mariadb -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
        mariadb -e "FLUSH PRIVILEGES;"
fi

service mariadb stop

exec "$@"
