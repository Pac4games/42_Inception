VOLUME_PATH := $(HOME)/Docker_volumes

all:
	@if [ ! -d "$(VOLUME_PATH)/wordpress_volume" ]; then \
		mkdir -p $(VOLUME_PATH)/wordpress_volume; \
	fi
	@if [ ! -d "$(VOLUME_PATH)/mariadb_volume"]; then \
		mkdir -p $(VOLUME_PATH)/mariadb_volume; \
	fi
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

clean:
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)
	@docker rmi -f $$(docker images -qa)
	@docker volume rm $$(docker volume ls -q)
	@docker network rm $$(docker network ls -q)	

re: clean all

.PHONY: all down stop clean re
