# Penultimate stable version of Debian
FROM debian:bullseye-slim

# Install NGINX
RUN apt-get update && apt-get upgrade -y && apt-get install -y nginx && apt-get install -y openssl &&rm -rf /var/lib/apt/lists/*

# Create SSL certificate and key
RUN mkdir -p /etc/nginx/ssl && openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/nginx/ssl/server.key -out /etc/nginx/ssl/server.crt \
    -subj "/C=PT/ST=Lisbon/L=Lisbon/O=42 Lisboa/CN=42.fr"

# Copy config file into the container
COPY ./tools/nginx.conf /etc/nginx/nginx.conf

# Expose port 443
EXPOSE 443

#Start Nginx
CMD ["nginx", "-g", "daemon off;"]
