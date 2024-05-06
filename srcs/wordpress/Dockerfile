FROM debian:bullseye

ARG PACKAGES="	php-fpm \
		php-mysql \
		curl \
		mariadb-client \
		netcat"

RUN apt update && apt upgrade -y && apt install -y $PACKAGES
RUN mkdir /run/php/ && chmod 755 /run/php
