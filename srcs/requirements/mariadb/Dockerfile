FROM		alpine:3.18

RUN			apk add --no-cache mariadb mariadb-common mariadb-client

COPY		/50-server.cnf /tmp/50-server.cnf

COPY		./setup_mariadb.sh run/setup_mariadb.sh
RUN			chmod -R +x run/setup_mariadb.sh

EXPOSE		3306

ENTRYPOINT	["sh", "run/setup_mariadb.sh"]