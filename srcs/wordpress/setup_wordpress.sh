#!/bin/bash

cd /var/www/html/test.icl.es

IDX=0
while [ $IDX -lt 10 ] ; do
	if (nc -w 3 -zv $DB_HOST.$NETWORK_NAME 3306) ; then
		wp config create --allow-root \
		--dbname=$WP_DATABASE \
		--dbhost=$DB_HOST \
		--dbuser=$DB_USER \
		--dbpass=$DB_PWD
		
		wp core install --allow-root \
		--url=test.icl.es \
		--title="🍫 ⋆ 🍑  🎀  𝐵𝑒𝓅𝒾𝓈  🎀  🍑 ⋆ 🍫" \
		--admin_user=$ADMIN_USER \
		--admin_password=$ADMIN_PWD \
		--admin_email=$ADMIN_EMAIL

		wp user create --allow-root \
		$WP_USER $WP_USER_EMAIL \
		--user_pass=$WP_USER_PWD
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
