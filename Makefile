VOLUME_DIR = ${HOME}/data

all: create up

create:
	mkdir -p ${VOLUME_DIR}/wordpress
	mkdir -p ${VOLUME_DIR}/mariadb

up:
	#docker compose -f ./srcs/docker-compose.yml   up -d --build
	docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env up -d --build

down:
	docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down

start:
	docker compose -f ./srcs/docker-compose.yml start

stop:
	docker compose -f ./srcs/docker-compose.yml stop

re: down up

clean:
	docker compose -f ./srcs/docker-compose.yml --env-file ./srcs/.env down --rmi all --volumes

fclean:
	docker stop $$(docker ps -qa) 
	docker system prune --all --force
	docker network prune --force
	docker volume prune --force
	rm -rf ${VOLUME_DIR}

.PHONY : all create up down start stop re clean fclean
