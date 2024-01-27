# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

# Install php
RUN apt-get update && apt-get install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    && rm -rf /var/lib/apt/lists/*

# Install Wordpress
RUN wget https://wordpress.org/latest.tar.gz -P /var/www
RUN cd /var/www && tar -xzvf /var/www/latest.tar.gz -C /var/www
RUN rm /var/www/latest.tar.gz

RUN chown -R root:root /var/www/wordpress

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Set up the configuration files
#COPY ./conf/wp-config.php /var/www/html/wp-config.php
COPY ./conf/config.sh /var/www/wordpress/config.sh

# Set up permissions
RUN chmod 777 /var/www/wordpress/config.sh

# Expose php port
EXPOSE 9000

ENTRYPOINT ["/var/www/wordpress/config.sh"]

# Start PHP-FPM
CMD ["/usr/sbin/php-fpm7.4", "-F"]
