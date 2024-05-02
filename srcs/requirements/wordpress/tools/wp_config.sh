#!/bin/bash

# Wait for MariaDB to launch
sleep 10

# Check if wp-config.php already exists
if [ ! -f "/var/www/wordpress/wp-config.php" ];
then
        wp core download --allow-root

        # Create wp-config.php using wp-cli
        wp config create        --allow-root \
                                --dbname=$SQL_DATABASE \
                                --dbuser=$SQL_USER \
                                --dbpass=$SQL_PASSWORD \
                                --dbhost=mariadb:3306 \
                                --path='/var/www/wordpress'
else
        echo "wp-config.php already exists. Skipping configuration."
fi

wp core install         --path=/var/www/html/wordpress \
                        --url=$DOMAIN_NAME/ \
                        --title=$WP_TITLE \
                        --admin_user=$WP_ADMIN_USR \
                        --admin_password=$WP_ADMIN_PWD \
                        --admin_email=$WP_ADMIN_EMAIL \
                        --skip-email --allow-root
wp user create          $WP_USR $WP_EMAIL --role=author \
                        --user_pass=$WP_PWD --allow-root

# Run the CMD from Dockerfile
exec "$@"
