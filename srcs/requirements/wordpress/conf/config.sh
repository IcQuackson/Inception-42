#!/bin/bash

wp config create    --allow-root \
                    --dbname=$DB_NAME \
                    --dbuser=$DB_USER \
                    --dbpass=$DB_PASSWORD \
                    --dbhost=mariadb:3306 --path='/var/www/wordpress'

echo "Wordpress installed successfully"