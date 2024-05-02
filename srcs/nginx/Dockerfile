FROM debian:bullseye

RUN apt update && apt upgrade -y && apt install -y nginx openssl
COPY Certificates/localhost.key /etc/ssl/private/
COPY Certificates/localhost.crt /etc/ssl/certs/
COPY index.html /usr/share/nginx/html
COPY default.conf /etc/nginx/conf.d
CMD ["nginx", "-g", "daemon off;"]
