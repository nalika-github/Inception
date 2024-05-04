FROM		debian:bullseye

RUN		apt update && apt upgrade -y

RUN		apt install vim mariadb-server mariadb-client wget -y

COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/


# Wordpress-CLI Install
RUN		wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar\
		&& chmod +x wp-cli.phar\
		&& mv wp-cli.phar /usr/local/bin/wp

COPY		./tools/dbSet.sh /usr/local/bin/

RUN		chmod +x /usr/local/bin/dbSet.sh

RUN		mkdir -p /var/run/mysqld \ 
		&& chmod -R 777 /var/run/mysqld

EXPOSE		3306

ENTRYPOINT	[ "/usr/local/bin/dbSet.sh" ]

CMD     	[ "mysqld" ]
