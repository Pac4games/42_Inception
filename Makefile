# Colors
RED		= \033[0;31m
GREEN		= \033[0;32m
YELLOW		= \033[0;33m
NC		= \033[0m

# Self-explanatory
VOLUME_PATH	= $(HOME)/Docker_volumes

all:
	@if [ ! -d "$(VOLUME_PATH)/wordpress_volume" ]; then \
		echo "$(GREEN)Creating WordPress volume...$(NC)"; \
		mkdir -p $(VOLUME_PATH)/wordpress_volume; \
	fi
	@if [ ! -d "$(VOLUME_PATH)/mariadb_volume" ]; then \
		echo "$(GREEN)Creating MariaDB volume...$(NC)"; \
		mkdir -p $(VOLUME_PATH)/mariadb_volume; \
	fi
	@sleep 1
	@echo "$(GREEN)Docker volumes ready!$(NC)"
	@echo "$(GREEN)Starting up Docker compose...\n$(NC)"
	@docker compose -f ./srcs/docker-compose.yml up -d --build

down:
	@docker compose -f ./srcs/docker-compose.yml down

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

clean:
	@echo "$(GREEN)Cleaning up Docker containers, volumes and networks...\n$(NC)"
	@docker stop $$(docker ps -qa)
	@docker rm $$(docker ps -qa)
	@docker rmi -f $$(docker images -qa)
	@docker volume rm $$(docker volume ls -q)
	@docker network ls -q | while read network_id; do \
		network_name=$$(docker network inspect -f '{{.Name}}' $$network_id); \
		if [ "$$network_name" != "bridge" ] && [ "$$network_name" != "host" ] && [ "$$network_name" != "none" ]; then \
			docker network rm $$network_id; \
		fi; \
	done

re: 
	@echo "$(GREEN)Preparing to rebuild containers...\n$(NC)"
	@make clean
	@make all

.PHONY: all down stop clean re
