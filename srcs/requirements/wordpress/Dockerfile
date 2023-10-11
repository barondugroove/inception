FROM		alpine:3.17

RUN			apk update && apk upgrade && apk add php81 php-fpm php-mysqli

WORKDIR		/var/www/html

RUN			wget http://wordpress.org/latest.tar.gz
RUN			tar -xzvf /var/www/html/latest.tar.gz && rm -rf latest.tar.gz

RUN			cp wordpress/wp-config-sample.php wordpress/wp-config.php
COPY		./setup_wordpress.sh run/setup_wordpress.sh


RUN			adduser -S nginx && addgroup -S nginx
RUN 		chown -R nginx:nginx ./wordpress/
RUN			chmod -R 775 ./wordpress

RUN			rm -f etc/php81/php-fpm.d/www.conf
COPY		./www.conf /etc/php81/php-fpm.d/www.conf

RUN			chmod -R +x run/setup_wordpress.sh

EXPOSE		9000

CMD			["php-fpm"]
ENTRYPOINT	["sh", "run/setup_wordpress.sh"]