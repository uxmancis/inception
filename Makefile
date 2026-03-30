# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: uxmancis <uxmancis@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/23 11:47:11 by uxmancis          #+#    #+#              #
#    Updated: 2026/03/30 11:23:02 by uxmancis         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

URL = https://uxmancis.42.fr

all:
	@if [ ! -f srcs/.env ]; then \
		echo "Let's set our own credentials to run this project! 😊 "; \
		echo ""; \
		echo "👉 To run the project, follow these steps:"; \
		echo "1. Create a .env file inside the srcs/ directory. Make sure it's called ⚙️ .env!!"; \
		echo "2. Copy content from .env.example:"; \
		echo "   cp srcs/.env.example srcs/.env"; \
		echo "3. Edit the .env file and set your credentials"; \
		echo "4. Run again: make"; \
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