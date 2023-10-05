FROM		alpine:3.17

RUN			apk update && apk upgrade && apk add php php81 php-fpm php-mysqli

RUN			rm -f /etc/wordpress/wordpress.conf

RUN			mkdir -p /var/www/html
RUN			chmod -R 755 /var/www/html
RUN			wget http://wordpress.org/latest.tar.gz -P /var/www/html
RUN			tar -xzvf /var/www/html/latest.tar.gz -C /var/www/html && rm -rf /var/www/html/latest.tar.gz

RUN			chown -R root:root /var/www/html/wordpress
COPY		./setup_wordpress.sh run/setup_wordpress.sh

RUN			chmod -R +x run/setup_wordpress.sh

EXPOSE		9000

CMD			["php-fpm"]
ENTRYPOINT	["sh", "run/setup_wordpress.sh"]