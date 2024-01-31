# Use the penultimate stable version of Debian as the base image
FROM debian:bullseye-slim

EXPOSE 9000

# Install php
RUN apt-get update && apt-get install -y \
    php7.4 \
    php-fpm \
    php-mysql \
    mariadb-client \
    wget \
    && rm -rf /var/lib/apt/lists/*

COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf

# Install wp-cli
RUN wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
RUN chmod +x wp-cli.phar
RUN mv wp-cli.phar /usr/local/bin/wp

# Create the directory for pid file
RUN mkdir /run/php/ && chmod 755 /run/php/

# Copy the configuration files
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/www.conf
#COPY ./conf/config.sh /home
#RUN chmod 777 /home/config.sh
COPY ./conf/wp-config.php /var/www/html
RUN chown -R www-data:www-data /var/www/html

#ENTRYPOINT ["/home/config.sh"]

CMD ["php-fpm7.4", "-F"]