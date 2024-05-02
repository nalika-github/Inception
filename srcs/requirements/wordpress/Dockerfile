FROM debian:bullseye

RUN apt-get update && \
    apt-get install -y php7.3 \
    mariadb-client \
    php-fpm \
    php-mysql \
    curl \
    vim \
    wget

RUN wget https://fr.wordpress.org/wordpress-6.0-fr_FR.tar.gz -P /var/www \
    && cd /var/www \
    && tar -xzf wordpress-6.0-fr_FR.tar.gz \
    && rm wordpress-6.0-fr_FR.tar.gz \
    && wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod +x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp \
    && chown -R root:root /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

RUN mkdir /run/php

COPY ./tools/wp_config.sh /usr/local/bin/

RUN chmod +x /usr/local/bin/wp_config.sh

ENTRYPOINT ["/usr/local/bin/wp_config.sh"]

WORKDIR /var/www/html/wordpress

EXPOSE 9000

CMD ["/usr/sbin/php-fpm7.4", "-F"]
