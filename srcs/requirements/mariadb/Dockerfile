FROM		alpine:3.18

RUN			apk update && apk upgrade && apk add --no-cache mariadb mariadb-client
RUN			rm -rf /var/cache/apk/*

COPY		./setup_mariadb.sh run/setup_mariadb.sh
RUN			chmod -R +x run/setup_mariadb.sh

RUN			mkdir -p /run/mysqld \
    		&& chown -R mysql:mysql /run/mysqld

RUN			mkdir -p /var/lib/mysql \
    		&& chown -R mysql:mysql /var/lib/mysql

EXPOSE		3306

ENTRYPOINT	["sh", "run/setup_mariadb.sh"]