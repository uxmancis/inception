# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: uxmancis <uxmancis@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/23 11:47:11 by uxmancis          #+#    #+#              #
#    Updated: 2026/03/31 11:12:44 by uxmancis         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

URL = https://uxmancis.42.fr

CYAN=\033[36m
RESET=\033[0m

all: 
	
# Add 'uxmancis.42.fr' domain to virtual machine's /etc/hosts file
	@echo "👉 Checking and adding 'uxmancis.42.fr' to /etc/hosts if needed..."
	@if ! grep -q "uxmancis.42.fr" /etc/hosts; then \
		echo "⚠️ Adding uxmancis.42.fr to /etc/hosts..."; \
		echo "You may be prompted for your password."; \
		sudo sh -c 'echo "127.0.0.1 uxmancis.42.fr" >> /etc/hosts'; \
		echo "✅ Domain added!"; \
	else \
		echo "✅ Domain already exists in /etc/hosts"; \
	fi
	
# Create credentials to run project:
	@if [ ! -f srcs/.env ]; then \
		echo "🔒 Let's set our own credentials to run this project! 🔒 "; \
		echo ""; \
		echo "To run the project, follow these steps:"; \
		echo "👉 1. Create your own credentials:"; \
		echo "    1.1.- Copy the content from .env.example:"; \
		printf "$(CYAN)		cp srcs/.env.example srcs/.env$(RESET)\n"; \
		echo "    1.2.- Define passwords"; \
		echo ""; \
		printf "👉 2. Run again: $(CYAN)make$(RESET)\n"; \
		exit 1; \
	fi

# Builds the Containers:
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