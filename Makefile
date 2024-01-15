# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bchabot <bchabot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/25 20:18:45 by rlaforge          #+#    #+#              #
#    Updated: 2024/01/15 15:31:52 by bchabot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

create_local_volume:
	@cp ~/.env ./srcs/.env
	@mkdir -p ~/data/db
	@mkdir -p ~/data/wordpress

build: create_local_volume
	@docker compose -f ./srcs/docker-compose.yml build --no-cache

up:
	@docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down --remove-orphans

stop:
	@docker compose -f ./srcs/docker-compose.yml stop

clean: down
	@docker system prune -af --volumes
	@sudo rm -rf ~/data/

.PHONY: create_local_volume up clean build stop down


