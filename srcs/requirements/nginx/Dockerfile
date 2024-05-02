FROM	debian:bullseye

RUN	apt update && apt upgrade -y \
	&& apt install nginx openssl vim -y

RUN	mkdir -p /etc/nginx/ssl \
	&& openssl req -x509 -nodes \
	-days 365 \
	-newkey rsa:2048 \
	-keyout /etc/nginx/ssl/inception.key \
	-out /etc/nginx/ssl/inception.crt \
	-subj "/C=TH/L=Bangkok/O=42/CN=ptungbun.42.fr"

RUN	rm -rf /etc/nginx/sites-enabled/default && rm -rf /etc/nginx/sites-available/default

COPY	./conf/nginx.conf ./etc/nginx/conf.d/

RUN	chmod 755 /var/www/html \
	&& chown -R www-data:www-data /var/www/html

CMD	[ "nginx", "-g", "daemon off;" ]
