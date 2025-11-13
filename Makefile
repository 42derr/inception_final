COMPOSE=docker compose
COMPOSE_FILE=srcs/docker-compose.yml
ENV_FILE=srcs/.env

.PHONY: all build up down restart logs ps shell clean

all: up

build:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) build

up:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) up -d

down:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down

restart: down up

ps:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) ps

logs:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) logs -f

shell:
	$(COMPOSE) -f $(COMPOSE_FILE) exec $(SERVICE) bash

clean:
	$(COMPOSE) -f $(COMPOSE_FILE) --env-file $(ENV_FILE) down -v
	docker system prune -af

rebuild: build restart
