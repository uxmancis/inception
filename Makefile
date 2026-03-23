# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: uxmancis <uxmancis@student.42.fr>          +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2026/03/23 11:47:11 by uxmancis          #+#    #+#              #
#    Updated: 2026/03/23 14:33:17 by uxmancis         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

COMPOSE = docker compose -f srcs/docker-compose.yml

URL = https://uxmancis.42.fr

all:
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