FROM debian:oldstable

ARG PACKAGES="	nginx \
		openssl"

RUN apt update && apt upgrade -y && apt install -y $PACKAGES
COPY Certificates/localhost.key /etc/ssl/private/
COPY Certificates/localhost.crt /etc/ssl/certs/
COPY default.conf /etc/nginx/conf.d
CMD ["nginx", "-g", "daemon off;"]
