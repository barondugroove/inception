echo "Starting Wordpress setup..."

adduser -S www && addgroup -S www
chown -R www:www /var/www/
chmod -R 775 /var/www/

if [ -f "/var/www/html/wordpress/wp-config.php)" ]; then
    echo "WordPress is already installed. Skipping installation."
else
	cd /var/www/html/wordpress

	curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
	chmod +x wp-cli.phar
	mv wp-cli.phar /usr/local/bin/wp

	wp core download --allow-root

	cp /tmp/wp-config.php /var/www/html/wordpress/

	sed -i "s/database_name_here/${MYSQL_DATABASE}/g" /var/www/html/wordpress/wp-config.php
	sed -i "s/username_here/${MYSQL_USER}/g" /var/www/html/wordpress/wp-config.php
	sed -i "s/password_here/${MYSQL_PASSWORD}/g" /var/www/html/wordpress/wp-config.php

	wp core install --allow-root --url=$DOMAIN_NAME --title='Inception' --admin_user=$WP_ADMIN_NAME --admin_password=$WP_ADMIN_PASSWORD --admin_email=$WP_ADMIN_EMAIL --skip-email
	wp user create --allow-root $WP_GUEST_NAME $WP_GUEST_EMAIL --role=subscriber --user_pass=$WP_GUEST_PASSWORD --path='/var/www/html/wordpress/'
	wp theme install twentytwentyone --activate

	chown -R www:www /var/www/html/wordpress
fi

exec php-fpm81 -F