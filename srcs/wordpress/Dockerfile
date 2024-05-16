FROM debian:oldstable

ARG PACKAGES="	php-fpm \
		php-mysql \
		curl \
		mariadb-client \
		netcat"

RUN apt update && apt upgrade -y && apt install -y $PACKAGES
RUN mkdir /run/php/ && chmod 755 /run/php
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
    && chmod a+x wp-cli.phar \
    && mv wp-cli.phar /usr/local/bin/wp
RUN mkdir -p /var/www/html/paugonca.42.fr \
    && cd /var/www/html/paugonca.42.fr \
    && wp --allow-root core download
RUN sed -i 's:listen = /run/php/php7.4-fpm.sock:listen = 9000:g' /etc/php/7.4/fpm/pool.d/www.conf

COPY setup_wordpress.sh /home/
ENTRYPOINT ["/home/setup_wordpress.sh"]
CMD ["php-fpm7.4", "-F", "-R"]
