FROM		alpine:3.17

RUN			apk update && apk upgrade && apk add openssl nginx

RUN			rm -f /etc/nginx/nginx.conf

COPY		./nginx.conf /etc/nginx/nginx.conf
COPY		./setup_nginx.sh run/setup_nginx.sh

RUN			chmod -R +x run/setup_nginx.sh
RUN			mkdir -p etc/nginx/ssl
RUN			openssl req -x509 -nodes -out /etc/nginx/ssl/inception.crt -keyout /etc/nginx/ssl/inception.key -subj "/C=FR/ST=IDF/L=Angouleme/O=42/OU=42/CN=bchabot.42.fr/UID=bchabot"

EXPOSE		9000

ENTRYPOINT	["sh", "run/setup_nginx.sh"]