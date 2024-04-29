#!/bin/bash

service mysql start

if [ ! -d "/var/lib/mysql/$SQL_DATABASE" ]
then
	# Secure Databases
	echo -e "\nY\nY\n$SQL_ROOT\n$SQL_ROOT\nY\nY\nY\nY" | mysql_secure_installation

	# Init Databases
	mysql -e "CREATE DATABASE IF NOT EXISTS \`${SQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${SQL_USER}\`@'localhost' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${SQL_DATABASE}\`.* TO \`${SQL_USER}\`@'%' IDENTIFIED BY '${SQL_PASSWORD}';"
	mysql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${SQL_ROOT_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"
fi

service mysql stop

exec mysqld_safe
