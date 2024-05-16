#!/bin/bash

if [ ! -d /var/lib/mysql/$WP_DATABASE ]; then
	mysqld_safe --skip-networking &
	sleep 5
	mysql -u root -e "CREATE DATABASE $WP_DATABASE;" \
	&& '/usr/bin/mysqladmin' -u root password $MARIADB_ROOT_PWD
	mysql -u root -e "CREATE USER '"$DB_USER"'@'"$WP_CONT_NAME.$NETWORK_NAME"' IDENTIFIED BY '"$DB_PWD"'; GRANT ALL PRIVILEGES ON *.* TO '"$DB_USER"'@'"$WP_CONT_NAME.$NETWORK_NAME"'; FLUSH PRIVILEGES;"
	mysql -u root -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '"$MARIADB_ROOT_PWD"';"
	mysqladmin -u root -p $MARIADB_ROOT_PWD shutdown
fi

sed -i 's/127.0.0.1/0.0.0.0/g' /etc/mysql/mariadb.conf.d/50-server.cnf
exec "$@"
