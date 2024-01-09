# Start MariaDB
mysql_install_db --user=mysql --datadir=/var/lib/mysql --skip-test-db
mysqld --user=mysql --bootstrap <<EOF
	USE mysql;
	FLUSH PRIVILEGES ;
	ALTER USER 'root'@'localhost' IDENTIFIED BY '$ROOT_PASSWORD';
	CREATE DATABASE IF NOT EXISTS $DATABASE CHARACTER SET utf8 COLLATE utf8_general_ci;
	GRANT ALL ON $DATABASE.* to '$USER'@'%' IDENTIFIED BY '$PASSWORD';
	FLUSH PRIVILEGES ;
EOF

sed -i "s|.*bind-address\s*=.*|bind-address=0.0.0.0|g" /etc/my.cnf.d/mariadb-server.cnf
sed -i "s|.*skip-networking.*|skip-networking=OFF\nskip-grant-tables=0|g" /etc/my.cnf.d/mariadb-server.cnf

# Start MariaDB
exec mysqld --user=mysql --console