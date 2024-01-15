FROM		alpine:3.18

RUN			apk add --no-cache curl php-curl php-fpm php-mbstring php-mysqli php-phar php-zip mariadb-client

COPY		./setup_wordpress.sh run/setup_wordpress.sh
RUN			chmod -R +x run/setup_wordpress.sh

RUN			rm -f etc/php81/php-fpm.d/www.conf
COPY		./www.conf /etc/php81/php-fpm.d/www.conf

COPY 		./wp-config.php /tmp/wp-config.php

RUN			mkdir -p /var/www/html/wordpress/

EXPOSE		9000

ENTRYPOINT	["sh", "run/setup_wordpress.sh"]