FROM		alpine:3.18

RUN			apk update && apk upgrade && apk add --no-cache curl php-curl php-fpm php-mbstring php-mysqli php-phar php-zip mariadb-client
RUN			rm -rf /var/cache/apk/*

COPY		./setup_wordpress.sh run/setup_wordpress.sh
RUN			chmod -R +x run/setup_wordpress.sh

WORKDIR		/var/www/html

RUN			wget http://wordpress.org/latest.tar.gz
RUN			tar -xzvf /var/www/html/latest.tar.gz && rm -rf latest.tar.gz

RUN			cp wordpress/wp-config-sample.php wordpress/wp-config.php

RUN			adduser -S www && addgroup -S www
RUN 		chown -R www:www ./wordpress/
RUN			chmod -R 775 ./wordpress

RUN			rm -f etc/php81/php-fpm.d/www.conf
COPY		./www.conf /etc/php81/php-fpm.d/www.conf

EXPOSE		9000

WORKDIR 	/

ENTRYPOINT	["sh", "run/setup_wordpress.sh"]