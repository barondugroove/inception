# Start MariaDB
mysql_install_db --datadir=/var/lib/mysql --skip-test-db

/etc/init.d/mariadb start
#mysqld --defaults-file=/etc/mysql/mariadb.conf.d/50-server.cnf --user=root --datadir=/var/lib/mysql
#PID=$!

echo "FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON *.* to 'root'@'%' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
echo "CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot
echo "CREATE DATABASE IF NOT EXISTS $MYSQL_DATABASE; FLUSH PRIVILEGES;" | mysql -uroot
echo "GRANT ALL ON $MYSQL_DATABASE.* to '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; FLUSH PRIVILEGES;" | mysql -uroot

/etc/init.d/mariadb stop

# Start MariaDB
exec mysqld --user=$MYSQL_USER --console