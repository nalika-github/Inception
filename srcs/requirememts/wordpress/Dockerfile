FROM		debian:bullseye

RUN		apt update && apt upgrade -y

RUN		apt install -y vim wget php php-fpm php-mysql mariadb-client

RUN		wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz \
		&& mkdir -p /var/www/html \ 
		&& tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html/ \
		&& rm -rf /tmp/wordpress.tar.gz \ 
		&& chown -R www-data:www-data /var/www/html/wordpress \
		&& chmod -R 755 /var/www/html/wordpress

RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
		&& chmod +x wp-cli.phar \
		&& mkdir -p /usr/local/bin/wp \
		&& mv wp-cli.phar /usr/local/bin/wp

COPY		./conf/www.conf ./etc/php/7.4/fpm/pool.d/

EXPOSE		9000

#COPY		./tools/wordpress_conf.sh /home/

#RUN		chmod +x /home/wordpress_conf.sh

#RUN		service php7.4-fpm start

#ENTRYPOINT	[ "/home/wordpress_conf.sh" ]

#CMD		[ "/usr/sbin/php-fpm7.4", "-F" ]
