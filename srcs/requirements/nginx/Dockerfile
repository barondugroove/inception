FROM		alpine:3.18

RUN			apk add openssl nginx

RUN			rm -f /etc/nginx/nginx.conf

COPY		./nginx.conf /etc/nginx/nginx.conf
COPY		./setup_nginx.sh run/setup_nginx.sh

RUN			chmod -R +x run/setup_nginx.sh
RUN			mkdir -p etc/nginx/ssl
RUN			openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=bchabot.42.fr/UID=bchabot"

RUN			adduser -D -g 'www' www

RUN			mkdir -p /var/www/html
RUN			chmod 755 /var/www/html
RUN			chown -R www:www /var/lib/nginx
RUN			chown -R www:www /var/www/

EXPOSE		443

ENTRYPOINT	["sh", "run/setup_nginx.sh"]
