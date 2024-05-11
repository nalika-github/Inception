NAME = inception
WEB_DIR = ${HOME}/data

all: create_dir $(NAME)

create_dir:
	mkdir -p $(WEB_DIR)/mariadb
	mkdir -p $(WEB_DIR)/wordpress

$(NAME): up


up:
	docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml down

volume_clean:
	docker exec -it wordpress sh -c "rm -rf /var/www/html/wordpress/*"
	docker exec -it mariadb sh -c "rm -rf /var/lib/mysql/*"
	rm -rf $(WEB_DIR)

clean:	down
	docker rmi srcs-mariadb srcs-nginx srcs-wordpress

fclean: volume_clean clean
	docker system prune -af
	docker volume prune -f

re: clean all

.PHONY: all create_dir $(NAME) up down clean re fclean
