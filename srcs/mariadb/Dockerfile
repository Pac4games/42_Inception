FROM debian:oldstable

ARG PACKAGES="	mariadb-server"

RUN apt update && apt upgrade -y && apt install -y $PACKAGES
RUN mysql_install_db --user=mysql --basedir=/usr --datadir=/var/lib/mysql

COPY setup_mariadb.sh /home/
ENTRYPOINT ["/home/setup_mariadb.sh"]
CMD ["mysqld_safe"]
