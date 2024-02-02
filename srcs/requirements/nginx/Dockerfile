# Penultimate stable version of Debian
FROM debian:bullseye-slim

EXPOSE 443

# Install NGINX
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx && apt-get install -y openssl &&rm -rf /var/lib/apt/lists/*

# Create directory for nginx pid file
RUN mkdir -p /run/nginx

# Create SSL certificate and key
RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt \
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42Lisboa/OI=pedgonca/CN=localhost/"

# Set permissions for SSL certificates
RUN chmod 777 /etc/nginx/ssl/server.crt /etc/nginx/ssl/server.key

# Copy config file into the container
COPY ./conf/nginx.conf /etc/nginx/conf.d
RUN chown -R www-data:www-data /var/www/html

#Start Nginx
CMD ["nginx", "-g", "daemon off;"]
