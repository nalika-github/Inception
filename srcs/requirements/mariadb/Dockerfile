FROM		debian:bullseye

RUN		apt update && apt upgrade -y

RUN		apt install vim mariadb-server -y

COPY		./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY		./tools/dbSet.sh /usr/local/bin/

RUN		chmod +x /usr/local/bin/dbSet.sh

RUN		mkdir -p /var/run/mysqld \ 
		&& chmod -R 777 /var/run/mysqld

EXPOSE		3306

ENTRYPOINT	[ "/usr/local/bin/dbSet.sh" ]
