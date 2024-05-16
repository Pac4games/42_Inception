#!/bin/bash

echo "DB_HOST: $DB_HOST"
echo "NETWORK_NAME: $NETWORK_NAME"
echo "WP_DATABASE: $WP_DATABASE"
echo "DB_USER: $DB_USER"
echo "DB_PWD: $DB_PWD"
echo "ADMIN_USER: $ADMIN_USER"
echo "ADMIN_PWD: $ADMIN_PWD"
echo "ADMIN_EMAIL: $ADMIN_EMAIL"
echo "WP_USER: $WP_USER"
echo "WP_USER_EMAIL: $WP_USER_EMAIL"
echo "WP_USER_PWD: $WP_USER_PWD"

cd /var/www/html/paugonca.42.fr

IDX=0
while [ $IDX -lt 10 ] ; do
	if (nc -w 3 -zv $DB_HOST 3306) ; then
		wp config create --allow-root \
		--dbname=$WP_DATABASE \
		--dbhost=$DB_HOST \
		--dbuser=$DB_USER \
		--dbpass=$DB_PWD
		
		wp core install --allow-root \
		--url=paugonca.42.fr \
		--title="🍫 ⋆ 🍑  🎀  𝐵𝑒𝓅𝒾𝓈  🎀  🍑 ⋆ 🍫" \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PWD \
		--admin_email=$ADMIN_EMAIL

		wp user create --allow-root \
		$WP_USER $WP_USER_EMAIL \
		--user_pass=$WP_USER_PWD

		break
	else
		sleep 1
		((IDX++))
	fi
done

if [ $IDX -eq 10 ] ; then
	echo "Server connection timed out" >&2
else
	exec "$@"
fi
