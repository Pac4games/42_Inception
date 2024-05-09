#!/bin/bash

if (!(test -d /var/lib/mysql/$WP_DATABASE)); then
	/etc/init.d/mysql start
	sleep 1
	mysql -u root -e "CREATE USER '"$DB_USER"'@'"$WP_CONT_NAME.$NETWORK_NAME"' IDENTIFIED BY '"$DB_PWD"'; GRANT ALL PRIVILEGES ON *. * TO '"$DB_USER"'@'"$WP_CONT_NAME.$NETWORK_NAME"'; FLUSH PRIVILEGES;" \
	&& mysql -u root -e "CREATE DATABASE $WP_DATABASE;" \
	&& '/usr/bin/mysqladmin' -u root password $MARIADB_ROOT_PWD
	/etc/init.d/mysql stop
fi

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
exec "$@"
