path_docker_compose = ./srcs/docker-compose.yml

all : up
up :
	docker-compose -f $(path_docker_compose) up --build
down :
	docker-compose -f $(path_docker_compose) down
re : down up
ps :
	docker-compose -f $(path_docker_compose) ps
logs :
	docker-compose -f $(path_docker_compose) logs
clean :
	docker-compose -f $(path_docker_compose) down
	if [ "$$(docker ps -aq)" ]; then docker stop $$(docker ps -aq); fi
	if [ "$$(docker ps -aq)" ]; then docker rm $$(docker ps -aq); fi
	if [ "$$(docker images -q)" ]; then docker rmi -f $$(docker images -q); fi
	if [ "$$(docker volume ls -q)" ]; then docker volume rm $$(docker volume ls -q) ; fi
	sudo rm -rf /home/ouidriss/data/mariadb/* && sudo rm -rf /home/ouidriss/data/wordpress/*
	docker system prune -a -f
	
.PHONY: up down restart ps logs clean