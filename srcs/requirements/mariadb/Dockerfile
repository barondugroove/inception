FROM		alpine:3.18

RUN			apk update && apk upgrade && apk add --no-cache mariadb mariadb-common mariadb-client openrc

RUN			chown -R mysql:mysql /var/lib/mysql

COPY		/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
RUN			chown -R mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf

COPY		./setup_mariadb.sh run/setup_mariadb.sh
RUN			chmod -R +x run/setup_mariadb.sh

RUN			mkdir -p /var/run/mysqld/ \
    		&& chown -R mysql:mysql /var/run/mysqld/
RUN			chmod -R 777 /var/run/mysqld/

EXPOSE		3306

ENTRYPOINT	["sh", "run/setup_mariadb.sh"]