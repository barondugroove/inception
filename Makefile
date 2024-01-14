# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: bchabot <bchabot@student.42.fr>            +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2023/07/25 20:18:45 by rlaforge          #+#    #+#              #
#    Updated: 2024/01/14 22:11:15 by bchabot          ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

create_local_volume:
	@mkdir -p ~/data/db
	@mkdir -p ~/data/wordpress

build: create_local_volume
	@docker compose -f ./srcs/docker-compose.yml build --no-cache

up: build
	docker compose -f ./srcs/docker-compose.yml up -d

down:
	@docker compose -f ./srcs/docker-compose.yml down --remove-orphans

stop:
	docker compose -f ./srcs/docker-compose.yml stop

clean: down
	@docker system prune -af --volumes
	sudo rm -rvf ~/data/

.PHONY: up clean build stop down


