COMPOSE_FILE := ./srcs/docker-compose.yml
HOME := /home/pedgonca

up-build:
	sudo mkdir -p $(HOME)/data/mysql
	sudo mkdir -p $(HOME)/data/wordpress
	sudo docker-compose -f $(COMPOSE_FILE) up --build

up:
	sudo docker-compose -f $(COMPOSE_FILE) up

down:
	sudo docker-compose -f $(COMPOSE_FILE) down

down-volumes:
	sudo docker-compose -f $(COMPOSE_FILE) down -v

clean:
	sudo docker-compose -f $(COMPOSE_FILE) down -v --remove-orphans

fclean: clean
	sudo rm -rf $(HOME)/data/mysql
	sudo rm -rf $(HOME)/data/wordpress

#delete all images
images_clean:
	sudo docker rmi $$(sudo docker images -q)

volume_clean:
	sudo docker volume rm $$(sudo docker volume ls -qf dangling=true)

container_clean:
	sudo docker rm $$(sudo docker ps -qa --no-trunc --filter "status=exited")

prune:
	sudo docker system prune -a

re-up: clean up-build

.PHONY: up down clean clean-re