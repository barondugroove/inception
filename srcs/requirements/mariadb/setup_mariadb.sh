#!/bin/sh
echo "Starting MariaDB setup..."

if [ -d /var/lib/mysql/mysql ]
then
	echo "MariaDB is already installed."
else
	echo "Installing MariaDB..."
	
	mkdir -p /etc/mysql/mariadb.conf.d
	cp /tmp/50-server.cnf /etc/mysql/mariadb.conf.d/50-server.cnf
	chmod 775 /etc/mysql/mariadb.conf.d/50-server.cnf
	chown -R mysql:mysql /etc/mysql/mariadb.conf.d/50-server.cnf

	mysql_install_db --datadir=/var/lib/mysql --skip-test-db > /dev/null

	echo "Starting MariaDB chown..."
	chown -R mysql:mysql /var/lib/mysql
	mkdir -p run/mysqld/ && chown -R mysql:mysql /run/mysqld/
	chmod -R 777 /run/mysqld/

fi

if [ -d "/var/lib/mysql/${MYSQL_DATABASE}" ]
then
	echo "Database already exists."
else
	echo "Creating database..."
	mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --user=mysql > output.log 2>&1 &
	PID="$!"

	sleep 1

	mysql -e "CREATE DATABASE IF NOT EXISTS \`${MYSQL_DATABASE}\`;"
	mysql -e "CREATE USER IF NOT EXISTS \`${MYSQL_USER}\`@'localhost' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "GRANT ALL PRIVILEGES ON \`${MYSQL_DATABASE}\`.* TO \`${MYSQL_USER}\`@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
	mysql -e "FLUSH PRIVILEGES;"

	kill -s TERM "${PID}"
	wait ${PID}

	touch /tmp/ok
fi

# Start MariaDB
exec mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --user=mysql