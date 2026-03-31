# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: uxmancis <uxmancis@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/23 11:47:11 by uxmancis          #+#    #+#              #
#    Updated: 2026/03/31 09:23:49 by uxmancis         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

URL = https://uxmancis.42.fr

CYAN=\033[36m
RESET=\033[0m

all:
	@if [ ! -f srcs/.env ]; then \
		echo "🔒 Let's set our own credentials to run this project! 🔒 "; \
		echo ""; \
		echo "To run the project, follow these steps:"; \
		echo "👉 1. Create your own credentials:"; \
		echo "    1.1.- Copy the content from .env.example:"; \
		printf "$(CYAN)				cp srcs/.env.example srcs/.env$(RESET)\n"; \
		echo "    1.2.- Define passwords"; \
		echo ""; \
		printf "👉 2. Run again: $(CYAN)make$(RESET)\n"; \
		exit 1; \
	fi
	@echo "🚀 Starting Inception..."
	@$(COMPOSE) up --build -d
	@echo "⏳ Waiting for services to be ready..."
	@until curl -k --silent --fail $(URL) > /dev/null; do \
		sleep 2; \
		printf "."; \
	done
	@echo "\n✅ Inception is ready!"
	@echo "👉 Open: $(URL)"

down:
	@$(COMPOSE) down

clean:
	@$(COMPOSE) down -v

fclean: clean
	@docker system prune -af

re: fclean all

.PHONY: all down clean fclean re