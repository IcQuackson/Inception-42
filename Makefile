COMPOSE_FILE := ./srcs/docker-compose.yml
HOME := /home/pedgonca

all:
	@echo "Usage: make [up|down|clean|fclean|delete_folders|images_clean|volume_clean|container_clean|prune|re-up]"

build:
	sudo docker compose -f $(COMPOSE_FILE) build
	sudo mkdir -p $(HOME)/data/mysql
	sudo mkdir -p $(HOME)/data/wordpress

build-up: build up

up:
	sudo docker compose -f $(COMPOSE_FILE) up

down:
	sudo docker compose -f $(COMPOSE_FILE) down

down-volumes:
	sudo docker compose -f $(COMPOSE_FILE) down -v

clean: images_clean
	sudo docker compose -f $(COMPOSE_FILE) down -v --remove-orphans

fclean: clean delete_folders

delete_folders:
	sudo rm -rf $(HOME)/data/mysql
	sudo rm -rf $(HOME)/data/wordpress

#delete all images
images_clean:
	sudo docker rmi $$(sudo docker images -q)

restart: down up

volume_clean:
	sudo docker volume rm $$(sudo docker volume ls -qf dangling=true)

container_clean:
	sudo docker rm $$(sudo docker ps -qa --no-trunc --filter "status=exited")

prune:
	sudo docker system prune -a

re-up: fclean up-build

.PHONY: up down clean clean-re