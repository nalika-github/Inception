FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y php7.3 \
    mariadb-client \
    php-fpm \
    php-mysql \
    curl \
    vim \
    wget

RUN	wget -O /tmp/wordpress.tar.gz https://wordpress.org/latest.tar.gz && \
	mkdir -p /var/www/html && \
	tar -xzvf /tmp/wordpress.tar.gz -C /var/www/html/ && \
	chown -R www-data:www-data /var/www/html/wordpress && \
	chmod -R 755 /var/www/html/wordpress

RUN	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
	&& chmod +x wp-cli.phar\
	&& mv wp-cli.phar /usr/local/bin/wp

COPY	./conf/www.conf /etc/php/7.4/fpm/pool.d/

COPY	./tools/wp_config.sh /usr/local/bin/

RUN	chmod +x /usr/local/bin/wp_config.sh

ENTRYPOINT ["/usr/local/bin/wp_config.sh"]

WORKDIR /var/www/html/wordpress

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
