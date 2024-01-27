#Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

#Install php
RUN apt-get update && \
    apt-get install -y \
    php7.4-fpm \
    php7.4-mysql \
    mariadb-client \
    && rm -rf /var/lib/apt/lists/*

# Copy www.conf for PHP-FPM
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

#Install Wordpress
RUN wget -qO wordpress.tar.gz https://wordpress.org/latest.tar.gz && tar -xzvf wordpress.tar.gz --strip-components=1 && rm wordpress.tar.gz

# Set up the configuration files
COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/config.sh /var/www/html/config.sh

# Install WP-CLI
RUN curl -o /usr/bin/wp https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar --silent && \
    chmod +x /usr/bin/wp

# Create directory for PHP-FPM
RUN mkdir /run/php

#Expose php port
EXPOSE 9000

ENTRYPOINT ["bash", "/var/www/html/config.sh"]

# Start PHP-FPM
CMD ["php-fpm", "-F"]
