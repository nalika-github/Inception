#!/bin/bash

service php7.4-fpm start
# Check if wp-config.php already exists
if [ ! -f "/var/www/html/wordpress/wp-config.php" ];
then
        # Create wp-config.php
	cd /var/www/html/wordpress
	cp wp-config-sample.php wp-config.php

	# Init Wordpress Databases
	sed -i "s/database_name_here/${SQL_DATABASE}/g" wp-config.php
	sed -i "s/username_here/${SQL_USER}/g" wp-config.php
	sed -i "s/password_here/${SQL_PASSWORD}/g" wp-config.php
	sed -i "s/localhost/mariadb/g" wp-config.php

	sleep 10

	wp core install         --path=/var/www/html/wordpress \
                        --url=$DOMAIN_NAME/ \
                        --title=$WP_TITLE \
                        --admin_user=$SQL_USER \
                        --admin_password=$SQL_PASSWORD \
                        --admin_email=$SQL_EMAIL \
                        --skip-email --allow-root
	wp user create          $USER $EMAIL --role=author \
                        --user_pass=$PASSWORD --allow-root
else
        echo "wp-config.php already exists. Skipping configuration."
fi

service php7.4-fpm stop

# Run the CMD from Dockerfile
exec "$@"
